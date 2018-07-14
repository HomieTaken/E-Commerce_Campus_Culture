package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONObject;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SchoolTeamsManagement extends ActionSupport {
    private String teamID;
    private String teamName;
    private String passOrFailed;
    private InputStream inputStream;

    public String getTeamID() {
        return teamID;
    }

    public void setTeamID(String teamID) {
        this.teamID = teamID;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getPassOrFailed() {
        return passOrFailed;
    }

    public void setPassOrFailed(String passOrFailed) {
        this.passOrFailed = passOrFailed;
    }

    public String deleteTeam() throws UnsupportedEncodingException {
        try {
            DBOperation.Update("delete from user where user_id="+teamID);
            System.out.println(teamID+"删除成功");
            inputStream = new ByteArrayInputStream("0".getBytes("UTF-8"));
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(teamID+"删除失败");
            inputStream = new ByteArrayInputStream("1".getBytes("UTF-8"));
        }
        return "ajax_delete";
    }

    public String dealApplication() throws UnsupportedEncodingException {
        String backData="";
        try {
            ResultSet rs=DBOperation.getRS("select * from team_apply where team_name=\'"+teamName+"\'");
            if(rs.next()) {
                if (passOrFailed.equals("pass")) {
                    String sql = "insert into user(user_name,user_email,user_password,user_school_name,user_type) " +
                            "values(\'" + rs.getString("team_name") +
                            "\',\'" + rs.getString("team_email") +
                            "\',\'" + rs.getString("team_password") +
                            "\',\'" + rs.getString("team_school_name") +
                            "\','TEAM')";
                    DBOperation.Update(sql);

                    sql = "update team_apply set apply_state='pass' where team_name=\'"+teamName+"\'";
                    DBOperation.Update(sql);

                    ResultSet resultSet=DBOperation.getRS("select * from user where user_name=\'"+teamName+"\'");
                    if(resultSet.next()){
                        backData+="{\"state\":\"0\",\"teamName\":\"" +
                                resultSet.getString("user_name")+
                                "\",\"teamID\":\"" +
                                Integer.parseInt(resultSet.getString("user_id"))+
                                "\",\"teamEmail\":\"" +
                                resultSet.getString("user_email")+
                                "\"}";
                    }
                } else if (passOrFailed.equals("failed")) {
                    String sql = "update team_apply set apply_state='failed' where team_name=\'"+teamName+"\'";
                    DBOperation.Update(sql);
                    backData+="{\"state\":\"1\"}";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            backData+="{\"state\":\"2\"}";
            return "ajax_deal";
        }
        inputStream = new ByteArrayInputStream(backData.getBytes("UTF-8"));
//        String backData="";
//        if(passOrFailed.equals("pass")){
//            backData="{\"teamName\":\"teamName\",\"state\":\"0\"}";
//        }else if(passOrFailed.equals("failed")) {
//            backData="{\"teamName\":\"teamName\",\"state\":\"1\"}";
//        }
//        inputStream=new ByteArrayInputStream(backData.getBytes("UTF-8"));
        return "ajax_deal";
    }
}
