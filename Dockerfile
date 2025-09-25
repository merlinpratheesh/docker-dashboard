# Use Nginx to serve Angular app
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Copy pre-built Angular dist from Jenkins workspace
COPY dist/merlin-dashboard/ .

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
