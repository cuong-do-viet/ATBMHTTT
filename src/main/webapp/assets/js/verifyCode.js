$('#otp-form').on('submit', (e) => {
    e.preventDefault()
    alert("HOH")

    var o1=document.getElementById('o1').value;
    var o2=document.getElementById('o2').value;
    var o3=document.getElementById('o3').value;
    var o4=document.getElementById('o4').value;
    var o5=document.getElementById('o5').value;
    var code = o1+o2+o3+o4+o5
    verifyCode("VERIFY", code, $('#emailInput').val())
})

$('#btn-resend').on('click', (e) => {
    e.preventDefault()
    e.stopPropagation()
    countdown(60*5,'#countdown','#btn-resend');
    $.ajax({
        url: "/ThietBiDiDong/verify",
        method: "POST",
        data: { action: "RESEND", email: $('#emailInput').val()},
        success: function(data) {
            console.log(data);
            $("#verifyCode-response").html(data);
        }
    });
})

function verifyCode(action,code,email) {
    console.log(code.length);
    if(code.length != 5)
        tellWrongCode();

    else {
        $.ajax({
            url: "/ThietBiDiDong/verify",
            method: "POST",
            data: { action: action, code: code, email: email},
            success: function(data) {
                console.log(data);
                $("#verifyCode-response").html(data);
            }
        });
    }

}

function tellWrongCode() {
    console.log("ma xac nhan sai");
    const errorSpan = document.querySelector("#otp-form .pwd-error");
    errorSpan.innerText = "Mã xác nhận không hợp lệ.";
    errorSpan.classList.add('active');
}

function tellExpiredCode() {
    const errorSpan = document.querySelector("#otp-form .pwd-error");
    errorSpan.innerText = "Mã xác nhận đã hết hiệu lực.";
    errorSpan.classList.add('active');
}

function tellVerifySuccessful() {
    document.querySelector(".otp-message").classList.add('active');
}