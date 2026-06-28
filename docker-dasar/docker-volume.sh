# DOCKER VOLUME 
    # adalah folder di dalam container yang bisa diakses oleh container di dalam container atau di luar container sama seperti bind mounts
    # cuma ini adalah versi yang di anjurkan, bedanya bind mounts kita bisa mengakses folder di luar container di dalam container atau sebaliknya
    # dengan menggunakan volume kita bisa mengakses folder di luar container di dalam container atau sebaliknya. dan dia akan menyimpan datanya 
    # didalam volume, volume dan container berdisi sendiri sendiri.

# list volume
docker volume ls

# membuat volume
docker volume create mongovolume

# menghapus volume
#   pastikan volume tiidak di gunakan container
docker volume rm mongovolume

# volume seperti storage di dalam container

# ==========================================================================================================================================

# DOCKER CONTAINER VOLUME
    # Adalah proses untuk mengintegrasikan container ke volume tertentu
    # untuk membuat prompt yang digunakan sama yaitu mount bedanya parameter "type=volume, source=namaVolume" *destination sama seperti di      dokumentasi docker

# Contoh
docker container create --name mongovolume --publish 27017:27017 --mount "type=volume,source=mongovolume,destination=/data/db" --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest