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
  <title>boardDelFrame</title>
  <link rel="stylesheet" type="text/css" href="./../css/del.css">
 </head>
 <body>
  <%
 request.setCharacterEncoding("UTF-8");
 String bod_no=request.getParameter("bod_no");
 String category=request.getParameter("category");
 BoardV01DTO dto = bodDAO.bodSelect(Integer.parseInt(bod_no));
 out.print(category);
 String contextPath = request.getContextPath();
 %>
 <div id ="wrapper">
	
        <div id="delForm">
            <p>**글을 남기실 때 입력하신 비밀번호를 입력하여 주세요!**</p>
        </div>
        <div>
        <input type="text" id="delTxt" value="" autofocus>
        </div>
            
        <div id="delBtn">
            <input type="button" class="btn" value="확인"onclick='valSend2(<%=bod_no %>, <%=dto.getBod_pwd() %>, <%=category %>)'>
            <input type="button" class="btn" value="취소">
        </div>
        <form id="formChk" method="post" action="">	
			<input id="fo" type = "hidden" name="bod_no" value="">
			<input id="fo2" type = "hidden" name="bod_pwd" value="">
			<input id = "fo1"type="hidden" name="category" value="">
		</form>

	<script>
	function valSend2(no, pwd, category){
		let txt = document.getElementById('delTxt').value;
		let formChk = document.getElementById('formChk');
		if(txt==pwd){
			alert("비밀번호가 일치확인!! 해당메뉴로 이동합니다");
			if(category == 0){
				formChk.action = "<%=contextPath %>/ControllerBoard.do";
				document.getElementById('fo1').value = "del"

			}else{
				formChk.action = "<%=contextPath %>/ControllerBoard.do";
				document.getElementById('fo1').value="updChk"
			}
			document.getElementById('fo').value = no;
			document.getElementById('fo2').value = pwd;
			document.forms[0].submit();
		}else{
			alert("비밀번호가 일치하지 않습니다.");
			
			document.getElementById('delTxt').select();
		}
	}
	</script>
 </div>
  
 </body>
</html>
