package DAO;

import model.PublicKey;
import service.JDBCUtil;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;

public class PublicKeyDAO implements IDAO<PublicKey> {

    private static final String encryptKey = "fGVuF4z4/tRgpeAFy6UcTw=="; // 16 ký tự = 128-bit key (có thể thay từ nơi khác)

    private static PublicKeyDAO instance;

    // Singleton Pattern
    public static PublicKeyDAO getInstance() {
        if (instance == null) {
            instance = new PublicKeyDAO();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException {
        return JDBCUtil.getConnection();
    }

    // Encrypt content using AES
    private String encrypt(String plainText) throws Exception {
        Key aesKey = new SecretKeySpec(encryptKey.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, aesKey);
        byte[] encrypted = cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }

    // Decrypt content using AES
    private String decrypt(String encryptedText) throws Exception {
        Key aesKey = new SecretKeySpec(encryptKey.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, aesKey);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
        return new String(decrypted, StandardCharsets.UTF_8);
    }

    @Override
    public int insert(PublicKey publicKey) {
        String sql = "INSERT INTO publickeys (user_id, content) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, publicKey.getUserId());
            stmt.setString(2, encrypt(publicKey.getContent()));
            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(PublicKey publicKey) {
        String sql = "UPDATE publickeys SET content = ? WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, encrypt(publicKey.getContent()));
            stmt.setInt(2, publicKey.getUserId());
            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

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
                String encryptedContent = rs.getString("content");
                String decryptedContent = decrypt(encryptedContent);
                PublicKey publicKey = new PublicKey(userId, decryptedContent);
                publicKey.setId(id);
                publicKeys.add(publicKey);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return publicKeys;
    }

    @Override
    public PublicKey selectById(int userId) {
        String sql = "SELECT * FROM publickeys WHERE user_id = ? AND deleted = 0";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String encryptedContent = rs.getString("content");
                String decryptedContent = decrypt(encryptedContent);
                int id = rs.getInt("id");

                return new PublicKey(id, decryptedContent);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

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
            stmt.setString(2, encrypt(publicKeyStr));
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int updateOrInsert(int userId, String publicKeyStr) {
        String selectSql = "SELECT * FROM publickeys WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(selectSql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE publickeys SET content = ? WHERE user_id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, encrypt(publicKeyStr));
                    System.out.println(selectById(20));
                    updateStmt.setInt(2, userId);
                    return updateStmt.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO publickeys (user_id, content) VALUES (?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setString(2, encrypt(publicKeyStr));
                    return insertStmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}