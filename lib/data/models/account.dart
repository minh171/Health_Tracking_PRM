class Account {
  final int? id;
  final String email; // Dùng làm định danh đăng nhập
  final String password;
  final String createdAt;

  Account({this.id, required this.email, required this.password, required this.createdAt});

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'password': password,
    'created_at': createdAt,
  };

  factory Account.fromMap(Map<String, dynamic> map) => Account(
    id: map['id'],
    email: map['email'],
    password: map['password'],
    createdAt: map['created_at'],
  );
}