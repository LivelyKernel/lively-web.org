# lively-web.org setup

Consists currently out of

- LivelyWeb installation running on docker (see `lively/`)
- Proxying to a mailman install on a different server

## dir structure

- `http`: nginx config (should be linked to `/etc/nginx/conf.d`)
- `supervisor`: config for supervisord, link to /etc/supervisor/config.d
- `lively` docker setup for running a LiveyWeb
- `mailman` currently unused docker mailman setup
- `logs`: where supervisor puts the log files *not part of the repo*
- `data`: hast a `LivelyKernel/` sub folder used by livey docker *not part of the repo*
