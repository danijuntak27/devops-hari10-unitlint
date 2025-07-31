# Gunakan image Python sebagai base
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Salin file requirements dan install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Salin semua file project ke dalam image
COPY . .

# Jalankan aplikasi
CMD ["python", "app/main.py"]
