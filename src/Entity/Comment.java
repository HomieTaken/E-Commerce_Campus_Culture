package Entity;

import DataBase.DBOperation;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Comment {
    private int comment_id;//评论id
    private int comment_uid;//评论用户id
    private int from_product_id;//评论产品id
    private String  comment_content;//评论内容
    private ReplyType replyType;//
    private Date date;//
    private int to_comment_id;//
    private List<Comment> commentSet;//回复集合
    static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  //  private static List<CommentPlus> plusList = new ArrayList<>();

    public  Comment(){
        commentSet = new ArrayList<>();
    }
    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getComment_uid(){
      return comment_uid;
    }

    public void setComment_uid(int comment_uid) {
        this.comment_uid = comment_uid;
    }

    public int getFrom_product_id() {
        return from_product_id;
    }

    public void setFrom_product_id(int from_product_id) {
        this.from_product_id = from_product_id;
    }

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public String getDate() {
        return DATE_FORMAT.format(date);
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public ReplyType getReplyType() {
        return replyType;
    }

    public void setReplyType(ReplyType replyType) {
        this.replyType = replyType;
    }

    public List<Comment> getReplySet() {
        return commentSet;
    }

    public void setReplySet(List<Comment> commentSet) {
        this.commentSet = commentSet;
    }

    public int getTo_comment_id() {
        return to_comment_id;
    }

    public void setTo_comment_id(int to_comment_id) {
        this.to_comment_id = to_comment_id;
    }

    public static List<CommentPlus> toCommentPlusList(List<Comment> commentList)
    {
        List<CommentPlus> commentPlusList = new ArrayList<>();
       // List<CommentPlus> resultList = new ArrayList<>();
        if(commentList == null || commentList.size() == 0)
            return commentPlusList;
        for(Comment c : commentList)
        {
            CommentPlus commentPlus = toCommentPlus(c);
            commentPlusList.add(commentPlus);
        }
//        for(CommentPlus c : commentPlusList)
//        {
//            if(c.getReplyBody().size() == 0)
//                resultList.add(c);
//            List<CommentPlus> list = toSplitCommentPlus(c);
//            for(CommentPlus cc:list)
//            {
//                resultList.add(cc);
//            }
//        }
        return reverseCommentPlus(commentPlusList);
    }

//    private static List<CommentPlus> toSplitCommentPlus(CommentPlus commentPlus)
//    {
//        //List<CommentPlus> commentPlusList = new ArrayList<>();
//        if(commentPlus.getReplyBody().size() == 0)
//            return plusList;
//        else {
//            if (!ifNextBody(commentPlus))
//                plusList.add(commentPlus);
//            else {
//                for(CommentPlus c:commentPlus.getReplyBody())
//                {
//                    CommentPlus cc = c;
//                    c.getReplyBody().clear();
//                    plusList.add(c);
//                    return toSplitCommentPlus(cc);
//                }
//            }
//        }
//        return  plusList;
//
//    }
    private static boolean ifNextBody(CommentPlus commentPlus)
    {
        for(int i = 0;i < commentPlus.getReplyBody().size();i++)
        {
            if(commentPlus.getReplyBody().get(i).getReplyBody().size() != 0)
                return true;
        }
        return false;
    }
    private static CommentPlus toCommentPlus(Comment comment)
    {
        CommentPlus commentPlus = new CommentPlus();
        commentPlus.setId(comment.getComment_id());
        commentPlus.setContent(comment.getComment_content());
        commentPlus.setReplyName(convertToName(comment.getComment_uid(),0));
        commentPlus.setReplyBody(toCommentPlusList(comment.getReplySet()));
        commentPlus.setImg("img/qm.png");
        commentPlus.setOsname("个人用户");
        commentPlus.setTime(comment.getDate());
        commentPlus.setBeReplyName(convertToName(comment.getTo_comment_id(),1));
        return  commentPlus;
    }

    private static String convertToName(int id,int flag)
    {
        try{
            ResultSet rs;
            if(flag == 0)
                rs = DBOperation.getRS("select user_name from user where user_id = '"+id+"'");
            else {
                ResultSet rs1 = DBOperation.getRS("select comment_uid from comment where comment_id = '" + id + "'");
                int userID = 0;
                if(rs1.next())
                {
                    userID = rs1.getInt("comment_uid");
                    System.out.println(userID);
                }
                rs = DBOperation.getRS("select user_name from user where user_id = '" + userID + "' ");
            }
                String name = "";
            if(rs.next())
            {
                name = rs.getString("user_name");
            }
            DBOperation.close();
            return name;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return "";
    }

    private static  List<CommentPlus> reverseCommentPlus(List<CommentPlus> commentPlusList)
    {
        List<CommentPlus> newList = new ArrayList<>();
        for(int i = commentPlusList.size()-1;i>=0;i--)
        {
            newList.add(commentPlusList.get(i));
        }
        return  newList;
    }


}