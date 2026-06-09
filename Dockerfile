FROM python:3.11-slim

WORKDIR /betpulse

RUN pip install --no-cache-dir boto3

COPY . .

EXPOSE 8080

CMD ["python", "-c", "print('Betpulse container running')"]