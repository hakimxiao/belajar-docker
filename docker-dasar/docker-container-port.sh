# port forwarding
    # adalah cara meneruskan port local kita ke port container kita, karena port container dengan local itu terpisah (sama seperti ngrok)
    # (8080:80) adalah 8080 = local port kita dan kata : merujuk akan ke forward ke port 80 di container (jadi 8080 dari local | 80 di container)
    # secara harfiah kita meneruskan port 8080 di local kita ke port 80 di container agar bisa diakses
docker container create --name contohnginx --publish 8080:80 nginx:latest