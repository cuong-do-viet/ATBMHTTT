import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.Document;
import java.beans.PropertyChangeListener;

public class TextAreaChangeListener {

    private int lastChange = 0, lastNotifiedChange = 0;
    private JTextArea textArea;
    private DocumentListener documentListener;
    private PropertyChangeListener propertyChangeListener;
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

    public void setChangeCallback(TextAreaChangeCallback changeCallback) {
        this.changeCallback = changeCallback;
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
