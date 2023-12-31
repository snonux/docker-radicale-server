FROM alpine:latest
RUN adduser -D radicale

RUN apk add --no-cache python3 py3-pip
RUN python3 -m pip install --upgrade pip 
RUN python3 -m pip install --upgrade radicale

RUN mkdir /auth /collections /etc/radicale
RUN chown radicale /collections
COPY ./config /etc/radicale/config
COPY ./htpasswd-test /auth/htpasswd
RUN chown 700 /auth
RUN chown 600 /auth/htpasswd

EXPOSE 5232
USER radicale
CMD ["python3", "-m", "radicale", "--debug"]
