# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y \
#   python3.10 \
#   python3-pip \
#   git


# RUN pip install PyYAML

# COPY feed.py /usr/bin/feed.py

# COPY entrypoint.sh /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]


FROM ubuntu:latest

# Install Python, pip, and git
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    git \
    && apt-get clean

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Install PyYAML inside the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install PyYAML

# Copy application code and entrypoint script
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the script has execution permissions
RUN chmod +x /entrypoint.sh

# Set the PATH to include the virtual environment's bin directory
ENV PATH="/opt/venv/bin:$PATH"

# Use the virtual environment Python and pip by default
ENTRYPOINT ["/entrypoint.sh"]
