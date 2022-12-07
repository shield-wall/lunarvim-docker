Lunarvim docker
===============

[![Publish image on docker hub](https://github.com/shield-wall/lunarvim-docker/actions/workflows/publish_docker_hub.yml/badge.svg)](https://github.com/shield-wall/lunarvim-docker/actions/workflows/publish_docker_hub.yml)


### Quick start


> **Warning**
>
> Make sure that [fonts][lunavim_doc_fonts] are installed into your host/machine, and set in your Terminal.

Let's use the image that we build above.

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/:/home/dev/.ssh/:ro -v $HOME/.config/lvim/config.lua:/home/dev/.config/lvim/config.lua -v /var/run/docker.sock:/var/run/docker.sock:ro docker shieldwalll/lunarvim
```

or you can configure it in your `docker-compose.yml` file 

```yaml
#docker-compose.override.yml

version: '3.8'

services:
  lvim:
    image: shieldwalll/lunarvim
    # entrypoint: lvim
    volumes:
      - ./:/app
      - ~/.ssh/:/home/dev/.ssh/:ro
      - ~/.config/lvim/config.lua:/home/dev/.config/lvim/config.lua
      - /var/run/docker.sock:/var/run/docker.sock:ro
```

and run

```
docker-compose run --rm lvim

//and after you access your container you run:

lvim
```

> **Note**
> 
> You can also enable the entrypoint in your docker-composer.yml file with **lvim**!

### Docker images

| Lenguage   | image                     |
| ---------- | ------------------------- |
| Default    | shieldwalll/lunarvim      |
| PHP        | shieldwalll/lunarvim:php  |

### Others

**User credentials**

- user: `dev`
- password: `dev`

[lunavim_doc_fonts]: https://www.lunarvim.org/docs/configuration/nerd-fonts

