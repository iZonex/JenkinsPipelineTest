FROM python:3.6-alpine

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD main.py /src/main.py
ADD requirements /src/requirements/

WORKDIR /src

RUN pip install -r requirements/prod.txt


ENTRYPOINT ["/docker-entrypoint.sh"]