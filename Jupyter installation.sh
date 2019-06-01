yum install -y wget bzip2
mkdir anaconda-files
cd anaconda-files
wget https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh
mkdir anaconda-repo
cd anaconda-repo
wget -r --no-parent https://repo.continuum.io/pkgs/free/linux-64/

bash /root/anaconda-files/Anaconda3-2018.12-Linux-x86_64.sh # -u
/opt/anaconda3/bin/conda list
/opt/anaconda3/bin/python
/opt/anaconda3/bin/conda update -n base -c defaults conda
/opt/anaconda3/bin/conda install -c conda-forge jupyterhub
/opt/anaconda3/bin/conda install notebook
/opt/anaconda3/bin/conda install jupyterlab

# Additional options
/opt/anaconda3/bin/conda install --help
/opt/anaconda3/bin/conda install -c conda-forge jupyterhub --verbose --use-index-cache --dry-ryn --offline

# Checking dependencies of packages
awk "/depends/,/features/" /opt/anaconda3/pkgs/[package name]/info/repodata_record.json
sed -n "/depends/,/features/p" /opt/anaconda3/pkgs/[package name]/info/repodata_record.json
# Offline installations
/opt/anaconda3/bin/conda install -c conda-forge /opt/anaconda3/pkgs/[package name].tar.bz2 --verbose --use-index-cache --dry-ryn --offline
# Anaconda Cloud repository: https://anaconda.org/conda-forge/repo

ll /opt/anaconda3/bin/ | grep jupyter
yum install -y npm nodejs
npm install -g configurable-http-proxy

/opt/anaconda3/bin/jupyterhub --generate-config -f /etc/jupyterhub/jupyterhub_config.py
find / -name jupyterhub_config.py
mkdir /srv/jupyterhub
mkdir /etc/jupyterhub
mkdir /var/log/jupyterhub
touch /var/log/jupyterhub/jupyterhub.log
mv /root/jupyterhub_config.py /etc/jupyterhub
vim /etc/jupyterhub/jupyterhub_config.py

/opt/anaconda3/bin/jupyterhub --help-all
/opt/anaconda3/bin/jupyterhub -h
/opt/anaconda3/bin/jupyterhub --no-ssl -f /etc/jupyterhub/jupyterhub_config.py &>>'/var/log/jupyterhub/jupyterhub.log'
/opt/anaconda3/bin/jupyterhub --no-ssl -f /etc/jupyterhub/jupyterhub_config.py --log-file=/var/log/jupyterhub/jupyterhub.log #--user=root

kill -9 $(fuser 8000/tcp 2>/dev/null)
ps -ef | grep jupyterhub | awk '{ print $2 }' | xargs kill -9

touch /etc/init.d/jupyterhub
chmod 755 /etc/init.d/jupyterhub
vim /etc/init.d/jupyterhub
chkconfig --add jupyterhub
#chkconfig --del jupyterhub
chkconfig --list | grep jupyterhub
grep -v '#' /etc/jupyterhub/jupyterhub_config.py
vim /etc/jupyterhub/jupyterhub_config.py

c.Authenticator.admin_users = { 'dsela', 'root', 'pzeger' }
c.Spawner.cmd = ['/opt/anaconda3/bin/jupyterhub_singleuser']

###########################################################################################

The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    jupyterhub-0.9.4           |        py37_1000         1.6 MB  conda-forge
    pamela-1.0.0               |             py_0           9 KB  conda-forge
    nodejs-11.9.0              |       hf484d3e_0        16.3 MB  conda-forge
    conda-4.6.2                |           py37_0         870 KB  conda-forge
    configurable-http-proxy-1.3.0|                0         233 KB  conda-forge
    python-oauth2-1.1.0        |   py37h28b3542_1          87 KB
    alembic-1.0.2              |             py_0         104 KB  conda-forge
    python-editor-1.0.4        |             py_0           9 KB  conda-forge
    mako-1.0.7                 |             py_1          57 KB  conda-forge
    async_generator-1.10       |             py_0          18 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        19.3 MB

The following NEW packages will be INSTALLED:

    alembic:                 1.0.2-py_0           conda-forge
    async_generator:         1.10-py_0            conda-forge
    configurable-http-proxy: 1.3.0-0              conda-forge
    jupyterhub:              0.9.4-py37_1000      conda-forge
    mako:                    1.0.7-py_1           conda-forge
    nodejs:                  11.9.0-hf484d3e_0    conda-forge
    pamela:                  1.0.0-py_0           conda-forge
    python-editor:           1.0.4-py_0           conda-forge
    python-oauth2:           1.1.0-py37h28b3542_1

The following packages will be UPDATED:

    conda:                   4.5.12-py37_0                    --> 4.6.2-py37_0 conda-forge
