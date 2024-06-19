<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>boardWriteFrame</title>
  <link rel="stylesheet" type="text/css" href="./../css/frame.css">
 </head>
 <body>
 <div id ="wrapper">
	<div class="first">
	<p>**게시판 글쓰기**</p>
	</div>
	<%
		String contextPath = request.getContextPath();
	 	String controllerPath = contextPath+"/ControllerBoard.do?category=";
	 %>
	 <form name="frmWri" action="<%=contextPath %>/ControllerBoard.do" method="get">
	 <input type="hidden" name="category" value="frmWri">
		<div class="body">
		<table>
			<thead>
			<tr>
				<td colspan="4"><a href="<%=controllerPath %>boardList">[글 내용 List]</a>
							<a href="<%=controllerPath %>boardTitleList">[글 목록 List]</a></td>
			</tr>
			</thead>
	
			<tbody>
			<tr>
				<td class = "blac">Write</td>
				<td><input type = "text" class = "textfiled" name="bod_writer" placeholder= "HYG" autofocus></td>
				<td class = "blac">Password</td>
				<td><input type = "password" class = "textfiled" name="bod_pwd" placeholder = "****"></td>
			</tr>
	
			<tr>
				<td class = "blac">Title</td>
				<td colspan = "3"><input type = "text" class = "tilte" name="bod_subject" placeholder = "Nice"></td>
			</tr>
			<tr>
				<td class = "blac">Email</td>
				<td colspan = "3"><input type = "text" class = "tilte" name="bod_email" placeholder = ""></td>
			</tr>
	
			<tr>
				<td class = "blac">Contents</td>
				<td colspan = "3"><textarea rows="20" cols="70" name="bod_content" placeholder="행복하루"></textarea></td>
			</tr>
			</tbody>	
		</table>
		</div>
	
		<div><br>
			<table>
				<tr>
				<td><input type = "submit" class = "button" value = "Write"></td> 
				<td><input type = "reset" class = "button" value = "Reset"></td> 
				</tr>
			</table>
		</div>
</form>
</div>   
</body>
</html>
