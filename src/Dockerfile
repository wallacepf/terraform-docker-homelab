FROM alpine

COPY --chmod=755 dbconn.sh /usr/local/bin/dbconn.sh

RUN apk --no-cache add postgresql-client

CMD ["sh", "/usr/local/bin/dbconn.sh"]
