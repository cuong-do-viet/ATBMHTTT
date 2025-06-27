package com.example;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

public class Main {

    private static class StatusMessage {
        private final boolean success;
        private final String msg;
        public StatusMessage(boolean success, String msg) {
            this.success = success;
            this.msg = msg;
        }

        @Override
        public String toString() {
            return "StatusMessage{" +
                    "success=" + success +
                    ", msg='" + msg + '\'' +
                    '}';
        }
    }

    private final KeyPairGenerator rsaGenerator;
    private final KeyFactory keyFactory;
    private PublicKey publicKey;
    private PrivateKey privateKey;
    private final Integer[] availableKeySize = {1024, 2048, 4096};
    private int selectedKeySizeIndex = 0;

    private final String START_RSA_PUBLIC_STRING = "-----BEGIN PUBLIC KEY-----";
    private final String END_RSA_PUBLIC_STRING = "-----END PUBLIC KEY-----";
    private final String START_RSA_PRIVATE_STRING = "-----BEGIN PRIVATE KEY-----";
    private final String END_RSA_PRIVATE_STRING = "-----END PRIVATE KEY-----";

    private final SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

    public Main() throws NoSuchAlgorithmException {
        rsaGenerator = KeyPairGenerator.getInstance("RSA");
        keyFactory = KeyFactory.getInstance("RSA");
        generateGUI();
    }

    private void generateGUI() {

        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setTitle("RSA KeyPair Generator");
        frame.getContentPane().setLayout(new BorderLayout());
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null);
        // Title
        JLabel title = new JLabel("RSA Processor");
        frame.getContentPane().add(title, BorderLayout.NORTH);

        // Content
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.fill = GridBagConstraints.BOTH;
        c.insets = new Insets(4, 4, 4, 4);
        c.gridx = 0;
        c.gridy = 0;
        c.weightx = 0.0;
        c.weighty = 1.0;
        c.gridheight = 2;
        panel.add(new JLabel("Select key size:"), c);

        c.gridx++;
        c.weightx = 0.5;
        JComboBox<Integer> keySizeBox = new JComboBox<>(availableKeySize);
        panel.add(keySizeBox, c);

        c.gridx++;
        c.gridheight = 1;
        c.weightx = 0.5;
        JButton generateBtn = new JButton("Generate Key");
        panel.add(generateBtn, c);

        c.gridy++;
        JButton exportBtn = new JButton("Export Key");
        exportBtn.setEnabled(false);
        panel.add(exportBtn, c);

        c.gridx = 0;
        c.gridy++;
        panel.add(new JLabel("Status:"), c);

        c.gridx++;
        JLabel status = new JLabel("Empty. Try either generate new key or load existing key.");
        panel.add(status, c);

        c.gridx++;
        JButton importBtn = new JButton("Load Key");
        panel.add(importBtn, c);

        c.gridx = 0;
        c.gridy++;
        c.gridwidth = 1;
        panel.add(new JLabel("Insert Hash Here:"), c);

        c.gridx++;
        c.gridwidth = 2;
        JTextArea inputArea = new JTextArea(10, 20);
        inputArea.setLineWrap(true);
        panel.add(new JScrollPane(inputArea), c);

        c.gridx = 0;
        c.gridy++;
        c.gridwidth = 1;
        panel.add(new JLabel("Result Signing To Copy:"), c);

        c.gridx++;
        c.gridwidth = 2;
        JTextArea outputArea = new JTextArea(10, 20);
        outputArea.setLineWrap(true);
        outputArea.setEditable(false);

        panel.add(new JScrollPane(outputArea), c);

        frame.getContentPane().add(panel, BorderLayout.CENTER);

        // EVENTS
        keySizeBox.addItemListener((e -> selectedKeySizeIndex = keySizeBox.getSelectedIndex()));
        generateBtn.addActionListener((e -> {
            generateKeyPair();
            status.setText(String.format("Generated Key Pair of size %d bits at %s", availableKeySize[selectedKeySizeIndex], sdf.format(new Date())));
            exportBtn.setEnabled(true);
            outputArea.setText(processData(inputArea.getText()));
        }));
        exportBtn.addActionListener((e -> {
            JFileChooser chooser = new JFileChooser();
            chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
            if (chooser.showSaveDialog(frame) == JFileChooser.APPROVE_OPTION) {
                File file = chooser.getSelectedFile();
                StatusMessage sm = exportRSAKeyFile(file.getAbsolutePath());
                status.setText("<html><p>%s</p></html>".formatted(sm.msg.replaceAll("\\n", "<br>")));
            }
        }));
        importBtn.addActionListener((e -> {
            JFileChooser chooser = new JFileChooser();
            chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
            if (chooser.showOpenDialog(frame) == JFileChooser.APPROVE_OPTION) {
                File file = chooser.getSelectedFile();
                StatusMessage sm = importRSAKeyFile(file.getAbsolutePath());
                status.setText("<html><p>%s</p></html>".formatted(sm.msg.replaceAll("\\n", "<br>")));
                outputArea.setText(processData(inputArea.getText()));
                exportBtn.setEnabled(sm.success);
            }
        }));
        TextAreaChangeListener listener = new TextAreaChangeListener(inputArea);
        listener.setChangeCallback((e -> {
            if (publicKey == null || privateKey == null)
                outputArea.setText("No key to process! Please make a new one or load an existing one!");
            else
                outputArea.setText(processData(inputArea.getText()));
        }));
        listener.startListening();
        frame.setVisible(true);
    }

    private String getStackTrace(Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        pw.flush();
        pw.close();
        return sw.toString();
    }

    private void generateKeyPair() {
        rsaGenerator.initialize(availableKeySize[selectedKeySizeIndex]);
        KeyPair pair = rsaGenerator.generateKeyPair();
        publicKey = pair.getPublic();
        privateKey = pair.getPrivate();
    }

    private String processData(String data) {
        try {
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, privateKey);
            byte[] byteData = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = cipher.doFinal(byteData);
            return Base64.getEncoder().encodeToString(result);
        } catch (NoSuchAlgorithmException | NoSuchPaddingException |
                 InvalidKeyException | IllegalBlockSizeException |
                 BadPaddingException e) {
            return getStackTrace(e);
        }
    }

    private StatusMessage exportKeyFile(String keyPath, Key key, String startString, String endString, int maxCol) {
        File keyFile = new File(keyPath);
        String keyString = Base64.getEncoder().encodeToString(key.getEncoded());

        try {
            PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(keyFile)));
            writer.println(startString);
            int sizing;
            while (!keyString.isEmpty()) {
                sizing = Math.min(maxCol, keyString.length());
                writer.println(keyString.substring(0, sizing));
                keyString = keyString.substring(sizing);
            }
            writer.println(endString);
            writer.flush();
            writer.close();
            return new StatusMessage(true, "Export Key File %s successfully at %s!".formatted(keyPath, sdf.format(new Date())));
        } catch (FileNotFoundException e) {
            return new StatusMessage(false, "File Not Found During Export: ".concat(getStackTrace(e)));
        }
    }

    private StatusMessage exportRSAKeyFile(String privateFilePath) {
        StatusMessage pubFileSuccess = exportKeyFile(privateFilePath.concat(".pub"), publicKey, START_RSA_PUBLIC_STRING, END_RSA_PUBLIC_STRING, 32);
        if (!pubFileSuccess.success)
            return new StatusMessage(false, pubFileSuccess.msg);

        StatusMessage privateFileSuccess = exportKeyFile(privateFilePath, privateKey, START_RSA_PRIVATE_STRING, END_RSA_PRIVATE_STRING, 32);
        return new StatusMessage(privateFileSuccess.success, pubFileSuccess.msg.concat("\n").concat(privateFileSuccess.msg));
    }

    private byte[] importKeyFile(String filePath, String endString) {
        try {
            File f = new File(filePath);
            BufferedReader reader = new BufferedReader(new FileReader(f));
            reader.readLine();
            String line;
            StringBuilder base64 = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                if (!line.equals(endString)) {
                    base64.append(line);
                }
            }
            reader.close();
            return Base64.getDecoder().decode(base64.toString());
        } catch (IOException e) {
            return null;
        }
    }

    private StatusMessage importRSAKeyFile(String privateFilePath) {
        File privateFile = new File(privateFilePath);
        if (!privateFile.exists()) {
            return new StatusMessage(false, "Private Key File Not Found");
        }
        File publicFile = new File(privateFilePath.concat(".pub"));
        if (!publicFile.exists()) {
            return new StatusMessage(false, "Public Key File Not Found");
        }

        byte[] privateBytes = importKeyFile(privateFile.getAbsolutePath(), END_RSA_PRIVATE_STRING);
        if (privateBytes == null) {
            return new StatusMessage(false, "Private Key File Not Found");
        }
        byte[] publicBytes = importKeyFile(publicFile.getAbsolutePath(), END_RSA_PUBLIC_STRING);
        if (publicBytes == null) {
            return new StatusMessage(false, "Public Key File Not Found");
        }
        try {
            privateKey = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateBytes));
            publicKey = keyFactory.generatePublic(new X509EncodedKeySpec(publicBytes));
            return new StatusMessage(true, "Import Key File Successfully!");
        } catch (InvalidKeySpecException e) {
            return new StatusMessage(false, getStackTrace(e));
        }
    }

    public static void main(String[] args) throws NoSuchAlgorithmException {
        new Main();
    }
}