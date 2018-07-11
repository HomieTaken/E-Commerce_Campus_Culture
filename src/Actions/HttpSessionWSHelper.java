package Actions;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

/**
 * Created by zipple on 2017/11/14.
 * 协助server获取http session
 */
public class HttpSessionWSHelper extends Configurator {
    @Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        System.out.println("调用modifyHandshake方法...");
        HttpSession session = (HttpSession) request.getHttpSession();//session有可能为空
        if (session!=null){
            System.out.println("获取到session id:"+session.getId());
            sec.getUserProperties().put(HttpSession.class.getName(),session);
        }else{
            System.out.println("modifyHandshake 获取到null session");
        }
    }

}
