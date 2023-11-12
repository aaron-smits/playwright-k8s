FROM mcr.microsoft.com/playwright:focal
 
# Set the work directory for the application
WORKDIR /app
 
# Set the environment path to node_modules/.bin
ENV PATH /app/node_modules/.bin:$PATH

# COPY the needed files to the app folder in Docker image
COPY package.json /app/
COPY tests/ /app/tests/
COPY playwright.config.ts /app/

# Get the needed libraries to run Playwright
RUN npm install

CMD ["npx", "playwright", "test", "repeat-each=100"]