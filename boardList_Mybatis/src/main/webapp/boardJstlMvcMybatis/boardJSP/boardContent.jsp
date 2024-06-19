<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="boardV01.BoardV01DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.io.Resources"%> 
<%@page import="java.io.Reader"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String contextPath = request.getContextPath();
 	String controllerPath = contextPath+"/ControllerBoard.do?category=";
 	String cssPath = contextPath+"/boardMVC/css/frame.css";
 %>
<html>
 <head>
  <meta charset="UTF-8">
  <title>boardContents</title>
  <link rel="stylesheet" type="text/css" href="<%=cssPath%>">
  <style>
  a{
  cursor: pointer;
  }
  </style>
	<jsp:useBean id="bodDAO" class="boardV01.BoardV01DAO"/>
 </head>
 <body>
 <%
 String bod_no=request.getParameter("bod_no");
 out.print(bod_no);

 int no = Integer.parseInt(bod_no);

 BoardV01DTO dto = new BoardV01DTO(no);


 ArrayList<BoardV01DTO> dtoL = new ArrayList<BoardV01DTO>();

Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
SqlSession session1 = sqlSessionFactory.openSession(true);
dtoL = (ArrayList)session1.selectList("boardContentAll", dto);

 %>
<script>
function valSend(no, category){
	document.getElementById('fo').value = no;
	document.getElementById('chk01').value = category;
	 document.forms[0].submit();
}
</script>
 <div id ="wrapper">
	<div class="first">
	<p>**Board Contents**</p>
	</div>

	<div class="body">
	<form method="post" action="<%=contextPath %>/ControllerBoard.do">	
		 <input id="fo" type = "hidden" name="bod_no" value="bod_no">
		 <input id="chk01" type = "hidden" name="category" value="">
	</form>

	<table>
		<thead>
		<tr>
		<td colspan="4">                
            <a onclick='valSend(<%=dtoL.get(0).getBod_no() %>, 1)'>[ 수 정 ] </a>
            <a onclick='valSend(<%=dtoL.get(0).getBod_no() %>, 0)'>[ 삭 제 ] </a>
            <a href="<%=controllerPath %>boardTitleList">[글 목록 List] </a>
            <a href='<%=controllerPath %>boardWrite'>[ 글 쓰기 ] </a>
		</td>
		</tr>
		</thead>
		<c:set var="dto" value="${dtoL}"/>
		<tbody>
		<tr>
			<td class = "blac">글번호</td>
			<td><input type = "text" class = "textfiled" value="<%=dtoL.get(0).getBod_no() %>"autofocus></td>
			<td class = "blac">조회수</td>
			<td><input type = "text" class = "textfiled" value="<%=dtoL.get(0).getBod_readCnt() %>"></td>
		</tr>
        <tr>
			<td class = "blac">Writer</td>
			<td><input type = "text" class = "textfiled" value="<%=dtoL.get(0).getBod_writer() %>"></td>
			<td class = "blac">Date</td>
			<td><input type = "date" class = "textfiled" value="<%=dtoL.get(0).getBod_logtime()+1 %>"></td>
		</tr>
		<tr>
			<td class = "blac">Title</td>
			<td colspan = "3"><input type = "text" class = "tilte" value="<%=dtoL.get(0).getBod_subject() %>"></td>
		</tr>
		<tr>
			<td class = "blac">Email</td>
			<td colspan = "3"><input type = "text" class = "tilte" value="<%=dtoL.get(0).getBod_email() %>"></td>
		</tr>
		<tr>
			<td class = "blac">Contents</td>
			<td colspan = "3"><textarea name="message" rows="20" cols="70" ><%=dtoL.get(0).getBod_content() %></textarea></td>
		</tr>
		</tbody>	
	</table>
	</div>

 </form>
 </div>
  
 </body>
</html>
