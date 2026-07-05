# DOCKER CONTAINER NETWORK
    # Docker container network adalah cara menghubungkan container ke sebuah network.
    # Kalau docker network adalah "jalannya", maka container network adalah proses
    # memasukkan container ke jalan tersebut agar bisa berkomunikasi.
    #
    # Dengan menghubungkan container ke network yang sama, container bisa saling mengenal
    # menggunakan nama container. Jadi kita tidak perlu mengingat IP address container.

# ==========================================================================================================================================

# RINGKASAN
    # Container bisa dihubungkan ke network saat container dibuat.
    # Container yang sudah ada juga bisa dimasukkan ke network menggunakan docker network connect.
    # Container bisa dilepaskan dari network menggunakan docker network disconnect.
    # Container dalam network yang sama bisa saling berkomunikasi.
    # Container dalam network berbeda akan terpisah, kecuali dihubungkan secara sengaja.

# ==========================================================================================================================================

# PERSIAPAN: MEMBUAT NETWORK
    # Sebelum container dihubungkan ke network, kita bisa membuat network sendiri.
    # Jika --driver tidak ditulis, Docker otomatis memakai driver bridge.
docker network create belajarnetwork

# Penjelasan parameter:
    # docker       : program utama Docker.
    # network      : perintah untuk mengelola network.
    # create       : membuat network baru.
    # belajarnetwork : nama network yang dibuat.

# Versi lengkap dengan driver:
docker network create --driver bridge belajarnetwork

# Penjelasan parameter:
    # --driver bridge : membuat network dengan jenis bridge.
    # belajarnetwork  : nama network yang dibuat.

# ==========================================================================================================================================

# MENGHUBUNGKAN CONTAINER KE NETWORK SAAT CONTAINER DIBUAT
    # Cara ini digunakan jika container belum dibuat.
    # Container akan langsung masuk ke network yang kita tentukan.
docker container create --name mongonetwork --network belajarnetwork --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest

# Penjelasan parameter:
    # docker container create : membuat container baru, tetapi belum menjalankannya.
    # --name mongonetwork     : memberi nama container menjadi mongonetwork.
    # --network belajarnetwork : memasukkan container ke network bernama belajarnetwork.
    # --env                   : menambahkan environment variable ke dalam container.
    # MONGO_INITDB_ROOT_USERNAME="admin"  : username awal untuk MongoDB.
    # MONGO_INITDB_ROOT_PASSWORD="admin123" : password awal untuk MongoDB.
    # mongo:latest            : image yang digunakan, yaitu MongoDB versi latest.

# Menjalankan container setelah dibuat:
docker container start mongonetwork

# Penjelasan parameter:
    # start   : menjalankan container yang sudah dibuat.
    # mongonetwork : nama container yang ingin dijalankan.

# ==========================================================================================================================================

# MENGHUBUNGKAN CONTAINER YANG SUDAH ADA KE NETWORK
    # Cara ini digunakan jika container sudah dibuat sebelumnya,
    # tetapi belum masuk ke network yang kita inginkan.
docker network connect belajarnetwork mongonetwork

# Penjelasan parameter:
    # docker network connect : menghubungkan container ke sebuah network.
    # belajarnetwork         : nama network tujuan.
    # mongonetwork           : nama container yang ingin dimasukkan ke network.

# ==========================================================================================================================================

# MELEPASKAN CONTAINER DARI NETWORK
    # Jika container tidak perlu lagi berada di network tertentu,
    # kita bisa melepasnya menggunakan docker network disconnect.
docker network disconnect belajarnetwork mongonetwork

# Penjelasan parameter:
    # docker network disconnect : melepas container dari sebuah network.
    # belajarnetwork            : nama network yang akan dilepaskan.
    # mongonetwork              : nama container yang dilepas dari network tersebut.

# ==========================================================================================================================================

# MELIHAT NETWORK YANG DIPAKAI CONTAINER
    # Untuk melihat detail container, termasuk network yang digunakan,
    # kita bisa memakai docker container inspect.
docker container inspect mongonetwork

# Penjelasan parameter:
    # docker container inspect : melihat informasi detail sebuah container.
    # mongonetwork             : nama container yang ingin dicek.

# Melihat detail network:
docker network inspect belajarnetwork

# Penjelasan parameter:
    # docker network inspect : melihat informasi detail sebuah network.
    # belajarnetwork         : nama network yang ingin dicek.

# ==========================================================================================================================================

# CONTOH KASUS: APLIKASI DAN DATABASE DALAM SATU NETWORK
    # Misalnya kita punya aplikasi web dan database.
    # Agar aplikasi web bisa terhubung ke database, keduanya dimasukkan
    # ke network yang sama.

    # 1. Buat network khusus aplikasi
docker network create appnetwork

    # 2. Buat container database di network tersebut
docker container create --name mongodb --network appnetwork --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest

    # 3. Buat container web di network yang sama
docker container create --name nginxapp --network appnetwork nginx:latest

    # 4. Jalankan kedua container
docker container start mongodb
docker container start nginxapp

    # Karena mongodb dan nginxapp berada di network yang sama,
    # nginxapp bisa mengenali mongodb menggunakan nama "mongodb".
    #
    # Dalam aplikasi sungguhan, alamat database bisa ditulis seperti ini:
    # mongodb://admin:admin123@mongodb:27017
    #
    # Bagian "mongodb" pada alamat tersebut adalah nama container,
    # bukan IP address.

# ==========================================================================================================================================

# CATATAN PENTING
    # --network hanya menentukan network yang digunakan container.
    # --network tidak otomatis membuat port container bisa diakses dari komputer kita.
    # Jika ingin container bisa diakses dari host, gunakan --publish atau -p.
    #
    # Contoh:
docker container create --name nginxpublic --network appnetwork --publish 8080:80 nginx:latest

# Penjelasan parameter tambahan:
    # --publish 8080:80 : membuka port 80 di container melalui port 8080 di komputer kita.
    # 8080              : port di host atau komputer kita.
    # 80                : port di dalam container.

# ==========================================================================================================================================

# KESIMPULAN
    # Docker container network digunakan untuk mengatur container masuk ke network mana.
    # Gunakan --network saat membuat container baru.
    # Gunakan docker network connect untuk container yang sudah ada.
    # Gunakan docker network disconnect jika container ingin dilepas dari network.
    # Container dalam network yang sama bisa saling memanggil menggunakan nama container.
    # Untuk kebutuhan sehari-hari, buat network sendiri lalu masukkan container yang saling berhubungan ke network tersebut.
