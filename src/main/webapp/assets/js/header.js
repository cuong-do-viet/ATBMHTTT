function initUpdateAddress(event,parent, formElement) {
    event.preventDefault();
    const parentEs= document.querySelectorAll(parent);
    parentEs.forEach((element) => {
        if(element.classList.contains('active')) {
            element.classList.remove('active');
        }
    });
    const parentElement = event.currentTarget.closest(parent);
    parentElement.classList.add('active');
    let id = parentElement.querySelector('.id').innerText;
    let receiver = parentElement.querySelector('.receiver').innerText;
    let phone = parentElement.querySelector('.phone').innerText;
    let street = parentElement.querySelector('.street').innerText;
    let village = parentElement.querySelector('.village').innerText;
    let district = parentElement.querySelector('.district').innerText;
    let province = parentElement.querySelector('.province').innerText;
    const form = document.querySelector(formElement);
    const inputs = form.querySelectorAll('input');
    inputs.forEach(input => {
        if(input.name == "id") input.value = id;
        else if(input.name == "receiver") input.value = receiver;
        else if(input.name == "phone") input.value = phone;
        else if(input.name == "street") input.value = street;
        else if(input.name == "village") input.value = village;
        else if(input.name == "district") input.value = district;
        else if(input.name == "province") input.value = province;
        else if(input.name == "action") input.value = "updateAddress";

    });
    form.querySelector('.edit-title').innerText = "Cập nhật địa chỉ";

}



function updateAddressAjax(action,id,receiver,phone,street,village,district,province) {
    console.log("call update address ajax");
    $.ajax({
        type: "GET",
        url: "profile",
        data: {action: action, id:id ,receiver: receiver,phone: phone,street:street,village:village,district:district,province:province},
        success: function(data) {
            var addresses = $('#address-container .address-item');
            addresses.each(function(index, element) {
                if ($(element).hasClass('active')) {
                    $(element).html(data);
                }
            });
            cancelEdit('#editAddressForm');
            showSuccessToast('Cập nhật địa chỉ thành công','#toast-header');
        },
        error: function(error) {
            console.error("Error during querying address: ", error);
        }
    });
}

function addAddressAjax(action,id,receiver,phone,street,village,district,province) {
    console.log("call add address ajax");
    $.ajax({
        type: "GET",
        url: "profile",
        data: {action: action, id:id ,receiver: receiver,phone: phone,street:street,village:village,district:district,province:province},
        success: function(data) {
            $('#address-container').html(data);
            cancelEdit('#editAddressForm');
            showSuccessToast('Thêm địa chỉ thành công','#toast-header');

        },
        error: function(error) {
            console.error("Error during querying address: ", error);
        }
    });
}

function cancelEdit(element) {
    const form = document.querySelector(element);
    const inputs = form.querySelectorAll('input');
    inputs.forEach(input => {
        input.value = '';
        if(input.name=="action") input.value = 'addAddress';
    });
    form.querySelector('.edit-title').innerText = "Thêm địa chỉ";

}

function initDeleteAddress(event,parent,modal,confirmModal) {
    const parentEs= document.querySelectorAll(parent);
    parentEs.forEach((element) => {
        if(element.classList.contains('active')) {
            element.classList.remove('active');
        }
    });
    const parentElement = event.currentTarget.closest(parent);
    parentElement.classList.add('active');
    let id = parentElement.querySelector('.id').innerText;
    let receiver = parentElement.querySelector('.receiver').innerText;
    let phone = parentElement.querySelector('.phone').innerText;
    let address = parentElement.querySelector('.address').innerText;

    const modalElement = parentElement.closest(modal);
    const confirmElement = modalElement.querySelector(confirmModal);
    confirmElement.querySelector('.id').innerText = id;
    confirmElement.querySelector('.receiver').innerText = receiver;
    confirmElement.querySelector('.phone').innerText = phone;
    confirmElement.querySelector('.address').innerText = address;
    confirmElement.classList.add('active');
}

function deleteAddressAjax(id) {
    $.ajax({
        type: "GET",
        url: "profile",
        data: {action: "deleteAddress",id: id},
        success: function(data) {
            var addresses = $('#address-container .address-item');
            addresses.each(function(index, element) {
                if ($(element).hasClass('active')) {
                    $(element).hide();
                }
            });
            console.log(data);
            $('#header-response').html(data);
            $('.address-confirm').removeClass('active');
        },
        error: function(error) {
            console.error("Error during querying address: ", error);
        }
    });
}

function cancelDelete(event,element) {
    event.currentTarget.closest(element).classList.remove('active');
}

function initUpdateInfo(event,parent) {
    const form = event.currentTarget.closest(parent);
    const inputs = form.querySelectorAll('input');
    inputs.forEach(input => {
        input.removeAttribute('readonly');
        if(input.name=="dateIn") input.readOnly = true;
        if(input.name=="email") input.readOnly = true;
    });
    form.querySelector('.update-action').style.display = 'none';
    form.querySelector('.edit-title').style.display = 'block';
    form.querySelector('.btn-edit-container').style.display = 'flex';
}

function cancelEditInfo(event,parent) {
    const form = event.currentTarget.closest(parent);
    const inputs = form.querySelectorAll('input');
    inputs.forEach(input => {
        input.setAttribute('readonly',true);
    });
    form.querySelector('.update-action').style.display = 'flex';
    form.querySelector('.edit-title').style.display = 'none';
    form.querySelector('.btn-edit-container').style.display = 'none';

//     them ham goi ajax de lay lai gia tri ban dau
}

function initChangePwd(event,pwdForm) {
    event.preventDefault();
    document.querySelector(pwdForm).classList.add('active');
}

function cancelChangePwd(pwdForm) {
    document.querySelector(pwdForm).classList.remove('active');
}

function manageAddress(event) {
    event.preventDefault();
    document.querySelector('.address-modal').classList.add('active');
    getAddressList();
}

function manageProfile(event) {
    event.preventDefault();
    document.querySelector('.info-modal').classList.add('active');
    loadUserInfo();
}

function loadUserInfo() {
    console.log("load user info");
    $.ajax({
        type: "post",
        url: "profile",
        data: {action: "info"},
        success: function(data) {
            console.log(data);
            $('#editInfoForm input[name="name"]').val(data.name);
            $('#editInfoForm input[name="email"]').val(data.email);

            const info = JSON.parse(data.info);
            $('#editInfoForm input[name="dateIn"]').val(info.dateIn);
            $('#editInfoForm input[name="phone"]').val(info.phone);
            $('#editInfoForm input[name="gender"]').val(info.gender);
            $('#editInfoForm input[name="birthday"]').val(info.birthday);
        },
        error: function(error) {
            console.error("Error during querying address: ", error);
        }
    });
}

function openHeaderModal(modal) {
    const modalElement = document.querySelector(modal);
    modalElement.classList.add('active');

}

function getAddressList() {
    $.ajax({
        type: "GET",
        url: event.currentTarget.href,
        success: function(data) {
            console.log($('#address-container'));
            $('#address-container').html(data);
        },
        error: function(error) {
            console.error("Error during querying address: ", error);
        }
    });
}

function logout(event) {
    event.preventDefault();
    $.ajax({
        type: "GET",
        url: event.currentTarget.href,
        success: function(data) {
            window.location.href="product?action=init&&category=smartphone";
        },
        error: function(error) {
        }
    });
}

function toggleNotificationPanel(event) {
    console.log("toggleNotificationPanel called");
    event.preventDefault();
    event.stopPropagation();

    const modal = document.querySelector('.notification-modal');
    console.log("Modal element:", modal);

    if (!modal) {
        console.error("Notification modal not found");
        return;
    }

    console.log("Modal classes before:", modal.className);
    if (modal.classList.contains('active')) {
        modal.classList.remove('active');
    } else {
        modal.classList.add('active');
        console.log("Modal classes after:", modal.className);
        loadNotificationList();
    }
}

function loadNotificationList() {
    console.log("Loading notification list...");

    const sampleNotifications = `
        <div class="notification-item" style="padding: 15px; border-bottom: 1px solid #eee;">
            <p style="margin: 0; font-weight: 500;">Đơn hàng #12345 đã được xác nhận</p>
            <small style="color: #666;">2 giờ trước</small>
        </div>
        <div class="notification-item" style="padding: 15px; border-bottom: 1px solid #eee;">
            <p style="margin: 0; font-weight: 500;">Khuyến mãi iPhone 15 giảm 20%</p>
            <small style="color: #666;">1 ngày trước</small>
        </div>
        <div class="notification-item" style="padding: 15px;">
            <p style="margin: 0; font-weight: 500;">Chào mừng bạn đến với Thietbididong.com</p>
            <small style="color: #666;">3 ngày trước</small>
        </div>
        <div class="notification-item" style="padding: 15px; border-bottom: 1px solid #eee;">
            <p style="margin: 0; font-weight: 500;">Sản phẩm Samsung Galaxy S24 đã có hàng</p>
            <small style="color: #666;">1 tuần trước</small>
        </div>
    `;

    $('#notification-container').html(sampleNotifications);

    $.ajax({
        type: "GET",
        url: "profile",
        data: { action: "getNotifications" },
        success: function(data) {
            console.log("Notification data received:", data);
            if (data && data.trim() !== '') {
                $('#notification-container').html(data);
            } else {
                $('#notification-container').html(`
                    <div class="notification-item" style="padding: 20px; text-align: center; color: #666;">
                        <p style="margin: 0;">Không có thông báo mới</p>
                    </div>
                `);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error during loading notifications: ", error);
            console.error("Status: ", status);
            console.error("Response: ", xhr.responseText);

            $('#notification-container').html(`
                <div class="notification-item" style="padding: 20px; text-align: center; color: #dc3545;">
                    <p style="margin: 0;">Lỗi khi tải thông báo. Vui lòng thử lại sau.</p>
                </div>
            `);
        }
    });
}

function closeNotificationModal(event) {
    event.preventDefault();
    event.stopPropagation();
    const modal = document.querySelector('.notification-modal');
    if (modal) {
        modal.classList.remove('active');
    }
}

function removeModal(containerSelector) {
    const container = document.querySelector(containerSelector);
    if (container) {
        const modals = container.querySelectorAll('.modall');
        modals.forEach(modal => {
            modal.classList.remove('active');
        });
    }
}

