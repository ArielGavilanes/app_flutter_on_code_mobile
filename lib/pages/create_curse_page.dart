import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CreateCoursePage(),
  ));
}

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _descripcionCursoController =
      TextEditingController();
  final TextEditingController _precioCursoController = TextEditingController();
  bool _formSubmitted = false;
  bool _premiumCurso = false;
  bool _conCertificacion = false;
  bool _uploaded = false;
  String _uploadedFileName = '';

  void _onSubmit() {
    setState(() {
      _formSubmitted = true;
    });
    if (_formKey.currentState?.validate() ?? false) {
    }
  }

  void _onUpload() {
    setState(() {
      _uploaded = true;
      _uploadedFileName = 'example.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Crear Curso'),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseCreationSection(),
            const SizedBox(height: 16.0),
            _buildCoursePriceSection(),
            const SizedBox(height: 16.0),
            _buildCourseCoverSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCreationSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Empecemos a crear tu curso!',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextInputField(
                  controller: _nombreCursoController,
                  label: 'Nombre de tu curso',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                _buildTextAreaField(
                  controller: _descripcionCursoController,
                  label: 'Añade una descripcion',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                _buildCategorySelectField(),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.black.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                  child: const Text('Siguiente',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursePriceSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Elige un precio para tu curso (si quieres)',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          Row(
            children: [
              Checkbox(
                value: _premiumCurso,
                onChanged: (bool? value) {
                  setState(() {
                    _premiumCurso = value ?? false;
                  });
                },
              ),
              const Text('Tu curso será de paga?',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ],
          ),
          const Text(
            'Certificación',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          Row(
            children: [
              Checkbox(
                value: _conCertificacion,
                onChanged: (bool? value) {
                  setState(() {
                    _conCertificacion = value ?? false;
                  });
                },
              ),
              const Text('Tu curso tendrá una certificación?',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ],
          ),
          _buildTextInputField(
            controller: _precioCursoController,
            label: 'Elige un precio',
            enabled: _premiumCurso,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (_premiumCurso && (value?.isEmpty ?? true)) {
                return 'Este campo es obligatorio';
              }
              if (_premiumCurso && double.tryParse(value!) == null) {
                return 'Ingrese un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3),
              foregroundColor: Colors.black.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            child: const Text('Siguiente',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCoverSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Finalmente, escoge una portada',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          GestureDetector(
            onTap: _onUpload,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: _uploaded
                  ? Text('$_uploadedFileName - 1000000 bytes',
                      style: const TextStyle(color: Colors.white))
                  : const Text('Escoger archivo',
                      style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _uploaded ? _onSubmit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3),
              foregroundColor: Colors.black.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            child: const Text('Finalizar',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
        if (_formSubmitted && validator != null) ...[
          const SizedBox(height: 8.0),
          Text(
            validator(controller.text) ?? '',
            style: const TextStyle(color: Colors.red),
          ),
        ],
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildTextAreaField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLines: 5,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
        if (_formSubmitted && validator != null) ...[
          const SizedBox(height: 8.0),
          Text(
            validator(controller.text) ?? '',
            style: const TextStyle(color: Colors.red),
          ),
        ],
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildCategorySelectField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Categoria de tu curso',
            style: TextStyle(color: Colors.white)),
        DropdownButtonFormField<String>(
          value: null,
          items: const [
            DropdownMenuItem(value: '1', child: Text('Categoria 1')),
            DropdownMenuItem(value: '2', child: Text('Categoria 2')),
          ],
          onChanged: (String? value) {},
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
        if (_formSubmitted) ...[
          const SizedBox(height: 8.0),
          const Text(
            'Este campo es obligatorio',
            style: TextStyle(color: Colors.red),
          ),
        ],
        const SizedBox(height: 16.0),
      ],
    );
  }
}
