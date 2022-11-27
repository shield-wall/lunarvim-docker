### Vim workspace

Build an image, in this case we are naming as `vim_workspace`.

```
docker build -t vim_workspace .
```


Let's use the image that we build above.

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $HOME/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro vim_workspace
```

