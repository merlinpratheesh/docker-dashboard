# Stage 1: Build Angular app
FROM node:22 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (includes Angular CLI)
RUN npm ci

# Copy all source code
COPY . .

# Build Angular for production (project name is merlin-dashboard)
RUN npx --yes ng build merlin-dashboard --configuration production

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy Angular build output to Nginx html folder
COPY --from=build /app/dist/merlin-dashboard/browser /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
