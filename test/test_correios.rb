# encoding: UTF-8
require "test/unit"
require "correios"

class CorreiosTest < Test::Unit::TestCase
  def setup
    @obj = Correios.new(76410000, 74932180)
  end

  def test_get_xml_for_one_service
    url = "http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&StrRetorno=xml&nCdServico=41106&sCepOrigem=76410000&sCepDestino=74932180&nVlPeso=0.4&nCdFormato=1&nVlComprimento=17&nVlAltura=16&nVlLargura=16&nVlDiametro=0&sCdMaoPropria=N&nVlValorDeclarado=0&sCdAvisoRecebimento=N"
    xml = @obj.get_xml(url)
    assert xml.has_key? "cServico"
    first_service = xml["cServico"].first
    assert_equal ["41106"], first_service["Codigo"],          "Codigo"
    assert_equal ["12,50"], first_service["Valor"],           "Valor"
    assert_equal ["4"],     first_service["PrazoEntrega"],    "PrazoEntrega"
    assert_equal ["0,00"],  first_service["ValorMaoPropria"], "ValorMaoPropria"
    assert_equal ["0,00"],  first_service["ValorAvisoRecebimento"], "ValorAvisoRecebimento"
    assert_equal ["0,00"],  first_service["ValorValorDeclarado"], "ValorValorDeclarado"
    assert_equal ["N"],     first_service["EntregaSabado"],     "EntregaSabado"
    assert_equal ["S"],     first_service["EntregaDomiciliar"], "EntregaDomiciliar"
    assert_equal ["0"],     first_service["Erro"],              "Erro"
  end

  def test_get_xml_with_multiple_service
    url = "http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&StrRetorno=xml&nCdServico=41106,40010&sCepOrigem=76410000&sCepDestino=74932180&nVlPeso=0.4&nCdFormato=1&nVlComprimento=17&nVlAltura=16&nVlLargura=16&nVlDiametro=0&sCdMaoPropria=N&nVlValorDeclarado=0&sCdAvisoRecebimento=N"
    xml = @obj.get_xml(url)
    assert xml.has_key? "cServico"
    first_service = xml["cServico"].first
    second_service = xml["cServico"].fetch(1)

    # first service
    assert_equal ["41106"], first_service["Codigo"],                "Codigo"
    assert_equal ["12,50"], first_service["Valor"],                 "Valor"
    assert_equal ["4"],     first_service["PrazoEntrega"],          "PrazoEntrega"
    assert_equal ["0,00"],  first_service["ValorMaoPropria"],       "ValorMaoPropria"
    assert_equal ["0,00"],  first_service["ValorAvisoRecebimento"], "ValorAvisoRecebimento"
    assert_equal ["0,00"],  first_service["ValorValorDeclarado"],   "ValorValorDeclarado"
    assert_equal ["N"],     first_service["EntregaSabado"],         "EntregaSabado"
    assert_equal ["S"],     first_service["EntregaDomiciliar"],     "EntregaDomiciliar"
    assert_equal ["0"],     first_service["Erro"],                  "Erro"

    # second service
    assert_equal ["40010"], second_service["Codigo"],               "Codigo"
    assert_equal ["15,40"], second_service["Valor"],                "Valor"
    assert_equal ["1"],     second_service["PrazoEntrega"],         "PrazoEntrega"
    assert_equal ["0,00"],  second_service["ValorMaoPropria"],      "ValorMaoPropria"
    assert_equal ["0,00"],  second_service["ValorAvisoRecebimento"], "ValorAvisoRecebimento"
    assert_equal ["0,00"],  second_service["ValorValorDeclarado"],  "ValorValorDeclarado"
    assert_equal ["S"],     second_service["EntregaSabado"],        "EntregaSabado"
    assert_equal ["S"],     second_service["EntregaDomiciliar"],    "EntregaDomiciliar"
    assert_equal ["0"],     second_service["Erro"],                 "Erro"
  end

  def test_integration
    correios = Correios.new(76410000, 74932180)
    frete = correios.calcular_frete(Correios::Servico::PAC, 0.4, 17, 16, 16)
    assert_equal :pac,  frete.servico,  "Servico"
    assert_equal 12.5,  frete.valor,    "Valor"
    assert_equal 4,     frete.prazo,    "Prazo"
    assert_equal 0,     frete.erro,     "Erro?"
  end

  def test_force_error
    correios = Correios.new(76410000, 74932180)
    frete = correios.calcular_frete(99999, 0.4, 17, 16, 16)
    assert_equal -1,  frete.erro,  "Código de erro incorreto"
    assert_equal "Codigo de servico invalido.",  frete.message,  "Servico inválido"
  end

  def test_track_service_with_invalid_parameters
    assert_equal Correios::Rastreamento.buscar(""), false
    assert_equal Correios::Rastreamento.buscar(nil), false
  end
end