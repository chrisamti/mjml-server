FROM node:15-alpine

ENV NODE_ENV=production

ENV CORS=""
ENV PORT=80

ENV MJML_KEEP_COMMENTS=false
ENV MJML_VALIDATION_LEVEL=soft
ENV MJML_MINIFY=true
ENV MJML_BEAUTIFY=false
ENV HEALTHCHECK=true
ENV CHARSET="utf8"
ENV DEFAULT_RESPONSE_CONTENT_TYPE="text/html; charset=utf-8"

COPY package* ./

RUN set -ex \
    && apk --no-cache upgrade \
    && apk --no-cache add curl \
    && npm install

COPY index.js ./index.js

COPY healthcheck.sh /healthcheck.sh

HEALTHCHECK --start-period=10s --retries=1 CMD /healthcheck.sh || exit 1

EXPOSE 80

# ENTRYPOINT [ "node", "--inspect=0.0.0.0:9229", "index.js" ]
ENTRYPOINT [ "node", "index.js" ]
