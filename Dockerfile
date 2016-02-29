FROM ubuntu:14.04
MAINTAINER Peter Gusev <gpeetonn@gmail.com>

RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list \
  && echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y \
    nginx \
    build-essential \
    make \
    g++ \
    gfortran \
    libuuid1 \
    uuid-runtime \
    python-setuptools \
    python-dev \
    libpython2.7 \
    python-pip \
    git-core \
    libffi-dev \
    libatlas-dev \
    libblas-dev \
    python-numpy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
  && pip install git+https://github.com/Ticketmaster/metrilyx-2.0.git

RUN cp /opt/metrilyx/etc/metrilyx/metrilyx.conf.sample /opt/metrilyx/etc/metrilyx/metrilyx.conf \
   && cp /opt/metrilyx/data/metrilyx.sqlite3.default /opt/metrilyx/data/metrilyx.sqlite3 \
  && sed -i -e "s/<OpenTSDB url>/OPENTSDB/g" /opt/metrilyx/etc/metrilyx/metrilyx.conf \
  && sed -i "s/user .\+;/user www-data;/g" /etc/nginx/nginx.conf \
  && chown -R www-data:www-data /opt/metrilyx \
  && sed -i "s/NGINX_USER=.\+/NGINX_USER=\"www-data\"/g" /etc/sysconfig/metrilyx \
  && sed -i -e "s/uid.\+/uid\t\t= www-data/g" -e "s/gid.\+/gid\t\t= www-data/g" /opt/metrilyx/etc/metrilyx/uwsgi.conf
  && cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.old &&
  && mv /etc/nginx/conf.d/metrilyx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
ADD start.sh /opt/metrilyx/
RUN chmod 0744 /opt/metrilyx/start.sh
CMD ["/bin/bash", "/opt/metrilyx/start.sh"]
