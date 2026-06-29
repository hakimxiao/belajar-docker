# CARA MANUAL
# Sayangnya di versi sekarang docker tidak ada backup volume secara otomatis. Namun kita biusa memanfaatkan container untuk melakukkan
# backup data yang ada di dalam volume ke dalam archive seperti zip atau tar.gz

# TAHAPAN MELAKUKUKKAN BACKUP
#   1. matikan container
#   2. buat container baru dengan 2 mount, volume yang ingin di backup, dan bind mount folder dari sistem host
#   3. backup dengan container dengan cara meng-archive isi volume, dan simpan di bind mount folder
#   4. isi file backup sekarang ada di folder sistem hosy
#   5. delete container yang kita gunakan untuk backup

# 1. matikan container =============
docker container ls
docker container stop mongovolume
# 
# 2. buat container baru dengan 2 mount, volume yang ingin di backup, dan bind mount folder dari sistem host ===========
docker volume ls 
docker container create --name nginxbackup --mount "type=bind,source=/Users/alhakim/Development/Docker/docker-dasar/backup,destination=/backup" --mount "type=volume,source=mongovolume,destination=/data/db" nginx:latest # menggunakan volume mongovolume
# 
# 3. jalankan container backup  =================
docker container start nginxbackup
# 
# 4. masuk ke container backup (untuk eksekusi bash) ==============
docker container exec -i -t nginxbackup /bin/bash
ls -l
# masuk ke folder data
cd /data
ls -l 
# 
# 5. manfaatkan tar atau zip untuk melakukkan backup  ===================
tar cvf /backup/backup.tar.gz /data #(/data = folder data di dalam container yang kita akses dengan bash, /backup/backup.tar.gz = file backup di dalam folder backup di sistem host, tar cvf = membuat archive)
# 
# 6. exit bash ============
exit
# 
# 7. stop dan remove container backup kemudian start lagi mongovolume nya (unbtuk mengecek backup) ============
# 
docker container stop nginxbackup
docker container rm nginxbackup 
docker container start mongovolume 


# CARA MUDAH 
#   kita bisa menggunakan perintah run untuk menjalankan perintah di coontainer dan gunakan parameter --rm untuk melakukkan 
#   remove container setelah perintahnya berjalan.

# ==================================================================================================================================

# CARA MUDAH - DENGAN CARA INI SEMUA CARA DI ATAS DI SELESAIKAN DALAM 1 COMAND
docker container run -rm --name ubuntu --mount "type=bind,source=/Users/alhakim/Development/Docker/docker-dasar/backup,destination=/backup" --mount "type=volume,source=mongovolume,destination=/data/db" ubuntu:latest tar cvf /backup/backup-2.tar.gz /data # gunakan nama folder beda agar tidak bentrok /backup/backup-2.tar.gz