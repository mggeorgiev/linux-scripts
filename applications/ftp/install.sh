#!/bash/bin

value=$(cat userpass.txt)

docker run -d -v /home/ftpserver:/home/vsftpd -p 20:20 -p 21:21 -p 47400-47470:47400-47470 -e FTP_USER=yourName -e FTP_PASS=$value -e PASV_ADDRESS=127.0.0.1 --name ftp --restart=always bogem/ftp