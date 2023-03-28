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

## LICENSE

MIT
