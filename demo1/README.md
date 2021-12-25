# DEMO1

1. Run docker container

```bash
docker run --rm --name nginx -p 80:80 -v $PWD/test:/test nginx:1.20-alpine
```

2. exec to container check volume file

```bash
docker exec -it nginx sh
```
