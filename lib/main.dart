import 'package:alugueis_app/consts/mensagens_app_consts.dart';
import 'package:alugueis_app/pages/listagem/listagem_page.dart';
import 'package:alugueis_app/pages/residencias/residencias_page.dart';
import 'package:alugueis_app/pages/resumo/resumo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const AlugueisApp());
}

class AlugueisApp extends StatefulWidget {
  const AlugueisApp({super.key});

  @override
  State<AlugueisApp> createState() => _AlugueisAppState();
}

class _AlugueisAppState extends State<AlugueisApp> {
  int selecionado = 0;

  static const List<Widget> _opcoes = <Widget>[
    ListagemPage(),
    ResidenciasPage(),
    ResumoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MensagensAppConsts.labelTitulo,
      theme: buildTheme(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[300],
          title: const _AppBarWidget(),
        ),
        body: Center(child: _opcoes.elementAt(selecionado)),
        bottomNavigationBar: _BarraNavegacaoWidget(
          onTap: (value) => setState(() => selecionado = value),
          selecionado: selecionado,
        ),
      ),
    );
  }

  ThemeData buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.lightGreen,
      ),
      useMaterial3: true,
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.monetization_on),
        SizedBox(width: 10),
        Text(MensagensAppConsts.labelTitulo),
      ],
    );
  }
}

class _BarraNavegacaoWidget extends StatelessWidget {
  const _BarraNavegacaoWidget({
    required this.selecionado,
    required this.onTap,
  });

  final int selecionado;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selecionado,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: MensagensAppConsts.menuListagem,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_mini_outlined),
          label: MensagensAppConsts.menuResidencias,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: MensagensAppConsts.menuResumo,
        ),
      ],
    );
  }
}
