endJava_fe_be
=============


###结构

- be_endjava 负责json文件的新建，获取，编辑
- fe_endjava 负责本地开发

###安装

- clone项目
- 在fe_endjava目录下新建`views`和`public`文件夹
- 建软链接
	- views下面建WEB-INF的软链接; public下面建styles,javascript,images的软链接。
	- 命令是： mklink /D [目标地址] [源地址]
		- 比如：mklink  /D  d:/~/javascript  e:/~/javascript
- 分别启动两个项目
	- 进入项目根路径，node app.js启动即可

###使用

- （先略）

