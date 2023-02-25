# Week 1 — App Containerization

## Required homework

- [x] Watch How to Ask for Technical Help
- [x] Watched Grading Homework Summaries
- [x] Watched Week 1 - Live Streamed Video
- [x] Remember to Commit Your Code
- [x] Watcked Chirag's Week 1 - Spending Considerations
- [x] Watched Ashish's Week 1 - Container Security Considerations
- [x] Containerize Application (Dockerfiles, Docker Compose)
- [x] Document the Notification Endpoint for the OpenAI Document
- [x] Write a Flask Backend Endpoint for Notifications
- [x] Write a React Page for Notifications
- [x] Run DynamoDB Local Container and ensure it works
- [x] Run Postgres Container and ensure it works

## Homework Challenges

- [x] Run the dockerfile CMD as an external script
- [x] Push and tag a image to DockerHub (they have a free tier)
- [x] Use multi-stage building for a Dockerfile build
- [x] Implement a healthcheck in the V3 Docker compose file
- [x] Research best practices of Dockerfiles and attempt to implement it in your Dockerfile

## Proof of work

### Dockerization

In order to allow for development outside of gitpods I made multiple docker-compose files to specify different environment variables to break the dependency on the gitpod environment vars.

### Frontend
After watching the videos for this week's lesson I began making the docker / docker compose files.

I started with the `frontend` container.
While watching the video I was a little confused by this part:
```Dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```
I had seen this method where we copy over the package.json and such and installing them before we copy over the rest of the files, and I was confused. I had thought it would have made more sense to copy over all the files first, I then did some research and found out that doing it in this 3-step format makes it, so we can truly take advantage of Docker's caching. I learned that every command in the Dockerfile essentially makes a new "layer" onto this image. While making these layers it is also caching each layer. So if we copy the package files over and then install them before we copy over all of our actual codebase files that will actually cache the package.json file and all the node_modules so that if we dont make any changes to our packages then it will use the cached image and completely skip redownloading all the node_modules again.

After getting that all documented for future readers:
```Dockerfile
# We copy over the package.json files to take advantage of dockers caching
# When we copy & install first, we are creating an intermediate image since we
# are using the RUN command, that image will be cached, so as long as our dependencies
# dont change it can use this cached version to save time while still being up to date on
# anything that changed.
COPY package*.json ./
RUN npm install

# Now that all the node modules are cached, we can copy over the rest of the things
COPY . .
```
I proceeded on to creating its container in the docker-compose file.

I followed the instructions while watching the video and I found there was an issue at first because I hadn't run `npm install` in the frontend directory, I was curious as to why I needed to run it myself since I figured the docker container would be handling all of that.
Then I looked more into it and found that although we are in fact telling the docker image to install all the node_modules but then since we mount the entire frontend directory as a volume in the docker compose we are effectively overwriting the node_modules when running docker-compose up.
I found we can solve this by defining the node_modules path as a volume in itself so that whenever the image gets built using compose it will run `npm install`, populate the node_modules folder and then using the info we provided in the docker-compose's volume section it creates a random volume to use, copy the first node_modules into this volume, and then mount this volume to `/frontend-react-js/node_modules` in the container. 
This works because in our compose we are defining a volume like this:
```yaml
volumes:
  - /frontend-react-js/node_modules
```
This tells docker that we want a new volume, and we want it to mount to `/frontend-react-js/node_modules` in the container. So when we run `docker compose build` we are creating the image and populating the `node_modules` folder in the image. And when we run `docker compose up` we are creating the container which looks at the path in the volumes section(`/frontend-react-js/node_modules`) and creates a new volume, fills it from the files that are in `/frontend-react-js/node_modules` in the image, and then mounts it to the same path in the container. Leaving the container with an up to date node_modules and leaving the host free of needing `npm` at all.

For my `multi-stage build` I made a builder image to install all the packages and then a dev image for us to actually use in the container. This allows for easy expansion to a prod image/container using `npm run build`.

### Backend 

I didn't have any issues with the backend image/container, it spun up properly and was accessible.

## Notes

- Managed container service (ECS) is when youre using a cloud provider as how you run your containers, whereas an unmmanaged is like docker where we can run them locally or on the cloud
- 

## Notes on main video

- Docker hub is dockers container registry for easy access to all of the containers within said registry. There are many like it but this one is mine (And it follows the OCI registry standards)
- The docker container uses a union type file system when its building its images up so that all the layers of the images are able to work within the same fs.
  - Each command within the docker image is its own layer
- Within the `Dockerfile`, the `workdir` is the working directory that the image will continue the rest of the commands from
  - This will be the directory from the containers filesystem standpoint not the host
