# nss-docker

docker run example

```
docker run -p 4433:4433 -it thekuwayama/nss selfserv -n rsa-server -p 4433 -d /certdb -V tls1.3:tls1.3 -v
```

Note that `/certdb` is build by Dockerfile.

```
docker run -it thekuwayama/nss tstclnt -D -V tls1.3:tls1.3 -o -O -h localhost -p 4433
```
