import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCPConnection {

	private static DataSource env;
	
	static { 
		try {
			InitialContext initialContext = new InitialContext();
			env=(DataSource) initialContext.lookup("java:comp/env/ssafy/mysql");
			System.out.println("look up success");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("look up fail");
		}
	}
	public static Connection getConnection() throws SQLException {
		if(env!=null) {
			Connection conn=env.getConnection();
			if(conn!=null) {
				System.out.println("connection success");
			}else {
			System.out.println("connection faile");
			}
			return conn;
		}else {
			System.out.println("connection fail");
			return env.getConnection();
		}
	}
	public static void close(Connection conn,Statement stmt,ResultSet rs) {
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public static void close(Connection conn,Statement stmt) {
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
