package Entity;

import DataBase.DBOperation;

import java.sql.ResultSet;

public class Team {
    private String teamName;
    private String teamEmail;
    private String teamPassword;
    private String teamSchool;
    private int teamSchool_id;
    private int team_id;
    private UserType type;
    public int getTeam_id() {
        return team_id;
    }

    public void setTeam_id(int team_id) {
        this.team_id = team_id;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getTeamName() {
        return teamName;
    }

    public String getTeamEmail() {
        return teamEmail;
    }

    public String getTeamPassword() {
        return teamPassword;
    }

    public String getTeamSchool() {
        return teamSchool;
    }

    public int getTeamSchool_id() {
        return teamSchool_id;
    }

    public void setTeamEmail(String teamEmail) {
        this.teamEmail = teamEmail;
    }

    public void setTeamPassword(String teamPassword) {
        this.teamPassword = teamPassword;
    }

    public void setTeamSchool(String teamSchool) {
        this.teamSchool = teamSchool;
    }

    public void setTeamSchool_id(int teamSchool_id) {
        this.teamSchool_id = teamSchool_id;
    }

    public static Team getTeam(int team_id){
        try {
            Team team=new Team();
            team.setTeam_id(team_id);
            String sql = "select * from user where user_id=" + team_id;
            ResultSet rs = DBOperation.getRS(sql);
            if(rs.next()) {
                team.setTeamEmail(rs.getString("user_email"));
                team.setTeamName(rs.getString("user_name"));
                team.setTeamSchool(rs.getString("user_school_name"));
            }
            sql = "select user_id from user where user_school_name='" +team.getTeamSchool()+"' and user_type='SCHOOL'" ;
            rs = DBOperation.getRS(sql);
           if(rs.next()) {
               team.setTeamSchool_id(rs.getInt("user_id"));
           }
            return team;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
