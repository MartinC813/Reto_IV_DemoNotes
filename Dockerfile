FROM python:3.11-slim

WORKDIR /main

COPY v2/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY v2/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

