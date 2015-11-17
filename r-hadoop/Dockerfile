FROM sequenceiq/hadoop-ubuntu:2.6.0

WORKDIR /opt/

RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -
RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list' && apt-get update && apt-get -y install git r-base build-essential libevent-dev zlib1g-dev libssl-dev libcurl4-gnutls-dev libxml2-dev libssl-dev bison openjdk-7-jdk && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/lib/jvm/java-7-openjdk-amd64/ /usr/lib/jvm/default-java
RUN R -e "install.packages(c('rJava', 'caTools', 'Rcpp', 'RJSONIO', 'bitops', 'digest', 'functional', 'stringr', 'plyr', 'reshape2'), repos='http://cran-mirror.cs.uu.nl')"

RUN wget --quiet http://sourceforge.net/projects/boost/files/boost/1.53.0/boost_1_53_0.tar.gz && tar xf boost_1_53_0.tar.gz && cd boost_1_53_0 && ./bootstrap.sh 2&>1 >> /tmp/buildlog.txt && ./b2 install 2&>1 >> /tmp/buildlog.txt
RUN git clone https://git-wip-us.apache.org/repos/asf/thrift.git && cd thrift && ./bootstrap.sh 2&>1 >> /tmp/buildlog.txt && ./configure --with-boost=/usr/local --with-lua=no 2&>1 >> /tmp/buildlog.txt && make 2&>1 >> /tmp/buildlog.txt && make install 2&>1 >> /tmp/buildlog.txt

# Thrift/RHbase hacks
ADD thrift.pc /usr/local/lib/pkgconfig/thrift.pc
ADD thrift-nb.pc /usr/local/lib/pkgconfig/thrift-nb.pc
RUN cp /usr/local/lib/libthrift-1.0.0-dev.so /usr/lib/.

RUN wget --quiet https://github.com/RevolutionAnalytics/rhbase/blob/master/build/rhbase_1.2.1.tar.gz?raw=true -O rhbase_1.2.1.tar.gz && R -e "install.packages('/opt/rhbase_1.2.1.tar.gz'), repos='http://cran-mirror.cs.uu.nl')" && rm rhbase_1.2.1.tar.gz
RUN wget --quiet https://github.com/RevolutionAnalytics/rhdfs/blob/master/build/rhdfs_1.0.8.tar.gz?raw=true -O rhdfs_1.0.8.tar.gz && R -e "install.packages('/opt/rhdfs_1.0.8.tar.gz'), repos='http://cran-mirror.cs.uu.nl')" && rm rhdfs_1.0.8.tar.gz
RUN wget --quiet https://github.com/RevolutionAnalytics/rmr2/releases/download/3.3.1/rmr2_3.3.1.tar.gz -O rmr2_3.3.1.tar.gz && R -e "install.packages('/opt/rmr2_3.3.1.tar.gz'), repos='http://cran-mirror.cs.uu.nl')" && rm rmr2_3.3.1.tar.gz