$().ready(function() {
	$("#login_form").validate({
		rules: {
			username: {
				required: true,
				Uname: true
			},
			password: {
				required: true,
				minlength: 5
			},
		},
		messages: {
			username: {
				required: "请输入姓名",
				Uname: "请输入英文字母开头的5-10位字符串，例如a123456789"
			},
			password: {
				required: "请输入密码",
				minlength: jQuery.format("密码不能小于{0}个字 符")
			},
		}
	});
	$("#register_form").validate({
		rules: {
			username: {
				required: true,
				Uname: true
			},
			password: {
				required: true,
				minlength: 5
			},
			rpassword: {
				equalTo: "#register_password"
			},
			email: {
				required: true,
				email: true
			}
		},
		messages: {
			username: {
				required: "请输入姓名",
				Uname: "请输入英文字母开头的5-10位字符串，例如a123456789"
			},
			password: {
				required: "请输入密码",
				minlength: jQuery.format("密码不能小于{0}个字 符")
			},
			rpassword: {
				equalTo: "两次密码不一样"
			},
			email: {
				required: "请输入邮箱",
				email: "请输入有效邮箱"
			}
		}
	});
	$("#reply_form").validate({
		rules: {
			title: {
				required: true,
				maxlength: 25
			},
			cont: {
				required: true,
				rangelength: [5,500]
			}			
		},
		messages: {
			title: {
				required: "请输入标题",
				maxlength: "请输入不超过{0}个字符的标题，中文算一个字符"
			},
			cont: {
				required: "内容不能为空",
				rangelength: jQuery.format("请输入长度在 {0} 到 {1} 之间的字符串")
			}
		}
	});
	$("#new_form").validate({
		rules: {
			title: {
				required: true,
				maxlength: 25
			},
			cont: {
				required: true,
				rangelength: [5,500]
			}			
		},
		messages: {
			title: {
				required: "请输入标题",
				maxlength: "请输入不超过{0}个字符的标题，中文算一个字符"
			},
			cont: {
				required: "内容不能为空",
				rangelength: jQuery.format("请输入长度在 {0} 到 {1} 之间的字符串")
			}
		}
	});
});
$(function() {
	$("#register_btn").click(function() {
		$("#register_form").css("display", "block");
		$("#login_form").css("display", "none");
	});
	$("#back_btn").click(function() {
		$("#register_form").css("display", "none");
		$("#login_form").css("display", "block");
	});
});