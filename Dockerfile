# Use NodeJS base image
FROM node:13 as build

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install -g ionic
RUN npm ci

# Copy app source
COPY . .

# Bind the port that the image will run on
EXPOSE 8100

# Define the Docker image's behavior at runtime
RUN ionic build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build  /usr/src/app/www/ /usr/share/nginx/html/
