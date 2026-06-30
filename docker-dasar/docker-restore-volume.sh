# ==========================================================
# RESTORE DOCKER VOLUME DARI FILE BACKUP (.tar.gz)
# ==========================================================

# Setelah melakukan backup volume ke dalam file archive (.tar.gz),
# kita dapat menyimpan file tersebut ke lokasi yang lebih aman
# seperti cloud storage, hard disk eksternal, atau server backup.
#
# Jika suatu saat volume hilang atau rusak, kita dapat
# mengembalikan (restore) data dari file backup tersebut.

# ----------------------------------------------------------
# 1. Membuat volume baru untuk menampung hasil restore
# ----------------------------------------------------------
docker volume create mongorestore

# Penjelasan:
# - mongorestore adalah nama volume baru.
# - Volume ini nantinya akan diisi dengan data dari file backup.

# ----------------------------------------------------------
# 2. Menjalankan container sementara untuk proses restore
# ----------------------------------------------------------
docker container run --rm \
    --name ubunturestore \
    --mount "type=bind,source=/Users/alhakim/Development/Docker/docker-dasar/backup,destination=/backup" \
    --mount "type=volume,source=mongorestore,destination=/data" \
    ubuntu:latest \
    bash -c "cd /data && tar xvf /backup/backup.tar.gz --strip-components=1"

# Penjelasan:
#
# --rm
#   Container akan otomatis dihapus setelah selesai dijalankan.
#
# --name ubunturestore
#   Memberikan nama container sementara yaitu "ubunturestore".
#
# Mount pertama (Bind Mount)
#   source      : Folder backup di komputer host.
#   destination : Diakses sebagai /backup di dalam container.
#
#   Contoh:
#   /Users/alhakim/Development/Docker/docker-dasar/backup
#          |
#          +--> /backup (di dalam container)
#
# Mount kedua (Volume Mount)
#   source      : Volume Docker bernama mongorestore.
#   destination : Diakses sebagai /data di dalam container.
#
#   Data hasil extract backup akan ditempatkan ke volume ini.
#
# ubuntu:latest
#   Menggunakan image Ubuntu terbaru untuk menjalankan proses restore.
#
# bash -c
#   Menjalankan perintah shell di dalam container.
#
# cd /data
#   Masuk ke direktori volume tujuan.
#
# tar xvf /backup/backup.tar.gz
#   Mengekstrak file backup.tar.gz.
#
# --strip-components=1
#   Menghapus 1 level folder teratas dari archive saat ekstraksi.
#   Berguna jika isi backup berada di dalam folder tambahan.

# ----------------------------------------------------------
# 3. Memastikan data berhasil direstore
# ----------------------------------------------------------
docker volume inspect mongorestore

# Melihat informasi volume yang sudah direstore.

# ----------------------------------------------------------
# 4. Menggunakan volume hasil restore
# ----------------------------------------------------------
# Setelah proses restore selesai, volume mongorestore
# dapat digunakan oleh container lain.
#
# Contoh:
#
# docker container run -d \
#     --name mongodb-restore \
#     --mount "type=volume,source=mongorestore,destination=/data/db" \
#     mongo:latest
#
# Container MongoDB tersebut akan menggunakan data
# yang sudah direstore dari file backup.

# MEMBUAT CONTAINER MENGGUNAKAN VOLUME RESTORE
docker container create --name mongorestore --publish 27017:27017 --mount "type=volume,source=mongorestore,destination=/data/db" --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest