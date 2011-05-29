require 'open-uri'
require 'xmlsimple'

class Correios
  
  class InvalidCalcException < Exception
    attr_reader :message
    
    def initialize(message)
      @message = message
    end
  end
  
  class Servico     
    PAC        = 41106
    SEDEX      = 40010
    SEDEX10    = 40215
    SEDEX_HOJE = 40290
    ESEDEX     = 81019    
    MALOTE     = 44105
  end
  
  SIM = 'S'
  NAO = 'N'
  
  def self.calcula_frete(tipo, cep_origem, cep_destino, peso, comprimento, 
                         altura, largura, diametro, mao_propria = NAO, 
                         valor_declarado = 0, aviso_recebimento = NAO)
    host = 'http://ws.correios.com.br'
    path = '/calculador/CalcPrecoPrazo.aspx'
    
    params = {
      :nCdEmpresa => '',
      :sDsSenha => '',
      :StrRetorno => "xml",
      :nCdServico => tipo,
      :sCepOrigem => cep_origem,
      :sCepDestino => cep_destino,
      :nVlPeso => peso,
      :nCdFormato => 1,
      :nVlComprimento => comprimento,
      :nVlAltura => altura,
      :nVlLargura => largura,
      :nVlDiametro => diametro,
      :sCdMaoPropria => mao_propria,
      :nVlValorDeclarado => valor_declarado,
      :resposta => "Xml",
      :sCdAvisoRecebimento => aviso_recebimento
    }                                
    
    params = params.to_a.map {|item| item.to_a.join('=')} .join('&')
    
    xml = XmlSimple.xml_in(open("#{host}#{path}?#{params}").read)
    if xml["cServico"].first["Erro"].first == '0'    
      xml['cServico'].first["Valor"].first.gsub(',', '.').to_f
    else
      raise InvalidCalcException, xml["cServico"].first["MsgErro"].first 
    end
  end
end