package com.example;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.beans.PropertyChangeListener;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

public class Main {

    // limiting the text area
    private static class LengthLimitDocumentFilter extends DocumentFilter {
        private int maxLength = -1; // -1 means no limit

        public void setMaxLength(int maxLength) {
            this.maxLength = maxLength;
        }

        @Override
        public void insertString(FilterBypass fb, int offset, String string, AttributeSet attr)
                throws BadLocationException {
            if (maxLength == -1 || (fb.getDocument().getLength() + string.length() <= maxLength)) {
                super.insertString(fb, offset, string, attr);
            } else {
                // Optionally, notify the user or just silently ignore excess input
                // System.out.println("Input exceeds max length: " + maxLength);
            }
        }

        @Override
        public void replace(FilterBypass fb, int offset, int length, String text, AttributeSet attrs)
                throws BadLocationException {
            if (maxLength == -1 || (fb.getDocument().getLength() - length + (text != null ? text.length() : 0) <= maxLength)) {
                super.replace(fb, offset, length, text, attrs);
            } else {
                // Optionally, notify the user
                // System.out.println("Replacement exceeds max length: " + maxLength);
            }
        }
    }

    private interface TextAreaChangeCallback {
        void callback(String... args);
    }

    private class TextAreaChangeListener {

        private int lastChange = 0, lastNotifiedChange = 0;
        private final JTextArea textArea;
        private final DocumentListener documentListener;
        private final PropertyChangeListener propertyChangeListener;
        private TextAreaChangeCallback changeCallback;

        public TextAreaChangeListener(JTextArea textArea) {
            this.textArea = textArea;
            this.documentListener = new DocumentListener() {

                @Override
                public void insertUpdate(DocumentEvent e) {
                    changedUpdate(e);
                }

                @Override
                public void removeUpdate(DocumentEvent e) {
                    changedUpdate(e);
                }

                @Override
                public void changedUpdate(DocumentEvent e) {
                    lastChange++;
                    SwingUtilities.invokeLater(() -> {
                        if (lastChange != lastNotifiedChange) {
                            lastNotifiedChange = lastChange;
                            if (changeCallback != null) changeCallback.callback();
                        }
                    });
                }
            };
            propertyChangeListener = evt -> {
                Document oldDoc = (Document) evt.getOldValue();
                Document newDoc = (Document) evt.getNewValue();
                if (oldDoc != null) oldDoc.removeDocumentListener(documentListener);
                if (newDoc != null) newDoc.addDocumentListener(documentListener);
                documentListener.changedUpdate(null);
            };
        }

        public TextAreaChangeListener(JTextArea textArea, TextAreaChangeCallback callback) {
            this(textArea);
            this.changeCallback = callback;
        }

        public void startListening() {
            textArea.addPropertyChangeListener("document", propertyChangeListener);
            textArea.getDocument().addDocumentListener(documentListener);
        }

        public void stopListening() {
            textArea.removePropertyChangeListener("document", propertyChangeListener);
            textArea.getDocument().removeDocumentListener(documentListener);
        }

    }

    // callback with bytes decoded from Base64
    private interface KeyLoadedCallback {
        void onKeyLoaded(byte[] privateKeyBytes);
    }

    // custom popup for loading file
    private static class LoadKeyPopup extends JDialog {
        private JTextArea keyInputArea;
        private JButton loadFromFileButton;
        private JButton confirmButton;
        private JLabel statusLabel;

        private final KeyLoadedCallback callback;

        public LoadKeyPopup(Frame parentFrame, KeyLoadedCallback callback) {
            super(parentFrame, "Load Private Key", true);
            this.callback = callback;
            initUI();
            setupListeners();
            pack();
            setLocationRelativeTo(parentFrame);
        }

        // ui
        private void initUI() {
            setLayout(new BorderLayout(10, 10));

            // Panel cho khu vực nhập key
            JPanel inputPanel = new JPanel(new BorderLayout(5, 5));
            inputPanel.setBorder(BorderFactory.createTitledBorder("Paste Private Key (Base64) or Load from File"));

            keyInputArea = new JTextArea(10, 64);
            keyInputArea.setLineWrap(true);
            keyInputArea.setWrapStyleWord(true);
            JScrollPane scrollPane = new JScrollPane(keyInputArea);
            inputPanel.add(scrollPane, BorderLayout.CENTER);

            add(inputPanel, BorderLayout.CENTER);

            // Panel cho nút bấm
            JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 10, 5));
            loadFromFileButton = new JButton("Load from File...");
            confirmButton = new JButton("Confirm");
            buttonPanel.add(loadFromFileButton);
            buttonPanel.add(confirmButton);

            add(buttonPanel, BorderLayout.SOUTH);

            statusLabel = new JLabel("Enter or load your private key.");
            statusLabel.setHorizontalAlignment(SwingConstants.CENTER);
            add(statusLabel, BorderLayout.NORTH);
        }

        // listener
        private void setupListeners() {
            loadFromFileButton.addActionListener(this::loadFromFile);
            confirmButton.addActionListener(this::confirmKey);
        }

        // function to load using jfilechooser
        private void loadFromFile(ActionEvent e) {
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Select Private Key File");
            int userSelection = fileChooser.showOpenDialog(this);

            if (userSelection == JFileChooser.APPROVE_OPTION) {
                Path filePath = fileChooser.getSelectedFile().toPath();
                try {
                    File f = filePath.toFile();
                    BufferedReader reader = new BufferedReader(new FileReader(f));
                    String line;
                    StringBuilder data = new StringBuilder();
                    while ((line = reader.readLine()) != null) {
                        data.append(line);
                    }
                    reader.close();
                    keyInputArea.setText(data.toString());
                    statusLabel.setText("Key loaded from file. Click Confirm.");
                } catch (IOException ex) {
                    statusLabel.setText("Error reading file: " + ex.getMessage());
                    JOptionPane.showMessageDialog(this,
                            "Error reading file: " + ex.getMessage(),
                            "File Error",
                            JOptionPane.ERROR_MESSAGE);
                }
            }
        }

        // function to verify key
        private void confirmKey(ActionEvent e) {
            String base64EncodedKey = keyInputArea.getText().trim();

            if (base64EncodedKey.isEmpty()) {
                statusLabel.setText("Please enter or load a key.");
                JOptionPane.showMessageDialog(this,
                        "Private key cannot be empty.",
                        "Input Error",
                        JOptionPane.WARNING_MESSAGE);
                return;
            }

            // look for start and end of private key
            int headerIndex = base64EncodedKey.indexOf(START_RSA_PRIVATE_STRING);
            int footerIndex = base64EncodedKey.indexOf(END_RSA_PRIVATE_STRING);

            if (headerIndex != -1 && footerIndex != -1 && footerIndex > headerIndex) {
                // on correct order, get the middle part
                int startIndex = headerIndex + START_RSA_PRIVATE_STRING.length();
                base64EncodedKey = base64EncodedKey.substring(startIndex, footerIndex);
                // remove spaces
                base64EncodedKey = base64EncodedKey.replaceAll("\\s", "");
            } else {
                // assuming all the text is the base64, remove spacing and new line
                base64EncodedKey = base64EncodedKey.replaceAll("\\s", "");
            }

            try {
                // Cố gắng giải mã Base64 để kiểm tra tính hợp lệ sơ bộ
                byte[] decodedKey = Base64.getDecoder().decode(base64EncodedKey);

                statusLabel.setText("Base64 successfully processed! Import Private Key on modal closing...");
                JOptionPane.showMessageDialog(this,
                        "Private key loaded successfully.",
                        "Success",
                        JOptionPane.INFORMATION_MESSAGE);

                // Gọi phương thức callback để chuyển tiếp khóa đã giải mã
                if (callback != null) {
                    callback.onKeyLoaded(decodedKey);
                }
                dispose();
            } catch (IllegalArgumentException ex) {
                statusLabel.setText("Invalid Base64 format. Please check the key.");
                JOptionPane.showMessageDialog(this,
                        "The provided key is not a valid Base64 string.",
                        "Decoding Error",
                        JOptionPane.ERROR_MESSAGE);
            } catch (Exception ex) {
                statusLabel.setText("An unexpected error occurred: " + ex.getMessage());
                JOptionPane.showMessageDialog(this,
                        "An unexpected error occurred: " + ex.getMessage(),
                        "Error",
                        JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    // status message to update xdx
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

    private final KeyFactory keyFactory;
    private PrivateKey privateKey;
    private final LengthLimitDocumentFilter inputLimitFilter;
    private static final String START_RSA_PRIVATE_STRING = "-----BEGIN PRIVATE KEY-----";
    private static final String END_RSA_PRIVATE_STRING = "-----END PRIVATE KEY-----";

    private final SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

    public Main() throws NoSuchAlgorithmException {
        keyFactory = KeyFactory.getInstance("RSA");
        inputLimitFilter = new LengthLimitDocumentFilter();
        generateGUI();
    }

    private void generateGUI() {
        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setTitle("ThietBiDiDong Toolkit");
        frame.getContentPane().setLayout(new BorderLayout());
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null);
        // Title
        JLabel title = new JLabel("ThietBiDiDong Signing Toolkit");
        Font font = title.getFont();
        title.setFont(font.deriveFont(font.getSize2D() * 1.6f));
        title.setHorizontalAlignment(JLabel.CENTER);
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
        c.gridheight = 1;

        c.gridy++;

        c.gridx = 0;
        c.gridy++;
        panel.add(new JLabel("Status:"), c);

        c.gridx++;
        c.weightx = 0.5;
        JLabel status = new JLabel("Empty. Try loading existing key.");
        panel.add(new JScrollPane(status), c);

        c.gridx++;
        c.weightx = 0;
        JButton importBtn = new JButton("Load Key");
        panel.add(importBtn, c);

        c.gridx = 0;
        c.gridy++;
        c.gridwidth = 1;
        panel.add(new JLabel("Insert Hash Here:"), c);

        c.gridx++;
        c.gridwidth = 2;
        JTextArea inputArea = new JTextArea(10, 40);
        inputArea.setLineWrap(true);
        ((AbstractDocument)inputArea.getDocument()).setDocumentFilter(inputLimitFilter);
        panel.add(new JScrollPane(inputArea), c);

        c.gridx = 0;
        c.gridy++;
        c.gridwidth = 1;
        panel.add(new JLabel("Result To Copy:"), c);

        c.gridx++;
        c.gridwidth = 2;
        JTextArea outputArea = new JTextArea(10, 40);
        outputArea.setLineWrap(true);
        outputArea.setEditable(false);

        panel.add(new JScrollPane(outputArea), c);

        frame.getContentPane().add(panel, BorderLayout.CENTER);

        // Popup
        JDialog loadKeyDialog = new LoadKeyPopup(frame, privateKeyBytes -> {
            try {
                privateKey = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKeyBytes));
                StatusMessage sm;
                if (privateKey instanceof RSAPrivateKey) {
                    int keySizeBits = ((RSAPrivateKey) privateKey).getModulus().bitLength();
                    int maxInputBytes = keySizeBits / 8 - 11;
                    inputLimitFilter.setMaxLength(maxInputBytes);
                    sm = new StatusMessage(true, "Key loaded successfully. Max input length: " + maxInputBytes + " bytes.");
                    System.out.println("Loaded RSA Private Key. Key size: " + keySizeBits + " bits. Max input bytes (approx): " + maxInputBytes);
                } else {
                    inputLimitFilter.setMaxLength(-1);
                    sm = new StatusMessage(false, "Key loaded unsuccessfully. Not an RSA key or cannot determine size.");
                }
                status.setText("<html><p>%s</p></html>".formatted(sm.msg.replaceAll("\\n", "<br>")));
            } catch (InvalidKeySpecException e) {
                StatusMessage sm = new StatusMessage(false, getStackTrace(e));
                status.setText("<html><p>%s</p></html>".formatted(sm.msg.replaceAll("\\n", "<br>")));
            }
            outputArea.setText(processData(inputArea.getText()));
        });

        // EVENTS
        importBtn.addActionListener((e -> {
            loadKeyDialog.setVisible(true);
        }));
        TextAreaChangeListener listener = new TextAreaChangeListener(inputArea, (e -> {
            if (privateKey == null)
                outputArea.setText("No key to process! Please load an existing one!");
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

    public static void main(String[] args) throws NoSuchAlgorithmException {
        new Main();
    }

}