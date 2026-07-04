# DOCKER NETWORK
    # Docker network adalah fitur Docker untuk mengatur cara container saling terhubung.
    # Bayangkan setiap container seperti rumah kecil. Agar rumah-rumah itu bisa saling bicara,
    # Docker menyediakan "jalan" bernama network.
    #
    # Dengan network, container bisa:
    #   - berkomunikasi dengan container lain
    #   - dipisahkan dari container yang tidak perlu terhubung
    #   - diakses dari luar melalui port forwarding
    #   - menggunakan nama container sebagai alamat, bukan harus mengingat IP address
    #
    # Contoh sederhana:
    #   aplikasi web butuh database
    #   maka container web dan container database bisa dimasukkan ke network yang sama
    #   agar web bisa mengakses database dengan aman dan mudah.

# ==========================================================================================================================================

# RINGKASAN DOCKER NETWORK
    # Network membuat container bisa saling bicara.
    # Container dalam network yang sama bisa saling mengakses.
    # Container dalam network berbeda akan terpisah, kecuali kita hubungkan secara sengaja.
    # User-defined network lebih disarankan dibanding network bawaan, karena lebih mudah diatur.

# ==========================================================================================================================================

# LIST NETWORK
docker network ls

# MELIHAT DETAIL NETWORK
docker network inspect bridge

# MEMBUAT NETWORK BARU
docker network create contohnetwork

# MEMBUAT NETWORK DENGAN DRIVER TERTENTU
    # --driver digunakan untuk menentukan jenis network yang ingin dibuat.
    # Jika --driver tidak ditulis, Docker akan otomatis menggunakan driver bridge.
    #
    # Jadi command ini:
docker network create contohnetwork

    # Sama artinya dengan command ini:
docker network create --driver bridge contohnetwork

    # Bridge adalah default karena paling cocok untuk penggunaan umum,
    # terutama saat beberapa container berjalan di satu komputer yang sama.

# MENGHAPUS NETWORK
    # Pastikan network tidak sedang digunakan oleh container.
docker network rm contohnetwork

# ==========================================================================================================================================

# MENGHUBUNGKAN CONTAINER KE NETWORK SAAT DIBUAT
    # Container akan langsung masuk ke network yang kita tentukan.
docker container create --name mongonetwork --network contohnetwork --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest

# MENGHUBUNGKAN CONTAINER YANG SUDAH ADA KE NETWORK
docker network connect contohnetwork mongonetwork

# MELEPASKAN CONTAINER DARI NETWORK
docker network disconnect contohnetwork mongonetwork

# ==========================================================================================================================================

# NETWORK DRIVER
    # Network driver adalah jenis atau cara kerja network di Docker.
    # Driver menentukan bagaimana container berkomunikasi.
    # Setiap driver punya tujuan yang berbeda, jadi kita pilih sesuai kebutuhan.
    #
    # Bentuk command umum:
docker network create --driver nama_driver nama_network

    # Contoh:
docker network create --driver bridge contohnetwork

    # Jika driver tidak disebutkan:
docker network create contohnetwork

    # Maka Docker otomatis membuat network dengan driver bridge.
    # Jadi default network driver untuk docker network create adalah bridge.

# JENIS-JENIS NETWORK DRIVER
    # 1. bridge  : default, untuk komunikasi container dalam satu host.
    # 2. host    : container memakai network host secara langsung.
    # 3. none    : container tidak memakai network sama sekali.
    # 4. overlay : menghubungkan container antar host, biasanya untuk Docker Swarm.
    # 5. macvlan : container terlihat seperti perangkat sendiri di jaringan fisik.

# 1. BRIDGE
    # Bridge adalah driver default yang paling sering digunakan.
    # Cocok untuk menjalankan beberapa container dalam satu komputer atau satu host.
    # Container dalam bridge network yang sama bisa saling mengakses.
    #
    # Biasanya digunakan untuk belajar, development, atau aplikasi kecil di satu mesin.
docker network create --driver bridge bridgenetwork

# 2. HOST
    # Host membuat container memakai network milik host secara langsung.
    # Artinya container tidak punya isolasi network sendiri.
    # Performa bisa lebih cepat, tapi pemisahan network menjadi lebih tipis.
    #
    # Cocok untuk kebutuhan khusus yang butuh akses langsung ke network host.
    # Driver host umumnya digunakan di Linux.
docker container create --name nginxhost --network host nginx:latest

# 3. NONE
    # None membuat container tidak memiliki akses network.
    # Container benar-benar dipisahkan dari jaringan.
    #
    # Cocok untuk proses yang tidak butuh internet atau komunikasi network.
docker container create --name nginxnone --network none nginx:latest

# 4. OVERLAY
    # Overlay digunakan untuk menghubungkan container yang berjalan di beberapa host berbeda.
    # Biasanya dipakai di Docker Swarm.
    #
    # Cocok untuk aplikasi yang berjalan di banyak server.
docker network create --driver overlay overlaynetwork

# 5. MACVLAN
    # Macvlan membuat container terlihat seperti perangkat fisik di jaringan.
    # Container bisa punya alamat IP sendiri di jaringan yang sama dengan host.
    #
    # Cocok untuk kebutuhan jaringan lanjutan, misalnya container harus terlihat seperti mesin terpisah.

# ==========================================================================================================================================

# CONTOH KASUS: APLIKASI DAN DATABASE DALAM SATU NETWORK
    # 1. Buat network
docker network create appnetwork

    # 2. Buat container database di network tersebut
docker container create --name mongodb --network appnetwork --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest

    # 3. Buat container lain di network yang sama
docker container create --name nginxapp --network appnetwork nginx:latest

    # Karena keduanya berada di network yang sama,
    # container nginxapp bisa mengenali container mongodb dengan nama "mongodb".

# ==========================================================================================================================================

# KESIMPULAN
    # Docker network adalah jembatan komunikasi antar container.
    # Gunakan bridge untuk kebutuhan umum di satu komputer.
    # Gunakan host jika container perlu memakai network host secara langsung.
    # Gunakan none jika container tidak boleh memakai network.
    # Gunakan overlay untuk banyak host atau server.
    # Gunakan macvlan jika container perlu terlihat seperti perangkat sendiri di jaringan.
    #
    # Untuk penggunaan sehari-hari, user-defined bridge network adalah pilihan yang paling nyaman,
    # karena container bisa saling mengakses menggunakan nama container.
