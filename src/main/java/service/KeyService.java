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
        this.mailService = new JavaMailImpl(); // Hoặc inject qua constructor
    }

    public void generateKeyAndSend(int id) {
        try {
            // get User from userId
            User user = UserDAO.getInstance().selectById(id);

            // create a key pair
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance("RSA");
            keyGen.initialize(2048);
            KeyPair keyPair = keyGen.generateKeyPair();

            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            // Encode Base64
            String publicKeyStr = Base64.getEncoder().encodeToString(publicKey.getEncoded());
            String privateKeyStr = Base64.getEncoder().encodeToString(privateKey.getEncoded());

            // send mail
            String subject = "Your New Private Key";
            String message = "Here is your new private key:\n\n" +
                    privateKeyStr + "\n\nKeep it safe and do not share it.";
            boolean mailSent = mailService.send(user.getEmail(), subject, message);

            if (mailSent) {
                // save public key to DB
                PublicKeyDAO.getInstance().updateOrInsert(id, publicKeyStr);
                System.out.println("Public key saved for userId: " + id);
            } else {
                System.out.println("Failed to send email. Key not saved.");
            }

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
}