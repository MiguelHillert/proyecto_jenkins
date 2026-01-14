FROM python:3.9-slim
WORKDIR /app
COPY pichichi.py .
CMD ["python", "pichichi.py"]
