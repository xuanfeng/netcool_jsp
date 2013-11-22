
var http = require("http"),
    path = require("path"),
    fs = require('fs'),
    jsonFolderPath = "../be_endjava/public/jsons/"

//渲染用户请求的页面
exports.renderPage = function(req, resPage) {
    var jspName = req.params.jspName.toLowerCase(),
        re = /\.jsp$/,
        viewsPath = path.normalize(__dirname + "/../views"),
        filePath = "",
        found = false;

    jspName += (re.test(jspName) ? "" : ".jsp");

    //找jsp文件
    walkFilePath(viewsPath, jspName);

    if(filePath === ""){
        resPage.send(["没找到", jspName].join(""));
    }else{
        //请求json文件
        var jsonName = jspName.replace(re, ".json");
        http.get( "http://localhost:3000/get_file?fileName=" + jsonName, function(res) {
            res.on("data", function(data){
                var errorInfo = ["没找到", jsonName].join("");
                if(data == errorInfo){
                    resPage.send(errorInfo);
                }else{
                    var jsonData = JSON.parse(data);
                    resPage.render(filePath, jsonData);
                }
            });
        });
    }

    //遍历路径查找文件函数
    function walkFilePath(rootPath, fileName){
        
        if(!found){
            var currentDir = fs.readdirSync(rootPath);

            currentDir.forEach(function(fileName){
                var tempPath = rootPath + "/" + fileName;
                if(fs.statSync(tempPath).isFile()){
                    if(fileName == jspName){
                        found = true;
                        filePath = tempPath;
                    }
                }else{
                    walkFilePath(tempPath);
                }
            });
        }
    }

};



//返回首页
exports.getIndexPage = function(req, res){
    res.render('index.jsp', {
        layout: false
    });
};


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


exports.ajax = function(req, res) {
    fs.readFile(jsonFolderPath + "ajax.json", "utf-8", function(err, data){
        if(err != null){
            console.log(err);
            res.send("file ajax.json not found");
        }
        else{
            res.render("ajax.jsp", JSON.parse(data), function(err, html){
                res.send(html);
            });
        }
    });
};
