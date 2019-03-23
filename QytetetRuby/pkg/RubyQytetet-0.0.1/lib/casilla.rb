#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Casilla
    attr_accessor :numHoteles, :numCasas, :titulo
    attr_reader :numeroCasilla, :coste, :tipo
    
    def initialize(nc,c, tipo,tit)
      
      @numeroCasilla = nc
      @coste = c
      @numHoteles = 0
      @numCasas = 0
      @tipo = tipo
      @titulo = tit
      
    end
    
    def to_s
      " \n Numero de casilla: #{@numeroCasilla} \n coste: #{@coste} \n Numero de hoteles: #{@numHoteles} \n Numero de casas #{@numCasas} \n Tipo: #{@tipo} \n Titulo: #{@titulo} \n"
    end
    
    def self.inicializar_casilla(nc,c,tipo)
      self.new(nc,c,tipo,nil)
    end
    
    def self.inicializar_calles(nc,c,tit)
      self.new(nc,c,nil,tit)
    end
    
    def asignar_propietario(jugador)
      
    end
    
    def calcular_valor_hipoteca()
  
    end
    
    def cancelar_hipoteca()
      
    end
    
    def cobrar_alquiler()
      
    end
    
    def edificar_casa()
      
    end
   
    def edificar_hotel()
      
    end
    
    def esta_hipotecada()
      
    end
    
    def hipotecar()
      
    end
    
    def coste_hipoteca()
      
    end
    
    def get_precio_edificar()
      
    end
    
    def hipotecar()
      
    end
    
    def precio_total_comprar()
      
    end
    
    def propietario_encarcelado()
      
    end
    
    def se_puede_edificar_casa()
      
    end
    
    def se_puede_edificar_hotel()
      
    end
    
    def soy_edificable()
      
    end
    
    def tengo_propietario()
      
    end
    
    def vender_titulo()
      
    end
    
    def asignar_titulo_propiedad()
      
    end
    
  end
end
