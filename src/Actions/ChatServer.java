package Actions;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;
import java.text.SimpleDateFormat;

import Encoder.ServerEncoder;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import net.sf.json.JSONObject;

/**
 * 聊天服务器类
 * @author homietaken
 *
 */
@ServerEndpoint(value = "/ws/chatRoom/",configurator=HttpSessionWSHelper.class,encoders = ServerEncoder.class)
public class ChatServer {

    static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    private Session session;
    private HttpSession httpSession;
//    private static CopyOnWriteArraySet<ChatServer> ChatServers=new CopyOnWriteArraySet<>();

    //聊天组号与聊天组服务器组
    private static Map<String,CopyOnWriteArraySet<ChatServer>> ChatServers=new HashMap<>();

    @OnOpen
    public void onOpen(Session session, EndpointConfig config){
        try {
            init(session,config);
            if(httpSession.getAttribute("user_name")==null)
                return;

            //添加服务器组，不存在的组则新建
            String groupName=(String) httpSession.getAttribute("group_name");
            if(!ChatServers.containsKey(groupName)){
                CopyOnWriteArraySet<ChatServer> chatServers=new CopyOnWriteArraySet<>();
                chatServers.add(this);
                ChatServers.put(groupName,chatServers);
            }else {
                ChatServers.get(groupName).add(this);
            }
//            ChatServers.add(this);
            System.out.println(new Date().toString()+":"+ChatServers.size());
//            sendOnlineUsers();

//            String selfName = (String) httpSession.getAttribute("user_name");

//            send2All(selfName+"上线");

//            if (username!=null&&!username.equals("null")){
//                sendOnlineUsers();
//            }else{
//                //发送在线列表
//                sendOnlineUsers();
//            }

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @OnMessage
    public void onMessage(Session session, String msg){
        if(httpSession.getAttribute("user_name")==null)
            return;
        try {
            send2All(msg);
            saveRecord(msg);
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    @OnError
    public void onError(Session session, Throwable throwable){
        if(httpSession.getAttribute("user_name")==null)
            return;
    }

    @OnClose
    public void onClose(Session session, CloseReason reason){
        try {
            if(httpSession.getAttribute("user_name")==null)
                return;

            String groupName=(String) httpSession.getAttribute("group_name");
            CopyOnWriteArraySet<ChatServer> chatServers=ChatServers.get(groupName);
            chatServers.remove(this);
//            ChatServers.remove(this);//会不会remove 两次
            //发送在线列表
//            sendOnlineUsers();
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    private void init(Session session,EndpointConfig config){
        this.setSession(session);
        HttpSession httpSession=(HttpSession)config.getUserProperties().get(HttpSession.class.getName());
        this.setHttpSession(httpSession);
    }

    private void saveRecord(String msg){

    }

//    //私聊连接
//    private void connect2Users(String username,String selfName){
//        boolean flag =false;
//        for (ChatServer chatServer: ChatServers){
//            String userName=(String) chatServer.getHttpSession().getAttribute("user_name");
//            if (userName.equals(username)){
//                targetName=username;//必须要在能连接会话的时候赋值
//                targetSession=chatServer.getSession();//获取目标对象的Session
//
//                //同时给对方也连接本身的target
//                chatServer.setTargetSession(session);
//                chatServer.setTargetName(selfName);
//                flag=true;
//                break;
//            }
//        }
//
//        if (flag){
//            try {
//                session.getBasicRemote().sendText("连接成功！");
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }else{
//            String message="对方不在线！";
//            try {
//                session.getBasicRemote().sendText(message);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }

    /**
     * 将消息发送给所有人
     * @param msg 消息
     */
    private void send2All(String msg) throws IOException,EncodeException {
//        JSONObject message = JSONObject.fromObject(msg);
//        JSONObject message=JSONObject.fromObject(msg);

        String message=msg;
        message=message.replaceAll("}","");

//        message.put("date", DATE_FORMAT.format(new Date()));
        message+=",\"date\":\""+DATE_FORMAT.format(new Date())+"\"";

        String sendStr;
        //发送消息
        String groupName=(String)httpSession.getAttribute("group_name");
        CopyOnWriteArraySet<ChatServer> chatServers=ChatServers.get(groupName);
        for(ChatServer chatServer:chatServers){
            sendStr=message+",\"isSelf\":\"" +chatServer.getSession().equals(session) +"\"}";
//            message.put("isSelf", chatServer.getSession().equals(session));
            chatServer.getSession().getBasicRemote().sendText(sendStr);
        }

    }

    /**
     * 发送在线列表
     * @throws IOException IO异常
     * @throws EncodeException 编码器异常
     */
//    private void sendOnlineUsers() throws IOException, EncodeException {
//        //当有新用户连接服务器时，将在线列表发送给所有在线用户
//        Set<String> userSet =new HashSet<>();
//        for (ChatServer chatServer: ChatServers){
//            String temp = (String) chatServer.getHttpSession().getAttribute("user_name");
//            if (temp!=null){
////                temp.setChatRecords(null);//不需要加载聊天记录----否则会引起死循环解析
//                userSet.add(temp);
//            }
//        }
//        //发送在线列表
//        for (ChatServer chatServer: ChatServers){
//            chatServer.getSession().getBasicRemote().sendObject(userSet);
//        }
//    }

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    public HttpSession getHttpSession() {
        return httpSession;
    }

    public void setHttpSession(HttpSession httpSession) {
        this.httpSession = httpSession;
    }

    //    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");	// 日期格式化
//
//    @OnOpen
//    public void open(Session session) {
//        // 添加初始化操作
//    }
//
//    /**
//     * 接受客户端的消息，并把消息发送给所有连接的会话
//     * @param message 客户端发来的消息
//     * @param session 客户端的会话
//     */
//    @OnMessage
//    public void getMessage(String message, Session session) {
//        // 把客户端的消息解析为JSON对象
//        JSONObject jsonObject = JSONObject.fromObject(message);
//        // 在消息中添加发送日期
//        jsonObject.put("date", DATE_FORMAT.format(new Date()));
//        // 把消息发送给所有连接的会话
//        for (Session openSession : session.getOpenSessions()) {
//            // 添加本条消息是否为当前会话本身发的标志
//            jsonObject.put("isSelf", openSession.equals(session));
//            // 发送JSON格式的消息
//            openSession.getAsyncRemote().sendText(jsonObject.toString());
//        }
//    }
//
//    @OnClose
//    public void close() {
//        // 添加关闭会话时的操作
//    }
//
//    @OnError
//    public void error(Throwable t) {
//        // 添加处理错误的操作
//    }
}