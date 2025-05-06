# Use Ubuntu as the base image
FROM ubuntu:latest

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the host machine to the container
COPY . .

# Install Python dependencies (if you have a requirements.txt)
RUN pip3 install -r requirements.txt

# Define the default command to run your service
CMD ["python3", "hellow.py"]
