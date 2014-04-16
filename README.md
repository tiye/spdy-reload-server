
Serve files with SPDY
------

This repo is based on the materials below:

* https://coderwall.com/p/2gfk4w
* https://github.com/ericallam/spdy-with-server-push-tutorial

File loading before using SPDY:

![](http://jiyinyiyong.u.qiniudn.com/spdy-net-before.png)

After using SPDY

![](http://jiyinyiyong.u.qiniudn.com/spdy-net-after.png)

`cd` to a directory with `app.html`, or change the code as you need,
then run this:

```bash
coffee src/serve.coffee
```

The server would cache all files requested,
and push them to client in following requests to the same url.