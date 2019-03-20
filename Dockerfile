FROM jetbrains/teamcity-agent

ARG timezone=Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

RUN echo ${timezone} > /etc/localtime
RUN add-apt-repository ppa:ondrej/php && apt update && apt install php7.3-cli php7.3-curl php7.3-xml php7.3-sqlite3 php7.3-mbstring php7.3-gd php-pear tzdata -y && pecl install imagick mcrypt
# && dpkg-reconfigure --frontend noninteractive tzdata
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt update && apt install nodejs -y
WORKDIR /tmp
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer && php -r "unlink('composer-setup.php');"