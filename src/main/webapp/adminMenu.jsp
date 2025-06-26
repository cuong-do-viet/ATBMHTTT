
<%
    User userLoggingMenu = (User) session.getAttribute("userLogging");
    String adminMenu = (String) session.getAttribute("adminMenu");
    if(adminMenu==null) adminMenu="";
%>
<aside id="sidebar" class="sidebar grid-col-2">
    <ul class="sidebar-nav" id="sidebar-nav">
        <h3 style="text-align: center">[Admin]</h3>
        <%if(userLoggingMenu.hasRole("CUSTOMER")) {%>
            <li class="nav-item">
                <a class="nav-link <%=adminMenu.equalsIgnoreCase("customer")?"":"collapsed"%>" href="adminmenu?action=admincustomer">
                    <span>Quản lý khách hàng</span>
                </a>
            </li>
        <%
            }
        %>
        <%if(userLoggingMenu.hasRole("EMPLOYEE")) {%>
        <li class="nav-item ">
            <a class="nav-link <%=adminMenu.equalsIgnoreCase("employee")?"":"collapsed"%>" href="adminmenu?action=adminemployee">
                <span>Quản lý nhân viên</span>
            </a>
        </li>
        <%
            }
        %>
        <%if(userLoggingMenu.hasRole("PRODUCT")) {%>
        <li class="nav-item ">
            <a class="nav-link <%=adminMenu.equalsIgnoreCase("product")?"":"collapsed"%>" href="adminmenu?action=adminproduct">
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <%
            }
        %>
        <%if(userLoggingMenu.hasRole("ORDER")) {%>
        <li class="nav-item ">
            <a class="nav-link <%=adminMenu.equalsIgnoreCase("order")?"":"collapsed"%>" href="adminmenu?action=adminorder">
                <span>Quản lý đơn hàng</span>
            </a>
        </li>
        <%
            }
        %>
    </ul>
</aside><!-- End Sidebar-->