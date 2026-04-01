import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _claveFormulario = GlobalKey<FormState>();
  final ApiService servicioApi = ApiService();

  late TextEditingController _controladorTitulo;
  late TextEditingController _controladorPrecio;
  late TextEditingController _controladorDescripcion;

  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _controladorTitulo = TextEditingController(text: widget.product.title);
    _controladorPrecio = TextEditingController(text: widget.product.price.toString());
    _controladorDescripcion = TextEditingController(text: widget.product.description);
  }

  void _enviarActualizacion() async {
    if (_claveFormulario.currentState!.validate()) {
      setState(() => _cargando = true);

      final productoActualizado = Product(
        id: widget.product.id,
        title: _controladorTitulo.text,
        price: double.parse(_controladorPrecio.text),
        description: _controladorDescripcion.text,
        category: widget.product.category,
        image: widget.product.image,
      );

      try {
        await servicioApi.updateProduct(widget.product.id!, productoActualizado);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Actualizado con éxito'), backgroundColor: Colors.blue),
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
        title: const Text('Editar Producto', style: TextStyle(color: Colors.black87)),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _cargando 
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _claveFormulario,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _controladorTitulo,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorPrecio,
                    decoration: const InputDecoration(labelText: 'Precio', prefixText: '\$ '),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      final precio = double.tryParse(value);
                      if (precio == null) {
                        return 'Número no válido';
                      }
                      if (precio < 0) {
                        return 'El precio no puede ser negativo'; // Validación solicitada
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorDescripcion,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    maxLines: 4,
                    validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _enviarActualizacion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('GUARDAR CAMBIOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}