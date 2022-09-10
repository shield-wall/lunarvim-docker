### Vim workspace

```
docker build -t vim_workspace .
```

```shell
docker run --rm -it -v $(pwd):/app -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $HOME/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro vim_workspace
```

