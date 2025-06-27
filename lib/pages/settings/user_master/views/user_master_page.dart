import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/user_master/add_user_modal.dart';
import '../../../../components/user_master/search_user_modal.dart';
import '../../../../components/user_master/user_table.dart';
import '../models/user_model.dart';
import '../controllers/user_master_controller.dart';

class UserMasterPage extends StatefulWidget {
  const UserMasterPage({super.key});

  @override
  State<UserMasterPage> createState() => _UserMasterPageState();
}

class _UserMasterPageState extends State<UserMasterPage> {
  final UserMasterController _controller = UserMasterController();
  List<User> _users = [];
  bool _isLoading = true;
  String _error = '';

  int _entriesPerPage = 10;
  int _currentPage = 1;

  List<User> get _paginatedUsers {
    final start = (_currentPage - 1) * _entriesPerPage;
    final end = (_currentPage * _entriesPerPage).clamp(0, _users.length);
    return _users.sublist(start, end);
  }

  int get _totalPages =>
      (_users.length / _entriesPerPage).ceil().clamp(1, _users.length);

  void _updateUser(int index, User updatedUser) {
    final globalIndex = ((_currentPage - 1) * _entriesPerPage) + index;
    setState(() {
      _users[globalIndex] = updatedUser;
    });
  }

  Future<void> _loadUsers() async {
    try {
      final fetchedUsers = await _controller.getUsers();
      setState(() {
        _users = fetchedUsers;
        _isLoading = false;
        _currentPage = 1;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading users: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
        currentRoute:
            GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'USER MASTER'),

          // Top Controls Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items: [5, 10, 25, 50, 100]
                          .map((count) => DropdownMenuItem<int>(
                                value: count,
                                child: Text('$count'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _entriesPerPage = value;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => showSearchUserModal(context),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Search'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => showAddUserModal(context),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add User'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // User Table
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : UserTable(users: _paginatedUsers, onUpdate: _updateUser),
            ),
          ),

          // Pagination Controls & Footer
          if (!_isLoading && _error.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _users.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                          'to ${( (_currentPage * _entriesPerPage).clamp(0, _users.length) )} '
                          'of ${_users.length} entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _currentPage > 1
                            ? () => setState(() => _currentPage--)
                            : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $_totalPages'),
                      TextButton(
                        onPressed: _currentPage < _totalPages
                            ? () => setState(() => _currentPage++)
                            : null,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const Footer(),
        ],
      ),
    );
  }
}
