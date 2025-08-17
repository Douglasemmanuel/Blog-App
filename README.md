 Here’s a **detailed and professional README** for your Flutter app, including:

* Overview
* Setup instructions
* JSONPlaceholder API endpoints used (`/posts`, `/comments`, `/users`)
* UI preview placeholders
* Video walkthrough
* Folder structure
* Features
* Contribution guide

---

# 📱 JSONPlaceholder Flutter App

A **Flutter application** powered by the [JSONPlaceholder API](https://jsonplaceholder.typicode.com), demonstrating clean REST API integration, post browsing, comment viewing, and user profile display.

---

## 🚀 Live Preview

| Search Post                                                     | View Post & Comments                                           | User Profile                                                   |
| --------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- |
| ![Search](https://via.placeholder.com/150x300?text=Search+Post) | ![Post](https://via.placeholder.com/150x300?text=Post+Details) | ![User](https://via.placeholder.com/150x300?text=User+Profile) |

---

## 🎬 Video Walkthrough

📺 **Watch Full Tutorial**
[![Watch on YouTube](https://img.youtube.com/vi/Wsor0fci3Ss/0.jpg)](https://www.youtube.com/watch?v=Wsor0fci3Ss)

---

## 📡 API Endpoints Used

All data is fetched from [https://jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com)

| Feature        | Endpoint                   | Description              |
| -------------- | -------------------------- | ------------------------ |
| 📄 Posts       | `/posts`                   | Fetch all posts          |
| 🔍 Single Post | `/posts/{id}`              | Fetch post by ID         |
| 💬 Comments    | `/posts/{postId}/comments` | Get comments for a post  |
| 👤 Users       | `/users/{userId}`          | Get user info for a post |

Example:

```bash
GET https://jsonplaceholder.typicode.com/posts/2
GET https://jsonplaceholder.typicode.com/posts/2/comments
GET https://jsonplaceholder.typicode.com/users/1
POST  https://jsonplaceholder.typicode.com/posts/
DELETE  https://jsonplaceholder.typicode.com/posts/1
PATCH  https://jsonplaceholder.typicode.com/posts/1
```

---

## 📂 Folder Structure

```
lib/
├── main.dart
├── models/
│   ├── post.dart
│   ├── comment.dart
│   └── user.dart
├── services/
│   └── api_service.dart
├── screens/
│   ├── search_screen.dart
│   ├── user_profile_screen.dart
│   └── post_detail_screen.dart
├── providers/
│   ├── comments_provider.dart
│   ├── posts_provider.dart
│   └── user_provider.dart
├── widgets/
│   ├── search_bar.dart
│   ├── post_card.dart
│   └── comment_list.dart
│   ├── user_card.dart
│   ├── loading_widget.dart
|   ├── components/
|          |--comment_list.dart
|          |--create_pos_form.dart
|          |--post_list.dart
│   ├──commons/
|          |--responsive_navigation.dart
│   
│   
├── utils/
│   ├── responsive_breakpoints.dart
│   ├── routes_generator.dart
│   └── comment_list.dart
```

---

## ✨ Features

✅ Search for posts by ID
✅ View post details with title & body
✅ Display user info (name, email, profile picture)
✅ Fetch and show related comments
✅ Custom bottom sheets and form handling
✅ Error & loading states
✅ Responsive UI

---

## 🛠️ Installation & Run

1. **Clone the repo:**

   ```bash
   git clone https://github.com/Douglasemmanuel/Blog-App.git
   cd jsonplaceholder_app
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

---

## 🧪 Sample API Integration

```dart
Future<Post> fetchSinglePost(int postId) async {
  final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
```

---

## 🤝 Contribution Guide

Want to improve this app? Here’s how:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push and create a Pull Request

---

## 📬 Contact

For questions or improvements, open an issue or email:
📧 **[emmanueldouglas2121@gmail.com](mailto:emmanueldouglas2121@gmail.com)**

---

Let me know if you want this version exported as a `README.md` file, or if you’d like GitHub badge integration (e.g. Flutter version, license, YouTube link).


<!-- COLOR
 Color(0xFF003366) -->
