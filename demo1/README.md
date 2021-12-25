# DEMO1

1. Run docker container

```bash
docker run --rm --name nginx -p 80:80 -v $PWD/test:/test nginx:1.20-alpine
```

2. exec to container check volume file

```bash
docker exec -it nginx sh
```

## Docker Network

1. Create docker network

```bash
docker network create -d bridge demo_network
```

2. Run app container

```bash
docker run -d --name demo-network1 -p 80:80 --net=demo_network nginx:1.20-alpine
```

3. Run database container
```bash
docker run -d --name demo-network2 --net=demo_network -e POSTGRES_PASSWORD=mysecretpassword postgres:12-alpine
```

4. Check docker network
```bash
docker network ls
docker network inspect demo_network
```

5. Exec app container
```bash
docker exec -it demo-network1 sh
```

6. Test connection
```bash
ping demo-network2
nc -v demo-network2 5432
```
