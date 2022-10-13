Change:
```
sudo nano /etc/nomad.d/nomad.hcl
```
Apply the changes: 
```
sudo systemctl restart nomad
sudo systemctl status nomad
```
Verify:
```
nomad node status -verbose -self
```

Cleanup:
```
nomad system gc
nomad system reconcile summaries
```