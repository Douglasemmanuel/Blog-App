import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('User Profile'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User avatar placeholder with '?' since no userName provided
            Container(
  alignment: Alignment.center,
  padding: const EdgeInsets.all(16.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      CircleAvatar(
        backgroundImage: AssetImage('images/Douglas.jpeg'),
        radius: 50,
      ),
      SizedBox(height: 16),

      // User name placeholder
      Text(
        'Douglas Emmanuel',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),

      // User email placeholder
      Text(
        'emmanueldouglas2121@gmail.com',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          
        ),
      ),
      SizedBox(height: 24),
    ],
  ),
),
           Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: const [
                  Icon(
                    Icons.photo_album,
                    size: 30,
                    // color: Colors.blueGrey,
                     color: Color(0xFF003366),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Container wrapping the PostCard
            Container(
              child: const PostCard(),
            ),
           
          ],
        ),
      ),
    );
  }
}



class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {

  return Center(  // Optional: center horizontally
  child: SizedBox(
    width: 650,  // Set your desired width here
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(  // Use Column here to hold multiple children inside the Card
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Post Title',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'This is a sample post body for display only.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
                Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit),
              splashRadius: 20,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: EditFormSheet(),
                    );
                  },
                );
              },
            ),

          // const Spacer(),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final bool? confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete this item?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false), // Cancel
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true), // Confirm
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  print('Item deleted');
                }
              },
              splashRadius: 20,
            ),

        ],
      )

        ],
      ),
    ),
  ),
);


  }
}



//eddit form input 
class EditFormSheet extends StatefulWidget {
  @override
  _EditFormSheetState createState() => _EditFormSheetState();
}

class _EditFormSheetState extends State<EditFormSheet> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String body = '';
  string userId = '1';
 
int postId = 2;
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView( // ensures bottom sheet scrolls with keyboard
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Post ${postId}' ,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => title = value ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value for Title';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => body = value ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter value for Body';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // TODO: Use field1, field2, field3 values as needed here

                  Navigator.of(context).pop(); // close bottom sheet
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
