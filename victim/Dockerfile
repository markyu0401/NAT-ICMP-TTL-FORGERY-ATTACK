FROM handsonsecurity/seed-ubuntu:large

# Set any environment variables
ENV CONTAINER_NAME=victim

# Set the working directory
WORKDIR /code/

# Copy the exploit code into the container
COPY ./exploitCode/ /code/

# Set the container to run in privileged mode with all capabilities
# Note: This cannot be set from a Dockerfile and needs to be done at runtime

# Set up the network route commands
# These commands may need to be run manually after the container starts
# Dockerfiles do not support interactive commands like 'bash -c'

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]

