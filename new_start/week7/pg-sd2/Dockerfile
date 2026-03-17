# # Base image to use
# FROM node:latest

# # set a working directory
# WORKDIR /src

# # Copy across project configuration information
# # Install application dependencies
# COPY package*.json /src/

# # Ask npm to install the dependencies
# RUN npm install -g supervisor && npm install && npm install supervisor

# # Copy across all our files
# COPY . /src

# # Expose our application port (3000)
# EXPOSE 3000


# Base image to use
FROM node:20

# Install build tools needed for native modules like sqlite3
RUN apt-get update && apt-get install -y python3 python-is-python3 build-essential

# Set a working directory
WORKDIR /src

# Copy across project configuration information
COPY package*.json /src/

# Install supervisor globally, then install app dependencies
RUN npm install -g supervisor && npm install

# Copy across all our files
COPY . /src

# Expose our application port (3000)
EXPOSE 3000