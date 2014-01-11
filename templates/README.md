Packer template of building CentOS/Debian/Ubuntu virtual machines
=================================================================

Steps

```sh
# build vmware (non-vagrant) box
$ packer build -only=vmware debian.json
# or build virtualbox (vagrant) box
$ packer build -only=virtualbox debian.json
```

