<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<script src="js/jquery.js"></script>
	<script src="js/public.js"></script>
</head>
<body>

	<!-- 测试路径 -->
	<%@ include file="include/index.jsp" %>

	<!-- 测试图片 -->
	<img src="images/Penguins.jpg" width="100" height="50" alt="">

	<h1>测试endJava</h1>

	<hr>
	<p>测试输出变量</p>
	${bar}

	<hr>
	<p>测试c:if</p>
	<c:if test="${bar=='xuanfeng' }">true</c:if>


	<hr>
	<c:choose>

		<c:when test="${pagination.items}">
			<div class="no_new_topic">
			小组话题还是空的， 去<a href="javascript:;" title="发布话题">发布</a>一个话题吧！
		</c:when>


		
		<c:otherwise>
			<c:forEach items="${pagination.items}" var="groupTopicVO" start="1" end="5">
				<div class="one_topic">

					
					<a href=""  title="${groupTopicVO.title}"> ${groupTopicVO.title} </a>
					<c:if test="${groupTopicVO.good}"> ${groupTopicVO.good}精华 </c:if>
					<c:if test="${groupTopicVO.top}"> ${groupTopicVO.top}置顶 </c:if>
					
					<c:if test="${bollean}">${bollean}</c:if>

					<a href="" target="_blank" title="${groupTopicVO.owner}">${groupTopicVO.owner}</a>

					<span class="topic_response fl">${groupTopicVO.responseNum}回应</span>

				</div>
			</c:forEach>
		</c:otherwise>	
		
	</c:choose>	
	
	<!-- 测试ajax -->
	<a  target="ifr" href="/ajax?bookInfoId=2013&bookInfoDetailsId=2012" title="点击删除" id="delete">点击删除</a>
	<!-- <a target="ifr" href="/ajax" title="点击删除" id="delete">点击删除</a> -->


</body>
</html>