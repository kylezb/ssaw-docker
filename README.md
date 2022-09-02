# ssaw-docker
insurgency sandstorm game server manager dockerfile

## 使用/Usage
```shell
docker run -d \
--name ssaw \
--restart=always \
-p 7000:51422 \
-p 7777:7777/udp \
-p 7778:27015 \
-p 7779:27131 \
-v path/to/data:/home/sandstorm/ssaw \
wurua/ssaw:latest
```

## 说明/Instructions
- -e TZ=Asia/Shanghai 时区
- -v yourpath:/home/sandstorm/ssaw 宿主机目录：容器目录
- -p xxxx:51422 web管理端口
- -p xxxx:7777/udp 进程端口
- -p xxxx:27015 steam查询端口
- -p xxxx:27131 Rcon管理端口
- ……
- 端口请根据 **容器内启用的端口** 按需分配映射，以免造成冲突浪费
- Port mappings should be assigned based on the port  `enabled in the container`  to avoid conflicts and waste


## 注意
- 请先创建一个用来存放持久化数据的目录，并赋予该目录 **用户 1000:1000** 读写权限；或者直接`chmod 777`（但是这样并不安全）
- 安装完成、正常启动后，如果在**Config界面**遇到如下错误：
```shell
 An error occurred (Errno::ENOENT). Only hosts can see thefollowing message and backtrace: No such file or directory @rb_sysopen - /home/sandstorm/server-configa62789e1-c334-48c3-875d-273c410c9bb1/Game.ini | Backtrace:
 ~/admin-interface/lib/webapp.rb:739:in read' ~/admin-interfacelib/webapp.rb:739:in block in class:SandstormAdminWrapperSite'
 ...
```
- 请前往 `Wrapper` -> `Config` (或者http://ip:port/wrapper-config ),选择 `Restart Wrapper` 重启SSAW

## notice
- Make sure the User( 1000:1000 ) has access (R/W permission) to your data path.

- Fresh install, heading to `Server` -> `Config`, but get errors like this:
```shell
 An error occurred (Errno::ENOENT). Only hosts can see thefollowing message and backtrace: No such file or directory @rb_sysopen - /home/sandstorm/server-configa62789e1-c334-48c3-875d-273c410c9bb1/Game.ini | Backtrace:
 ~/admin-interface/lib/webapp.rb:739:in read' ~/admin-interfacelib/webapp.rb:739:in block in class:SandstormAdminWrapperSite'
 ...
```
- Heading to `Wrapper` -> `Config` (or http://yourip:port/wrapper-config ), then hit `Restart Wrapper` button to restart SSAW.

