# Supplied Docker recipe; only COPY paths adapted to this repository layout.
# Existing packaged image is documented in docs/environment.md.
FROM python:3.11-slim

# =============================
# OS dependencies
# =============================
RUN apt-get update && apt-get install -y --no-install-recommends \
    r-base \
    r-base-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libffi-dev \
    build-essential \
    git \
 && rm -rf /var/lib/apt/lists/*

# =============================
# R dependencies
# =============================
RUN R -q -e "install.packages(c('BiocManager','remotes','R.utils'), repos='https://cloud.r-project.org')" \
 && R -q -e "install.packages(c('data.table','doParallel','foreach','mclust','NMF'), repos='https://cloud.r-project.org')" \
 && R -q -e "BiocManager::install('maftools', ask=FALSE, update=FALSE)" \
 && R -e "BiocManager::install('BSgenome', ask=FALSE)" \
 && R -q -e "stopifnot('maftools' %in% rownames(installed.packages())); packageVersion('maftools')" \
 && R -q -e "remotes::install_github(c('PoisonAlien/TCGAmutations','CCICB/TCGAgistic','CCICB/PCAWGmutations'), dependencies=TRUE, upgrade='never')" \
 && R -q -e "library(maftools); library(TCGAmutations); sessionInfo()"

# =============================
# Python dependencies
# =============================
WORKDIR /app
ENV RPY2_CFFI_MODE=ABI

COPY environment/docker-requirements.original.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
 && python -m pip show fastmcp

# =============================
# MCP server
# =============================
COPY src/maftools_mcp/server.py ./server.py

EXPOSE 8000

ENTRYPOINT ["fastmcp", "run", "server.py"]
CMD ["--transport","stdio"]
