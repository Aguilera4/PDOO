#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class TituloPropiedad
    
    attr_accessor :hipotecado
    attr_reader :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edificar
    attr_accessor :casilla, :propietario, :nombre
    
    def initialize(n,ab,fr,hb,pe,propie,casi)
      
      @nombre = n
      @hipotecado = false
      @alquiler_base = ab
      @factor_revalorizacion = fr
      @hipoteca_base = hb
      @precio_edificar = pe
      @propietario=propie
      @casilla=casi
      
    end
    
    def self.inicializar(n,ab,fr,hb,pe)
      
      self.new(n,ab,fr,hb,pe,nil,nil)
    end
    
    def to_s
      "Calle: #{@nombre}  Hipotecado: #{@hipotecado}  alquiler_base: #{@alquiler_base}  factor_revalorizacion: #{@factor_revalorizacion}  hipoteca_base: #{@hipoteca_base}  precio_edificar: #{@precio_edificar}"
    end
    
    def set_casilla(cas)
      @casilla=cas
    end
     
   
    def cobrar_alquiler(cantidad)
      @propietario.modificar_saldo(cantidad)
    end
    
    def propietario_encarcelado
      @propietario.encarcelado
    end
  
    def set_propietario(propietario = nil)
      @propietario = propietario
    end
    
    def tengo_propietario
      @propietario != nil
    end

  end
end
