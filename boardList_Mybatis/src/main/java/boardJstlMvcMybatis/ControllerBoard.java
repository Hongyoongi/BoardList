package boardJstlMvcMybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.Resources;

import boardV01.BoardV01DAO;
import boardV01.BoardV01DTO;

@WebServlet("/ControllerBoard.do")
public class ControllerBoard extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");  
		
		
		String context = request.getContextPath();
		String path = context+"/boardJstlMvcMybatis/boardJSP";
		
		String category = request.getParameter("category");
		String bod_no = request.getParameter("bod_no");
		String bod_pwd = request.getParameter("bod_pwd");
		String para ="";
		
		BoardV01DAO bodDAO = new BoardV01DAO();
		
		String vWriter = request.getParameter("bod_writer");
		String vPwd = request.getParameter("bod_pwd");
		String vSubject = request.getParameter("bod_subject");
		String vEmail = request.getParameter("bod_email");
		String vContent = request.getParameter("bod_content");
		String vIP = request.getRemoteAddr();
		
		BoardV01DTO bodDTO = new BoardV01DTO(0,vWriter,vEmail,vSubject,vPwd,"",vContent,0,vIP);
		int su = 0;
		
		if(category != null) {
			//boardList--------------------------------------------------------
			if(category.equals("boardList")) {		// 글 보기 목록으로 가는 로직
				para = "/boardJstlMvcMybatis/boardJSP/boardListMybatis.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(para);
				rd.forward(request, response);
			}
			//boardTitleList--------------------------------------------------------
			else if(category.equals("boardTitleList")) {	// 글 목록으로 가는 로직
				para ="/boardJstlMvcMybatis/boardJSP/boardTitleListMybatis.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(para);
				rd.forward(request, response);
			}
			//boardWrite--------------------------------------------------------
			else if(category.equals("boardWrite")) {	// 글작성으로 가는 로직
				para = path +"/boardWrite.jsp";
			}
			//boardContent--------------------------------------------------------
			else if(category.equals("boardContent")) {	// 글 보기로 가는 로직
				request.setAttribute("bod_no", bod_no);
				para = "/boardJstlMvcMybatis/boardJSP/boardContent.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(para);
				rd.forward(request, response);
			}
			
			//form 경로
			//글작성--------------------------------------------------------
			else if(category.equals("frmWri")) {	//글작성
				Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
				SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
				SqlSession session1 = sqlSessionFactory.openSession(true);
				su = session1.insert("boardInsAll", bodDTO);
				if(su!=0 ){
					para = path+"/boardChk.jsp?msg= "+bodDTO.getBod_writer()+URLEncoder.encode("님 고객정보 등록완료","UTF-8");
				}else {
					para = path+"/boardChk.jsp?msg= "+bodDTO.getBod_writer()+URLEncoder.encode("님 고객정보 등록실패","UTF-8");
				}
			}
			
			//글삭제--------------------------------------------------------
			else if(category.equals("0")) {// 글 삭제 Chk
				
				para = path +"/boardDelUpdChk.jsp?category=0&bod_no="+bod_no;
			}
			else if(category.equals("del")) {	// 글 삭제
				bodDTO.setBod_no(Integer.parseInt(bod_no));
				bodDTO.setBod_pwd(bod_pwd);	
				Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
				SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
				SqlSession session1 = sqlSessionFactory.openSession(true);
				su = session1.insert("boardDelAll", bodDTO);
				if(su!=0 ){
					para = path+"/boardChk.jsp?msg= "+ bodDTO.getBod_no() +URLEncoder.encode("번 글삭제 성공","UTF-8");
				}else {
					para = path+"/boardChk.jsp?msg= "+URLEncoder.encode("글삭제 실패","UTF-8");
				}
			}
			
			//글수정--------------------------------------------------------
			else if(category.equals("1")) {	// 글 수정 Chk
				para = path +"/boardDelUpdChk.jsp?category=1&bod_no="+bod_no;
			}
			else if(category.equals("updChk")) {	// 글 수정 경로 설정
				para = path +"/boardUpdMybatis.jsp?category=0&bod_no="+bod_no;
			}else if(category.equals("upd")) {	// 글 수정
				
				bodDTO.setBod_no(Integer.parseInt(bod_no));	
				Reader reader = Resources.getResourceAsReader("boardJstlMvcMybatis/mybatis-config.xml");
				SqlSessionFactory sqlSessionFactory  = new SqlSessionFactoryBuilder().build(reader);
				SqlSession session1 = sqlSessionFactory.openSession(true);
				su = session1.insert("boardUpdAll", bodDTO);
				
				 if(su!=0 ){
					 para = path+"/boardChk.jsp?msg= "+ bodDTO.getBod_writer() +URLEncoder.encode("님의 정보가 수정되었습니다.","UTF-8");
				 }else{
					 para = path+"/boardChk.jsp?msg= "+URLEncoder.encode( "글 수정에 실패하였습니다.","UTF-8");
				 }
			}
			response.sendRedirect(para);	
		}
	}

}
