package model;

public class PublicKey {
    private int id;
    private int userId;
    private String content;

    // Constructor
    public PublicKey(int userId, String content) {
        this.userId = userId;
        this.content = content;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
