Lunarvim docker
===============

Build an image, in this case we are naming as `vim_workspace`.

> **Warning**
>
> Make sure that [fonts][lunavim_doc_fonts] are installed into your host/machine, and set in your Terminal.

```
docker build -t vim_workspace --target base .
```


Let's use the image that we build above.

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/:/home/dev/.ssh/:ro -v $HOME/.config/lvim/config.lua:/home/dev/.config/lvim/config.lua -v /var/run/docker.sock:/var/run/docker.sock:ro vim_workspace
```
or you can configure it in your `docker-compose.yml` file 

```
#docker-compose.override.yml

version: '3.8'

services:
  lvim:
    image: vim_workspace
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

user: `dev`
password: `dev`

[lunavim_doc_fonts]: https://www.lunarvim.org/docs/configuration/nerd-fonts

