# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal blog website built with Docusaurus v3. The site contains multiple content categories including technical articles, English learning materials, books, and courses.

## Development Commands

### Basic Development Workflow
- `npm install` - Install dependencies
- `npm run start` or `npm run dev` - Start development server on http://localhost:3000
- `npm run build` - Build the site for production
- `npm run serve` - Serve the built site locally

### Internationalization
- `npm run dev:zh` - Start development server in Chinese locale
- `npm run dev:en` - Start development server in English locale

### Code Quality
- `npm run typecheck` - Run TypeScript type checking

## Project Structure

### Content Directories
- `blog/` - Blog posts organized by year
- `docs-tech/` - Technical documentation and knowledge base
- `docs-english/` - English learning materials
- `docs-book/` - Book notes and summaries
- `docs-class/` - Course materials

### Code Structure
- `src/` - Custom React components, pages, and theme overrides
- `docusaurus.config.ts` - Main configuration file
- `sidebars.js` - Sidebar navigation configuration
- `static/` - Static assets like images and fonts

## Key Configuration Files

### docusaurus.config.ts
Main configuration file that defines:
- Site metadata (title, URL, etc.)
- Navigation structure
- Theme configuration
- Plugin configuration
- Internationalization settings

### Environment Variables
The project uses environment variables for optional features:
- `GISCUS_REPO_ID` and `GISCUS_CATEGORY_ID` - For Giscus comments
- `POSTHOG_API_KEY` - For PostHog analytics
- `ALGOLIA_*` variables - For Algolia search

## Deployment
The site can be deployed to Vercel using the provided button in README.md, or built locally with `npm run build` and served with `npm run serve`.