<%@ page import="model.User" %>
<%
    User userLogging = (User) session.getAttribute("userLogging");
%>

<header id="header" class="header fixed-top flex-roww" style="justify-content: space-between">
    <a href="index" class="logo grid-col-2 pd0">
        <img src="./assets/img/logo/Logo-The-Gioi-Di-Dong-MWG-B-H.webp" alt="" style="color:black;">
    </a>
    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link nav-icon search-bar-toggle " href="#">
                    <i class="bi bi-search"></i>
                </a>
            </li><!-- End Search Icon-->

            <li class="nav-item dropdown pe-3">

                <a class="nav-link d-flex align-items-center pe-0 dropdown-toggle" href="#"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="dropdownMenuButton">
                    <span class="d-none d-md-block ps-2"><%=userLogging.getName()%></span>
                </a>
                <!-- End Profile Iamge Icon -->

                <ul class="dropdown-menu profile" aria-labelledby="dropdownMenuButton">
                    <li class="dropdown-header">
                        <h6>Chức vụ</h6>
                        <span>Phòng ban</span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="">
                            <i class="bi bi-person"></i>
                            <span>Quản lý tài khoản</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="login?action=logout">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </li>

                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->

        </ul>
    </nav><!-- End Icons Navigation -->
    <script>

        const link = document.querySelector('.nav-profile');
        if (link) {
            link.addEventListener("focus", (e) => {
                e.preventDefault();
                document.querySelector('.profile').classList.add('active');
            });

            link.addEventListener("blur", (e) => {
                e.preventDefault();
                document.querySelector('.profile').classList.remove('active');
            });
        }
    </script>
</header>