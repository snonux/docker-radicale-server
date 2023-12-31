FROM alpine:latest
RUN adduser -D radicale

RUN apk add --no-cache python3 py3-pip
RUN python3 -m pip install --upgrade pip 
RUN python3 -m pip install --upgrade radicale

RUN mkdir /config /collections /etc/radicale
RUN chown radicale /config /collections
COPY ./config /etc/radicale/config

EXPOSE 5232
USER radicale
CMD ["python3", "-m", "radicale", "--debug"]
