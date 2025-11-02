# MCP-.Net-8-Claude-CLI

this is my attempt to build an independent .Net 8 dev env detached from my computer except local folder for whatever like source or DB.

## TODO 
* add reamde about the Dockerfile
* add reamde about the yaml file



## Instuctions:

CHANGE THE PASSWORDS FOR PRODUCTION!!


IN LOCAL FOLDER:




### build (~5 min)

* `docker-compose build` 	=> ONCE build the image
* `docker-compose up -d` 	=> run it
* `docker-compose ps` 		=> test it runs
* `docker-compose down`		=> shut down


### re-build

* `docker-compose logs` 					=> see why something was not working
* `docker-compose down -v` 					=> remove everything
* `docker rmi mcp-codernet8claude:v1.0` 	=> DELETE everything
* `docker-compose build --no-cache` 		=> rebuild without any cashing (if needed)

back to post build



## start working

* open port 8080 for coder 8083, 8094, 8105, change in yaml file
* list ports `docker port mcp-codernet8claude-dev`.


### build backend api for something 

* `dotnet new webapi -n TestApiSomething`			=> create an API 
* `dotnet run --urls http://0.0.0.0:8083`			=> run the api
* `http://localhost:8083/swagger/index.html`		=> see your api endpoints
* `http://localhost:8083/weatherforecast`			=> test your api




### build http base MCP

* `dotnet new webapi -n TestHttpMCPSomething`		=> create an API 
* `dotnet run --urls http://0.0.0.0:8094`			=> run the api
* `http://localhost:8094/swagger/index.html`		=> see your api endpoints
* `http://localhost:8094/mcp/how-is-ari`			=> test your api [current example copy]



### play with n8n

* `n8nio/n8n`										=> get this from dockerhub
* `docker volume create n8n_data`  					=> give it a volume to save stuff
* run it as below									=> read below
* `http://localhost:5678`							=> browse there and learn n8n

```
docker run -it --rm \
 --name n8n \
 -p 5678:5678 \
 -v n8n_data:/home/node/.n8n \
 docker.n8n.io/n8nio/n8n
```

CMD:
`docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n`

