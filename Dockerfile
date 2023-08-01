FROM rootproject/root:6.28.00-ubuntu22.04

ENV PANDA_WORKDIR /
WORKDIR /work

MAINTAINER Paul Nilsson

RUN apt-get update && apt-get install -y python3-pip

# Install packages from PyPI. These are the ones needed for almost any
# Jupyter installation.
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade jupyter metakernel
RUN pip3 install --upgrade numpy scipy matplotlib

# Packages
RUN pip3 install --upgrade jupyterlab
RUN pip3 install --upgrade iminuit sympy terminado urllib3 tables
RUN pip3 install --upgrade uproot coffea pyarrow
RUN pip3 install --no-cache-dir "pandas==2.0.1"
RUN pip3 install --no-cache-dir "dask[complete]==2023.4.1"
RUN pip3 install --upgrade dask-histogram dask-awkward

# Forward current workdir to user so they can find input files staged in by pilot
RUN export PANDA_WORKDIR=$PANDA_WORKDIR

# local running: CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", '--token=_hashed_password_']
