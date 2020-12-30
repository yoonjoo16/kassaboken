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
	
	
	public int write(String userID, String datum, String category, String place, int belopp) {
		String SQL = "INSERT INTO cashbook (userID, datum, category, place, belopp) VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, datum);
			pstmt.setString(3, category);
			pstmt.setString(4, place);
			pstmt.setInt(5, belopp);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public int update(int id, String user, String datum, String category, String place, int belopp) {
		String SQL = "UPDATE cashbook SET userID = ?, datum = ?, category = ?, place = ?, belopp =? WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user);
			pstmt.setString(2, datum);
			pstmt.setString(3, category);
			pstmt.setString(4, place);
			pstmt.setInt(5, belopp);
			pstmt.setInt(6, id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public ArrayList<Cashbook> getList(int year, int month) {
		String SQL = "SELECT * FROM cashbook WHERE year(datum) = ? and month(datum) = ? ORDER BY datum DESC";
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
				cashbook.setAmount(rs.getInt(4));
				cashbook.setCategory(rs.getString(5));
				cashbook.setPlace(rs.getString(6));
				list.add(cashbook);
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return list;
	}
	
	public String getDateById(int id) {
		String SQL = "SELECT * FROM cashbook WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(3);
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return "";
	}
	
	
	public int delete(int id) {
		String SQL = "DELETE FROM CASHBOOK WHERE id = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public int getSum(String user) {
		String SQL = "SELECT sum(belopp) from cashbook where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
}
