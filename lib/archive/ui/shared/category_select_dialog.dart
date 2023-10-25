import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/archive/core/view_models/category_view_model.dart';
import 'package:todo_todo/archive/locator.dart';
import 'package:todo_todo/archive/ui/shared/category_alert_dialog.dart';

class CategorySelectDialog extends StatelessWidget {
  const CategorySelectDialog({super.key});

  void _onCategorySelected(BuildContext context,
      {required String? id, required String? name}) {
    Navigator.of(context).pop((id, name));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => locator<CategoryViewModel>(),
      child: Consumer<CategoryViewModel>(
        builder: (_, model, child) {

          final categories = model.seenCategoriesWithoutDefault;
          return AlertDialog(
            content: SizedBox(
              height: size.height * 0.7,
              width: size.width * 0.7,
              child: ListView.builder(
                itemCount: categories.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        _onCategorySelected(
                          context,
                          id: null,
                          name: null,
                        );
                      },
                      child: const ListTile(
                        isThreeLine: false,
                        title: Text('No Category'),
                      ),
                    );
                  } else if (index == categories.length + 1) {
                    return InkWell(
                      onTap: () async {
                        final createdCategory = await showDialog(
                          context: context,
                          builder: (context) {
                            return const CategoryAlertDialog();
                          },
                        );

                        if (context.mounted) {
                          _onCategorySelected(
                            context,
                            id: createdCategory.categoryId,
                            name: createdCategory.name,
                          );
                        }
                      },
                      child: const ListTile(
                        isThreeLine: false,
                        leading: Icon(Icons.add),
                        title: Text('Create Category'),
                      ),
                    );
                  }

                  final category = categories[index - 1];

                  return InkWell(
                    onTap: () {
                      _onCategorySelected(
                        context,
                        id: category.categoryId,
                        name: category.name,
                      );
                    },
                    child: ListTile(
                      isThreeLine: false,
                      leading: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category.color,
                        ),
                      ),
                      title: Text(category.name),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
