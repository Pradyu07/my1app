# 1. Use a lightweight Python image
FROM python:3.9-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Install Flask (the only dependency for this app)
RUN pip install flask

# 4. Copy the local app.py and templates folder into the container
COPY app.py .
COPY templates/ ./templates/

# 5. Tell the container to listen on port 5000
EXPOSE 5000

# 6. Run the application
CMD ["python", "app.py"]
