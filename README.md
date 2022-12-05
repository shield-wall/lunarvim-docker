Lunarvim docker
===============

Build an image, in this case we are naming as `vim_workspace`.

> **Warning**
> Make sure that [fonts][lunavim_doc_fonts] are installed into your host/machine, and set in your Terminal.

```
docker build -t vim_workspace .
```


Let's use the image that we build above.

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/:/home/dev/.ssh/:ro -v $HOME/.config/lvim/config.lua:/home/dev/.config/lvim/config.lua -v /var/run/docker.sock:/var/run/docker.sock:ro vim_workspace
```

user: `dev`
password: `dev`

[lunavim_doc_fonts]: https://www.lunarvim.org/docs/configuration/nerd-fonts

