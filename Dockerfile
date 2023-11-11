FROM rocker/tidyverse

LABEL maintainer="Jose Storopoli <jose@storopoli.io>" \
  org.opencontainers.image.authors="Jose Storopoli" \
  org.opencontainers.image.url="https://hub.docker.com/repository/docker/jstoropoli/cmdstanr" \
  org.label-schema.vcs-url="https://github.com/storopoli/cmdstanr-docker" \
  org.label-schema.license="MIT"

# env vars
ENV CSVER=2.33.0
ENV CMDSTAN=/opt/cmdstan-$CSVER

# Rprofile stuff
RUN echo 'options(Ncpus = max(1L, parallel::detectCores() - 1L), mc.cores = max(1L, parallel::detectCores() - 1L))' >> "${R_HOME}/etc/Rprofile.site"

# install openMPI and MPI's mpicxx binary and libglpk for brms
RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl libopenmpi-dev mpi-default-dev libglpk-dev

# set workdir for /opt/cmdstan-CSVER
WORKDIR /opt/

# download and extract cmdstan based on CSVER from github
RUN curl -OL https://github.com/stan-dev/cmdstan/releases/download/v$CSVER/cmdstan-$CSVER.tar.gz \
  && tar xzf cmdstan-$CSVER.tar.gz \
  && rm -rf cmdstan-$CSVER.tar.gz

# copy the make/local to CMDSTAN dir
COPY make/local $CMDSTAN/make/local

# build cmdstan using 2 threads
RUN cd cmdstan-$CSVER \
  && make -j2 build examples/bernoulli/bernoulli

# install cmdstanr with all features and all other stuff
RUN install2.r -e --ncpus -1 bayesplot loo brms arrow
RUN Rscript -e "install.packages('cmdstanr',dependencies=TRUE, repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"

WORKDIR /home/rstudio
CMD ["/init"]

# entrypoint to terminal
ENTRYPOINT ["/bin/bash"]
