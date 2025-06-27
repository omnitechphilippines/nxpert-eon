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
  int _totalCount = 0;

  void _updateUser(int index, User updatedUser) {
    setState(() {
      _users[index] = updatedUser;
    });
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final result = await _controller.getUsers(
        page: _currentPage,
        limit: _entriesPerPage,
      );
      setState(() {
        _users = result.users;
        _totalCount = result.total;
        _isLoading = false;
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
    final int totalPages =
        _totalCount == 0 ? 1 : (_totalCount / _entriesPerPage).ceil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
        currentRoute:
            GoRouter.of(
              context,
            ).routerDelegate.currentConfiguration.uri.toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'USER MASTER'),

          // Top Controls Row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Entry limit dropdown
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items:
                          [5, 10, 25, 50, 100]
                              .map(
                                (count) => DropdownMenuItem<int>(
                                  value: count,
                                  child: Text('$count'),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _entriesPerPage = value;
                            _currentPage = 1;
                          });
                          _loadUsers();
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),

                // Buttons: Search + Add
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showSearchUserModal(context, ({
                          userCode,
                          userFirstName,
                          userLastName,
                          userEmail,
                          userPosition,
                        }) {
                          setState(() => _isLoading = true);
                          _controller
                              .searchUser(
                                page: 1,
                                limit: _entriesPerPage,
                                userCode: userCode,
                                firstName: userFirstName,
                                lastName: userLastName,
                                email: userEmail,
                                position: userPosition,
                              )
                              .then((result) {
                                setState(() {
                                  _users = result.users;
                                  _totalCount = result.total;
                                  _currentPage = 1;
                                  _isLoading = false;
                                });
                              })
                              .catchError((e) {
                                setState(() {
                                  _error = 'Search failed: $e';
                                  _isLoading = false;
                                });
                              });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
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
                      onPressed: () => showAddUserModal(context, _loadUsers),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
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
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : UserTable(users: _users, onUpdate: _updateUser),
            ),
          ),

          // Pagination Controls & Footer
          if (!_isLoading && _error.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _users.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _users.length} '
                            'of $_totalCount entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed:
                            _currentPage > 1
                                ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                  _loadUsers();
                                }
                                : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $totalPages'),
                      TextButton(
                        onPressed:
                            (_currentPage * _entriesPerPage < _totalCount)
                                ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                  _loadUsers();
                                }
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
