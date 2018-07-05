/*
 * 数据库操作定义：
 * 数据库连接、
 * 增删查改功能insert，delete，update，select、
 *
 */
package DataBase;

import java.sql.*;

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
}
