package cashbook;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.AdminInfo;

public class CashbookDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CashbookDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/kassaboken?serverTimezone=UTC";
			AdminInfo admin = new AdminInfo();
			String dbID = admin.getID();
			String dbPassword = admin.getPW();
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int write(String userID, String datum, int belopp, int place_id) {
		String SQL = "INSERT INTO cashbook (userID, datum, place_id, belopp, available) VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, datum);
			pstmt.setInt(3, place_id);
			pstmt.setInt(4, belopp);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
}
