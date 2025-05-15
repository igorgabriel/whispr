class EndPoints {
  static const String login = 'login/oauth';
  static const String register = 'conta/registro';
  static const String resend = 'conta/reenviarEmail';
  static const String resetPassword = 'conta/resetarSenha';
  static const String buscar = 'empresa/buscar';
  static const String recentes = 'empresa/recentes';
  static const String setarRecente = 'empresa/setRecente';
  static const String meusServicos = 'empresa/meusServicos';
  static const String enviarCodigoSms = 'empresa/enviarcodigosms';
  static const String confirmarCodigo = 'empresa/confirmarsms';
  static const String alterarEmpresa = 'empresa/alterar';
  static const String categorias = 'categoria/buscar';
  static const String categoriasTodos = 'categoria/getAll';
  static const String categoria = 'categoria/get';
  static const String cadastrarServico = 'servico/cadastrar';
}

class Params {
  static const String apiKey = 'api_key';
}
