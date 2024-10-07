# Use the latest stable version of Python with Alpine base
FROM python:3.12-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=app:create_app
ENV PYTHONPATH=/mood-service/src

# Working directory
WORKDIR /mood-service

# Install system dependencies
RUN apk update && apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    postgresql-dev \
    build-base \
    tcpdump \
    iputils \
    busybox-extras

# Install Gunicorn before switching users
RUN pip install --upgrade pip setuptools==70.0.0
RUN pip install gunicorn

# Create a non-root user and group with a fixed UID and GID
RUN addgroup -g 1001 -S appgroup && adduser -u 1001 -S appuser -G appgroup

# Set permissions on the working directory
RUN chown -R appuser:appgroup /mood-service

# Grant necessary capabilities for network tools like tcpdump
RUN setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

# Switch to the non-root user
USER appuser

# Copy the current directory contents into the container
COPY . /mood-service

# Install the dependencies from requirements.txt
COPY requirements.txt /mood-service/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the app port
EXPOSE 3002

# Use Gunicorn as the WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:3002", "--log-level", "debug", "--worker-class", "sync", "wsgi:app"]
