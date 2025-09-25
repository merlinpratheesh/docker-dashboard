# Use Nginx to serve the Angular app
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Copy pre-built Angular app from Jenkins workspace
COPY dist/merlin-dashboard/browser .

# Copy custom Nginx configuration for Angular routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
