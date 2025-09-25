# Stage 1: Build Angular app
FROM node:22 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies including devDependencies
RUN npm ci

# Copy all source code
COPY . .

# Build Angular for production (merlin-dashboard is project name)
RUN npx --yes ng build merlin-dashboard --configuration production

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy Angular build output to Nginx html folder
COPY --from=build /app/dist/merlin-dashboard /usr/share/nginx/html

# Copy Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
