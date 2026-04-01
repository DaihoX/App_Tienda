import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _claveFormulario = GlobalKey<FormState>();
  final ApiService servicioApi = ApiService();

  final _controladorTitulo = TextEditingController();
  final _controladorPrecio = TextEditingController();
  final _controladorDescripcion = TextEditingController();
  final _controladorCategoria = TextEditingController();

  bool _cargando = false;

  void _enviarFormulario() async {
    if (_claveFormulario.currentState!.validate()) {
      setState(() => _cargando = true);

      final productoNuevo = Product(
        title: _controladorTitulo.text,
        price: double.parse(_controladorPrecio.text),
        description: _controladorDescripcion.text,
        category: _controladorCategoria.text,
        image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      );

      try {
        final resultado = await servicioApi.createProduct(productoNuevo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto creado. ID: ${resultado.id}'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.redAccent),
        );
      } finally {
        setState(() => _cargando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nuevo Producto', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _cargando 
        ? const Center(child: CircularProgressIndicator(color: Colors.black87)) 
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _claveFormulario,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _controladorTitulo,
                    decoration: const InputDecoration(labelText: 'Título del producto *'),
                    validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorPrecio,
                    decoration: const InputDecoration(labelText: 'Precio (USD) *', prefixText: '\$ '),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El precio es obligatorio';
                      }
                      final precio = double.tryParse(value);
                      if (precio == null) {
                        return 'Ingrese un número válido';
                      }
                      if (precio < 0) {
                        return 'El precio no puede ser negativo'; // Validación 
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorDescripcion,
                    decoration: const InputDecoration(labelText: 'Descripción *'),
                    maxLines: 4,
                    validator: (value) => value!.isEmpty ? 'La descripción es obligatoria' : null,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('GUARDAR PRODUCTO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}