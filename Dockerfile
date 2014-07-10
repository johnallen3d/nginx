FROM debian:jessie

RUN useradd -r -s /bin/false nginx

RUN apt-get update && apt-get -y install \
	build-essential \
	curl \
	libpcre3-dev \
	libssl-dev \
	zlib1g-dev

RUN \
	cd /tmp && \
	curl -O http://nginx.org/download/nginx-1.6.0.tar.gz && \
	tar -xzf nginx-1.6.0.tar.gz && \
	cd nginx-1.6.0 && \
	./configure --prefix=/usr/local --with-http_ssl_module --with-http_spdy_module && \
	make -j`nproc` install && \
	rm -rf /tmp/nginx-1.6.0*

ENTRYPOINT ["/usr/local/sbin/nginx", "-g", "daemon off; error_log /dev/stdout info;"]
