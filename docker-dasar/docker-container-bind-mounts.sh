# Bind Mounts adalah
# meneruskan folder di host ke folder di container agar bisa diakses oleh container di dalam container atau di luar container
# dengan menggunakan bind mounts kita bisa mengakses folder di luar container di dalam container atau sebaliknya.

# Parameter mount
# =======================================================================================
# | parameter       |                  deskripsi                                        |
# =======================================================================================
#   type                tipe mount, bind atau volume                                    =
#   source              lokasi file atau folder di sistem host                          =  
#   destination         lokasi file atau folder di dalam container                      =
#   readonly            Jika ada, maka file atau folder hanya bisa dibaca di container. =
#                       tidak bisa ditulis                                              =
# =======================================================================================

# Melakukkan mounting
docker container create --name namaContainer --mount "type=bind,source=folder,destination=folder,readonly" image:tag

# Contoh
docker container create --name contohredis --mount "type=bind,source=/var/lib/redis,destination=/data" redis:latest

# Contoh mongodb
docker container create --name contohmongo --publish 27017:27017 --mount "type=bind,source=/var/lib/mongodb,destination=/data/db" --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest

# !!!
# Enaknya menggunakan ini di mongodb adalah ketika kita menghancurkan si container maka data nya masih tetap ada
# sehingga kita bisa lakukkan perintah nanti untuk create ulang sehingga datanya masih tetap yang tadi