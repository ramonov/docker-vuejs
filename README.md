<p align="center">
    <a href="http://github.com/luisaveiro/dev.env">
        <img src="https://res.cloudinary.com/luisaveiro/image/upload/v1600614169/github/docker-vue-template/docker-vue-template-logo_qj2krh.png" alt="Vue + Docker Logo" width="75%">
    </a>
</p>

<h4 align="center">
    A GitHub template to quickly start Vue.js application running in Docker
</h4>

<p align="center">
    <a href="#about">About</a> •
    <a href="#disclaimer">Disclaimer</a> •
    <a href="#getting-started">Getting Started</a> •
    <a href="#how-to-use">How To Use</a> •
    <a href="#make-commands">Make Commands</a> •
    <a href="#useful-tips">Useful Tips</a> •
    <a href="#known-issues">Known Issues</a> •
    <a href="#license">License</a>
</p>

## About

These instructions will get you through the bootstrap phase of creating a containerised Vue.js application with Docker Compose.

This GitHub template will setup a Docker image with the following packages

- [Node (Alpine)](https://hub.docker.com/_/node)
- [Yarn](https://yarnpkg.com/)
- [Vue CLI](https://cli.vuejs.org/)
- [TypeScript](https://www.typescriptlang.org/)

## Disclaimer
**Please note:** The Dockerfile provided is intended for use in local development environments. **Please do not** use this Dockerfile to deploy your Vue.js application in production environments. 

Please visit [Vue CLI Deployment Documentation](https://cli.vuejs.org/guide/deployment.html#platform-guides) for instructions on how to deploy on various platforms.

## Getting started

Make sure that you have Docker and Docker Compose installed

- Windows or macOS: [Install Docker Desktop](https://www.docker.com/get-started)
- Linux: [Install Docker](https://www.docker.com/get-started) and then [Docker Compose](https://github.com/docker/compose)

## How To Use

#### <ins>Creating a repository from this GitHub template</ins>

To create new projects using this GitHub template, you can click on the ***use this template*** button to create a new repository with this GitHub template.


Below is how your Vue.js project repository is structured. Your Vue.js code will be stored in the `code` folder.

```
.
├── .env
├── docker-compose.yaml
├── Makefile
├── README.md
└── docker
    └── Dockerfile
└── code
    └── ...
```

#### <ins>Setup Docker environment</ins>

Before you setup a new Vue.js application, you will need to create an **.env** file for the Docker Compose file to use. This will allow you to customise your docker setup without having to manually override the Dockerfile and Docker Compose file.

This GitHub template includes a **.env.example** which you can copy from. You can run the following command in your terminal.

```bash
# Create .env from .env.example.
$ cp .env.example .env
```

Your **.env** needs to have the following environment variables.


| #  	| Variable          	| Description                                   	| Example Value 	|
|----	|-------------------	|-----------------------------------------------	|---------------	|
| 1  	| DOCKER_USERNAME   	| Docker hub username                           	| luisaveiro    	|
| 2  	| PROJECT_NAME      	| Project name                                  	| website       	|
| 3  	| CONTAINER_NAME    	| Docker container name                         	| website.local 	|
| 4  	| IMAGE_NAME        	| Image tag                                     	| website       	|
| 5  	| NODE_VERSION      	| Node Docker Version                           	| latest        	|
| 6  	| PROJECT_PATH      	| Project directory in Docker image & container 	| website       	|
| 7  	| ENABLE_TYPESCRIPT 	| Add TypeScript support in Docker image        	| true          	|
| 8  	| NETWORK           	| Docker container network                      	| front-end     	|
| 9  	| VUE_UI_PORT       	| Port used for the UI server                   	| 8000          	|
| 10 	| VUE_UI_HOST       	| Host used for the UI server                   	| 0.0.0.0       	|

#### <ins>Running Docker container</ins>

Once you have updated the **.env** as per your requirements. You can run `docker compose up` or use the `make dev-start` alias command to create your Docker environment.

<details>
<summary><strong>Example of the terminal output</strong></summary>

```bash
$ make dev-start
docker-compose -f docker-compose.yml up
Creating network "front-end" with the default driver
Creating volume "website.local_node_modules" with default driver
Building web
Step 1/11 : FROM node:14.11.0-alpine3.12
...
Successfully tagged luisaveiro/website:latest
WARNING: Image for service web was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating website.local ... done
Attaching to website.local
website.local | 🚀  Starting GUI...
website.local | 🌠  Ready on http://0.0.0.0:8000
website.local | 8000
```

</details>

Once Docker compase as started your Docker Container, you can navigate to http://localhost&colon; &lt;port&gt; in your web browser to access the Vue UI web server.

#### <ins>Creating a new Vue.js project</ins>
Please do not use the Vue UI to create a new project [See known issue #1](#known-issues). Instead you need to use the Vue CLI `create` command inside the Docker container.

You can access the Docker container terminal by using the `make ssh` alias command.

```bash
$ make ssh
# docker exec -t -i website.local /bin/sh
/var/www/website
```

Once you have accessed your Docker container terminal, you will need to run the `vue create .` command. This will create a new Vue.js application in the current directory, which is the volume mounted to your `code` folder.

<details>
<summary><strong>Example of the terminal output</strong></summary>

```bash
$ vue create .

Vue CLI v4.5.6
? Generate project in current directory? (Y/n) y
...

Vue CLI v4.5.6
✨  Creating project in /var/www/website.
⚙️  Installing CLI plugins. This might take a while...
...
success Saved lockfile.
Done in 15.19s.
⚓  Running completion hooks...

📄  Generating README.md...

🎉  Successfully created project website.
👉  Get started with the following commands:

 $ yarn serve
```

</details>

Once Vue CLI has created your new Vue.js application, you will able to access your code in the `code` folder of your repository.

#### <ins>Import Vue.js project into Vue UI</ins>

Once you have a Vue.js project (new or existing), you can import your Vue.js project using Vue UI import function. You will be able to use all the Vue UI functionality for you Vue.js application.

#### <ins>Enabling Hot-Reloading with vue-cli-service serve</ins>

To enable Hot-Reloading in your Docker container when using the **Vue UI serve task**; you will need to include `devServer.watchOptions` in your `vue.config.js` file. This GitHub template includes a `vue.config.js` file in the `code` folder or you can copy the code below.

```javascript
module.exports = {
  devServer: {
    watchOptions: {
      poll: true,
    },
  },
};
```

## Make Commands

This GitHub template includes `Makefile`. A Makefile is a file containing a set of directives used by a make build automation tool to generate a target/goal. The following commands are available for you interact with your Docker environment.

| # 	| Command               	| Description                                             	|
|---	|-----------------------	|---------------------------------------------------------	|
| 1 	| make clean            	| Remove project Docker container, image, network, volume 	|
| 2 	| make clean-yarn-cache 	| Clean Yarn global cache                                 	|
| 3 	| make dev-rebuild      	| Rebuild Docker image and container with Docker compose  	|
| 4 	| make dev-start        	| Start Docker container with Docker compose              	|
| 5 	| make image            	| Build Docker image                                      	|
| 6 	| make publish          	| Publish Docker image to Docker Hub                      	|
| 7 	| make serve            	| Run Docker container without Docker compose             	|
| 8 	| make ssh              	| Access Docker container terminal.                       	|
| 9 	| make stop             	| Stop Docker container                                   	|

## Useful Tips

<details>
<summary><strong>1. Visual Studio Code Extensions</strong></summary>

If you use VS Code as your Development IDE, I recommend the following extensions.

#### <ins>Coding with Vue.js</ins>
- [Vetur (By Pine Wu)](https://marketplace.visualstudio.com/items?itemName=octref.vetur) &equals;&gt; Vue tooling for VS Code

#### <ins>Docker management</ins>
- [Docker (By Microsoft)](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) &equals;&gt; Makes it easy to create, manage, and debug containerized applications.
- [Remote - Containers (By Microsoft)](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) &equals;&gt; Open any folder or repository inside a Docker container and take advantage of Visual Studio Code's full feature set.

</details>

<details>
<summary><strong>2. Self-assigned SSL Certificates</strong></summary>

If you want to use HTTPS with your Vue.js application and not have browsers display a warning message about invalid SSL Certificate, you can use [mkcert (By FiloSottile)](https://github.com/FiloSottile/mkcert) tool. 

[mkcert](https://github.com/FiloSottile/mkcert) is a simple tool for making locally-trusted development certificates. Once you have created you SSL Certificate with mkcert, you will need to copy the files into your Docker container and update your `vue.config.js` file. 

Below is an example of the additional settings you need to include.

```javascript
module.exports = {
  devServer: {
    http2: true,
    https: {
      key: fs.readFileSync('/path/to/local.key'),
      cert: fs.readFileSync('/path/to/local.crt'),
    },
  },
};
```

</details>

## Known issues

<details>
<summary><strong>1. Vue UI is unable to generate a new project in current directory.</strong></summary>

This is a limitation of Vue UI, please visit [GitHub vue-cli issue #1509](https://github.com/vuejs/vue-cli/issues/1509#issuecomment-436707488).

**[Solution]** Access Docker container terminal and run `vue create .` command.
</details>

<details>
<summary><strong>2. Stopping Vue UI `serve task` causes the Vue UI server to crash and stops the docker container.</strong></summary>

It seems the development server which is used by the `serve task` is linked to Vue UI web server. Below is the log of the Vue UI during the crash.

```bash
website.local | events.js:291
website.local |       throw er; // Unhandled 'error' event
website.local |       ^
website.local | 
website.local | Error: spawn /usr/local/share/.config/yarn/global/node_modules/@vue/cli-ui/apollo-server/util/terminate.sh ENOENT
website.local |     at Process.ChildProcess._handle.onexit (internal/child_process.js:268:19)
website.local |     at onErrorNT (internal/child_process.js:464:16)
website.local |     at processTicksAndRejections (internal/process/task_queues.js:80:21)
website.local | Emitted 'error' event on ChildProcess instance at:
website.local |     at Process.ChildProcess._handle.onexit (internal/child_process.js:274:12)
website.local |     at onErrorNT (internal/child_process.js:464:16)
website.local |     at processTicksAndRejections (internal/process/task_queues.js:80:21) {
website.local |   errno: -2,
website.local |   code: 'ENOENT',
website.local |   syscall: 'spawn /usr/local/share/.config/yarn/global/node_modules/@vue/cli-ui/apollo-server/util/terminate.sh',
website.local |   path: '/usr/local/share/.config/yarn/global/node_modules/@vue/cli-ui/apollo-server/util/terminate.sh',
website.local |   spawnargs: [ '77' ]
website.local | }
website.local exited with code 1
```

**[Solution]** re-run `docker-compose up` or `make dev-start` alias command to have everything running again.
</details>

<details>
<summary><strong>3. Hot-Reloading with vue-cli-service serve is slow.</strong></summary>

This is caused by the host-container file system configuration. [Docker documentation](https://docs.docker.com/docker-for-mac/osxfs-caching/#performance-implications-of-host-container-file-system-consistency) provides information on Docker implementations of volume mount.

**[Solution]** run `make clean-yarn-cache` alias command or access the Docker container terminal and run `yarn cache clean` command. Running this command will clear the global cache. It will be populated again the next time `yarn` or `yarn install` is run.
</details>

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.

---

<p align="center">
  <a href="http://github.com/luisaveiro" target="_blank">GitHub</a> •
  <a href="https://uk.linkedin.com/in/luisaveiro" target="_blank">LinkedIn</a> •
  <a href="https://twitter.com/luisdeaveiro" target="_blank">Twitter</a>
</p>
