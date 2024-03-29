
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("doPost");
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			connection = DBCPConnection.getConnection();
			pstmt = connection.prepareStatement("select empno,ename,sal from emp");
			rs = pstmt.executeQuery();
			if (rs != null) {
				PrintWriter writer = response.getWriter();
				while (rs.next()) {
					String empno = rs.getString("empno");
					String ename = rs.getString("ename");
					String sal = rs.getString("sal");
					System.out.println("empno: " + empno + ", ename: " + ename + ", sal : " + sal);
					writer.write("<h1>empno :"+empno+", ename: " + ename + " sal : " + sal+"</h1><br>");
					writer.flush();
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBCPConnection.close(connection, pstmt,rs);
		}
	}

}
