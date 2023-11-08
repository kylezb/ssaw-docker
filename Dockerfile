FROM ruby:3.2.2-slim-bullseye
#FROM ruby:3.2-slim-bookworm

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Change source and install dependencies
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget make gcc git lib32gcc-s1 && \
    rm -rf /var/lib/apt/lists/*

# Sandstorm server won't run under root
RUN useradd -ms /bin/bash sandstorm
USER sandstorm

WORKDIR /home/sandstorm
RUN git clone https://gitee.com/kylezb/sandstorm-admin-wrapper.git 
COPY --chown=sandstorm:sandstorm steamcmd_linux.tar.gz sandstorm-admin-wrapper/steamcmd/installation/
RUN cp sandstorm-admin-wrapper/config/config.toml.docker sandstorm-admin-wrapper/config/config.toml  && \
    cd sandstorm-admin-wrapper/steamcmd/installation && tar -xvf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz
    
# source 'https://gems.ruby-china.com'
RUN cd sandstorm-admin-wrapper/admin-interface && \
    sed -i 's/rubygems.org/gems.ruby-china.com/g' Gemfile && \
    gem install bundler:2.3.7 && \
    /bin/bash -c bundle


# VOLUME ["/home/sandstorm"]
WORKDIR /home/sandstorm/ssaw
COPY --chown=sandstorm:sandstorm start.sh /home/sandstorm/start.sh
RUN chmod +x /home/sandstorm/start.sh
CMD /home/sandstorm/start.sh
