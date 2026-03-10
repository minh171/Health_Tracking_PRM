import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/login_vm.dart';
import '../register/custom_text_field.dart';
import '../register/register_page.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(LoginViewModel viewModel) async {
    // 1. Kiểm tra validation của các ô nhập liệu (email, password)
    if (_formKey.currentState!.validate()) {

      // 2. Gọi hàm login từ ViewModel
      final success = await viewModel.login(
        _emailController.text,
        _passwordController.text,
      );

      // 3. Kiểm tra xem Widget còn tồn tại trong cây thư mục không trước khi điều hướng
      if (!mounted) return;

      if (success) {
        // Đăng nhập thành công -> Sang trang chủ
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Đăng nhập thất bại -> Hiển thị lỗi cụ thể (Sai email/mật khẩu) từ ViewModel
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              viewModel.errorMessage ?? 'Đăng nhập thất bại',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Ẩn bàn phím khi chạm ngoài
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  // Logo
                  Image.asset('assets/logo-removebg.png', height: 120),
                  const SizedBox(height: 16),
                  const Text(
                    'Đăng Nhập',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Theo dõi sức khỏe của bạn mỗi ngày',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 40),

                  // Email Input
                  CustomInput.buildLabel('Email'),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: CustomInput.decoration(
                        hint: 'example@gmail.com',
                        icon: Icons.email_outlined
                    ),
                    validator: (v) => (v != null && v.endsWith('@gmail.com'))
                        ? null
                        : 'Email phải có đuôi @gmail.com',
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  CustomInput.buildLabel('Mật khẩu'),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordObscured,
                    decoration: CustomInput.decoration(
                      hint: 'Nhập mật khẩu',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscured: _isPasswordObscured,
                      onToggle: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Vui lòng nhập mật khẩu';
                      final passwordRegExp = RegExp(r"^[a-zA-Z0-9]{7,8}$");
                      if (!passwordRegExp.hasMatch(v)) return 'Mật khẩu từ 7-8 ký tự (chữ và số)';
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Nút Đăng Nhập
                  Consumer<LoginViewModel>(
                    builder: (context, viewModel, child) {
                      return ElevatedButton(
                        // Nếu đang loading thì vô hiệu hóa nút bấm (null)
                        onPressed: viewModel.isLoading ? null : () => _onLogin(viewModel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          // Màu khi nút bị vô hiệu hóa
                          disabledBackgroundColor: const Color(0xFF4A90E2).withOpacity(0.6),
                        ),
                        child: viewModel.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Đăng Nhập',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Chuyển sang Đăng ký
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Chưa có tài khoản? ', style: TextStyle(color: Color(0xFF757575))),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Đăng ký ngay',
                          style: TextStyle(color: Color(0xFF4A90E2), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Ảnh minh họa phía dưới
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/healthtracking_loginpage.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}