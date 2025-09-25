# Use Nginx to serve the Angular app
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy pre-built Angular app from Jenkins workspace
# Assuming you build Docker from workspace root (merlinDockerDeploy)
COPY dist/docker-deploy/browser .

# Copy custom Nginx configuration for Angular routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
