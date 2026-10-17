String? requiredText(String? value) =>
    value == null || value.trim().isEmpty ? 'Este campo es obligatorio' : null;
