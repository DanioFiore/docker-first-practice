# NAME OF THE IMAGE, LOCALLY OR ONLINE INTO THE DOCKERHUB
FROM node:12

# THIS WILL BE THE ROOT 
WORKDIR /app

# IS GOOD PRACTICE TO COPY THE PACKAGE.JSON AND RUN NPM INSTALL FOR FIRST, BECAUSE IF WE CHANGE OUR CODE, IT WILL NOT RERUN THE NPM INSTALL COMMAND
COPY package.json /app

# AFTER COPIED, I WANT TO RUN A COMMAND. THE COMMANDS HAVE EFFECT INTO THE ROOT DIRECTORY, IN THIS CASE /app. IF THE ARE THE WORKDIR COMMAND, THE COMMAND RUNS THERE, IF THERE AREN'T, THE COMMAND WILL RUN INTO THE FOLDER SPECIFIED INTO COPY
RUN npm install

# FILES THAT WILL GO INTO THE IMAGE. WITH THE . WE TELL THE SAME FOLDER THAT CONTAINS THE DOCKERFILE, THE SECOND PARAM IS THE PATH INSIDE OF THE IMAGE WHERE THE FILES SHOULD BE STORED
COPY . /app

# EXPOSE ON THE PORT, SAME IN OUR server.js FILE, BUT THIS IS ONLY FOR DOCUMENTATION, IT DOES NOTHING, IT'S A GOOD PRACTICE TO HAVE IT
EXPOSE 80

# WITH THIS COMMAND WE MAKE SURE TO RUN IT WHEN A CONTAINER IS STARTED AND NOT WHEN AN IMAGE IS CREATED
# CMD node server.js TURNS LIKE
# IT MUST BE THE LAST INSTRUCTION
CMD ["node", "server.js"]

# AFTER COMPLETED IT, WE HAVE TO BUILD AN IMAGE WITH THE docker build COMMAND WITH THE PATH WERE THE DOCKERFILE IS, IN THIS CASE docker build .
# AFTER WE HAVE TO RUN THE CONTAINER, WITH docker run -p 3000:80 <container_id>

# TERMINAL COMMANDS
# docker --help = show all commands
# docker ps = show the running containers
# docker ps -a = show the container history
# docker stop <container_name> = stop the container, to do in another terminal, we don't have to insert the full name, even a few letters it's okay
# docker build <path> = create the image
# -p = port
# docker run -p 3000:80 <container_id> = run the container, 3000 (ex) where we want to expose in our local machine, 80 (ex) internal docker container exposed port. By adding -d (docker run -p 3000:80 -d <container_id>) we enter in detatch mode, so we run the container but we now can use the terminal
# docker start <container_name> = run the container in detatch mode
# docker attach <container_name> = we now attach again to the container and block the terminal
# docker logs -f <container_name> = follow the logs when we are in detatch mode, so we can see the console.log
# docker container prune = TO REMOVE ALL STOPPED CONTAINER AT ONCE
# docker rm <container> = to remove a container
# docker image = TO RETRIEVE A LIST OF OUR IMAGES STORED
# docker rmi <image_id> = to remove an image
# docker image prune = same as container
# --rm = ensure to remove the container we it's stopped (docker run -p 3001:80 -d --rm <container>)
# docker image inspect <image_id> = show the details of the image, we didn't see only our layers in the dockerfile, but also the layers of the FROM image
# --name to assign a name to a container when runs (docker run -p 3001:80 -d --rm --name <new_name> <container_name>)
#  -t = to assigna a name and a tag to the image (docker build -t goals:latest .)

# STUDY
# when we run docker build, we take a snapshot of our code, so if after the image are build, we update our code, the image will not take the changes, we have to re-run docker build to create a new image

# the images are build as a layer, it caches the images and if that don't change, it will rebuild it using the cache, when we run docker build. But, if it notice that there is a change in a layer, it use the cache for all the layers before, and rebuild all the layer next. EVERY INSTRUCTION IN AN IMAGE CREATES A CACHABLE LAYER

# TO REMOVE A CONTAINER, WE WIRST NEED TO STOP THAT CONTAINER.  
# WE CAN REMOVE IMAGES IF ONLY THEY ARE NOT USED, SO WE NEED TO STOP THE CONTAINER THAT USE THAT IMAGE

# for images we have tag and name, the syntax is name:tag, for example, (node:14.9.0) so we can specify a specific version