websocket=null;
function createConn() {
    if(window.websocket==null) {
        //判断当前浏览器是否支持WebSocket
        if ('WebSocket' in window) {
            window.websocket = new WebSocket("ws://localhost:8080/messageServer");
            //连接发生错误的回调方法
            window.websocket.onerror = function () {
                alert("WebSocket连接发生错误");
            };

            //连接成功建立的回调方法
            window.websocket.onopen = function () {
                // alert("WebSocket连接成功");
            }

            //接收到消息的回调方法
            window.websocket.onmessage = function (event) {
                //     alert(event.data.toString());
                window.location.href="/enterTeamBox.action?page="+pageNum;
                // setMessageInnerHTML(event.data);
            }

            //连接关闭的回调方法
            window.websocket.onclose = function () {
                // alert("WebSocket连接关闭");
            }
            window.onbeforeunload = function () {
                closeWebSocket();
            }


            //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
            /*  window.onbeforeunload = function () {
                  closeWebSocket();
              }*/
            //  alert('已连接');
        }
        else {
            alert('当前浏览器 Not support websocket');
        }
    }
}

//将消息显示在网页上
/*function setMessageInnerHTML(innerHTML) {
         document.getElementById('message').innerHTML += innerHTML + '<br/>';
       }*/

//关闭WebSocket连接
function closeWebSocket() {
    window.websocket.close();
}
