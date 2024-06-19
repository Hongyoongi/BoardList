<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
String msg = request.getParameter("msg");
if(msg == null){
	msg = "Message Chk";
}
%>
<html>
 <head>
  <meta charset="UTF-8">
  <title>boardUpdPro</title>
  <style>
  	@font-face {
	font-family:singleDayFont;
	src: url(./../font/SingleDay-Regular.ttf);
	 }
	#wrapper{
	    font-family:singleDayFont;
		margin:0 auto;
		text-align : center;
	    font-weight: 800;
	}
	#delForm{
	    margin:0 auto;
	    margin-top: 20px;
	    margin-bottom: 5px;
	    width: 500px;
	    height: 60px;
	    background-color: black;
	    display: inline-block;
	    color: white;
	}
	#delForm p{
	    margin:15px auto;
	    font-size: 20px;
	}
	#delBtn{
	    margin:0 auto;
	    margin-top: 5px;
	    width: 500px;
	    height: 80px;
	    background-color: black;
	    color: white;
	}
	#delBtn input{
	    font-family:singleDayFont;
	    margin: 0 auto;
	    margin-top: 15px;
	    width: 200px;
	    height: 50px;
	    background-color: white;
	    font-size: 20px;
	    font-weight: 800;
	}
  </style>
 </head>
 <%
		String contextPath = request.getContextPath();
	 	String controllerPath = contextPath+"/ControllerBoard.do?category=";
	 %>
 <body>
 <div id ="wrapper">
	<form id="formChk" method="post" action="<%=contextPath %>/ControllerBoard.do">
	<input id="fo" type = "hidden" name="category" value="boardTitleList">	
        <div id="delForm">
            <p>**<%=msg %>**</p>
        </div>
        <div id="delBtn">
            <input type="submit" class="btn" value="게시판 목록으로 돌아가기">
        </div>
		</form>
 </div>
  
 </body>
</html>