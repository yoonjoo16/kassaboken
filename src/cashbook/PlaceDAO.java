package cashbook;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.AdminInfo;

public class PlaceDAO {
	private Connection conn;
	private ResultSet rs;
	
	public PlaceDAO() {
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
	
	public ArrayList<Place> getListByCategory(String category) {
		String SQL = "SELECT * FROM place WHERE category = ? ORDER BY id";
		ArrayList<Place> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Place place = new Place();
				place.setId(rs.getInt(1));
				place.setPlace(rs.getString(2));
				place.setCategory(rs.getString(3));
				list.add(place);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public String getPlaceByID(int id) {
		String SQL = "SELECT * FROM Place WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Place place = new Place();
				place.setId(rs.getInt(1));
				place.setPlace(rs.getString(2));
				place.setCategory(rs.getString(3));
				return place.getPlace();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getCategoryByID(int id) {
		String SQL = "SELECT * FROM Place WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Place place = new Place();
				place.setId(rs.getInt(1));
				place.setPlace(rs.getString(2));
				place.setCategory(rs.getString(3));
				return place.getCategory();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getIdByPlace(String name) {
		String SQL = "SELECT * FROM Place WHERE place = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
