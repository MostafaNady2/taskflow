package org.example.demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.example.demo.model.User;
import org.example.demo.utils.DBUtil;

public class UserDao {
	public List<User> getAllUsers() {
		String query = "select * from users";
		List<User> users = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				users.add(user);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	public Optional<User> getUserById(int id) {
		Optional<User> user = Optional.empty();
		String query = "select * from users where id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("password"));
				user = Optional.of(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public Optional<User> getUserByEmail(String email) {
		Optional<User> user = Optional.empty();
		String query = "select * from users where email = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setString(1, email);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("password"));
				user = Optional.of(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public Optional<User> getUserByCredentials(String email, String password) {
		Optional<User> user = Optional.empty();
		String query = "select * from users where email = ? and password = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setString(1, email);
			pst.setString(2, password);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("password"));
				user = Optional.of(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public int createUser(User user){
		String query = "insert into users(name,email,password) values (?, ?, ?)";
		try(Connection conn = DBUtil.getConnection();PreparedStatement pst = conn.prepareStatement(query,PreparedStatement.RETURN_GENERATED_KEYS)){
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
			
			int rows = pst.executeUpdate();
			if(rows == 1){
				try(ResultSet rs = pst.getGeneratedKeys()){
					if(rs.next()){
						return rs.getInt(1);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	public void updateUser(User user) {
		String query = "update users set name = ?, email = ?, password = ? where id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
			pst.setInt(4, user.getId());
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
