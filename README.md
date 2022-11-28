### Vim workspace

Build an image, in this case we are naming as `vim_workspace`.

```
docker build -t vim_workspace .
```


Let's use the image that we build above.

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/:/home/dev/.ssh/:ro vim_workspace
```

