
/**
 * Module dependencies.
 */

var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');
var ejs = require('ejs');

var app = express();

// all environments
app.set('port', process.env.PORT || 3001);
app.set('views', __dirname + '/views');
// app.engine('.html', ejs.renderFile);
// app.set('view engine', 'html');
app.engine('jsp',require('endskin').__express);
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}


//本地的需求
app.get('/page/:jspName', routes.renderPage);
app.get('/ajax_get_group_menbers?groupId=1', function(req, res){
    res.send(true);
});


http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});



// 自定义路由
app.get('/', routes.getIndexPage);  //直接去routes目录下的index.js来搜索处理函数的名称
// // app.get('/test', routes.test);
app.get('/xuanfeng', routes.xuanfeng);
app.get('/ajax', function(req, res){
    res.send(true);
});