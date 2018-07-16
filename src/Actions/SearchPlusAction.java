package Actions;

import Entity.CultureProduct;
import Operations.MultiSort;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.util.Map;

public class SearchPlusAction extends ActionSupport{
    private String entry;//搜索词条
    private CultureProduct[] products;
    private int teamID;
    private int state;

    public String getEntry() {
        return entry;
    }

    public void setEntry(String entry) {
        this.entry = entry;
    }

    public CultureProduct[] getProducts() {
        return products;
    }

    public void setProducts(CultureProduct[] products) {
        this.products = products;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @Override
    public String execute() throws Exception {
//        byte[] b=entry.getBytes("ISO-8859-1");//用tomcat的格式（iso-8859-1）方式去读。
//        entry = new String(b,"utf-8");;
        this.setTeamID((int) ActionContext.getContext().getSession().get("teamID"));
        String  sql = "select * from (select * from product where product_team_id = '"+this.getTeamID() +"' )as team_product where product_name  like '%" + this.getEntry() + "%'";
        System.out.println(sql);
        this.setProducts(CultureProduct.getProduct(sql)) ;
        this.state = 1;
        MultiSort.multiSort(this.getProducts());
        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        session.put("search_products",products);
        session.put("search_state",state);
        return "success";
    }

}
