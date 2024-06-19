<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="boardV01.BoardV01DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="boardV01.BoardV01DTO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.io.Resources"%> 
<%@page import="java.io.Reader"%> 
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");   		
	String contextPath = request.getContextPath();
 	String controllerPath = contextPath+"/ControllerBoard.do?category=";
 	String cssPath = contextPath+"/boardJstlMvcMybatis/css/frame.css";
 %>
<!doctype html>
<html>
 <head>
  <meta charset="EUC-KR">
  
  <title>boardList</title>
  <link rel="stylesheet" type="text/css" href="<%=cssPath%>">
  <jsp:useBean id="bodDTO" class="boardV01.BoardV01DTO"/>
  <jsp:useBean id="bodDAO" class="boardV01.BoardV01DAO"/>
  <jsp:setProperty name="bodDTO" property="*"/>
	<script>
	function valSend(no, category){
		document.getElementById('fo').value = no;
		document.getElementById('chk01').value = category;
		 document.forms[0].submit();
	}
	</script>
	
 </head>
 <body>

 <div id ="wrapper">
	<div class="first">
	<p>**Board Contents**</p>
	</div>

	<div class="body">

	<form method="post" action="<%=contextPath %>/ControllerBoard.do">	
		 <input id="fo" type = "hidden" name="bod_no" value="bod_no">
		 <input id="chk01" type = "hidden" name="category" value="">
	</form>

		<%
				ArrayList<BoardV01DTO> dtoL = new ArrayList<BoardV01DTO>();
				Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
				SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
				SqlSession session1 = sqlSessionFactory.openSession(true);
				dtoL = (ArrayList)session1.selectList("boardSelAll");
				
				String vSubject, vWriter, vTime,vContent;
				int vNum;
				if(dtoL!=null){
					int totalRecord=dtoL.size();
					int recPerPage=2;
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
						vNum = dto.getBod_no();
						vSubject=dto.getBod_subject();
						vWriter	=dto.getBod_writer();
						vTime 	=dto.getBod_logtime();
						vContent 	=dto.getBod_content();
		%>
				<table>
				<thead>
				<tr>
				<td colspan="4">
				<a onclick="valSend('<%= vNum %>', 1)">[ 수 정 ] </a>
				<a onclick="valSend('<%= vNum %>', 0)">[ 삭 제 ] </a>
				<a href='<%=controllerPath %>boardTitleList'>[ 글 목록 ] </a>
				<a href='<%=controllerPath %>boardWrite'>[ 글 쓰기] </a>
				</td>
				</tr>
				</thead>
				
				<tbody>
				
				<tr>
				<td class='blac'>Writer</td>
				<td><input type = 'text' class = 'textfiled' value='<%= vWriter %>'></td>
				<td class='blac'>Date</td>
				<td><input type = 'text' class = 'textfiled' value='<%= vTime %>'></td>
				</tr>
				
				<tr>
				<td class='blac'>Title</td>
				<td colspan='3'><input type = 'text' class = 'tilte' value='<%= vSubject %>'></td>
				</tr>
				
				<tr>
				<td class='blac'>Contents</td>
				<td colspan='3'><textarea name='message' rows='20' cols='70' ><%= vContent %></textarea></td>
				</tr>
				</tbody>
				</table>
				<%
					} // Record for
					%>
					<div class="center">
						<div class = "pagination">
						<!-- ◀ 를 클릭했을 때 -->
						<%
						if(nowBlock !=0){
						%>
							<a href= "<%=controllerPath %>boardList&nowBlock=<%=nowBlock-1 %>&nowPage=<%=(nowBlock-1)*pagePerBlock %>"> < </a>
						<% 
						} 
						%>
						<!-- 페이지를 클릭했을 때 -->
						<% 
						for(int idx1 = pageOfBeginBlock; idx1 < pageOfBeginBlock+pagePerBlock; idx1++){
						%>
							<a href= "<%=controllerPath %>boardList&nowBlock=<%=nowBlock %>&nowPage=<%=idx1 %>" onclick="mFocus()"
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
						<a href= "<%=controllerPath %>boardList&nowBlock=<%=nowBlock+1 %>&nowPage=<%=(nowBlock+1)*pagePerBlock %>"> > </a>
						<%
						}else{
							//out.print("등록된 게시물이 없습니다.");
						}
						%>
						</div>
					</div>
		<%		} 
		%>

	</div>

 </div>
  
 </body>
   <style>
  a{
  cursor: pointer;
  }
  .textfiled{
  width: 252px;
  }
   .center {
  text-align: center;
}

.pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
  margin: 0 4px;
}

.pagination a.active {
  background-color: #4CAF50;
  color: white;
  border: 1px solid #4CAF50;
}
.pagination a:hover:not(.active) {background-color: #ddd;}
 </style>
</html>
