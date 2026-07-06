# Docker prune
#   Digunakan untuk menghapus semua container, image, dan volume yang tidak digunakan. Dengan parameter -a kita bisa menghapus semua container, image, dan volume 
#   yang tidak digunakan tanpa konfirmasi.
# FITUR PRUNE INI : 
#   Digunakan untuk menghapus secara otomatis tanpa prune maka kita harus satu sattu, network nya, containernya, imagenya, dan volumenya

# | hapus semua container sudah stop
docker container prune

# | hapus semua image yg tidak di gunakan container
docker image prune

# | hapus semua volume yg tidak di gunakan container
docker volume prune

# | satu perintah untuk hapus container, network dan image yang tidak digunakan 
docker system prune 