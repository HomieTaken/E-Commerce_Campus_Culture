package DataBase;

import java.sql.*;

public class DBConnect {

    private static Connection conn = null;			//连接对象

    //加载驱动，连接数据库
    public static Connection getConnection() {
        try{
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver);

            String user = "zhangweidb%zhangwei";
            String password = "Zhangwei123";
            String url = "jdbc:mysql://zhangweidb.mysqldb.chinacloudapi.cn:3306/db";
            conn = DriverManager.getConnection(url, user, password);

        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public static void close(Connection con,Statement st,ResultSet rs){
        if(rs!=null)
            try {
                rs.close();
            } catch (SQLException e) {   e.printStackTrace();       }
        if(st!=null)
            try {
                st.close();
            } catch (SQLException e) {  e.printStackTrace();        }
        if(con!=null)
            try {
                con.close();
            } catch (SQLException e) {   e.printStackTrace();       }
    }
}

