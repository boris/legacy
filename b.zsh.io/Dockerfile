FROM python:3.6-stretch

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY main.py /app/main.py
RUN mkdir /app/templates && mkdir -p /app/static/css

COPY scripts/entrypoint.sh /app/entrypoint.sh
EXPOSE 5000

CMD /app/entrypoint.sh
