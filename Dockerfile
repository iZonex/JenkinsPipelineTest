FROM python:3.6-alpine

ENV VERSION="0.1.0"

RUN apk add --no-cache gcc=5.3.0-r0

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY app /app
COPY requirements /app/requirements/
COPY tests /tests

WORKDIR /app

RUN pip install -r  /app/requirements/prod.txt


ENTRYPOINT ["/docker-entrypoint.sh"]