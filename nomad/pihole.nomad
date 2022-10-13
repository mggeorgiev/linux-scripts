job "pihole" {
  # region = "global"
  datacenters = ["habay"]
  type = "service"
  # constraint {
  #   attribute = "${attr.kernel.name}"
  #   value     = "linux"
  # }

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "pihole" {
    count = 1

    volume "etc-pihole" {
      type      = "host"
      read_only = false
      source    = "etc-pihole"
    }

    volume "etc-dnsmasq.d" {
      type      = "host"
      read_only = false
      source    = "etc-dnsmasq.d"
    }
    
    network {
      port "tcp53" {
        static = 53
        to = 53
      }
   
      port "management" {
        static = 8080
        to = 80
      }
    }

    service {
      name     = "pihole-dns"
      tags     = ["global", "pihole"]
      port     = "tcp53"
      provider = "nomad"

      # The "check" stanza instructs Nomad to create a Consul health check for
      # this service. A sample check is provided here for your convenience;
      # uncomment it to enable it. The "check" stanza is documented in the
      # "service" stanza documentation.

      #check {
      #  name     = "alive"
      #  type     = "tcp"
      #  interval = "10s"
      #  timeout  = "2s"
      #}

    }

    service {
      name     = "pihole-management"
      tags     = ["global", "pihole"]
      port     = "management"
      provider = "nomad"
    }

    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 2
      interval = "30m"

      delay = "15s"
      mode = "fail"
    }

    affinity {
        attribute = "${node.unique.name}"
        value     = "pi201"
        weight    = 100
    }

    task "pihole" {
      driver = "docker"

      volume_mount {
        volume      = "etc-pihole"
        destination = "/etc/pihole/"
        read_only   = false
      }

      volume_mount {
        volume      = "etc-dnsmasq.d"
        destination = "/etc/dnsmasq.d/"
        read_only   = false
      }

      env = {
        "MYSQL_ROOT_PASSWORD" = "password"
        "TZ" = "Europe/Brussels",
        "VIRTUAL_HOST" = "pi201.habay",
        "PROXY_LOCATION" = "pi201.habay",
        "ServerIP" = "${attr.unique.network.ip-address}"
      }

      config {
        image = "pihole/pihole:latest"
        ports = ["tcp53", "management"]
        auth_soft_fail = true

        dns_servers = [
          "127.0.0.1",
          "1.1.1.1"
        ]

        hostname  ="pi201.habay"
      }

      # The "artifact" stanza instructs Nomad to download an artifact from a
      # remote source prior to starting the task. This provides a convenient
      # mechanism for downloading configuration files or data needed to run the
      # task. It is possible to specify the "artifact" stanza multiple times to
      # download multiple artifacts.
      #
      # For more information and examples on the "artifact" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/artifact
      #
      # artifact {
      #   source = "http://foo.com/artifact.tar.gz"
      #   options {
      #     checksum = "md5:c4aa853ad2215426eb7d70a21922e794"
      #   }
      # }


      # The "logs" stanza instructs the Nomad client on how many log files and
      # the maximum size of those logs files to retain. Logging is enabled by
      # default, but the "logs" stanza allows for finer-grained control over
      # the log rotation and storage configuration.
      #
      # For more information and examples on the "logs" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/logs
      #
      # logs {
      #   max_files     = 10
      #   max_file_size = 15
      # }

      # The "resources" stanza describes the requirements a task needs to
      # execute. Resource requirements include memory, cpu, and more.
      # This ensures the task will execute on a machine that contains enough
      # resource capacity.
      #
      # For more information and examples on the "resources" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/resources
      #
      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }


      # The "template" stanza instructs Nomad to manage a template, such as
      # a configuration file or script. This template can optionally pull data
      # from Consul or Vault to populate runtime configuration data.
      #
      # For more information and examples on the "template" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/template
      #
      # template {
      #   data          = "---\nkey: {{ key \"service/my-key\" }}"
      #   destination   = "local/file.yml"
      #   change_mode   = "signal"
      #   change_signal = "SIGHUP"
      # }

      # The "template" stanza can also be used to create environment variables
      # for tasks that prefer those to config files. The task will be restarted
      # when data pulled from Consul or Vault changes.
      #
      # template {
      #   data        = "KEY={{ key \"service/my-key\" }}"
      #   destination = "local/file.env"
      #   env         = true
      # }

      # The "vault" stanza instructs the Nomad client to acquire a token from
      # a HashiCorp Vault server. The Nomad servers must be configured and
      # authorized to communicate with Vault. By default, Nomad will inject
      # The token into the job via an environment variable and make the token
      # available to the "template" stanza. The Nomad client handles the renewal
      # and revocation of the Vault token.
      #
      # For more information and examples on the "vault" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/vault
      #
      # vault {
      #   policies      = ["cdn", "frontend"]
      #   change_mode   = "signal"
      #   change_signal = "SIGHUP"
      # }

      # Controls the timeout between signalling a task it will be killed
      # and killing the task. If not set a default is used.
      # kill_timeout = "20s"
    }
  }
}