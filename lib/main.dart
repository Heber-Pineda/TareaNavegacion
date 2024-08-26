import 'package:flutter/material.dart';

void main() {
  runApp(const AppCombinada());
}

class AppCombinada extends StatelessWidget {
  const AppCombinada({super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Aplicación Combinada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaginaPrincipal(),
    );
    return materialApp;
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicación Combinada'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.tab),
              title: const Text('Navegación con pestañas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaNavegacionTabs()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.navigation),
              title: const Text('Navegación push y pop'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrimeraPagina()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              title: const Text('Datos de Padre a Hijo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaPadreAHijo()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Datos de Hijo a Padre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaHijoAPadre()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Selecciona una opción del menú'),
      ),
    );
  }
}


class PaginaNavegacionTabs extends StatefulWidget {
  const PaginaNavegacionTabs({super.key});

  @override
  _PaginaNavegacionTabsState createState() => _PaginaNavegacionTabsState();
}

class _PaginaNavegacionTabsState extends State<PaginaNavegacionTabs> {
  int _indiceSeleccionado = 0;

  static const List<Widget> _opcionesWidget = <Widget>[
    Text('Página Principal'),
    Text('Página de Configuración'),
  ];

  void _alPresionarElemento(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navegación con Pestañas'),
      ),
      body: Center(
        child: _opcionesWidget.elementAt(_indiceSeleccionado),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: _indiceSeleccionado,
        onTap: _alPresionarElemento,
      ),
    );
  }
}


class PrimeraPagina extends StatelessWidget {
  const PrimeraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primera Página'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SegundaPagina()),
            );
          },
          child: const Text('Ir a la Segunda Página'),
        ),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Página'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Volver'),
        ),
      ),
    );
  }
}


class PaginaPadreAHijo extends StatelessWidget {
  const PaginaPadreAHijo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Padre a Hijo'),
      ),
      body: const Center(
        child: WidgetHijo(mensaje: '¡Hola desde el Padre!'),
      ),
    );
  }
}

class WidgetHijo extends StatelessWidget {
  final String mensaje;

  const WidgetHijo({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Text(mensaje);
  }
}


class PaginaHijoAPadre extends StatefulWidget {
  const PaginaHijoAPadre({super.key});

  @override
  _PaginaHijoAPadreState createState() => _PaginaHijoAPadreState();
}

class _PaginaHijoAPadreState extends State<PaginaHijoAPadre> {
  String _mensaje = 'Esperando mensaje...';

  void _recibirMensaje(String mensaje) {
    setState(() {
      _mensaje = mensaje;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Hijo a Padre'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text(_mensaje)),
          const SizedBox(height: 20),
          WidgetHijoEmisor(onEnviarMensaje: _recibirMensaje),
        ],
      ),
    );
  }
}

class WidgetHijoEmisor extends StatelessWidget {
  final Function(String) onEnviarMensaje;

  const WidgetHijoEmisor({super.key, required this.onEnviarMensaje});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onEnviarMensaje('¡Hola desde el Hijo!'),
      child: const Text('Enviar mensaje al Padre'),
    );
  }
}

