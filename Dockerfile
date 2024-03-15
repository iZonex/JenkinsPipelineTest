FROM python:3.13.0a4-alpine

ENV VERSION="0.1.2"

RUN apk add --no-cache gcc=6.4.0-r8 musl-dev=1.1.19-r10

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY app /app
COPY requirements /app/requirements/
COPY tests /tests

WORKDIR /app

RUN pip install -r  /app/requirements/prod.txt


ENTRYPOINT ["/docker-entrypoint.sh"]