import 'package:facebook_clone_app/app/modules/main/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final user = controller.user.user;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 84,
                        backgroundColor: Colors.black,
                        child: controller.user.user == null &&
                                controller.user.user?.profileImage == null
                            ? const CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg'),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                  "http://10.0.2.2:8000/images/${controller.user.user!.profileImage!}",
                                ),
                              ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${user!.name}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${user.email}'),
                  const SizedBox(height: 8),
                  _buttonAddtoStory(),
                  const SizedBox(height: 16),
                  _postRow(),
                  const SizedBox(height: 16),
                  _detailColumn(),
                  const SizedBox(height: 16),
                  _storyRow(),
                  const SizedBox(height: 10),
                  _editPublicDetailButton(),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Row _editPublicDetailButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor:
                  WidgetStatePropertyAll(Colors.blue.withOpacity(0.1)),
              foregroundColor: WidgetStatePropertyAll(Colors.blue.shade800),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Edit public details',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _storyRow() {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
              const Text(
                'New',
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(width: 12),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://w0.peakpx.com/wallpaper/29/935/HD-wallpaper-nissan-gtr-r34-black-car-gtr-r34-thumbnail.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        'R34\nSkyline',
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _detailColumn() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Iconsax.link_circle5),
            SizedBox(width: 10),
            Text(
              'itsshinra and 1 other link',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Iconsax.profile_2user5),
            SizedBox(width: 10),
            Text(
              'Followed by 20 people',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.more_horiz_rounded),
            SizedBox(width: 10),
            Text(
              'See your About info',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _postRow() {
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            backgroundColor:
                WidgetStatePropertyAll(Colors.blue.withOpacity(0.2)),
            foregroundColor: WidgetStatePropertyAll(Colors.blue.shade800),
          ),
          onPressed: () {},
          child: const Text('Posts'),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          style: const ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () {},
          child: const Text('Photos'),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          style: const ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () {},
          child: const Text('Videos'),
        ),
      ],
    );
  }

  Row _buttonAddtoStory() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.add, size: 18),
                Text(
                  'Add to story',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
              foregroundColor: const WidgetStatePropertyAll(Colors.black),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.edit),
                Text(
                  'Edit profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade300,
            ),
            child: const Icon(Icons.more_horiz_rounded),
          ),
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      surfaceTintColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      title: const Text(
        'Shin ra',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.search_normal_1),
        ),
      ],
    );
  }
}
