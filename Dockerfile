FROM python:3.6-alpine

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD app /app
ADD requirements /app/requirements/

WORKDIR /app

RUN pip install -r  /app/requirements/prod.txt


ENTRYPOINT ["/docker-entrypoint.sh"]