# Digunakan untuk menjalankan perintah di dalam container atau masuk ke container agar dapat menjalankan perintah di dalam container

# Masuk container 
    # (-i = argument interaktive(menjaga input tetap aktiv) | -t = argument alokasi pseudo-TTY(terminal akses))
    # /bin/bash * ini biasa digunakan di linux
docker container exec -i -t contohredis /bin/bash