package Actions;

import com.opensymphony.xwork2.ActionSupport;

public class PurchaseAction extends ActionSupport {
    private String address;
    private int number;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public String execute() throws Exception {
        return super.execute();
    }
}
