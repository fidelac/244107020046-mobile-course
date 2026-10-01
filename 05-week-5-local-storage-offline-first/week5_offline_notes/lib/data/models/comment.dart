class Comment {
  // Constructor untuk membuat object Comment.
  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  // ID post yang memiliki comment.
  final int postId;

  // ID comment.
  final int id;

  // Nama pengirim comment.
  final String name;

  // Email pengirim comment.
  final String email;

  // Isi comment.
  final String body;

  // Mengubah JSON dari API menjadi object Comment.
  //
  // Penggunaan '?' dan '??' membuat parsing lebih aman
  // jika ada field yang hilang atau bernilai null.
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: (json['postId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  // Mengubah object Comment kembali menjadi JSON.
  Map<String, dynamic> toJson() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}