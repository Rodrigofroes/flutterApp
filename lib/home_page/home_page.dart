import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projectapp/pages/clientes.dart';
import 'package:projectapp/pages/orcamento.dart';
import 'package:projectapp/pages/relatorio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  late PersistentTabController _controller;


  @override
  void initState() {
 _controller = PersistentTabController(initialIndex: 0);
    
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      
      backgroundColor: const Color(0xff2196F3), 
      navBarHeight: 65,
      handleAndroidBackButtonPress:
          true, // Controle do botão de volta no Android
      resizeToAvoidBottomInset:
          true, // Redimensiona a tela para evitar sobreposição com o teclado
      stateManagement: true, // Mantém o estado das telas
      hideNavigationBarWhenKeyboardShows:
          true, // Esconde a barra de navegação quando o teclado é exibido
      
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
       // Escolha o estilo da barra de navegação
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const ClientePage(),
    const OrcamentoPage(), 
    const Relatorio()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      iconSize: 32,
      icon: const Icon(Icons.person),
      activeColorPrimary: const Color.fromARGB(255, 185, 185, 185),
      title: ("Clientes"),
      textStyle: const TextStyle(color: Color.fromARGB(255, 185, 185, 185)),
      activeColorSecondary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.attach_money_rounded),
      activeColorPrimary: const Color.fromARGB(255, 185, 185, 185),
      iconSize: 32,
      title: ("Orçamento"),
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 185, 185, 185)
      ),
      activeColorSecondary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      iconSize: 32,
      icon: const Icon(Icons.assignment_outlined),
      activeColorPrimary: const Color.fromARGB(255, 185, 185, 185),
      textStyle: const TextStyle(color: Color.fromARGB(255, 185, 185, 185)),
      title: ("Relatorio"),
      activeColorSecondary: Colors.white,
    ),
  ];
}