import 'package:flutter/material.dart';

class MessageItem {
  final String sender; // 'user' or 'assistant'
  final String content;
  final String timestamp;
  final bool isAnalysisCard; // Special structured card format

  MessageItem({
    required this.sender,
    required this.content,
    required this.timestamp,
    this.isAnalysisCard = false,
  });
}

class AppController extends ChangeNotifier {
  bool _isLoggedIn = false;
  int _currentTab = 1; // 0: CHATS, 1: LIBRARY, 2: SETTINGS
  final List<MessageItem> _messages = [];

  bool get isLoggedIn => _isLoggedIn;
  int get currentTab => _currentTab;
  List<MessageItem> get messages => _messages;

  AppController() {
    _initMockMessages();
  }

  void _initMockMessages() {
    _messages.add(MessageItem(
      sender: 'user',
      content: 'Can you outline the core differences between Phenomenology and Grounded Theory in qualitative research? Keep it highly concise.',
      timestamp: 'TODAY, 09:41 AM',
    ));
    _messages.add(MessageItem(
      sender: 'assistant',
      content: '', // The structured content is parsed in the UI card
      timestamp: 'TODAY, 09:41 AM',
      isAnalysisCard: true,
    ));
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _currentTab = 1;
    notifyListeners();
  }

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void navigateToTab(int tabIndex) {
    _currentTab = tabIndex;
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final now = DateTime.now();
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    final timestamp = "TODAY, ${now.hour % 12 == 0 ? 12 : now.hour % 12}:$timeStr $amPm";

    _messages.add(MessageItem(
      sender: 'user',
      content: text,
      timestamp: timestamp,
    ));
    notifyListeners();

    // Trigger mock response after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      _messages.add(MessageItem(
        sender: 'assistant',
        content: 'I have received your query regarding "${text.trim()}". I am currently searching the local databases and compiling related literature notes for you.',
        timestamp: timestamp,
      ));
      notifyListeners();
    });
  }
}
