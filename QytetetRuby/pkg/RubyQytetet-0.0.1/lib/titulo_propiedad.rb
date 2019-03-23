#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class TituloPropiedad
    
    attr_accessor :hipotecado
    attr_reader :calle, :alquilerBase, :factorRevaloracion, :hipotecaBase, :precioEdificar
    attr_accessor :casilla, :propietario
    
    def initialize(c,ab,fr,hb,pe,propie,casi)
      
      @calle = c
      @hipotecado = false
      @alquilerBase = ab
      @factorRevaloracion = fr
      @hipotecaBase = hb
      @precioEdificar = pe
      @propietario=propie
      @casilla=casi
      
    end
    
    def self.inicializar(c,ab,fr,hb,pe)
      
      self.new(c,ab,fr,hb,pe,nil,nil)
    end
    
    def to_s
      "Calle: #{@calle} \n Hipotecado: #{@hipotecado} \n AlquilerBase: #{@alquilerBase} \n FactorRevaloracion: #{@factorRevaloracion} \n HipotecaBase: #{@hipotecaBase} \n PrecioEdificar: #{@precioEdificar}"
    end
    
    def cobrar_alquiler(coste)
      
    end
    
    def propietario_encarcelado()
      
    end
    
    def set_casilla(casilla)
      
    end
    
    def set_propietario(propietario)
      
    end
    
    def tengo_propietario() 
      
    end

  end
end
