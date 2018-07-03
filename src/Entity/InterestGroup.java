package Entity;

import java.util.ArrayList;

public class InterestGroup {
    private int ownerID;
    private int groupID;
    private ArrayList<Integer> members;             //对应的id，members对应user
    private ArrayList<ChatRecord> records;

    public void addMember(User user){
        members.add(user.getId());
    }

    public void addRecord(ChatRecord record){
        records.add(record);
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public int getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(int ownerID) {
        this.ownerID = ownerID;
    }

    public ArrayList<Integer> getMembers() {
        return members;
    }

    public void setMembers(ArrayList<Integer> members) {
        this.members = members;
    }

    public ArrayList<ChatRecord> getRecords() {
        return records;
    }

    public void setRecords(ArrayList<ChatRecord> records) {
        this.records = records;
    }
}
