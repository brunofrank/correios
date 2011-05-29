require 'open-uri'
require 'xmlsimple'

class Correios
  
  class Servico
    PAC        = 41106
    SEDEX      = 40010
    SEDEX10    = 40215
    SEDEX_HOJE = 40290
    ESEDEX     = 81019    
    
    SERVICOS = {
      41106 => :pac,
      40010 => :sedex,
      40215 => :sedex10,
      40290 => :sedex_hoje,
      81019 => :esedex
    }    
    
    attr_reader :servico, :valor, :prazo, :erro, :message
    
    def initialize(servico)
      @servico = SERVICOS[servico["Codigo"].to_s.to_i]
      @valor = servico["Valor"].to_s.gsub(',', '.').to_f
      @prazo = servico["PrazoEntrega"].to_s.to_i
      @erro = servico["Erro"].to_s
      @message = servico["MsgErro"].to_s
    end
    
    def valid?
      @erro == '0'
    end
  end
  
  SIM = 'S'
  NAO = 'N'
  
  def initialize(cep_origem, cep_destino)
    @cep_origem = cep_origem 
    @cep_destino = cep_destino     
  end
  
  def calcular_frete(servicos, peso, comprimento, altura, largura, diametro, mao_propria = NAO, 
                    valor_declarado = 0, aviso_recebimento = NAO)
    host = 'http://ws.correios.com.br'
    path = '/calculador/CalcPrecoPrazo.aspx'
    
    params = {
      :nCdEmpresa => '',
      :sDsSenha => '',
      :StrRetorno => "xml",
      :nCdServico => servicos.to_a.join(','),
      :sCepOrigem => @cep_origem,
      :sCepDestino => @cep_destino,
      :nVlPeso => peso,
      :nCdFormato => 1,
      :nVlComprimento => comprimento,
      :nVlAltura => altura,
      :nVlLargura => largura,
      :nVlDiametro => diametro,
      :sCdMaoPropria => mao_propria,
      :nVlValorDeclarado => valor_declarado,
      :sCdAvisoRecebimento => aviso_recebimento
    }                                
    
    params = params.to_a.map {|item| item.to_a.join('=')} .join('&')
    
    xml = XmlSimple.xml_in(open("#{host}#{path}?#{params}").read)

    if xml["cServico"].size > 1
      servicos = []
      xml["cServico"].each do |servico|
        servicos << Servico.new(servico)
      end
    else
      servicos = Servico.new(xml["cServico"].first)
    end
    
    return servicos
  end
end