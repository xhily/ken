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

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

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

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies and clean up in same layer
RUN npm ci --only=production --omit=dev \
    && npm cache clean --force \
    && rm -rf ~/.npm \
    && find /app/node_modules -name "*.md" -type f -delete \
    && find /app/node_modules -name "*.txt" -type f -delete \
    && find /app/node_modules -name "*.map" -type f -delete \
    && find /app/node_modules -name "*.ts" -type f -delete \
    && find /app/node_modules -name "test" -type d -exec rm -rf {} + 2>/dev/null || true \
    && find /app/node_modules -name "tests" -type d -exec rm -rf {} + 2>/dev/null || true \
    && find /app/node_modules -name "__tests__" -type d -exec rm -rf {} + 2>/dev/null || true \
    && find /app/node_modules -name "example" -type d -exec rm -rf {} + 2>/dev/null || true \
    && find /app/node_modules -name "examples" -type d -exec rm -rf {} + 2>/dev/null || true

# Copy built application from builder stage
COPY --from=builder --chown=nodejs:nodejs /app/build ./build

# Copy static files and other necessary runtime files
COPY --chown=nodejs:nodejs static ./static
COPY --chown=nodejs:nodejs src ./src
COPY --chown=nodejs:nodejs docs ./docs
COPY --chown=nodejs:nodejs docs-book ./docs-book
COPY --chown=nodejs:nodejs docs-class ./docs-class
COPY --chown=nodejs:nodejs docs-english ./docs-english
COPY --chown=nodejs:nodejs docs-tech ./docs-tech
COPY --chown=nodejs:nodejs blog ./blog
COPY --chown=nodejs:nodejs blog-weekly ./blog-weekly
COPY --chown=nodejs:nodejs i18n ./i18n
COPY --chown=nodejs:nodejs author.yaml ./
COPY --chown=nodejs:nodejs docusaurus.config.ts ./
COPY --chown=nodejs:nodejs sidebars.js ./
COPY --chown=nodejs:nodejs babel.config.ts ./

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]
CMD ["npm", "run", "serve", "--", "--port", "3000", "--host", "0.0.0.0"]
