package DAO;
import model.PublicKey;
import service.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;

public class PublicKeyDAO implements IDAO<PublicKey> {

    private static PublicKeyDAO instance;

    // Singleton Pattern
    public static PublicKeyDAO getInstance() {
        if (instance == null) {
            instance = new PublicKeyDAO();
        }
        return instance;
    }

    // Kết nối cơ sở dữ liệu
    private Connection getConnection() throws SQLException {
        return JDBCUtil.getConnection();
    }

    // Insert public key
    @Override
    public int insert(PublicKey publicKey) {
        String sql = "INSERT INTO publickeys (user_id, content) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, publicKey.getUserId());
            stmt.setString(2, publicKey.getContent());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Update public key
    @Override
    public int update(PublicKey publicKey) {
        String sql = "UPDATE publickeys SET content = ? WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, publicKey.getContent());
            stmt.setInt(2, publicKey.getUserId());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Delete public key by userId
    @Override
    public int delete(PublicKey publicKey) {
        String sql = "DELETE FROM publickeys WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, publicKey.getUserId());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Get all public keys
    @Override
    public ArrayList<PublicKey> selectAll() {
        ArrayList<PublicKey> publicKeys = new ArrayList<>();
        String sql = "SELECT * FROM publickeys";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("user_id");
                String content = rs.getString("content");
                PublicKey publicKey = new PublicKey(userId, content);
                publicKey.setId(id);
                publicKeys.add(publicKey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return publicKeys;
    }

    // Get public key by userId
    @Override
    public PublicKey selectById(int id) {
        String sql = "SELECT * FROM publickeys WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String content = rs.getString("content");
                return new PublicKey(userId, content);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Xóa public key của user theo userId
    public void deleteByUserId(int userId) {
        String sql = "DELETE FROM publickeys WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertNewKey(int userId, String publicKeyStr) {
        String sql = "INSERT INTO publickeys (user_id, content) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, publicKeyStr);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int updateOrInsert(int userId, String publicKeyStr) {
        // Kiểm tra xem user đã có public key trong bảng chưa
        String selectSql = "SELECT * FROM publickeys WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(selectSql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Nếu đã có, thực hiện update
                String updateSql = "UPDATE publickeys SET content = ? WHERE user_id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, publicKeyStr);
                    updateStmt.setInt(2, userId);
                    return updateStmt.executeUpdate();
                }
            } else {
                // Nếu chưa có, thực hiện insert mới
                String insertSql = "INSERT INTO publickeys (user_id, content) VALUES (?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setString(2, publicKeyStr);
                    return insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

}
