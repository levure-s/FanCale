import 'package:fancale/edit_profile/edit_profile_page.dart';
import 'package:fancale/mypage/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MyModel>();

    return IconButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                      model.name ?? '', model.description ?? '')));
          model.feachUser();
        },
        icon: const Icon(Icons.edit));
  }
}
