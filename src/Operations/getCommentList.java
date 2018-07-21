package Operations;

import DataBase.DBOperation;
import Entity.Comment;
import Entity.ReplyType;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class getCommentList {

    private  void getComment(Comment comment) {
        if(convertToNext(comment))
            for(Comment c : comment.getReplySet())
            getComment(c);
    }
    private boolean convertToNext(Comment comment){
        try{
            ResultSet rs = DBOperation.getRS("select * from comment where to_comment_id = '" + comment.getComment_id()+"'");
            while(rs.next())
            {
                Comment reply = new Comment();
                reply.setComment_id(rs.getInt("comment_id"));
                reply.setComment_uid(rs.getInt("comment_uid"));
                reply.setComment_content(rs.getString("comment_content"));
                reply.setFrom_product_id(rs.getInt("from_product_id"));
                reply.setReplyType(ReplyType.REPLY);
                Timestamp timestamp = rs.getTimestamp("comment_time");
                Date date = new Date(timestamp.getTime());
                reply.setDate(date);
                reply.setTo_comment_id(rs.getInt("to_comment_id"));
                comment.getReplySet().add(reply);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return comment.getReplySet() != null && comment.getReplySet().size() != 0;

    }
    public  List<Comment> queryCommentByPid (int pid) {
        List<Comment> commentList = new ArrayList<>();
        String sql = "select * from comment where from_product_id = '" + pid + "' and reply_type = 'COMMENT'";
        try {
            ResultSet rs = DBOperation.getRS(sql);
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setComment_id(rs.getInt("comment_id"));
                comment.setComment_uid(rs.getInt("comment_uid"));
                comment.setComment_content(rs.getString("comment_content"));
                comment.setFrom_product_id(rs.getInt("from_product_id"));
                comment.setReplyType(ReplyType.COMMENT);
                Timestamp timestamp = rs.getTimestamp("comment_time");
                Date date = new Date(timestamp.getTime());
                comment.setDate(date);
                comment.setTo_comment_id(rs.getInt("to_comment_id"));
                commentList.add(comment);
            }
            if(commentList.size() == 0)
                return null;
            else
            {
                for (Comment comment : commentList) {
                    getComment(comment);
                }

                return commentList;
            }
          //  return commentList;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }
}
