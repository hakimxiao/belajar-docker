# Menambah environment variable (image: bisa pakai ngnx atau redis | tag : adalah versi bisa latest)
docker container create --name namaContainer --env KEY="value" --env KEY2="value2" image:tag

# Contoh image mongodb (Studi Kasus)
    # (--publish kita melakukkan forward agar port local kita bisa diakses di port container)
docker container create --name contohmongo --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME="admin" --env MONGO_INITDB_ROOT_PASSWORD="admin123" mongo:latest