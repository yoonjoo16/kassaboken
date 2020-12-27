package cashbook;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	
	public int write(String userID, String datum, int place_id, int belopp) {
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
	
	public ArrayList<Cashbook> getList(int year, int month) {
		String SQL = "SELECT * FROM cashbook WHERE year(datum) = ? and month(datum) = ? and available = 1";
		ArrayList<Cashbook> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, year);
			pstmt.setInt(2, month);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Cashbook cashbook = new Cashbook();
				cashbook.setId(rs.getInt(1));
				cashbook.setUserID(rs.getString(2));
				cashbook.setDatum(rs.getString(3));
				cashbook.setPlace_id(rs.getInt(4));
				cashbook.setBelopp(rs.getInt(5));
				cashbook.setAvailable(rs.getInt(6));
				list.add(cashbook);
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return list;
	}
}
