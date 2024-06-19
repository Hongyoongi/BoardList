<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="boardV01.BoardV01DTO"%>
    <jsp:useBean id="bodDTO" class="boardV01.BoardV01DTO"/>
<jsp:useBean id="bodDAO" class="boardV01.BoardV01DAO"/>
<jsp:setProperty name="bodDTO" property="*"/>
<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>boardUpdFrame</title>
  <link rel="stylesheet" type="text/css" href="./../css/frame.css">
  
 </head>
 <body>
   <%
 request.setCharacterEncoding("UTF-8");
 String bod_no=request.getParameter("bod_no");
 BoardV01DTO dto = bodDAO.bodSelect(Integer.parseInt(bod_no));
 out.print(dto.getBod_no());
 out.print(dto.getBod_pwd());
 String contextPath = request.getContextPath();
 %>
 <div id ="wrapper">
	<div class="first">
	<p>**게시판 수정**</p>
	</div>
	
	<div class="body">
		<form method="post" action="<%=contextPath %>/ControllerBoard.do">
		<input type="hidden" name="category" value="upd">
		<table>
			<thead>
			<tr>
				<td colspan="4"><a href="boardListMybatis.jsp">[게시판 내용 List]</a>
							<a href="boardTitleListMybatis.jsp">[게시판 목록 List]</a></td>
			</tr>
			</thead>
	
			<tbody>
			<tr>
				<td class = "blac">Write</td>
				<td><input type = "text" class = "textfiled" name="bod_writer" value="<%=dto.getBod_writer() %>" readOnly></td>
				<td class = "blac">Password</td>
				<td><input type = "password" class = "textfiled" name="bod_pwd" value="<%=dto.getBod_pwd() %>" autofocus></td>
			</tr>
	
			<tr>
				<td class = "blac">Title</td>
				<td colspan = "3"><input type = "text" class = "tilte" name="bod_subject" value="<%=dto.getBod_subject() %>"></td>
			</tr>
			<tr>
				<td class = "blac">Email</td>
				<td colspan = "3"><input type = "text" class = "tilte" name="bod_email" value="<%=dto.getBod_email() %>"></td>
			</tr>
	
			<tr>
				<td class = "blac">Contents</td>
				<td colspan = "3"><textarea name="bod_content" rows="20" name="bod_content" cols="70"><%=dto.getBod_content() %></textarea></td>
			</tr>
			</tbody>	
		</table>
			<input id="fo" type = "hidden" name="bod_no" value="<%=dto.getBod_no() %>">
		
			<br>
			<table>
				<tr>
				<td><input type = "submit" class = "button" value = "Update"></td> 
				<td><input type = "reset" class = "button" value = "Reset"></td> 
				</tr>
		</table>
		</form>

		

 </div>
  
 </body>
</html>
