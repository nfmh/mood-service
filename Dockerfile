# Use the latest stable version of Python with Alpine base
FROM python:3.12-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Working directory
WORKDIR /mood-service

# Install system dependencies
RUN apk update && apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    postgresql-dev \
    build-base
# Create a non-root user and group with a fixed UID and GID
RUN addgroup -g 1001 -S appgroup && adduser -u 1001 -S appuser -G appgroup

# Set permissions on the working directory
RUN chown -R appuser:appgroup /mood-service

# Switch to the non-root user
USER appuser

# Copy the current directory contents into the container
COPY . /mood-service

# Upgrade pip and setuptools to latest secure versions
RUN pip install --upgrade pip setuptools==70.0.0

# Install the latest secure dependencies
RUN pip install --no-cache-dir Flask==2.3.3 SQLAlchemy==2.0.21

# Expose the app port
EXPOSE 3002

# Command to run the Flask app
CMD ["flask", "run", "--host=0.0.0.0", "--port=3002"]
