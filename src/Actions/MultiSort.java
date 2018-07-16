package Actions;
import Entity.CultureProduct;

public class MultiSort {
    public static void multiSort(CultureProduct[] products)
    {
        if(products != null && products.length>0 ) {
            double[] weight = getWeight(products);
            descending_multi(products, 0, products.length - 1, weight);
        }
    }

    private static void descending_multi(CultureProduct[] products, int low, int high, double[] weight) {
        int start = low;
        int end = high;
        double temp = weight[low];
        while(end > start)
        {
            while(end > start && weight[end] <= temp)
            {
                end--;
            }
            if(weight[end] >= temp)
            {
                CultureProduct cTemp = products[end];
                products[end] = products[start];
                products[start] = cTemp;

                double dTemp = weight[end];
                weight[end] = weight[start];
                weight[start] = dTemp;
            }
            while(end > start && weight[start] >= temp)
            {
                start++;
            }
            if(weight[start] <= temp)
            {
                CultureProduct cTemp = products[start];
                products[start] = products[end];
                products[end] = cTemp;

                double dTemp = weight[end];
                weight[end] = weight[start];
                weight[start] = dTemp;
            }
        }
        if(start > low) descending_multi(products,low,start-1,weight);
        if(end < high)  descending_multi(products,end+1,high,weight);

    }

    private static double[] getWeight(CultureProduct[] products) {
        double[] weight = new double[products.length];
        for(int i = 0;i<weight.length;i++)
        {
            double dTemp = 0.0;
            if(products[i].getPrice() < 50.0)
                dTemp += products[i].getPrice() * 0.8;
            else if(50.0 <= products[i].getPrice() && products[i].getPrice() < 150.0)
                dTemp += products[i].getPrice() * 0.5;
            else
                dTemp += products[i].getPrice() * 0.2;

            dTemp += products[i].getAmount() * 0.5;
            weight[i] = dTemp;

        }

        return weight;
    }
}
