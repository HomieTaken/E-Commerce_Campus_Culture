package SocketServer;
import Configurator.MessageConf;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
  import javax.websocket.server.ServerEndpoint;
@ServerEndpoint(value="/messageServer",configurator= MessageConf.class)
public class MessageServer {
    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
  private static int onlineCount = 0;
  private ArrayList<String> unreadMessage;
//concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
 private static Map<Integer,ArrayList<MessageServer>> webSocketMap = new HashMap<Integer,ArrayList<MessageServer>>();

//与某个客户端的连接会话，需要通过它来给客户端发送数据
private HttpSession session;
private Session sendMessage;
public Session getSendMessage(){
    return sendMessage;
}
public static Map<Integer,ArrayList<MessageServer>> getWebSocketMap(){
    return webSocketMap;
}
@OnOpen
 public void onOpen(Session ss,EndpointConfig config){
    this.sendMessage=ss;
    this.session = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
    Integer id=(Integer)session.getAttribute("user_id");
    addClient(id,this);
    System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
    addOnlineCount();
      }
      @OnClose
  public void onClose(){
    try {
        Integer id = (Integer) this.session.getAttribute("user_id");
        MessageServer.removeClient(id,this);  //从set中删除
        subOnlineCount();           //在线数减1
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }
    catch (Exception e){}
      }
  @OnMessage
  public void onMessage(String message, Session session)throws IOException {
    Integer targetClient=Integer.parseInt(message.substring(0,message.indexOf('/')));
     // Integer id=(Integer)this.session.getAttribute("user_id");
          System.out.println("来自客户端的消息:" + message);
         ArrayList<MessageServer>arrayList= webSocketMap.get(targetClient);
         for(int i=0;i<arrayList.size();i++){
             arrayList.get(i).sendMessage.getBasicRemote().sendText(message);
         }
          }

 @OnError
  public void onError(Session session, Throwable error){
               System.out.println("发生错误");
             error.printStackTrace();
         }
 /*public void sendMessage(String message) throws IOException{
           this.session.getBasicRemote().sendText(message);
            //this.session.getAsyncRemote().sendText(message);
        }*/

         public static synchronized int getOnlineCount() {
              return onlineCount;
            }

         public static synchronized void addOnlineCount() {
             MessageServer.onlineCount++;
           }

          public static synchronized void subOnlineCount() {
              MessageServer.onlineCount--;
        }
        public synchronized  static void addClient(Integer id,MessageServer server){
            if(webSocketMap.containsKey(id)){
                webSocketMap.get(id).add(server);
            }
            else{
                ArrayList<MessageServer>arrayList=new ArrayList<MessageServer>();
                arrayList.add(server);
                webSocketMap.put(id,arrayList);
            }
        }
    public synchronized  static void removeClient(Integer id,MessageServer server){
             ArrayList<MessageServer>arrayList=webSocketMap.get(id);
             arrayList.remove(server);
             if(arrayList.size()==0){
                 webSocketMap.remove(id);
             }
    }
}
