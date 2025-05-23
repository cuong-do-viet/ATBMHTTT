package controller;

import DAO.BrandDAO;
import DAO.ImageDAO;
import DAO.ProductUnitDAO;
import DAO.UserDAO;
import com.google.gson.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@WebServlet("/adminemployee")
public class AdminEmployeeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User userLogging = (User) session.getAttribute("userLogging");

        String action = req.getParameter("action");
        action = action.toUpperCase();
        switch (action) {
            case "SEARCH": {
                String idin = req.getParameter("search");
                ArrayList<ProductUnit> productUnits = ProductUnitDAO.getInstance().searchForAdmin(idin);
                req.setAttribute("numOfPages", 1);
                req.setAttribute("productUnits", productUnits);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminProduct.jsp");
                dispatcher.forward(req, resp);
                break;
            }
            case "QUERY": {
                System.out.println("product query");
//                int page = req.getParameter("page")!=null?Integer.parseInt(req.getParameter("page")):0;
//                int byStatus = req.getParameter("byStatus")!=null?Integer.parseInt(req.getParameter("byStatus")):-1;
//                int offset = (page-1)*Constant.NUM_OF_ITEMS_A_PAGE;
//                System.out.println("page: " + page);
//                System.out.println("byStatus: " + byStatus);
//                System.out.println("offset: " + offset);
//                ArrayList<OrderUnit> orderunits = OrderDAO.getInstance().selectOrderUnitByStatus(byStatus,offset,Constant.NUM_OF_ITEMS_A_PAGE);
//                String html = renderOrderList(orderunits);
//                resp.getWriter().write(html);
                break;
            }
            case "ROLES" : {
                int id = Integer.parseInt(req.getParameter("id"));
                System.out.println("prepare update id: "+id);
                User user = UserDAO.getInstance().selectById(id);
                String[] roles=user.getRoles();
                System.out.println("mang roles");
                for(String role:roles)
                    System.out.println(role);

                String rolesString = String.join("==", roles);
                System.out.println("rolesString: "  + rolesString);
                if(roles!=null) {
                    Map<String, String> responseData = new HashMap<>();
                    responseData.put("id", String.valueOf(id));
                    responseData.put("roles", rolesString);
                    Gson gson = new GsonBuilder()
                            .disableHtmlEscaping() // Không escape các ký tự đặc biệt
                            .create();
                    String jsonResponse = gson.toJson(responseData);
                    System.out.println("jsno roles: " + jsonResponse);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(jsonResponse);
                }
                break;
            }
            case "UPDATEROLES" : {
                int id = Integer.parseInt(req.getParameter("id"));
                System.out.println("update roles id: "+id);
//                String dashboard = req.getParameter("dashboard");
                String customer = req.getParameter("customer");
                String employee = req.getParameter("employee");
                String product = req.getParameter("product");
                String order = req.getParameter("order");

                //["order","product"]
                String roles = "[\""+customer+"\",\""+employee+"\",\""+product+"\",\""+order+"\"]";
                int re = UserDAO.getInstance().updateRoles(id, roles);
                if(re==1) {
                    System.out.println("cap nhat quyeefn thanh cong");
                    String message="Cập nhật quyền cho " + id + " thành công";
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminmenu?action=adminemployee&message="+message);
                    dispatcher.forward(req, resp);
                }
                break;
            }
            case "LOCK": {
                System.out.println("lock customer");
                int id = Integer.parseInt(req.getParameter("id"));
                int re = UserDAO.getInstance().lockUser(id);
                String html="";
                if(re==1) {
                    html = htmlSuccessToast("Khóa tài khoản id: " + id +" thành công!");

                } else {
                    html = htmlErrorToast("Khóa tài khoản id: " + id +" thất bại!");
                }
                resp.getWriter().write(html);
                break;
            }
            case "ACTIVE": {
                System.out.println("active customer");
                int id = Integer.parseInt(req.getParameter("id"));
                int re = UserDAO.getInstance().activeUser(id);
                String html="";
                if(re==1) {
                    html = htmlSuccessToast("Mở tài khoản hàng id: " + id +" thành công!");

                } else {
                    html = htmlErrorToast("Mở tài khoản hàng id: " + id +" thất bại!");
                }
                resp.getWriter().write(html);
                break;
            }
            case "DELETE": {
                System.out.println("delete customer");
                int id = Integer.parseInt(req.getParameter("id"));
                int re = UserDAO.getInstance().deleteUser(id);
                if(re==1) {
                    System.out.println("xóa thanh cong");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminmenu?action=admincustomer&message=deleteSuccess_"+id);
                    dispatcher.forward(req, resp);
                }
                break;
            }
            case "ORDER": {
                System.out.println("cutomer: order");
                int id = Integer.parseInt(req.getParameter("id"));
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminorder?action=orderOf&id="+id);
                dispatcher.forward(req, resp);

                break;
            }
            case "SHOWDETAIL": {
                System.out.println("show detail customer");
                int id = Integer.parseInt(req.getParameter("id"));
                User user= UserDAO.getInstance().selectById(id);
                System.out.println("thong tin: " + user.getUserInfo());
                String html = renderDetails(user) ;
                resp.getWriter().write(html);
                break;
            }
            case "UPDATEDETAIL": {
                System.out.println("show detail customer");
                int id = Integer.parseInt(req.getParameter("id"));
                User user= UserDAO.getInstance().selectById(id);
                String info = user.getInfo();
                String area = req.getParameter("area");
                String position = req.getParameter("position");
                Gson gson = new Gson();
                JsonObject jsonObject = gson.fromJson(info, JsonObject.class);
                jsonObject.addProperty("position", position);
                jsonObject.addProperty("area", area);
                String updatedJsonString = gson.toJson(jsonObject);
                user.setInfo(updatedJsonString);
                int re = UserDAO.getInstance().update(user);
                if(re==1) {
                    String html = htmlSuccessToast("Cập nhật thông tin id: " + id + " thành công!") ;
                    resp.getWriter().write(html);
                }
                break;
            }
            case "ISSUEPASSWORD": {
                System.out.println("issue customer password");
                int id = Integer.parseInt(req.getParameter("id"));
                User user= UserDAO.getInstance().selectById(id);
                StringBuilder newPasswordTemp= new StringBuilder();
                for(int i=0;i<8;i++) {
                    int tempIndex= new Random().nextInt(Constant.EN_CHARS.length());
                    newPasswordTemp.append(Constant.EN_CHARS.charAt(tempIndex));
                }
                String newPassword = newPasswordTemp.toString();
                String hashedPassword = User.hashPassword(newPassword);
                int re = UserDAO.getInstance().updatePassword(id,hashedPassword); // cap nhat mat khau trong database

                // code gui mat khau moi ve mail
                String email  = user.getEmail();

                if(re==1) {
                    String html = htmlSuccessToast("Cấp mật khẩu mới thành công!");
                    resp.getWriter().write(html);
                }
                break;
            }
            case "ADD": {
                System.out.println("admin product : add product");
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String area = req.getParameter("area");
                String position = req.getParameter("position");
                String dateIn = req.getParameter("dateIn");
                String password = req.getParameter("defaultPassword");
                String info = "{\"dateIn\":\""+dateIn+"\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\""+position+"\",\"area\":\""+area+"\"}";

                String hashedPassword = User.hashPassword(password);
                User user = new User(name, email, hashedPassword, info);
                int id = UserDAO.getInstance().insert(user);
                id=UserDAO.getInstance().updateRoles(id,"[\""+null+"\",\""+null+"\",\""+null+"\",\""+null+"\"]");
                if(id!=0) {
                    // gui mail ve tai khoan

                    System.out.println("add customer thanh cong");
                    String message= "Thêm tài khoản nhân viên thành công";
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminmenu?action=adminemployee&message="+message);
                    dispatcher.forward(req, resp);
                }


                break;
            }

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        doGet(req, resp);
    }

    public String renderUpdateForm(ProductUnit p,ArrayList<Brand> brands, ArrayList<Image> imgs) {
        String re="";
//        re = "                    <form action=\"adminproduct\" method=\"POST\" id=\"updateInfoForm\" enctype=\"multipart/form-data\">\n" +
        re =
                "                        <h4 class=\"confirm-content\" style=\"text-align: center\">Cập nhật thông tin sản phẩm</h4>\n" +
                        "                        <div class=\"flex-roww\" style=\"justify-content: space-between; margin-top: 10px;\">\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label for=\"name\">Tên</label>\n" +
                        "                                <input type=\"text\" class=\"form-control\" id=\"name\" name=\"name\" value=\""+p.getName()+"\" aria-describedby=\"emailHelp\" placeholder=\"Nhập tên sản phẩm\" required>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group flex-roww grid-col-4\">\n" +
                        "                                <label for=\"id\">ID:</label>\n" +
                        "                                <input type=\"text\" class=\"form-control\" id=\"id\" name=\"id\" aria-describedby=\"emailHelp\" placeholder=\"ID\" value=\""+p.getProductID()+"\" readonly>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"justify-content: space-between; margin-top: 10px;\">\n" +
                        "                        <div class=\"form-group grid-col-4\">\n" +
                        "                            <label for=\"version\">Phiên bản</label>\n" +
                        "                            <input type=\"text\" class=\"form-control\" id=\"version\" name=\"version\" value=\""+p.getVersion()+"\" aria-describedby=\"emailHelp\" placeholder=\"Nhập phiên bản\" required>\n" +
                        "                        </div>\n" +
                        "                            <div class=\"form-group flex-roww grid-col-4\">\n" +

                        "                            </div>\n" +
                        "                        </div>\n" +

                        "                        <div class=\"flex-roww\" style=\"justify-content: space-between; margin-top: 15px;\">\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label>Thương hiệu</label>\n" +
                        getBrandSelect(p.brand.id,brands) +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label>Phân loại</label>\n" +
                        getCateSelect(p.cateID)+
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"justify-content: space-between; margin-top: 15px;\">\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label for=\"saleDate\">Ngày mở bán</label>\n" +
                        "                                <input type=\"date\" class=\"form-control\" id=\"saleDate\" name=\"saleDate\" value=\""+p.getSaleDate()+"\" placeholder=\"Nhập ngày mở bán\" required>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label for=\"initial-price\">Giá mở bán</label>\n" +
                        "                                <input type=\"text\" class=\"form-control\" id=\"initial-price\" name=\"initialPrice\" value=\""+p.getInitialPrice()+"\" placeholder=\"Nhập giá mở bán\" required>\n" +
                        "                            </div>\n" +
                        "                            <input type=\"text\" name=\"firstSale\"  value='"+p.firstSale+"' hidden>\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top: 15px;\" >\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label>Cấu hình</label>\n" +
                        "                                <table id=\"configTable\" class=\"table\">\n" +
                        "                                    <thead>\n" +
                        "                                    <tr>\n" +
                        "                                        <th>Tên</th>\n" +
                        "                                        <th>Giá trị</th>\n" +
                        "                                    </tr>\n" +
                        "                                    </thead>\n" +
                        "                                    <tbody class=\"group\">\n" +
                        getConfigurationTable(p.config)+
                        "                                    </tbody>\n" +
                        "                                </table>\n" +
                        "                                <input type=\"text\" name=\"config\" hidden>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top: 15px;\" >\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label>Nổi bật</label>\n" +
                        "                                <input type=\"text\" name=\"feature\" value=\""+getFeatureValue(p.config)+"\" placeholder=\"Nhập thuộc tính nổi bật\">\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top: 15px;\" >\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <label for=\"prominence\">Độ nổi bật</label>\n" +
                        "                                <input type=\"number\" class=\"form-control\" id=\"prominence\" name=\"prominence\" value=\""+p.prominence+"\" placeholder=\"Nhập độ nổi bật\" required>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                            </div>\n" +
                        "\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top: 20px;\" >\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                                <p>Ảnh thumbnail</p>\n" +
                        "                                <input id=\"thumbnailInput\" type=\"file\" name=\"thumbnail\" accept=\".jpg, .jpeg, .png\"  onchange=\"previewImage()\" />\n" +
                        "                                <div class=\"thumbnail-img-container grid-col-6\" style=\"margin-top: 15px;\">\n" +
                        "                                    <img src=\"./assets/img/thumbnail/"    +p.thumbnail+"\" alt=\"\" id=\"thumbnailPreview\" style=\"width:100%\">\n" +
//                "                                     <input type=\"text\" value=\""+p.thumbnail+"\" name=\"thumbnailInput\">\n\n" +
                        "                                </div>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"form-group grid-col-4\">\n" +
                        "                            </div>\n" +

                        "\n" +
                        "                        </div>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top: 20px;\" >\n" +
                        "                            <div class=\"form-group\">\n" +
                        "                                <p>Ảnh chi tiết</p>\n" +
                        "                                <!--                new -->\n" +
                        "                                <div class=\"upload__box group\">\n" +
                        "                                    <div class=\"upload__btn-box\">\n" +
                        "                                        <label class=\"upload__btn\">\n" +
                        "                                            <input type=\"file\" multiple data-max_length=\"20\" name=\"imgs\" class=\"upload__inputfile\" accept=\".jpg, .jpeg, .png\" onchange=\"previewImages(event);\">\n" +
                        "                                        </label>\n" +
                        "                                    </div>\n" +
                        "                                    <div class=\"upload__img-wrap\">" +
                        getImgs(imgs) +
                        "                                   </div>\n" +
                        "                                   <input type=\"text\" name=\"imgUrls\" value=\""+getImgUrls(imgs)+"\" hidden>\n" +
                        "                                </div>\n" +

                        "                            </div>\n" +
                        "\n" +
                        "\n" +
                        "\n" +
                        "                        </div>\n" +
                        "\n" +
                        "\n" +
                        "\n" +
                        "                        <p>Mô tả</p>\n" +
                        "                        <div class=\"toolbar\">\n" +
                        "                            <button onclick=\"document.execCommand('bold')\"><b>B</b></button>\n" +
                        "                            <button onclick=\"document.execCommand('italic')\"><i>I</i></button>\n" +
                        "                            <button onclick=\"document.execCommand('underline')\"><u>U</u></button>\n" +
                        "                        </div>\n" +
                        "\n" +
                        "                        <textarea contenteditable=\"true\" id=\"editor\" class=\"editor\" name=\"description\" placeholder=\"Bắt đầu soạn thảo văn bản ở đây...\"></textarea>\n" +
                        "                        <br>\n" +
                        "                        <div class=\"flex-roww\" style=\"margin-top:20px; justify-content: space-around\">\n" +
                        "                            <input type=\"text\" name=\"action\" value=\"update\" hidden>\n" +
                        "                            <button class=\"btn  btn-fourth btn-cancel\" type=\"button\" onclick=\"closeModal(event);\">Hủy</button>\n" +
                        "                            <button class=\"btn btn-primary btn-confirm\" onclick=\"\" type=\"submit\">Lưu</button>\n" +
                        "                        </div>\n";
//                "                    </form>\n";
        return re;
    }
    public String getFileName(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }


    public String getConfigurationTable(String config) {
        String re="";
        JsonObject jsonObject = JsonParser.parseString(config).getAsJsonObject();
        for (String key : jsonObject.keySet()) {
            JsonElement value = jsonObject.get(key);
            if(value.isJsonArray()) continue;
            re+=    "<tr>\n" +
                    "    <td><input type=\"text\" value=\""+key+"\" onkeydown=\"handleKeyDown(event, 1)\"></td>\n" +
                    "    <td><input type=\"text\" value=\""+value.getAsString()+"\" onkeydown=\"handleKeyDown(event, 2)\"></td>\n" +
                    "</tr>\n";

        }
        return re;
    }

    public String getBrandSelect(int selected,ArrayList<Brand> brands) {
        String re = "";
        re = "<select name=\"brandID\" data-default=\""+selected+"\">\n";
        for(Brand b : brands) {
            re+= "<option value=\""+b.getId()+"\" "+(b.getId()==selected?"selected":"") +">"+b.getName()+"</option>\n";
        }
        re+="</select>\n";
        return re;
    }

    public String getCateSelect(int selected) {
        String re = "";
        re = "<select name=\"cateID\" data-default=\""+selected+"\">\n";
        for(int i=1;i<=3;i++) {
            re+= "<option value=\""+i+"\" "+(i==selected?"selected":"") +">"+Constant.getCategoryName(i)+"</option>\n";
        }
        re+="</select>\n";
        return re;
    }

    public String getFeatureValue(String config) {
        String re="";
        JsonElement jsonElement = JsonParser.parseString(config);
        JsonObject jsonObject = jsonElement.getAsJsonObject();
        JsonArray features = jsonObject.getAsJsonArray("features");
        for(JsonElement f : features) {
            re+=f.getAsString()+",";
        }
        re= re.substring(0, re.length()-1);
        return re;

    }

    public String getImgs(ArrayList<Image> images) {
        String re="";
        for(Image image : images) {
            re+="<div class=\"upload__img-box\">\n" +
                    "<div style=\"background-image: url('./assets/img/product/"+image.getUrl()+"')\"  data-file=\""+image.getUrl()+"\" class=\"img-bg\">\n" +
                        "<div class=\"upload__img-close\" onclick=\"removeImg(event)\"></div>\n" +
                    "</div>\n" +
               "</div>";
        }
        return  re;

    }

    public String getImgUrls(ArrayList<Image> images) {
        StringBuilder temp = new StringBuilder();

        for(Image image : images) {
            temp.append(image.getUrl()+"==");
        }
        String re="";
        if(temp.toString().length()>4) {
            re= temp.toString();
            re=re.substring(0, re.length()-2);
        }
        return  re;

    }

    public String htmlSuccessToast(String message) {
        return "<script>showSuccessToast('"+message+"');</script>";
    }

    public String htmlErrorToast(String message) {
        return "<script>showErrorToast('"+message+"');</script>";
    }

    public String renderDetails(User user) {
        String re="";
        int stt=1;
        re=   "<tr class=\"group\">\n" +
                "     <th scope=\"row\" class=\"grid-col-1\" >\n" +
                "         <span class=\"gender\">"+user.getUserInfo().getGender()+"</span>\n" +
                "         <input type=\"text\" name=\"id\" value=\""+user.getId()+"\" hidden>\n" +
                "     </th>\n" +
                "     <td class=\"grid-col-1\">\n" +
                "         <span class=\"birthday\">"+user.getUserInfo().getBirthdayAsString()+"</span>\n" +
                "     </td>\n" +
                "     <td class=\"grid-col-1\">\n" +
                "         <input class=\"info-input\" type=\"text\" name=\"phone\" value=\""+user.getUserInfo().getPhone()+"\" readonly>\n" +
                "     </td>\n" +
                "     <td class=\"grid-col-1\">\n" +
                "          <input class=\"info-input\" type=\"text\" name=\"dateIn\" value=\""+user.getUserInfo().getDateInAsString()+"\" readonly>\n" +
                "     </td>\n" +
                "     <td class=\"grid-col-1\">\n" +
                "          <input class=\"info-input\" type=\"text\" name=\"area\" value=\""+user.getUserInfo().getArea()+"\" readonly>\n" +
                "     </td>\n" +
                "     <td class=\"grid-col-1\">\n" +
                "          <input class=\"info-input\" type=\"text\" name=\"position\" value=\""+user.getUserInfo().getPosition()+"\" readonly>\n" +
                "     </td>\n" +
                "     <td class=\"grid-col-1_5\">\n" +
                "          <div class=\"flex-coll\" style=\"align-items: end;\">\n" +
                "                <button class=\"btn btn-primary btn-setupupdate\" type=\"button\" onclick=\"setupUpdate(event);\" style=\"background-color: blue; color:white\">Cập nhật</button>\n" +
                "                <div class=\"flex-roww secondary-btns-container\" style=\"display: none\">\n" +
                "                      <button class=\"btn btn-fourth btn-save\" style=\"margin-right: 20px;background-color: blue; color:white\" type=\"button\" onclick=\"saveUpdateDetails(event);\">Lưu</button>\n" +
                "                      <button class=\"btn btn-fourth btn-cancel\" style=\"\" type=\"button\" onclick=\"closeDetail();\">Hủy</button>\n" +
                "\n" +
                "                 </div>\n" +
                "           </div>\n" +
                "      </td>\n" +
                " </tr>";

        return re;
    }

    public String renderDetail(ProductDetail d,int stt) {
        String re="";
            re=" <tr class=\"group "+(d.isActive()?"":"locked")+"\" id=\"detail"+d.getId()+"\">\n" +
                    "            <th scope=\"row\" class=\"grid-col-0_5 text-center\" >\n" +
                    "                <span class=\"stt\">"+stt+"</span>\n" +
                    "            </th>\n" +
                    "            <td class=\"grid-col-0_5 text-center\">\n" +
                    "                <span class=\"id\">"+d.getId()+"</span>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1\">\n" +
                    "                <input class=\"info-input\" type=\"text\" name=\"color\" value=\""+d.getColor()+"\" readonly>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1 text-center\">\n" +
                    "                <input class=\"info-input text-center\" type=\"number\" name=\"ram\" value=\""+d.getRam()+"\" readonly>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1 text-center\">\n" +
                    "                <input class=\"info-input text-center\" type=\"number\" name=\"rom\" value=\""+d.getRom()+"\" readonly>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1 text-center\">\n" +
                    "                <input class=\"info-input text-center\" type=\"number\" name=\"price\" value=\""+d.getPrice()+"\" readonly>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1\">\n" +
                    "                <input class=\"info-input text-center\" type=\"number\" name=\"qty\" value=\""+d.getQty()+"\" readonly>\n" +
                    "            </td>\n" +
                    "            <td class=\"grid-col-1\">\n" +
                    "                <select name=\"action\" onchange=\"handleChange(event);\" data-default=\"none\">\n" +
                    "                    <option value=\"none\">...</option>\n" +
                    "                    <option value=\"updatedetail\">Cập nhật</option>\n" +
                    "                    <option class=\"lock-option\" value=\"lockdetail\">Khóa</option>\n" +
                    "                    <option class=\"unlock-option\" value=\"unlockdetail\">Mở khóa</option>\n" +
                    "                    <option value=\"deletedetail\">Xóa</option>\n" +
                    "                </select>\n" +
                    "                <button class=\"update-detail-btn\" onclick=\"updateDetail(event);\"><i class=\"bi bi-floppy\"></i></button>\n" +
                    "\n" +
                    "            </td>\n" +
                    "\n" +
                    "        </tr>";
        return re;
    }



}
