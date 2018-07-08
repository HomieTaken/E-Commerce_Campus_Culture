/*
 * 数据库操作定义：
 * 数据库连接、
 * 增删查改功能insert，delete，update，select、
 *
 */
package DataBase;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;

import Entity.*;

public class DBOperation {

    private static Connection con = null;			//连接对象
    private static Statement st = null;			//语句对象
    private static ResultSet rs = null;				//结果集对象
    /*
     * 检验账户是否有效（未给出参数）
     *
     */
    public boolean validateAccount(){

        return true;
    }

   //数据的增删查改

    public static ResultSet getRS(String sql) throws SQLException {//查询
       con = DBConnect.getConnection();
       st = con.createStatement();
       rs = st.executeQuery(sql);
        return rs;
    }

    public static int Update(String sql) throws SQLException {//插入
        int ret = 0;
        con = DBConnect.getConnection();
        st = con.createStatement();
        ret = st.executeUpdate(sql);
        return ret;
    }
    public static void close()
    {
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
    public static OutputStream getPic(OutputStream os,String sql,String name){
        try{
            ResultSet rs = DBOperation.getRS(sql);
            if (rs.next()) {
                Blob b = rs.getBlob(name);
                long size = b.length();

                InputStream in = b.getBinaryStream();

                int blobsize = (int) b.length();//获取blob长度

                byte[] blobbytes = new byte[blobsize];

                int bytesRead = 0;

                while ((bytesRead = in.read(blobbytes)) != -1) {//循环写入outputstream

                    os.write(blobbytes, 0, bytesRead);

                }
              //  byte[] bs = b.getBytes(1, (int)size);
                //response.setContentType("image/jpeg");
                //OutputStream outs = response.getOutputStream();
              //  os.write(bs);
             //   os.flush();
            }
            else{
                return null;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return os;

    }
}
