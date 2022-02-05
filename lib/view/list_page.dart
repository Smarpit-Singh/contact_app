import 'package:dio_practice/View/view_detail.dart';
import 'package:dio_practice/modal/contact.dart';
import 'package:dio_practice/view/add_or_edit_contact.dart';
import 'package:dio_practice/controller/EditingController.dart';
import 'package:dio_practice/controller/add_contact_controller.dart';
import 'package:dio_practice/controller/validation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {

  final contactsController =
      Get.put(AddContactInList()); //For Using ContactList Data
  final editController = Get.put(
      EditContact()); // For implementing edit functionality on Edit Button
  final validationController = Get.put(ValidationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Contact')),
      ),
      body: Material(
        child: Obx(() {
          return ListView.builder(
              itemCount: contactsController.contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {

                    Get.to(ContactDetail(
                        contact: contactsController.contacts[
                            index])); // On Tap Go to View Detail Page to Show All Element in List

                  },
                  title: Text('${contactsController.contacts[index].userName}'),
                  subtitle:
                      Text('${contactsController.contacts[index].phoneNo}'),
                  leading: CircleAvatar(child: const Icon(Icons.person)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          editController.isEdit.value =
                              true; //Change Status of isEdit boolean into true
                          editController.GetList(contactsController.contacts[
                              index]); // Sending Contact List Data with index to EditController
                         editController.index= index;
                         print(editController.index);
                          validationController.createController();
                          Get.to(AddContact());

                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          contactsController.contacts.removeAt(
                              index); // Deleting Element From the List
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editController.isEdit.value =
              false; // Change Status isEdit Boolean into False
               validationController.createController();
          Get.to(AddContact());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
