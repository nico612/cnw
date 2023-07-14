import 'package:cached_network_image/cached_network_image.dart';
import 'package:cniao/common/application.dart';
import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/common/authentication/bloc/authentication_bloc.dart';
import 'package:cniao/common/constant.dart';
import 'package:cniao/common/icons.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/route/routes.dart';
import 'package:cniao/theme/style.dart';
import 'package:cniao/widgets/diolog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {

         List<Widget> slivers = [
          const _HeaderView(),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          const _ProfileList(items: [
            ItemModel(iconData: CNWFonts.gift_card, text: "学习卡·免费领"),
            ItemModel(iconData: CNWFonts.red_packet, text: "分销中心"),
            ItemModel(iconData: CNWFonts.group_booking, text: "我的拼团"),
            ItemModel(iconData: CNWFonts.heart_ed, text: "想学的课"),
          ]),
        ];
        if (state.status == AuthenticationStatus.authenticated) {
          //添加退出登录按钮
          slivers.add(const _LoginOutBtn());
        }
        return Container(
          padding: const EdgeInsets.all(10),
          color: Style.gray3,
          child: CustomScrollView(
            slivers: slivers,
          ),
        );
      }),
    ));
  }
}

class ItemModel {
  final IconData iconData;
  final String text;

  const ItemModel({required this.iconData, required this.text});
}

class _ProfileList extends StatelessWidget {
  const _ProfileList({super.key, required this.items});

  final List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 240,
        child: ListView.builder(
          itemBuilder: (buildContext, index) {
            if (index == items.length - 1) {
              return _ProfileListItem(itemModel: items[index]);
            }
            return Column(children: [
              _ProfileListItem(
                itemModel: items[index],
              ),
              const Divider(
                height: 1,
                thickness: 0.5, //绘制线条的粗细
                color: Style.gray3,
              )
            ]);
          },
          itemCount: items.length,
          itemExtent: 60,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}


class _LoginOutBtn extends StatelessWidget {
  const _LoginOutBtn({super.key});

  @override
  Widget build(BuildContext context) {

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Style.gray6
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return NDialog(
                          title: "提示",
                          message: "确认退出登录",
                          showCancelButton: true,
                          confirmTextColor: AppColors.white,
                          confirmButtonColor: AppColors.primaryColor,
                          onConfirm: () {
                            context.read<AuthenticationBloc>().add(LoginOutEvent());
                          },
                        );
                      }
                  );
                },
                child: const Text("退出登录"),
              ),
            ),
      ),
    );
  }
}


class _ProfileListItem extends StatelessWidget {
  const _ProfileListItem({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("dinji");
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              itemModel.iconData,
              size: 25,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                itemModel.text,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            )),
            const Icon(
              CNWFonts.next,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        String username =  state.user == null ? '登录/免费注册' : state.user?.username ?? "无名";
        return SliverToBoxAdapter(
          child: Container(
            // color: Colors.white,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                GestureDetector(
                    //login or register
                    onTap: () => state.status == AuthenticationStatus.authenticated ? null : Application.router.navigateTo(context, Routes.login),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            //头像
                            padding: EdgeInsets.all(13),
                            child: ClipOval(
                              child: Container(
                                width: 60,
                                height: 60,
                                color: const Color(0x33999999),
                                child: CachedNetworkImage(
                                  imageUrl: defualtHeadImg,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            username,
                            style: const TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                    )),
                Container(
                  color: Style.gray2,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 2,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ImageItem(
                          icon: Icon(CNWFonts.order),
                          text: "订单",
                          onTap: () {},
                        )),
                        Expanded(
                            child: ImageItem(
                          icon: Icon(CNWFonts.coupon),
                          text: "优惠券",
                          onTap: () {},
                        )),
                      ],
                    )),
              ],
            ),
          ),
        );
      }
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem(
      {super.key, required this.text, required this.icon, this.onTap});

  final String text;
  final GestureTapCallback? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          icon,
          const Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.black),
          )
        ],
      ),
    );
  }
}
