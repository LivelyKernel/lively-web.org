# lively-web.org mailman

mailman install for [](http://lively-web.org)

## setup

Make sure to have the backed-up list data from `/var/lib/mailman` in the folder `var-lib-mailman`. At least `archives/`, `data/`, `lists/` are required.

Install this repo:

```sh
git clone https://github.com/LivelyKernel/mailman-docker.git
cd mailman-docker
./start.sh
```

