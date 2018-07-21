package Actions;

import Entity.Message;
import Operations.MessageOperate;
import Operations.ViewTeam;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class GetActivityResources implements Action {
    private int activity_id;

    public void setActivity_id(int activity_id) {
        this.activity_id = activity_id;
    }

    public int getActivity_id() {
        return activity_id;
    }

    @Override
    public String execute() {
        HttpServletResponse response = ServletActionContext.getResponse();
        ActionContext actionContext=ActionContext.getContext();
        int userID = (int)actionContext.getSession().get("user_id");
         Message[]messages=MessageOperate.getHaveSendMessage(userID);
         ArrayList<Message>arrayList=new ArrayList<Message>();
         if(messages==null)
             messages=new Message[0];
        for(int i=0;i<messages.length;i++){
            if(messages[i].getType().equals("activity")){
             if(messages[i].getActivity_id()==activity_id)
                 arrayList.add(messages[i]);
            }
        }
        String str="<th>序号</th><th>动态内容 </th><th>发布时间</th><th>&emsp;&emsp;&emsp;&emsp;</th>";
for(int i=arrayList.size()-1;i>=0;i--){//overflow:hidden;white-space:nowrap;
    str+="<tr><td>"+(arrayList.size()-i)+"</td><td> <div style='width:200px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;'\n" +
            "    title='"+arrayList.get(i).getMessage_text()+"'>"+arrayList.get(i).getMessage_text()+"</div>";
            str+="</td><td>"+arrayList.get(i).getDate()+"</td><td>";
            if(arrayList.get(i).getHavePic())
            str+="<a href=\"/getPic.action?messageID="+arrayList.get(i).getMessage_id()+"\" target='_BLANK'>附件图片</a>";
            str+="</td></tr>";
}


        //返回文本数据
try {
    response.setContentType("text/plain;charset=utf-8");

    ServletOutputStream outputStream = response.getOutputStream();

    outputStream.write(str.getBytes("utf-8"));

    outputStream.flush();

    outputStream.close();
}
catch (Exception e){
    e.printStackTrace();
}
        return null;
    }
    public String enterActivity(){
       Object userID=ActionContext.getContext().getSession().get("user_id");
        try {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("text/plain;charset=utf-8");

            ServletOutputStream outputStream = response.getOutputStream();
            if(userID==null) {
                outputStream.write("fail".getBytes("utf-8"));
            }
            else{
                ViewTeam.enterActivity(activity_id,(int)userID);
                ViewTeam.sendEnterMessage(activity_id,userID);
                outputStream.write("".getBytes("utf-8"));
            }

            outputStream.flush();

            outputStream.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public String exitActivity(){
        int userID=(int)ActionContext.getContext().getSession().get("user_id");
        try {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("text/plain;charset=utf-8");

            ServletOutputStream outputStream = response.getOutputStream();
            if(userID==0) {
                outputStream.write("fail".getBytes("utf-8"));
            }
            else{
                ViewTeam.exitActivity(activity_id,userID);
                ViewTeam.sendExitMessage(activity_id,userID);
                outputStream.write("".getBytes("utf-8"));
            }

            outputStream.flush();

            outputStream.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
