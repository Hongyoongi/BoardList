<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="common.DbSet"%>
<%@page import="boardV01.BoardV01DTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.io.Resources"%> 
<%@page import="java.io.Reader"%>            
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String contextPath = request.getContextPath();
	 	String controllerPath = contextPath+"/ControllerBoard.do?category=";
	 	String cssPath = contextPath+"/boardJstlMvcMybatis/css/title.css";
	 %>
<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>boardTitleListFrame</title>
  <link rel="stylesheet" type="text/css" href="<%=cssPath%>">
 </head>
 <body>
 	<%
 	
 	%>
 	<jsp:useBean id="bodDTO" class="boardV01.BoardV01DTO"/>
	<jsp:useBean id="bodDAO" class="boardV01.BoardV01DAO"/>
	<jsp:setProperty name="bodDTO" property="*"/>
 <div id ="wrapper">
	<div class="first">
	<p>**Board Title List**</p>
	</div>
	<div class="body">
			<table class ="tb1">
				<thead>
				<tr>
					<td colspan="6" style="background-color:white;">
						<a href="<%=controllerPath %>boardList">[글 내용 List]</a>
						<a href="<%=controllerPath %>boardTitleList">[글 목록 List]</a>
					</td>
				</tr>
				</thead>
				<tr class="tr1">
					<td class="bod_no">번호</td>
					<td class="bod_suject">제목</td>
					<td class="bod_writer">글쓴이</td>
					<td class="bod_logtime">등록일</td>
					<td class="bod_readCnt">조회</td>
					<td class="bod_connIp">IP</td>
				</tr>
				</table>
			
				<%
				
				ArrayList<BoardV01DTO> dtoL = new ArrayList<BoardV01DTO>();
				Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
				SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
				SqlSession session1 = sqlSessionFactory.openSession(true);
				dtoL = (ArrayList)session1.selectList("boardSelAll");
				
				int vNo, vCnt;
				String vSubject, vWriter, vTime,vIp;
				if(dtoL!=null){
					int totalRecord=dtoL.size();
					int recPerPage=10;
					int pagePerBlock=10;
					
					int totalPage = (int)Math.ceil((double)totalRecord/recPerPage);	//총페이지 수
					int totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);	//총페이지 수
					
					int nowPage=0;	//현재 페이지 위치
					int nowBlock=0;	//현재 블럭 위치
					//nowPage, nowblock 값을 다시 받아오기
					
					if(request.getParameter("nowPage") != null){
						nowPage = Integer.parseInt(request.getParameter("nowPage"));
					}
					if(request.getParameter("nowBlock") != null){
						nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
					}
					int recOfBeginPage = nowPage*recPerPage;
					int pageOfBeginBlock = nowBlock*pagePerBlock;
					
					for(int idx = recOfBeginPage; idx < recOfBeginPage+recPerPage; idx++){
						if(idx>= totalRecord){
							break;
							}
						BoardV01DTO dto = (BoardV01DTO)dtoL.get(idx);
						vNo 	= dto.getBod_no();
						vSubject=dto.getBod_subject();
						vWriter	=dto.getBod_writer();
						vTime 	=dto.getBod_logtime();
						vCnt 	=dto.getBod_readCnt();
						vIp 	=dto.getBod_connIp();
					
				
						%>
						<form method="post" action="<%=controllerPath %>boardContent">	
		 					<!-- <input id="fo" type = "hidden" name="category" value="boardContent"-->
		 					<input id="fo1" type = "hidden" name="bod_no" value=""> 
		 				</form>
		 				
						<table class="table2" style="cursor:pointer;"onclick="valSend(<%=vNo %>)">
					
							<tr class="tr2">
								<td class="bod_no" ><%=vNo %></td>
								<td class="bod_suject"><%=vSubject %></td>
								<td class="bod_writer"><%=vWriter %></td>
								<td class="bod_logtime"><%=vTime %></td>
								<td class="bod_readCnt"><%=vCnt %></td>
								<td class="bod_connIp"><%=vIp %></td>
							</tr>
							
						</table>
					<%	} %>
					<div class="center">
						<div class = "pagination">
						<!-- ◀ 를 클릭했을 때 -->
						<%
						
						if(nowBlock !=0){
						%>
							<a href= "<%=controllerPath %>boardTitleList&nowBlock=<%=nowBlock-1 %>&nowPage=<%=(nowBlock-1)*pagePerBlock %>"> < </a>
						<% 
						} 
						%>
						<!-- 페이지를 클릭했을 때 -->
						<% 
						for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock+pagePerBlock; idx1++){
						%>
							<a href= "<%=controllerPath %>boardTitleList&nowBlock=<%=nowBlock %>&nowPage=<%=idx1 %>" onclick="mFocus()"
									class="page"><%=idx1+1 %></a>
						<% 
							if(idx1+1==totalPage){
								break;
							}
						}
					%>
						<!-- ▶를 클릭했을 때 -->
						<%
						if(nowBlock +1 < totalBlock){
						%>
						<a href= "<%=controllerPath %>boardTitleList&nowBlock=<%=nowBlock+1 %>&nowPage=<%=(nowBlock+1)*pagePerBlock %>"> > </a>
						<%
						}else{
							//out.print("등록된 게시물이 없습니다.");
						}
						%>
						</div>
					</div>
			<%} %>
		<script>
		function valSend(no){
			document.getElementById('fo1').value = no;
			 document.forms[0].submit();
		}
		</script>
		
 	</div>
 </div>
 </body>

</html>
