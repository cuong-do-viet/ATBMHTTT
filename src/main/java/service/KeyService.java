package service;

import DAO.UserDAO;
import JavaMail.IJavaMail;
import JavaMail.JavaMailImpl;
import DAO.PublicKeyDAO;
import model.User;

import java.security.*;
import java.util.Base64;

public class KeyService {

    private final IJavaMail mailService;

    public KeyService() {
        this.mailService = new JavaMailImpl();
    }

    public void generateKeyAndSend(int id) {
        try {
            // Get User by userId
            User user = UserDAO.getInstance().selectById(id);

            // Generate RSA Key Pair
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance("RSA");
            keyGen.initialize(2048);
            KeyPair keyPair = keyGen.generateKeyPair();

            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            // Encode to Base64
            String publicKeyStr = Base64.getEncoder().encodeToString(publicKey.getEncoded());
            String privateKeyBase64 = Base64.getEncoder().encodeToString(privateKey.getEncoded());

            // Format private key to PEM style
            String formattedPrivateKey = formatPrivateKeyPem(privateKeyBase64);

            // Send mail
            String subject = "Your New Private Key";
            String message = "Here is your new private key:\n\n" + formattedPrivateKey + "\n\nKeep it safe and do not share it.";
            boolean mailSent = mailService.send(user.getEmail(), subject, message);

            if (mailSent) {
                // Save public key to DB
                PublicKeyDAO.getInstance().updateOrInsert(id, publicKeyStr);
                System.out.println("Public key saved for userId: " + id);
            } else {
                System.out.println("Failed to send email. Key not saved.");
            }

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }

    private String formatPrivateKeyPem(String base64Key) {
        StringBuilder sb = new StringBuilder();
        sb.append("-----BEGIN PRIVATE KEY-----\n");
        int index = 0;
        while (index < base64Key.length()) {
            int endIndex = Math.min(index + 64, base64Key.length());
            sb.append(base64Key, index, endIndex).append("\n");
            index = endIndex;
        }
        sb.append("-----END PRIVATE KEY-----");
        return sb.toString();
    }
}