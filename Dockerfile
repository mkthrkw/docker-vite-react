ARG NODE_VER
FROM node:${NODE_VER}

USER node
WORKDIR /usr/src/app

# Add after vite create
RUN mkdir node_modules
