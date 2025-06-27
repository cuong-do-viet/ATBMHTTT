<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="adminHeaderImport.jsp" %>
    <title>Quản lý đơn hàng - ThietBiDiDong</title>
    <link href="./assets/css/adminOrder.css" rel="stylesheet">
</head>
<body>
<%@ include file="adminHeader.jsp" %>
<div class="flex-roww">
    <%@ include file="adminMenu.jsp" %>
    <%
        ArrayList<OrderUnit> orderUnits = (ArrayList<OrderUnit>) request.getAttribute("orderUnits");
        int numOfPages = request.getAttribute("numOfPages") != null ? (int) request.getAttribute("numOfPages") : 0;
        int byStatus = request.getAttribute("byStatus") != null ? (int) request.getAttribute("byStatus") : -1;
        String title = (String) request.getAttribute("title");

    %>
    <script>
        console.log("page: <%=numOfPages%>");
    </script>
    <main id="main" class="main grid-col-10">
        <div id="toast-2">

        </div>
        <div class="pagetitle grid-col-3">
            <%
                if (title == null) {
            %>
            <h1>Quản lý đơn hàng</h1>
            <%
            } else {
            %>
            <h1><%=title%>
            </h1>
            <%
                }
            %>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý đơn hàng</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->
        <div class="sub-content">
            <div class="flex-roww" style="justify-content: space-between">
                <form action="adminorder" method="get" class="search-bar grid-col-4" id="search-order-form">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" name="key" placeholder="Bạn tìm gì...">
                    <input type="submit" hidden>
                    <input type="text" name="action" value="search" hidden>
                    <input type="text" name="byStatus" value="-1" hidden>
                </form>
                <script>
                    document.getElementById("search-order-form").addEventListener("submit", function (e) {
                        e.preventDefault();
                        console.log("call search");
                        const byStatus = this.querySelector("input[name='byStatus']");
                        var value = document.querySelector("select[name='byStatus']").value;
                        byStatus.value = value;
                        // ajax time: i want to query for it?
                        this.submit();
                    });
                </script>
                <div class="flex-roww">
                    <p style="margin-right: 10px">Xem theo trạng thái: </p>
                    <select name="byStatus" data-default="<%=byStatus%>">
                        <option value="-1">Tất cả</option>
                        <option value="0">Chờ xác nhận</option>
                        <option value="1">Xác nhận</option>
                        <option value="2">Vận chuyển</option>
                        <option value="3">Thành công</option>
                        <option value="10">Hủy</option>
                    </select>
                </div>

            </div>
            <div class="info-container">
                <table style="width: 100%;" id="infoTable" class="info-table">
                    <thead>
                    <tr>
                        <th scope="col" class="grid-col-0_5 text-center" style="height: fit-content;">ID</th>
                        <th scope="col" class="grid-col-1">Tạo lúc</th>
                        <th scope="col" class="grid-col-3_5">Danh sách sản phẩm</th>
                        <th scope="col" class="grid-col-1_5">Tổng tiền</th>
                        <th scope="col" class="grid-col-1">Xác thực</th>
                        <%--                        <th scope="col" class="grid-col-1">Địa chỉ</th>--%>
                        <th scope="col" class="grid-col-1">Trạng thái</th>
                        <th scope="col" class="grid-col-1">Cập nhật vào</th>
                        <th scope="col" class="grid-col-1">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody id="order-list-container">
                    <%
                        for (OrderUnit o : orderUnits) {
                    %>
                    <tr class="group">
                        <th scope="row" class="grid-col-0_5 text-center id"
                            style="height: fit-content;"><%=o.getOrderID()%>
                        </th>
                        <td class="grid-col-1 text-center">
                            <span class="time"><%=o.getDateSet()%></span>
                        </td>
                        <td class="grid-col-3_5">
                            <%=o.getProductList()%>
                        </td>
                        <td class="grid-col-1_5"><%=o.getTotalMoney()%>
                        </td>
                        <td>HOH</td>
                        <td class="grid-col-1"><span
                                class="status-<%=o.getStatus()%>"><%=Constant.getStatusString(o.getStatus())%></span>
                        </td>
                        <td class="grid-col-1 text-center"><span class="updateTime time"><%=o.getUpdateTime()%></span>
                        </td>
                        <td class="grid-col-1">
                            <p>Cập nhật nhanh:</p>
                            <button class="btn btn-status-<%=o.getNextStatus()%>" type="button"
                                    onclick="updateStatus('<%=o.getOrderID()%>','<%=o.getNextStatus()%>')">
                                <%=o.getNextStatusString()%>
                            </button>
                            <select name="action" onchange="handleChange(event);" data-default="none"
                                    style="margin-bottom: 15px;">
                                <option value="none">Chọn trạng thái</option>
                                <option value="<%=Constant.CONFIRM%>">Xác nhận</option>
                                <option class="" value="<%=Constant.DELIVERY%>">Bàn giao</option>
                                <option class="" value="<%=Constant.COMPLETE%>">Thành công</option>
                                <option value="<%=Constant.CANCEL%>">Hủy</option>
                                <option value="detail">Chi tiết</option>
                            </select>
                            <div class="dropdown">
                                <a class="dropdown-toggle address-detail-btn" href="#"
                                   onclick="event.preventDefault()" role="button"
                                   id="dropdownMenuLink<%=o.getOrderID()%>"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Địa chỉ</a>
                                <div style="position: relative;" class="dropdown-menu address-container sub-content"
                                     aria-labelledby="dropdownMenuLink<%=o.getOrderID()%>">
                                    <%--                                            <div class="address-container sub-content">--%>
                                    <p>Người nhận: <%=o.getReceiver()%>
                                    </p>
                                    <p>Địa chỉ: <%=o.getAddress()%>
                                    </p>
                                    <%--                                            </div>--%>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>


                    <script>
                        // xử lý khi action được chọn trên một dòng nhất định
                        function handleChange(event) {
                            event.stopPropagation();
                            let selectedValue = event.target.value;
                            console.log("selected value: " + selectedValue);
                            const group = event.currentTarget.closest(".group");
                            selectedValue = selectedValue.toUpperCase();
                            var id = parseInt(group.querySelector('.id').innerText);
                            switch (selectedValue) {
                                case "3": {
                                    console.log("const")
                                    updateStatus(id, selectedValue);
                                    break;
                                }
                                default:
                                    updateStatus(id, selectedValue);

                            }
                        }

                        function updateStatus(id, status) {
                            var page = document.querySelector(".page-link.active").getAttribute("data-value");
                            var byStatus = document.querySelector('select[name="byStatus"]').value;
                            console.log("update: " + id + " status: " + status + " byStatus: " + byStatus + " page: " + page);

                            $.ajax({
                                type: "POST",
                                url: "adminorder?action=update",
                                data: {id: id, status: status, page: page, byStatus: byStatus},

                                success: function (data) {
                                    $('#order-list-container').html(data);
                                    $('#order-list-container .dropdown-toggle').dropdown()
                                },
                                error: function (error) {
                                    $('#server-response').html(error.responseText);
                                }
                            });
                        }

                        function queryOrder(page, byStatus) {
                            console.log("query page: " + page + " status: " + byStatus);
                            $.ajax({
                                type: "GET",
                                url: "adminorder?action=query",
                                data: {page: page, byStatus: byStatus},

                                success: function (data) {
                                    $('#order-list-container').html(data);
                                },
                                error: function (error) {
                                    console.error("Error during querying: ", error);
                                }
                            });
                        }

                        document.querySelector('select[name="byStatus"]').addEventListener('change', function (event) {
                            console.log("byStatus change");

                            var pageActiveItem = document.querySelector('.page-item .page-link.active');
                            if (pageActiveItem) {
                                var page = pageActiveItem.getAttribute('data-value');
                                var byStatus = event.currentTarget.value;
                                console.log("page:" + page);
                                console.log("byStatus:" + byStatus);
                                queryOrder(page, byStatus)
                            }
                            else {
                                console.log("BRUH")
                            }

                            // window.location.assign("adminorder?action=byStatus&byStatus=" + event.target.value);
                        });


                        // mở modal xác nhận
                        function setupConfirm(modalID, object) {
                            // var name = group.querySelector('input[name="name"]').value;
                            openModal(modalID);
                            document.querySelector(modalID).querySelector('.object').innerText = object;
                        }

                        function openModal(modalID) {
                            document.querySelector(modalID).classList.add('active');
                        }

                        function setDefaultOption(name) {
                            console.log("setting default option");
                            document.querySelectorAll("select[name=" + name + "]").forEach(select => {
                                const defaultValue = select.getAttribute('data-default');
                                select.value = defaultValue;
                                console.log("datadefault: " + defaultValue + " select: " + select.value);
                            });
                        }

                        setDefaultOption("byStatus");
                    </script>
                    </tbody>
                </table>
                <div class="temp" style="display: none;">

                </div>

            </div>
            <div class="flex-roww" style="justify-content: center;margin-top: 20px">
                <nav aria-label="Page navigation example" id="order-pagination">
                    <ul class="pagination group" style="align-items: baseline;">
                        <li class="page-item-nav">
                            <a class="page-link" href="#" aria-label="Previous" onclick="previousPage(event)">
                                <span class="sr-only">Trước</span>
                            </a>
                        </li>

                        <% for (int i = 1; i <= numOfPages; i++) {%>
                        <li class="page-item"><a class="page-link" data-value="<%=i%>" href="#"
                                                 onclick="queryPage(event)"><%=i%>
                        </a></li>
                        <%=i == 1 ? "<div class=\"flex-roww\" style=\"align-items: baseline\"><i class=\"bi bi-three-dots etc\" style=\"margin: 0 10px;\"></i></div>\n" : ""%>
                        <%=i == (numOfPages - 1) ? "<div class=\"flex-roww\" style=\"align-items: baseline\"><i class=\"bi bi-three-dots etc\" style=\"margin: 0 10px;\"></i></div>\n" : ""%>
                        <%
                            }
                        %>

                        <li class="page-item-nav">
                            <a class="page-link" href="#" aria-label="Next" onclick="nextPage(event)">
                                <!--              <span aria-hidden="true">&raquo;</span>-->
                                <span class="sr-only">Tiếp theo</span>
                            </a>
                        </li>
                    </ul>

                </nav>
            </div>

            <script>
                function createEtc() {
                    const iconElement = document.createElement('i');
                    iconElement.classList.add('bi', 'bi-three-dots');
                    return iconElement;
                }

                setUpPagination('#order-pagination');

                function setUpPagination(id) {
                    console.log("setup pagination");
                    const pagination = document.querySelector(id);
                    const pageLinks = pagination.querySelectorAll('.page-item .page-link');
                    var len = pageLinks.length;
                    const etcs = pagination.querySelectorAll('.etc');
                    if (pageLinks && len > 0)
                        pageLinks[0].classList.add('active');
                    if (len > 4) {
                        etcs.forEach(etc => {
                            etc.style.display = 'block';
                        });
                        pageLinks.forEach(page => {
                            page.style.display = 'none';
                            page.addEventListener('click', function (event) {
                                updatePagination('#order-pagination', event);
                            });
                        });
                        pageLinks[0].style.display = 'block';
                        pageLinks[1].style.display = 'block';
                        pageLinks[2].style.display = 'block';
                        pageLinks[3].style.display = 'block';
                        pageLinks[len - 1].style.display = 'block';
                    } else {
                        etcs.forEach(etc => {
                            etc.style.display = 'none';
                        });
                    }
                }

                function updatePagination(id, event) {
                    console.log("update pagination");
                    const pagination = document.querySelector(id);
                    const pageLinks = pagination.querySelectorAll('.page-item .page-link');
                    var len = pageLinks.length;
                    if (len > 4) {
                        pageLinks.forEach(page => {
                            page.style.display = 'none';
                        });
                        pageLinks[0].style.display = 'block';
                        pageLinks[len - 1].style.display = 'block';
                        var indexActive = event.currentTarget.getAttribute('data-value') - 1;
                        console.log("index active: " + indexActive);
                        if (indexActive == 0) {
                            pageLinks[1].style.display = 'block';
                            pageLinks[2].style.display = 'block';
                        } else if (indexActive == len - 1) {
                            pageLinks[len - 2].style.display = 'block';
                            pageLinks[len - 3].style.display = 'block';
                        } else {
                            pageLinks[indexActive - 1].style.display = 'block';
                            pageLinks[indexActive].style.display = 'block';
                            pageLinks[indexActive + 1].style.display = 'block';
                        }
                    }
                }

                function nextPage(event) {
                    event.preventDefault();
                    const pagination = event.currentTarget.closest('.group');
                    const pageLinks = pagination.querySelectorAll('.page-item .page-link');
                    var pageActiveItem = pagination.querySelector('.page-item .page-link.active');
                    if (pageActiveItem) {
                        var indexActive = pageActiveItem.getAttribute('data-value') - 1;
                        if (indexActive < pageLinks.length - 1) {
                            pageLinks[indexActive + 1].click();
                        }
                    }
                }

                function previousPage(event) {
                    event.preventDefault();
                    const pagination = event.currentTarget.closest('.group');
                    const pageLinks = pagination.querySelectorAll('.page-item .page-link');
                    var pageActiveItem = pagination.querySelector('.page-item .page-link.active');
                    if (pageActiveItem) {
                        var indexActive = pageActiveItem.getAttribute('data-value') - 1;
                        if (indexActive > 0) {
                            pageLinks[indexActive - 1].click();
                        }
                    }
                }
            </script>
            <script>
                radioElements('.page-item .page-link');

                function queryPage(event) {
                    event.preventDefault();
                    var page = event.currentTarget.getAttribute("data-value");
                    console.log("page:" + page);
                    var byStatus = document.querySelector('select[name="byStatus"]').value;
                    console.log("byStatus:" + byStatus);
                    queryOrder(page, byStatus);

                }
            </script>

        </div>
        <div id="server-response"></div>
        <div class="modall" id="cancel-confirm-modal">
            <div class="modal__overlay" onclick="closeModal(event);">
                <div class="modall-content grid-col-6" onclick="event.stopPropagation();">
                    <p class="confirm-content" style="text-align: center">Xác nhận hủy </br> <span
                            class="object"></span></p>
                    <div class="flex-roww" style="margin-top:20px; justify-content: space-around">
                        <button class="btn btn-fourth btn-cancel" type="button" onclick="closeModal(event);">Hủy
                        </button>
                        <button class="btn btn-primary btn-confirm" onclick="" type="button">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function closeModal(event) {
                event.currentTarget.closest(".modall").classList.remove("active");
            }
        </script>
        <script>
            // Hàm xử lý khi nhấn Enter hoặc Backspace
            function handleKeyDown(event, column) {
                const currentRow = event.target.closest('tr');
                const currentInput = event.target;
                const currentValue = currentInput.value;
                const firstColumnInput = currentRow.cells[0].querySelector('input');
                const secondColumnInput = currentRow.cells[1].querySelector('input');

                // Kiểm tra khi nhấn Backspace
                if (event.key === 'Backspace') {
                    // Nếu ô trống và ô đang được focus là ô đầu tiên
                    if (currentValue === '' && column === 1) {
                        event.preventDefault(); // Ngăn không cho xóa tiếp
                        const previousRow = currentRow.previousElementSibling;

                        if (previousRow) {
                            // Chuyển focus đến ô cuối cùng của cột 2 ở dòng trên nếu có
                            const previousCell = previousRow.cells[1].querySelector('input');
                            previousCell.focus();
                            currentRow.remove();
                        }
                        return;
                    }

                    // Nếu ô đang được focus là ô thứ hai và không còn ký tự
                    if (currentValue === '' && column === 2) {
                        // Nếu cột 1 vẫn còn dữ liệu thì focus về ô đầu tiên
                        if (firstColumnInput.value !== '') {
                            event.preventDefault();
                            firstColumnInput.focus();
                            return;
                        }
                        return;
                    }
                }

                // Kiểm tra khi nhấn Enter
                if (event.key === 'Enter') {
                    event.preventDefault(); // Ngăn form gửi đi (nếu có form bao quanh)
                    const nextColumn = column === 1 ? 2 : 1;

                    if (nextColumn === 2) {
                        // Chuyển sang ô thứ 2 trong cùng hàng
                        currentRow.cells[1].querySelector('input').focus();
                    } else {
                        // Nếu đang ở ô thứ 2, thêm hàng mới và chuyển focus đến ô đầu tiên của hàng mới
                        addNewRow();
                        const newRow = document.getElementById('configTable').getElementsByTagName('tbody')[0].lastElementChild;
                        newRow.cells[0].querySelector('input').focus();
                    }
                }
            }

            // Hàm thêm hàng mới vào bảng
            function addNewRow() {
                const table = document.getElementById('configTable').getElementsByTagName('tbody')[0];
                const newRow = document.createElement('tr');

                // Thêm 2 ô nhập liệu vào hàng mới
                for (let i = 0; i < 2; i++) {
                    const newCell = document.createElement('td');
                    const input = document.createElement('input');
                    input.type = 'text';
                    input.onkeydown = (event) => handleKeyDown(event, i + 1); // Gắn sự kiện Enter và Backspace cho từng ô
                    newCell.appendChild(input);
                    newRow.appendChild(newCell);
                }

                // Thêm hàng mới vào cuối bảng
                table.appendChild(newRow);
            }
        </script>

    </main><!-- End #main -->
</div>

</body>
</html>