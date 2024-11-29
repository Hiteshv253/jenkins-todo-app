# Use a Python base image
FROM python:3.13-slim

# Set the working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Install virtualenv
RUN pip install virtualenv

# Create and activate the virtual environment
RUN virtualenv /env
ENV VIRTUAL_ENV=/env
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy requirements.txt and install dependencies inside the virtualenv
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy your application code
COPY . .

# Run migrations inside the virtual environment
RUN /env/bin/python manage.py migrate

# Command to run your application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
