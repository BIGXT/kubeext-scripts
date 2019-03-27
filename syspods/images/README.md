
## dev.sh

It is a script to install [registry](https://github.com/docker/distribution) in development environment.

Note that if you want the registry is available remotely, please see https://docs.docker.com/registry/insecure/.

In brief, you should edit the daemon.json file in every docker machine, whose default location is /etc/docker/daemon.json on Linux.

```
{
  "insecure-registries" : ["IP:5000"]
}
```

## prod.sh

It is a script to install [registry](https://github.com/docker/distribution) in production environment.

Note that if you want the registry is available remotely, you should mkdir /etc/docker/certs.d/$hostname:443/,
and then execute the following command:

```
cp /etc/registry/domain.crt /etc/docker/certs.d/$hostname:443/ca.crt
```

Note that you can config $hostname by yourself.
