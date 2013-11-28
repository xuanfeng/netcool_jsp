Endjava项目
=============
----------------------------------

###Github地址

1.	版本一：https://github.com/xuanfeng/netcool_jsp
2.	版本二：https://github.com/louiseliu/endjava
3.	版本三：https://github.com/sqxieshuai/endJava_fe_be

-----------------------------------------

###环境搭建安装

1.	安装nodejs：http://nodejs.org/
2.	安装git bash：http://msysgit.github.io/（安装时有个打钩的选项记得勾选，可以右键快捷运行，鼠标右键增加Git Bash Here表示成功）
3.	在以上版本中（推荐版本一），点击复制右侧的HTTPS clone URL
4.	选择存放文件夹，鼠标右键点击Git Bash Here（即可在当前路径进行操作，否则还要进行打开磁盘的一系列操作）
    -	输入git clone 
    -	在git bash软件窗口顶部右键->编辑->粘贴，将刚才复制的github项目地址粘贴
    -	Enter运行
    -	开始从github下载项目，等待下载完成

----------------------------------------------

###项目结构解析
- **be_endjava**：用于json文件的新建，获取，编辑，即相当于后台
- **fe_endjava**：用于jsp页面解析，相当于前端本地开发

-------------------------------------------------

###开发流程
1.	在fe_endjava目录下新建`views`和`public`文件夹
    - Views：用于存放jsp文件
    - public：用于存放styles,javascript,images的文件夹
    - 项目启动：进入项目根路径，node app.js启动即可
2.	app.js
    -   指定请求处理函数
        - app.get('/', routes.getIndexPage);       //表示请求首页
        - app.get('/xuanfeng', routes.xuanfeng);   //表示请求某个页面
3.	routes/index.js
    - 开发app.js中定义的函数，处理相应的请求
        - //返回首页，此模板为静态页，不可包含jsp标签
        <pre>
            exports.getIndexPage = function(req, res){
                res.render('index.jsp', {
                    layout: false
                });
            };
        </pre>
        - //请求/xuanfeng，用xuanfeng.json中定义的数据装饰xuanfeng.jsp，并显示页面
        <pre>
        exports.xuanfeng = function(req, res) {
            fs.readFile(jsonFolderPath + "xuanfeng.json", "utf-8", function(err, data){
                if(err != null){
                    console.log(err);
                    res.send("file xuanfeng.json not found");
                }
                else{
                    res.render("xuanfeng.jsp", JSON.parse(data), function(err, html){
                        res.send(html);
                    });
                }
            });
        };
        </pre>
4.	项目预览
    - 后台json数据编写：启动项目后，输入http://localhost:3000/
    - 前端预览页面：http://localhost:3001/，相应的请求直接在后面添加

--------------------------------------

###后台编辑器
- 新建保存数据
- 点击左上角图标，输入文件名，新建json（文件名要唯一，与jsp文件名一致）
- 在右边框可视化编辑数据，点击代码化，点击保存即可
- 数据皆可进行更改，保存在endJava_fe_be\be_endjava\public\jsons

------------------------------------------

###Jstl标签学习
- http://baike.so.com/doc/2686415.html
- http://www.javawind.net/help/html/jstl_el.htm

--------------------------------------------

###前后端合作（关键字约定）
1.	先前端作图（设计稿or草图）
2.	开会时用markman软件在图上标记好关键字
3.	会议后分享图片，前后端均用这个关键字
4.	附markman分享： 文章

------------------------------------------

###标签使用
列出的标签为项目已解析的标签，文件路径请查看下一节endskin.js，可自行扩展
- Include： 引入其他页面

<%@ include file="../../include/taglib.jsp" %>

- Shiro： 用户权限管理

<shiro:guest>游客</shiro:guest>

- duobei:script：用于加载js

<duobei:script type="text/javascript" src="less-1.3.0.min.js" charset="utf-8"/>

- c:set：定义变量

<c:set value="this is andy" var="oneString"/>     ${oneString}

- c:forEach：循环语句

<c:forEach items="${sessionScope.arrayList}" var="arrayListI">${arrayListI}</c:forEach>
<c:forEach var="i" begin="1" end="10" step="1">${i}<br /></c:forEach>

- c:if：条件判断

<c:if test="${paramValues.sampleValue[2] == 12}" var="visits">It is 12</c:if>

- c:when：复杂判断，等价于if

<c:when test="${paramValues.sampleValue[2] == 11}">not 12 not 13,it is 11</c:when>
c:otherwise：复杂判断，等价于else

- <c:otherwise>not 11 、12、13</c:otherwise>

c:shoose： <c:choose>标签没有属性，可被认为是父标签，<c:when>、<c:otherwise>作为其子标签来使用
    <c:choose>
         <c:when test="${paramValues.sampleValue[2] == 11}">
                   not 12 not 13,it is 11
         </c:when>
         <c:when test="${paramValues.sampleValue[2] == 12}">
                   not 11 not 13,it is 12
         </c:when>
         <c:when test="${paramValues.sampleValue[2] == 13}">
                   not 11 not 12,it is 13
         </c:when>
         <c:otherwise>
                   not 11 、12、13
         </c:otherwise>
</c:choose>
支持大部分的jstl标签，可根据需求自行扩展

-------------------------------------------------

###功能扩展

本项目基于nodejs，可以通过修改js代码来扩展功能。

fe_endjava\node_modules\endskin\endskin.js：为解析规则代码，基本都用正则表达式开发

----------------------------------------

###要注意的写法

- 先将文件删除注释及其他没用信息。——已解决
- shiro问题，如何在endjava中使用？——已解决
- cif、cchoose、cwhen中判断逻辑带与、或等，解析问题——基本解决
    - 以下test、test1表示变量
    - 不要使用empty，改用test != null && test != ''
    - 不要使用7>5这种
    - 不要使用5< test,改用test>5
    - 不要使用test != test1这种 
    - 不要在判断的${}中写括号() 

- cforeach各种复杂功能解析——基本解决
- 完善cset——已解决
- 需要验证是否支持${num-1}


