FROM python:3.9-slim

# تعيين المسار للعمل
WORKDIR /app

# نسخ الملفات
COPY app.py /app/
COPY templates /app/templates
COPY static /app/static

# تثبيت الحزم مع تنظيف الكاش لتقليل الحجم
RUN pip install --no-cache-dir flask requests
EXPOSE 8080

# تشغيل التطبيق
CMD ["python", "app.py"]

