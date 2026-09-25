//FROM python:3.12-slim
//WORKDIR /app
//COPY requirements.txt .
//RUN pip install --no-cache-dir -r requirements.txt
//COPY . . 
//EXPOSE 5000
//cmd ["python", "app.py"]
----------------------------------------------------------------------------------------
//Multistage docker file

FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir \
  --prefix=/install \
  -r requirements.txt

FROM python:3.12-slim
WORKDIR /app
COPY --from builder=/install /usr/local
COPY app.py .
EXPOSE 5000
CMD ["python","app.py"]
