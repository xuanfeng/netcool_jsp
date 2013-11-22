<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${groupDetailVO.groupInfoVO.title}小组 - 多贝公开课</title>
	
	
</head>

<body>

	<div id="main_content_wrap">	
		<div class="main_content cf">
			<div class="content fl">
				<div class="group_detail_wrap cf">
					<div class="group_info fl">
						<a href="${pageContext.request.contextPath}/group/${groupDetailVO.groupInfoVO.uniqueGroupInfoId}" title="${groupDetailVO.groupInfoVO.title}" class="fl"><img src="${groupDetailVO.groupInfoVO.logoSmall}" alt="${groupDetailVO.groupInfoVO.title}" width="50" height="50"></a>
						<div class="nickname_and_member fl">
							<h3>${title}</h3>
							<span>${groupDetailVO.userNum}个成员</span>
						</div>
					</div>
					<div class="group_limit fr">
						<c:set var="status">manage</c:set>
						<c:choose>
							<c:when test="${groupDetailVO.theManager}">
								<a href="${pageContext.request.contextPath}/group/${groupDetailVO.groupInfoVO.uniqueGroupInfoId}/manage" title="管理小组" class="manage_group">管理小组</a>
							</c:when>
							<c:when test="${groupDetailVO.alreadyJoin}">
								<a href="javascript:;" title="退出" class="exit_group">已加入小组&nbsp;|&nbsp;<span>退出</span></a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" title="加入小组" class="join_group <shiro:guest>unlogin</shiro:guest>">加入小组</a>					
							</c:otherwise>
						</c:choose>									
					</div>
					<div class="group_introduce fl cf">
						<div class="introduce_text cf"><div class="intro_text cf">${groupDetailVO.groupInfoVO.intro}</div></div>
						<!-- <a href="javascript:;" class="read_more" title="展开">↓ &nbsp;展开</a> -->
					</div>
				</div>
				<!-- group_detail_wrap -->

				<div class="group_topic_wrap fl" >
					<div class="topic_bar">
						<a class="new_topic topic_current fl" href="javascript:;" title="最新话题">最新话题</a>

						<a class="good_topic fl" href="javascript:;"  title="精华话题">精华话题</a>
						<a class="create_topic fr <shiro:guest>unlogin</shiro:guest>" href="javascript:;" title="发布话题">+&nbsp;发布话题</a>

						<div class="topic_pop_layer mylayer">你必须加入此小组才能发表话题
							<div class="topic_pop_arrow"></div>
						</div>
					</div>
					<!-- 最新话题 -->
					<div class="group_topic_list new_topic_list cf">				
					<!-- ajax atart -->
					<c:choose>

						<c:when test="${empty pagination.items}">
							<div class="no_new_topic">
							小组话题还是空的， 去<a href="javascript:;" title="发布话题">发布</a>一个话题吧！
							
							<div class="topic_no_content_layer mylayer">你必须加入此小组才能发表话题
								<div class="topic_pop_arrow"></div>
							</div>
							</div>
						</c:when>
						
						<c:otherwise>
							<c:forEach items="${pagination.items}"  var="groupTopicVO">
							<div class="one_topic">
								<span class="topic_title fl"><a href="${pageContext.request.contextPath}/group/topic/${groupTopicVO.uniqueGroupTopicId}"  title="${groupTopicVO.title}"> ${groupTopicVO.title} </a><c:if test="${ groupTopicVO.good }"><span class="jing title_flag">精华</span></c:if><c:if test="${ groupTopicVO.top }"><span class="zding title_flag">置顶</span></c:if></span>
								<span class="topic_leader fl"><a href="${pageContext.request.contextPath}/${groupTopicVO.uniqueUserId}" target="_blank" title="${groupTopicVO.owner}">${groupTopicVO.owner}</a></span>
								<span class="topic_response fl">${groupTopicVO.responseNum}回应</span>
								<span class="topic_time fl">${groupTopicVO.lastUpdateTime}</span>
							</div>
							</c:forEach>
							

							<c:if test="${pagination.totalPages > 1}">
								<c:set var="pageUrl" value="${pageContext.request.contextPath}/group/${groupDetailVO.groupInfoVO.uniqueGroupInfoId}/topic" />
								<div class="page_turn group_detail_page_turn" >
									<c:if test="${pagination.hasPrePage}">
										<a class="pre_page" rel="nofollow" <c:choose><c:when test="${pagination.prePage == 1}">href="${pageUrl}"</c:when><c:otherwise>href="${pageUrl}/page/${pagination.prePage}"</c:otherwise></c:choose> title="上一页">上一页</a>
									</c:if>
									<c:forEach items="${pagination.slider}" var="slider">
										<a <c:choose><c:when test="${slider == 1}">href="${pageUrl}"</c:when><c:otherwise>href="${pageUrl}/page/${slider} "</c:otherwise></c:choose> rel="nofollow" title="第${slider}页" <c:if test="${pagination.pageNo eq slider}">class="current"</c:if>>${slider}</a>
									</c:forEach>
									<c:if test="${pagination.hasNextPage}">
										<a class="next_page" rel="nofollow" href="${pageUrl}/page/${pagination.nextPage}" title="下一页">下一页</a>
									</c:if>
								</div>
							</c:if>							
						</c:otherwise>	
					</c:choose>	
					<!-- ajax end -->
							
					</div>
					<!-- 精华话题 -->
					<div class="group_topic_list good_topic_list cf">
					</div>
					<!-- good_topic_list -->
				</div>
				<!-- group_topic_wrap -->

			</div>
			<div class="sidebar fr">
				<div class="group_member fl">
					<h2 class="fl">小组成员</h2>
					<a class="group_all_member fl" href="${pageContext.request.contextPath}/group/${groupDetailVO.groupInfoVO.uniqueGroupInfoId}/members">(全部${groupDetailVO.userNum})</a>
					<ul class="member_list cf fl">
						<c:choose>
							<c:when test="${not empty groupDetailVO.userInfoSimpleVOs}">
								<c:forEach items="${groupDetailVO.userInfoSimpleVOs}" var="userInfoSimple" >
								<li class="fl">
									<a class="pop_profile" href="${pageContext.request.contextPath}/${userInfoSimple.uniqueUserId}" target="_blank" data-user="${userInfoSimple.uniqueUserId}">
										<img src="${userInfoSimple.avatarSmall}" width="40" height="40" title="${userInfoSimple.nickname}" alt="${userInfoSimple.nickname}">
									</a>
								</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p>暂时没有成员加入~~</p>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!-- group_member -->
				<div class="group_creater fl">
					<h2>创建人</h2>
					<div class="creater_info cf">
						<a href="${pageContext.request.contextPath}/${groupDetailVO.uniqueUserId}" target="_blank"><img src="${groupDetailVO.avatarSmall}" alt="${groupDetailVO.nickname}" width="20" height="20"></a>
						<a class="creater_name" href="${pageContext.request.contextPath}/${groupDetailVO.uniqueUserId}" title="${groupDetailVO.nickname}" target="_blank">${groupDetailVO.nickname}</a>
					</div>
					<span class="create_time fl">创建日期：<fmt:formatDate value="${groupDetailVO.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
				</div>
			</div>
			<!-- sidebar -->
			<input type="hidden" name="" class="topic_id" value="${groupDetailVO.groupInfoVO.uniqueGroupInfoId}">
		</div>
	</div>  

	
</body>
</html>