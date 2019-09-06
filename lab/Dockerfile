FROM nginx
COPY files/ /usr/share/nginx/html
COPY nginx/ /etc/nginx
ADD entry.bash /opt/entry.bash
RUN apt update && apt install vim -y
