package calculator;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.AdminInfo;

public class CalculatorDAO{
	private Connection conn;
	private ResultSet rs;
	
	public CalculatorDAO() {
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
	
	
	public int write(String userID, String datum, int belopp, String category, String desc) {
		String SQL = "INSERT INTO calculator (userID, datum, belopp, category, description) VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, datum);
			pstmt.setInt(3, belopp);
			pstmt.setString(4, category);
			pstmt.setString(5, desc);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public int update(int id, String userID, String datum, int belopp, String category, String desc) {
		String SQL = "UPDATE calculator SET userID = ?, datum = ?,  belopp =?, category = ?, description = ? WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, datum);
			pstmt.setInt(3, belopp);
			pstmt.setString(4, category);
			pstmt.setString(5, desc);
			pstmt.setInt(6, id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	
	public int delete(int id) {
		String SQL = "DELETE FROM calculator WHERE id = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public int getSum(String user, String category) {
		String SQL = "SELECT sum(belopp) from calculator where userID = ? and category = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user);
			pstmt.setString(2, category);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB error
	}
	
	public ArrayList<Calculator> getList() {
		String SQL = "SELECT * FROM calculator ORDER BY datum DESC";
		ArrayList<Calculator> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Calculator calculator = new Calculator();
				calculator.setId(rs.getInt(1));
				calculator.setUserID(rs.getString(2));
				calculator.setDatum(rs.getString(3));
				calculator.setBelopp(rs.getInt(4));
				calculator.setCategory(rs.getString(5));
				calculator.setDescription(rs.getString(6));				
				list.add(calculator);
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return list;
}
}
