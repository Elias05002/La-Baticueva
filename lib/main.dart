import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // Necesario para usar Timer

void main() {
  runApp(const MyApp());
}

String? registeredUsername;
String? registeredPassword;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'La Baticueva del Cómic',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 232, 105, 105),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 254, 254)),
        scaffoldBackgroundColor: const Color.fromARGB(183, 202, 3, 216),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

//pagina que da la presentacion (SplashScreen)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textSizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textSizeAnimation = Tween<double>(begin: 30, end: 35).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    // Después de 3 segundos, navega a la página de inicio de sesión
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ComicListPage()), // Aquí debes tener la página LoginPage definida
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí puedes agregar tu imagen si la tienes
            // Image.asset('assets/tu_imagen.png'),
            const SizedBox(height: 5), // Espacio entre la imagen y el texto
            AnimatedBuilder(
              animation: _textSizeAnimation,
              builder: (context, child) {
                return Text(
                  'La Baticueva del Cómic',
                  style: GoogleFonts.dancingScript(
                    fontSize: _textSizeAnimation.value,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(222, 242, 42, 115),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//loginPage
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Iniciar Sesión 🦇',
          style: GoogleFonts.dancingScript(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
          
            const SizedBox(height: 40),
            Text(
              'Inicia sesión en la Baticueva',
              style: GoogleFonts.dancingScript(
                color: const Color.fromARGB(212, 238, 178, 249),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
              Image.asset(
            'assets/img/Labati.png', // Ruta de la imagen
            width: 150,                  // Ancho opcional
            height: 150,                 // Altura opcional
                    // Cómo se ajusta la imagen
          ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
              labelText:'Nombre de usuario',
              labelStyle: GoogleFonts.dancingScript(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(212, 238, 178, 249),
                  ),
              
              ),
            ),
            
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: GoogleFonts.dancingScript(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(212, 238, 178, 249),
                  ),

                ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.trim() == registeredUsername &&
                    passwordController.text.trim() == registeredPassword) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  ComicListPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Credenciales incorrectas')),
                  );
                }
              },
              child: Text(
                'Iniciar Sesión',
                style: GoogleFonts.dancingScript(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: Text(
                '¿No tienes cuenta? Regístrate aquí',
                style:  GoogleFonts.dancingScript(
                   fontSize: 18,
                  color: const Color.fromARGB(212, 238, 178, 249),
                  decoration: TextDecoration.underline,
                   decorationColor: Colors.white,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//RegisterPage
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Regístrate en la Baticueva',
              style: GoogleFonts.dancingScript(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(212, 238, 178, 249),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
              labelText:'Nombre de usuario',
              labelStyle: GoogleFonts.dancingScript(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(212, 238, 178, 249),
                  ),
              
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
              labelText:'Contraseña',
              labelStyle: GoogleFonts.dancingScript(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(212, 238, 178, 249),
                  ),
              
              ),
            ),

          
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                registeredUsername = usernameController.text.trim();
                registeredPassword = passwordController.text.trim();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registro exitoso')),
                );

                Navigator.pop(context); // Volver a la pantalla de login
              },
              child:  Text(
                'Registrarse',
                style: GoogleFonts.dancingScript(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple
              ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}






// Página de lista de cómics
class ComicListPage extends StatelessWidget {
  ComicListPage({super.key});

  final List<Map<String, dynamic>> comics = [
    {
      'title': 'Demon Slayer',
      'image': 'assets/img/comic_0.jpg',
      'description': 'Tanjiro, un cazador de demonios, busca una cura para su hermana Nezuko, quien fue convertida en demonio tras la masacre de su familia.',
      'price': 70.0,
    },
    {
      'title': 'Dragon Ball Super',
      'image': 'assets/img/comic_1.jpg',
      'description': 'Goku y sus amigos luchan contra poderosos enemigos en su búsqueda para ser los más fuertes del universo.',
      'price': 50.0,
    },
    {
      'title': 'Nana',
      'image': 'assets/img/comic_2.jpg',
      'description': 'Dos chicas llamadas Nana, con sueños diferentes, enfrentan desafíos en el amor y la música en Tokio.',
      'price': 55.0,
    },
    {
      'title': 'One Piece',
      'image': 'assets/img/comic_3.jpg',
      'description': 'Luffy y su tripulación buscan el tesoro legendario "One Piece" para que Luffy se convierta en el rey de los piratas.',
      'price': 80.0,
    },
    {
      'title': 'Garfield',
      'image': 'assets/img/comic_4.jpg',
      'description': 'Las aventuras cómicas de Garfield, un gato perezoso y amante de la lasaña, que vive con su dueño Jon y el perro Odie.',
      'price': 70.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Cómics 🦇',
          style: GoogleFonts.dancingScript(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(222, 0, 0, 0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // Agregado para que la pantalla sea desplazable
        child: Column(
          children: [
            // Aseguramos que la lista sea desplazable correctamente
            Container(
              height: MediaQuery.of(context).size.height - 150, // Se ajusta el tamaño para no ocupar toda la pantalla
              child: ListView.builder(
                shrinkWrap: true,  // Para evitar problemas con el tamaño del ListView
                physics: BouncingScrollPhysics(),
                itemCount: comics.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          comics[index]['image']!,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        comics[index]['title']!,
                        style: GoogleFonts.dancingScript(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        comics[index]['description']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${comics[index]['price']!}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                         Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                Cart.addComicToCart(comics[index]['title']!, comics[index]['price']!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${comics[index]['title']} agregado al carrito'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              color: const Color.fromARGB(183, 202, 3, 216),
                              iconSize: 30, // Ajusta el tamaño del ícono
                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// Clase para manejar el carrito de cómics
class Cart {
  static List<Map<String, dynamic>> cartItems = []; // Lista de cómics en el carrito

  // Método para agregar un cómic al carrito
  static void addComicToCart(String comic, double price) {
    cartItems.add({'title': comic, 'price': price});
  }

  // Método para eliminar un cómic del carrito
  static void removeComicFromCart(String comic) {
    cartItems.removeWhere((item) => item['title'] == comic);
  }

  // Método para calcular el total
  static double calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }
}

// Página del carrito
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tu Carrito',
          style: GoogleFonts.dancingScript(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: Cart.cartItems.isEmpty
          ? Center(
              child: Text(
                'Tu carrito está vacío.',
                style: GoogleFonts.dancingScript(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Cart.cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          Cart.cartItems[index]['title']!,
                          style: GoogleFonts.dancingScript(fontSize: 18),
                        ),
                        subtitle: Text(
                          '\$${Cart.cartItems[index]['price']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            Cart.removeComicFromCart(Cart.cartItems[index]['title']!);

                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cómic eliminado del carrito')),
                            );
                          },
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${Cart.calculateTotal()}',
                    style: GoogleFonts.dancingScript(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
