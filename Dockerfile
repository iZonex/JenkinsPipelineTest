FROM python:3.6-alpine

ADD main.py /src/main.py
ADD requirements /src/requirements/

WORKDIR /src

RUN pip install -r requirements/prod.txt

ENTRYPOINT ["python", "main.py"]