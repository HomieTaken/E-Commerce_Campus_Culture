package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionSupport;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class SearchGroup extends ActionSupport {
    private String searchStr;
    private String ownerID;
    private InputStream inputStream;

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(String ownerID) {
        this.ownerID = ownerID;
    }

    public String getSearchStr() {
        return searchStr;
    }

    public void setSearchStr(String searchStr) {
        this.searchStr = searchStr;
    }

    public String searchGroup() throws UnsupportedEncodingException {
        String groups="{\"success\":\"false\"}";
        try {
            Set<String> ownerGroups=new HashSet<>();
            Set<String> otherGroups=new HashSet<>();
            ResultSet rs=DBOperation.getRS("select * from interest_group");
            while (rs.next()) {
                String group=rs.getString("group_name");
                if(group.contains(searchStr)||searchStr.contains(group)) {
                    if (Integer.parseInt(ownerID) == rs.getInt("group_owner_id"))
                        ownerGroups.add(group);
                    else
                        otherGroups.add(group);
                }
            }
            if(ownerGroups.size()!=0||otherGroups.size()!=0) {
                groups = "{\"success\":\"true\",\"ownerGroups\":\"" + ownerGroups.toString() + "\",\"otherGroups\":\"" + otherGroups.toString() + "\"}";
                inputStream = new ByteArrayInputStream(groups.getBytes("UTF-8"));
                return "searchGroup";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        inputStream = new ByteArrayInputStream(groups.getBytes("UTF-8"));
        return "searchGroup";
    }
}
