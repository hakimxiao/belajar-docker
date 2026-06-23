# melihat semua container 
    # -a(all)
docker container ls -a
docker container ls

# membuat container 
    # (dengan image redis dengan nama container contohredis)
docker container create --name contohredis redis:latest

# menjalanlah container 
    # (contohredis: merupakan nama container yang ada)
docker container start contohredis

# meghentikan container 
    # (sebelum menghapus kita wajib menghentikan container | contohredis: merupakan nama container yang ada | status up berjalan, status exited tidak berjalan)
docker container stop contohredis

# menghapus container 
    # (contohredis: merupakan nama container yang ada)
docker container rm contohredis