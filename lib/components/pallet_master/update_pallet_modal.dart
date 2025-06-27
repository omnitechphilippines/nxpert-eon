import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../pages/settings/user_master/controllers/user_master_controller.dart';
import '../../pages/settings/user_master/models/user_model.dart';

void showUpdateUserModal(
  BuildContext context,
  int index,
  List<User> users,
  void Function(int index, User updatedUser) onUpdate,
) {
  final user = users[index];
  final controller = UserMasterController();

  final TextEditingController firstNameController = TextEditingController(text: user.userFirstName);
  final TextEditingController lastNameController = TextEditingController(text: user.userLastName);
  final TextEditingController emailController = TextEditingController(text: user.userEmail);
  final TextEditingController positionController = TextEditingController(text: user.userPosition);

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> submitForm() async {
    final newFirstName = firstNameController.text.trim();
    final newLastName = lastNameController.text.trim();
    final newEmail = emailController.text.trim();
    final newPosition = positionController.text.trim();

    if (newEmail.isNotEmpty &&
        newEmail != user.userEmail &&
        !isValidEmail(newEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Build a new user object with only changed fields
    final updatedUser = User(
      userCode: user.userCode,
      userFirstName: newFirstName != user.userFirstName ? newFirstName : user.userFirstName,
      userLastName: newLastName != user.userLastName ? newLastName : user.userLastName,
      userEmail: newEmail != user.userEmail ? newEmail : user.userEmail,
      userPosition: newPosition != user.userPosition ? newPosition : user.userPosition,
      userStatus: user.userStatus,
      userPassword: user.userPassword,
    );

    // Optional loading dialog
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Please wait',
      text: 'Updating user...',
      barrierDismissible: false,
    );

    final success = await controller.updateUser(
      userCode: updatedUser.userCode,
      firstName: newFirstName != user.userFirstName ? newFirstName : null,
      lastName: newLastName != user.userLastName ? newLastName : null,
      email: newEmail != user.userEmail ? newEmail : null,
      position: newPosition != user.userPosition ? newPosition : null,
    );

    if (!context.mounted) return;
    Navigator.pop(context); // close loading

    if (success) {
      Navigator.pop(context); // close modal
      onUpdate(index, updatedUser);
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'User successfully updated!',
      );
    } else {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Failed to update user. Please try again.',
      );
    }
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
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Update User',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: positionController,
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
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
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Update', style: TextStyle(color: Colors.white)),
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
