import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ecommerce/ui/app_pill_button.dart';
import 'package:ecommerce/ui/screen_padding.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.setting_2),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),

      body: ScreenPadding(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/profile.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'email@example.com',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          // Edit profile
                        },
                        icon: const Icon(Iconsax.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Text(
                'Quick actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: AppPillButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.bag_2, size: 18),
                      label: const Text('Orders'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppPillButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.location, size: 18),
                      label: const Text('Address'),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: AppPillButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.card, size: 18),
                      label: const Text('Payments'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppPillButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.security_safe, size: 18),
                      label: const Text('Security'),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            SliverToBoxAdapter(
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Iconsax.user_edit),
                      title: const Text('Account details'),
                      subtitle: const Text('Personal info, email, password'),
                      trailing: const Icon(Iconsax.arrow_right_3),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Iconsax.notification),
                      title: const Text('Notifications'),
                      subtitle: const Text('Offers, order updates'),
                      trailing: const Icon(Iconsax.arrow_right_3),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Iconsax.message_question),
                      title: const Text('Help & support'),
                      subtitle: const Text('FAQ, contact us'),
                      trailing: const Icon(Iconsax.arrow_right_3),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Iconsax.logout),
                      title: const Text('Log out'),
                      trailing: const Icon(Iconsax.arrow_right_3),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
          ],
        ),
      ),
    );
  }
}
