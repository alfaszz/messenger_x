import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_x/models/message.dart';
import 'package:messenger_x/models/user.dart';
import 'package:messenger_x/services/auth/auth_service.dart';

class ChatService {
  //firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //users stream
  Stream<List<UserModel>> getUserStream() {
    return _firestore.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    });
  }

//send message
  Future<void> sendMessage(String receiverID, message) async {
//get current user info
    final String currentUserId = currentUser!.uid;
    final String currentUserEmail = currentUser!.email;
    final Timestamp time = Timestamp.now();

//create a new message
    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        time: time);

//construct a chatroom id for the users
    List<String> ids = [currentUserId, receiverID];
    ids.sort(); // to ensure uniqueness
    String chatRoomId = ids.join('_');

//add the message to datatbase
    _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherId) {
    List<String> ids = [userId, otherId];
    ids.sort(); // to ensure uniqueness
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("time", descending: false)
        .snapshots();
  }
}
