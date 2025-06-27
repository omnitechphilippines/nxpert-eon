import 'package:flutter/material.dart';
import 'update_user_modal.dart';
import '../../pages/settings/user_master/models/user_model.dart';

class UserTable extends StatelessWidget {
  final List<User> users;
  final void Function(int index, User updatedUser) onUpdate;

  const UserTable({
    super.key,
    required this.users,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 1500),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 22, 63, 97),
              ),
              columnSpacing: 20,
              border: TableBorder.all(color: Colors.grey.shade300),
              columns: const [
                DataColumn(label: Text('User Code', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('First Name', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('Last Name', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('Position', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('Email', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
                DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white))),
              ],
              rows: List.generate(users.length, (index) {
                final user = users[index];
                return DataRow(
                  cells: [
                    DataCell(Text(user.userCode)),
                    DataCell(Text(user.userFirstName)),
                    DataCell(Text(user.userLastName)),
                    DataCell(Text(user.userPosition)),
                    DataCell(Text(user.userEmail)),
                    DataCell(Text(user.userStatus)),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => showUpdateUserModal(
                              context,
                              index,
                              users,
                              onUpdate,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                            label: const Text('Update', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
