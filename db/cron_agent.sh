#!/bin/bash

value=$(cat userpass.txt)
#echo "$value"

#sudo docker exec -it sql2 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $value -Q "Select @@version,getdate(),@@Servername"
#sudo docker exec -it sql2017 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $value -Q "EXECUTE [dbo].[sp_powerbi_log];"

docker exec -it sql2017 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $(cat /home/georgiem/userpass.txt) -Q "EXECUTE [dbo].[sp_powerbi_log];"
docker exec -it sql2017 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $(cat /home/georgiem/userpass.txt) -Q "EXECUTE [dbo].[sp_dbs_backup];"
docker exec -it sql2017 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $(cat /home/georgiem/userpass.txt) -Q "EXECUTE [dbo].[sp_dbs_backup_log];"
