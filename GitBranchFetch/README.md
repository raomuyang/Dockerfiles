# Git 分支自动下载更新工具

指定仓库和分支，定时自动更新到本地，用于博客等静态文件的更新


```
docker run --name=blog-fetch -v {local}:{container_path} -d raomengnan/git-interval-fetch:latest -r {repo} -o {container_out_path} -i {interval} -b {branch}
```

Image: docker.io/raomengnan/git-interval-fetch
