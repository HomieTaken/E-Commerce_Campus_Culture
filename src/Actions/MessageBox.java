package Actions;

import Entity.Message;
import Operations.MessageOperate;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MessageBox implements Action {
    private int page;
    private int message_id;
    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }
    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }
    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
        if(actionContext.getSession().containsKey("user_id")) {
            int id=(int)actionContext.getSession().get("user_id");
            Message[]messages=MessageOperate.getAllMessage(id);
            Map<String,ArrayList<Message>>messageMap=new HashMap<String,ArrayList<Message>>();
            for(int i=0;i< messages.length;i++){
                ArrayList<Message>arrayList=messageMap.get(messages[i].getType());
                if(arrayList==null) {
                    arrayList=new ArrayList<Message>();
                    arrayList.add(messages[i]);
                    messageMap.put(messages[i].getType(), arrayList);
                }
                else{
                    arrayList.add(messages[i]);
                }
            }
            actionContext.put("messages",messageMap);
        }
        return SUCCESS;
    }
    public String sendProductMessage(){
        ActionContext actionContext=ActionContext.getContext();
        if(actionContext.getSession().containsKey("user_id")) {
            int id = (int) actionContext.getSession().get("user_id");
            Message message = MessageOperate.getMessageFromId(message_id);
           ResultSet rs= MessageOperate.addProductMessage(message.getProduct_id(),id);
            try {
                if (rs.next()) {
                    MessageOperate.addMessageToUser(rs.getInt(1),message.getSender_id());
                    MessageOperate.sendToUser(message.getSender_id());
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            if(actionContext.getSession().containsKey("message_count")) {
                int count = MessageOperate.getNewMessageNum(id);
                actionContext.getSession().replace("message_count", count);
            }
        }
        return null;
    }
    public String readMessage(){
        int id=0;
        ActionContext actionContext=ActionContext.getContext();
        if(actionContext.getSession().containsKey("user_id")) {
            id = (int) actionContext.getSession().get("user_id");
            MessageOperate.readMessage(id, message_id);
            if(actionContext.getSession().containsKey("message_count")) {
                int count = MessageOperate.getNewMessageNum(id);
                actionContext.getSession().replace("message_count", count);
            }
        }
            return null;
    }
    public String deleteMessage(){
        int id=0;
        ActionContext actionContext=ActionContext.getContext();
        if(actionContext.getSession().containsKey("user_id")) {
            id = (int) actionContext.getSession().get("user_id");
            MessageOperate.deleteMessage(id, message_id);
            if(actionContext.getSession().containsKey("message_count")) {
                int count = MessageOperate.getNewMessageNum(id);
                actionContext.getSession().replace("message_count", count);
            }
        }
        return null;
    }
}
