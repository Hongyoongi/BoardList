package boardV01;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Scanner;
import common.DbClose;
import common.DbSet;

public class BoardV01DAO {
	BoardV01DTO bodDTO = new BoardV01DTO();
	
	Scanner sc = new Scanner(System.in);
	String url= "jdbc:oracle:thin:@localhost:1521:XE";
	String vUser = "hr";
	String vPassword = "hr";
	String sql = "select * from boardV01";
	String sql2;
	
	Connection conn;
	Statement stmt;
	ResultSet rs;
	PreparedStatement pstmt;
	int su;
	
	public int bodWrite(BoardV01DTO bodDTO) {
		int su=0;
		String vWriter = bodDTO.getBod_writer();
		String vPwd = bodDTO.getBod_pwd();
		String vSubject = bodDTO.getBod_subject();
		String vEmail = bodDTO.getBod_email();
		String vContent = bodDTO.getBod_content();
		String vConnIp=bodDTO.getBod_connIp();
		try {
			conn = DbSet.getConnection();
			sql2 = "select max(bod_no) as num from boardV01";
			pstmt = conn.prepareStatement(sql2);
			rs = pstmt.executeQuery();
			int number =1;
			while(rs.next()) {
				number=rs.getInt("num")+1;
			}
			sql2 = "insert into boardV01 values(?,?,?,?,?,sysdate,?,0,?)";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, number);
			pstmt.setString(2, vWriter);
			pstmt.setString(3, vEmail);
			pstmt.setString(4, vSubject);
			pstmt.setString(5, vPwd);
			pstmt.setString(6, vContent);
			pstmt.setString(7, vConnIp);
			BoardV01DTO dto = new BoardV01DTO();
			su = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(pstmt,conn);
		}
		return su;
	}
	
	String  bod_writer, bod_email, bod_subject,bod_pwd, bod_logtime,bod_content,bod_connIp;
	int bod_no,bod_readCnt;
	public ArrayList<BoardV01DTO> bodSelect(){
		ArrayList<BoardV01DTO> dtoL = new ArrayList<BoardV01DTO>();
		sql = "select * from boardV01";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs!=null)
			while (rs.next()) {
				bod_no = rs.getInt("bod_no");
				bod_writer = rs.getString("bod_writer");
				bod_email = rs.getString("bod_email");
				bod_subject = rs.getString("bod_subject");
				bod_pwd = rs.getString("bod_pwd");
				bod_logtime = rs.getString("bod_logtime");
				bod_content = rs.getString("bod_content");
				bod_readCnt = rs.getInt("bod_readCnt");
				bod_connIp = rs.getString("bod_connIp");
				BoardV01DTO dto = new BoardV01DTO(bod_no, bod_writer, bod_email, bod_subject ,bod_pwd, bod_logtime, bod_content, bod_readCnt, bod_connIp);
				dtoL.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(rs,pstmt,conn);
		}
		return dtoL;
	}
	public BoardV01DTO bodSelect(int bod_no){
		BoardV01DTO dto = null;
		sql = "select * from boardV01 where bod_no =?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bod_no);
			rs = pstmt.executeQuery();
			if(rs!=null)
			while (rs.next()) {
				bod_no = rs.getInt("bod_no");
				bod_writer = rs.getString("bod_writer");
				bod_email = rs.getString("bod_email");
				bod_subject = rs.getString("bod_subject");
				bod_pwd = rs.getString("bod_pwd");
				bod_logtime = rs.getString("bod_logtime");
				bod_content = rs.getString("bod_content");
				bod_readCnt = rs.getInt("bod_readCnt");
				bod_connIp = rs.getString("bod_connIp");
				dto = new BoardV01DTO(bod_no, bod_writer, bod_email, bod_subject ,bod_pwd, bod_logtime, bod_content, bod_readCnt, bod_connIp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(rs,pstmt,conn);
		}
		readCntChk(bod_no);
		return dto;
	}
	public void readCntChk(int bod_no) {
		int cnt=0;
		sql="select bod_readCnt from boardV01 where bod_no = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bod_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
				cnt++;
			}
			sql = "update boardV01 set bod_readCnt = ? where bod_no = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			pstmt.setInt(2, bod_no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(rs,pstmt,conn);
		}
	}
	public int bodDelete(BoardV01DTO bodDTO) {
		bod_no = bodDTO.getBod_no();
		bod_pwd = bodDTO.getBod_pwd();
		int su=0;
		sql="delete from boardV01 where bod_no=? and bod_pwd=? ";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bod_no);
			pstmt.setString(2, bod_pwd);
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(pstmt,conn);
		}
		return su;
	}
	public int bodUpdate(BoardV01DTO bodDTO) {
		bod_pwd = bodDTO.getBod_pwd();
		bod_subject = bodDTO.getBod_subject();
		bod_email = bodDTO.getBod_email();
		bod_content = bodDTO.getBod_content();
		bod_no = bodDTO.getBod_no();
		int su=0;
		try {
			conn = DbSet.getConnection();
			sql="update boardV01 set bod_pwd=?, bod_subject=?, bod_email=?, bod_content=? where bod_no=?";
			sql2 = "update boardV01 set bod_pwd=?, bod_subject=?,"
					+"bod_email=?, bod_content=?"
					+"where bod_no=?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, bod_pwd);
			pstmt.setString(2, bod_subject);
			pstmt.setString(3, bod_email);
			pstmt.setString(4, bod_content);
			pstmt.setInt(5, bod_no);
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbClose.close(pstmt,conn);
		}
		return su;
	}
}

