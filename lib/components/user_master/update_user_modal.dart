import 'package:flutter/material.dart';
import '../../pages/settings/user_master/models/user_model.dart';

void showUpdateUserModal(
  BuildContext context,
  int index,
  List<User> users,
  void Function(int index, User updatedUser) onUpdate,
) {
  final user = users[index];

  final TextEditingController firstNameController = TextEditingController(
    text: user.userFirstName,
  );
  final TextEditingController lastNameController = TextEditingController(
    text: user.userLastName,
  );
  final TextEditingController emailController = TextEditingController(
    text: user.userEmail,
  );
  final TextEditingController positionController = TextEditingController(
    text: user.userPosition,
  );

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void submitForm() {

    //! this should allown null parameters for update
    final updatedUser = User(
      userCode: user.userCode, // Assuming userCode is not being updated
      userStatus: user.userStatus, // Assuming userStatus is not being updated
      userPassword:
          user.userPassword, // Assuming userPassword is not being updated
      userFirstName: firstNameController.text.trim(),
      userLastName: lastNameController.text.trim(),
      userEmail: emailController.text.trim(),
      userPosition: positionController.text.trim(),
    );

    if (updatedUser.userEmail.isNotEmpty &&
        !isValidEmail(updatedUser.userEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    onUpdate(index, updatedUser);
    Navigator.pop(context);
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update User",
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Update User',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: positionController,
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
