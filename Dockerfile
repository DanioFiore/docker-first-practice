# NAME OF THE IMAGE, LOCALLY OR ONLINE INTO THE DOCKERHUB
FROM node

# THIS WILL BE THE ROOT 
WORKDIR /app

# FILES THAT WILL GO INTO THE IMAGE. WITH THE . WE TELL THE SAME FOLDER THAT CONTAINS THE DOCKERFILE, THE SECOND PARAM IS THE PATH INSIDE OF THE IMAGE WHERE THE FILES SHOULD BE STORED
COPY . /app

# AFTER COPIED, I WANT TO RUN A COMMAND. THE COMMANDS HAVE EFFECT INTO THE ROOT DIRECTORY, IN THIS CASE /app. IF THE ARE THE WORKDIR COMMAND, THE COMMAND RUNS THERE, IF THERE AREN'T, THE COMMAND WILL RUN INTO THE FOLDER SPECIFIED INTO COPY
RUN npm install

# EXPOSE ON THE PORT, SAME IN OUR server.js FILE, BUT THIS IS ONLY FOR DOCUMENTATION, IT DOES NOTHING, IT'S A GOOD PRACTICE TO HAVE IT
EXPOSE 80

# WITH THIS COMMAND WE MAKE SURE TO RUN IT WHEN A CONTAINER IS STARTED AND NOT WHEN AN IMAGE IS CREATED
# CMD node server.js TURNS LIKE
# IT MUST BE THE LAST INSTRUCTION
CMD ["node", "server.js"]

# AFTER COMPLETED IT, WE HAVE TO BUILD AN IMAGE WITH THE docker build COMMAND WITH THE PATH WERE THE DOCKERFILE IS, IN THIS CASE docker build .
# AFTER WE HAVE TO RUN THE CONTAINER, WITH docker run -p 3000:80 <container_id>

# TERMINAL COMMANDS
# docker ps = show the running containers
# docker ps -a = show the container history
# docker stop <container_name> = stop the container, to do in another terminal, we don't have to insert the full name, even a few letters it's okay
# docker build <path> = create the image
# -p = port
# docker run -p 3000:80 <container_id> = run the container, 3000 (ex) where we want to expose in our local machine, 80 (ex) internal docker container exposed port

# STUDY
# when we run docker build, we take a snapshot of our code, so if after the image are build, we update our code, the image will not take the changes, we have to re-run docker build to create a new image