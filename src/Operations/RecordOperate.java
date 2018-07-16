package Operations;

import DataBase.DBOperation;
import Entity.ShoppingRecord;

public class RecordOperate {
    public static ShoppingRecord deleteRecord(int user_id,int record_id){
        ShoppingRecord record=null;
        try {
            record=ViewProduct.viewRecord(record_id);
           String sql = "delete from shoppingchart where record_id=" + record_id+" and user_id="+user_id;
            DBOperation.Update(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return record;
    }
}
