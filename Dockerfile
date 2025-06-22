# Multi-stage build for smaller image size

# Stage 1: Build stage
FROM node:lts-alpine AS builder

# Environment variables for build
ARG POSTHOG_API_KEY
ARG GISCUS_REPO_ID
ARG GISCUS_CATEGORY_ID
ARG ALGOLIA_APP_ID
ARG ALGOLIA_API_KEY
ARG ALGOLIA_INDEX_NAME

ENV POSTHOG_API_KEY=$POSTHOG_API_KEY
ENV GISCUS_REPO_ID=$GISCUS_REPO_ID
ENV GISCUS_CATEGORY_ID=$GISCUS_CATEGORY_ID
ENV ALGOLIA_APP_ID=$ALGOLIA_APP_ID
ENV ALGOLIA_API_KEY=$ALGOLIA_API_KEY
ENV ALGOLIA_INDEX_NAME=$ALGOLIA_INDEX_NAME

# Set working directory
WORKDIR /app

# Copy package files and install ALL dependencies (including devDependencies for build)
COPY package*.json ./
RUN npm ci

# Copy source files
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production stage
FROM node:lts-alpine AS production

# Environment variables for runtime
ARG POSTHOG_API_KEY
ARG GISCUS_REPO_ID
ARG GISCUS_CATEGORY_ID
ARG ALGOLIA_APP_ID
ARG ALGOLIA_API_KEY
ARG ALGOLIA_INDEX_NAME

ENV POSTHOG_API_KEY=$POSTHOG_API_KEY
ENV GISCUS_REPO_ID=$GISCUS_REPO_ID
ENV GISCUS_CATEGORY_ID=$GISCUS_CATEGORY_ID
ENV ALGOLIA_APP_ID=$ALGOLIA_APP_ID
ENV ALGOLIA_API_KEY=$ALGOLIA_API_KEY
ENV ALGOLIA_INDEX_NAME=$ALGOLIA_INDEX_NAME

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy built application from builder stage
COPY --from=builder /app/build ./build

# Copy static files and other necessary runtime files
COPY static ./static
COPY docusaurus.config.ts ./
COPY sidebars.js ./
COPY babel.config.ts ./

# If you have any other necessary config files for runtime, copy them here
# COPY tsconfig.json ./

# Expose port
EXPOSE 3000

# Start the application
ENTRYPOINT ["npm", "run", "serve", "--", "--build", "--port", "3000", "--host", "0.0.0.0"]
