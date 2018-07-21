package Entity;

import java.util.List;

public class CommentPlus {
    private int id;
    private String img;
    private String replyName;
    private String content;
    private String osname;
    private String beReplyName;
    private String time;
    private List<CommentPlus> replyBody;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public String getReplyName() {
        return replyName;
    }

    public void setReplyName(String replyName) {
        this.replyName = replyName;
    }

    public List<CommentPlus> getReplyBody() {
        return replyBody;
    }

    public void setReplyBody(List<CommentPlus> replyBody) {
        this.replyBody = replyBody;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getOsname() {
        return osname;
    }

    public void setOsname(String osname) {
        this.osname = osname;
    }

    public String getBeReplyName() {
        return beReplyName;
    }

    public void setBeReplyName(String beReplyName) {
        this.beReplyName = beReplyName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
