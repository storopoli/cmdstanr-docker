# CmdStanR OCI Images

Includes:

- CmdStan built to `/opt/cmdstan-VERSION` with multithreading and OpenMPI support
- CmdStanR (already configured to use the `CMDSTAN` path)
- `{tidyverse}`
- `{bayesplot}`, `{loo}` and `{brms}`

## How to use it

- Docker: `docker pull jstoropoli/cmdstanr`
- GitHub Repository Container (GHCR): `docker pull ghcr.io/storopoli/cmdstanr`

The image follows from the [Rocker Project](https://rocker-project.org) [`tidyverse`](https://rocker-project.org/images/versioned/rstudio.html) Docker image.

This means that all the [environment variables defined previously in Rocker](https://rocker-project.org/images/versioned/rstudio.html#environment-variables) works.

Here are some examples:

- Run with RStudio Server in port `8787`: `docker run --rm -ti -e PASSWORD=yourpassword -p 8787:8787 cmdstanr`
- Run with RStudio Server in port `8888` with `root` access: `docker run --rm -ti -e ROOT=true -e PASSWORD=yourpassword -p 8888:8787 cmdstanr`

## Podman Workaround

If you are running in podman you'll need to override some options:\

```bash
podman run --rm -it \
  --uidmap 1000:0:1 --uidmap 0:1:1000 --uidmap 1001:1001:64536 \
  --gidmap 1000:0:1 --gidmap 0:1:1000 --gidmap 1001:1001:64536 \
  -v ~/myfolder:/home/rstudio \
  -p 8787:8787 \
  -e DISABLE_AUTH=true \
  cmdstanr
```

This was taken from <https://github.com/rocker-org/rocker-versioned2/issues/346#issuecomment-1427196730>

## LICENSE

MIT
