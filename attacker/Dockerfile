FROM handsonsecurity/seed-ubuntu:large

# Set any environment variables
ENV CONTAINER_NAME=attacker

# Set the working directory
WORKDIR /code/

# Copy the exploit code into the container
COPY ./exploitCode/ /code/

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]

