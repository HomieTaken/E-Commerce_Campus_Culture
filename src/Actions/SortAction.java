package Actions;

import Entity.CultureProduct;
import Operations.MultiSort;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.util.Map;

public class SortAction extends ActionSupport {

  private int sortFlag;//排序标记

    public int getSortFlag() {
        return sortFlag;
    }

    public void setSortFlag(int sortFlag) {
        this.sortFlag = sortFlag;
    }

    @Override
    public String execute() throws Exception {

        CultureProduct[] products =(CultureProduct[]) ActionContext.getContext().getSession().get("search_products");
        //CultureProduct[] products = super.getProducts();
        //int price_sort = 0;
        if(products.length > 0) {
            products = Sort(products, sortFlag);
            ActionContext actionContext = ActionContext.getContext();
            Map<String, Object> session = actionContext.getSession();
            session.put("search_products", products);
        }
        return "success";
    }

    private CultureProduct[] Sort(CultureProduct[] products, int price_sort) { ;

        switch (price_sort)
        {
            case 0:ascending_price(products,0,products.length-1);break;//价格升序
            case 1:descending_price(products,0,products.length-1);break;//价格降序
            case 2: descending_sale(products,0,products.length-1);break;//销量降序
            case 3: MultiSort.multiSort(products);break;//综合排序
            default:break;
        }
        return  products;
    }

    private void descending_price(CultureProduct[] products,int low,int high) {
        int start = low;
        int end = high;
        double temp = products[low].getPrice();
        while(end > start)
        {
            while(end > start && products[end].getPrice() <= temp)
            {
                end--;
            }
            if(products[end].getPrice() >= temp)
            {
                CultureProduct Temp = products[end];
                products[end] = products[start];
                products[start] = Temp;
            }
            while(end > start && products[start].getPrice() >= temp)
            {
                start++;
            }
            if(products[start].getPrice() <= temp)
            {
                CultureProduct Temp = products[start];
                products[start] = products[end];
                products[end] = Temp;
            }
        }
        if(start > low) descending_price(products,low,start-1);
        if(end < high)  descending_price(products,end+1,high);

    }

    private void ascending_price(CultureProduct[] products,int low,int high) {
        int start = low;
        int end = high;
        double temp = products[low].getPrice();
        while(end > start)
        {
            while(end > start && products[end].getPrice() >= temp)
            {
                end--;
            }
            if(products[end].getPrice() <= temp)
            {
                CultureProduct Temp = products[end];
                products[end] = products[start];
                products[start] = Temp;
            }
            while(end > start && products[start].getPrice() <= temp)
            {
                start++;
            }
            if(products[start].getPrice() >= temp)
            {
                CultureProduct Temp = products[start];
                products[start] = products[end];
                products[end] = Temp;
            }
        }
        if(start > low) ascending_price(products,low,start-1);
        if(end < high)  ascending_price(products,end+1,high);
    }

    private void descending_sale(CultureProduct[] products,int low,int high) {
        int start = low;
        int end = high;
        int temp = products[low].getAmount();
        while(end > start)
        {
            while(end > start && products[end].getAmount() <= temp)
            {
                end--;
            }
            if(products[end].getAmount() >= temp)
            {
                CultureProduct Temp = products[end];
                products[end] = products[start];
                products[start] = Temp;
            }
            while(end > start && products[start].getAmount() >= temp)
            {
                start++;
            }
            if(products[start].getAmount() <= temp)
            {
                CultureProduct Temp = products[start];
                products[start] = products[end];
                products[end] = Temp;
            }
        }
        if(start > low) descending_sale(products,low,start-1);
        if(end < high)  descending_sale(products,end+1,high);

    }

}


