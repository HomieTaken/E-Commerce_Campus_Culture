package Actions;

import DataBase.DBConnect;
import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.Parameter;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReleaseProduct extends ActionSupport {
    //productName,productPrice,productAmount,description,imgFile
    private String productName;
    private String productPrice;
    private String productAmount;
    private String description;
    private File imgFile;
    private String imgFileFileName;
    private String imgFileContentType;
    private String teamID;

    public String getImgFileContentType() {
        return imgFileContentType;
    }

    public void setImgFileContentType(String imgFileContentType) {
        this.imgFileContentType = imgFileContentType;
    }

    public String getImgFileFileName() {
        return imgFileFileName;
    }

    public void setImgFileFileName(String imgFileFileName) {
        this.imgFileFileName = imgFileFileName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductAmount() {
        return productAmount;
    }

    public void setProductAmount(String productAmount) {
        this.productAmount = productAmount;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public java.io.File getImgFile() {
        return imgFile;
    }

    public void setImgFile(java.io.File imgFile) {
        this.imgFile = imgFile;
    }

    public String getTeamID() {
        return teamID;
    }

    public void setTeamID(String teamID) {
        this.teamID = teamID;
    }

    public boolean fileUpload(File flie) {
        FileInputStream in = null;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            in = new FileInputStream(flie);
            System.out.println(in.available());
            conn = DBConnect.getConnection();
            if (conn == null) {
                System.out.println("连接为null");
                return false;
            }
            String sql="INSERT INTO product(product_info, product_img, product_name, product_price,product_team_id,product_amount)" +
                    " values('" +
                    description+
                    "',?,'" +
                    productName+
                    "','" +
                    productPrice+
                    "'," + this.teamID+",'" +
                    productAmount+
                    "')";
            ps = conn.prepareStatement(sql);
            ps.setBinaryStream(1, (InputStream) in, (int) in.available());
            if (ps.executeUpdate() > 0) {
                DBConnect.close(conn, ps, null);
                return true;
            } else {
                DBConnect.close(conn, ps, null);
                return false;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            DBConnect.close(conn, ps, null);
            return false;
        }
    }

    @Override
    public String execute() throws Exception {

//        String realpath = ServletActionContext.getServletContext().getRealPath("/");
//        System.out.println("realpath: "+realpath);
//        if(imgFile != null){
//            File savefile = new File(realpath, imgFile.getName());
//            System.out.println(savefile);
//            System.out.println(savefile.getParentFile());
//            if(savefile.getParentFile().exists()){
//                try {
//                    savefile.getParentFile().mkdirs();
//                    FileUtils.copyFile(imgFile, savefile);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//                ActionContext.getContext().put("message", "文件上传成功");
//            }
//        }

//        String sql="insert into activity values(NUll,NULL,?)";//挖坑
//        String sql="INSERT INTO product(product_info, product_img, product_name, product_price)" +
//                " values('" +
//                description+
//                "',empty_blob(),'" +
//                productName+
//                "','" +
//                productPrice+
//                "','" +
//                1+
//                "')";

        boolean upload=fileUpload(imgFile);
        System.out.println(upload);
        return SUCCESS;
    }
}
