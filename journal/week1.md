# Week 1 — App Containerization

## Notes on main video

- Docker hub is dockers container registry for easy access to all of the containers within said registry. There are many like it but this one is mine (And it follows the OCI registry standards)
- The docker container uses a union type file system when its building its images up so that all the layers of the images are able to work within the same fs.
  - Each command within the docker image is its own layer
- Within the `Dockerfile`, the `workdir` is the working directory that the image will continue the rest of the commands from
  - This will be the directory from the containers filesystem standpoint not the host
- 
