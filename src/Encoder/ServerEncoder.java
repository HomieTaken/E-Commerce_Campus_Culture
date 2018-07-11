package Encoder;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;
import java.util.Collection;

/**
 * Created by HomieTaken on 2017/11/14.
 * websocket 对象实体解码器
 */
public class ServerEncoder implements Encoder.Text<Object> {
    @Override
    public String encode(Object chatRecord) throws EncodeException {
        //将chatRecord转化成json格式
        String result;
        if (chatRecord instanceof Collection){//如果是集合类型按照数组转化json
            result = JSONArray.fromObject(chatRecord).toString();
        }else{
            result = JSONObject.fromObject(chatRecord).toString();
        }
        return result;
    }

    @Override
    public void init(EndpointConfig endpointConfig) {

    }

    @Override
    public void destroy() {

    }
}
