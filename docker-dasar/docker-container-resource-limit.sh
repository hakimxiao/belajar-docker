# resource limit
    # digunakan untuk membatasi resource yang digunakan oleh container seperti cpu, memory, dan lain-lain
    # resiko jika memasukkan resource limit yang terlalu besar maka container tidak akan berjalan dengan baik
    # maka alangkah baiknya memasukkan resource limit sesuai kebutuhan agar container berjalan dengan baik tanpa menggangu yang lain 

# A. memory |&| B. cpu (publish digunakan untuk meneruskan port local ke port container)
    # A. digunakan untuk membatasi memory yang digunakan oleh container (formatnya bisa mb=m, gb=g, tb=t)
    # B. digunakan untuk membatasi cpu yang digunakan oleh container (bisa menggunakan bilangan koma)
docker container create --name contohredis --publish 8080:80 --memory 100m --cpus 0.5 redis:latest


     

