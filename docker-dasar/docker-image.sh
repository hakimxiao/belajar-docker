# melihat semua image
docker image ls

# mengunduh image dari Docker Hub
    # (redis:latest merupakan nama image dan tag yang ingin diunduh)
docker image pull redis:latest

# melihat detail image
    # (redis:latest merupakan nama image yang ada)
docker image inspect redis:latest

# menghapus image
    # (image tidak boleh sedang digunakan oleh container)
docker image rm redis:latest

# menghapus semua image yang tidak digunakan
docker image prune

# menghapus semua image yang tidak digunakan tanpa konfirmasi
docker image prune -a -f

# memberi tag pada image
    # (berguna untuk versi atau repository berbeda)
docker image tag redis:latest redis:v1

# membuat image dari Dockerfile
    # (titik "." berarti lokasi Dockerfile saat ini)
docker image build -t aplikasi:v1 .

# mencari image di Docker Hub
docker search redis

# melihat riwayat layer image
    # (redis:latest merupakan nama image yang ada)
docker image history redis:latest