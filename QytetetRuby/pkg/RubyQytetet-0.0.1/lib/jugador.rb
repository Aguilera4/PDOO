#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Jugador
    
    attr_accessor :casillaActual, :encarcelado
    attr_accessor :cartaLibertad
    
    def initialize (nom)
      
      @encarcelado = false
      @nombre = nom
      @saldo = 7500
      @casillaActual = nil
      @cartaLibertad = nil
      @propiedades = Array.new
      
    end
    
    def to_s
      "  \n Nombre: #{@nombre}  \n Encarcelado: #{@encarcelado} \n Casilla Actual: #{@casillaActual} \n Carta Libertad: #{@cartaLibertad} \n Propiedades: #{@propiedades}"
    end
    
    def tengo_propiedades()
      
    end
    
    def actualizar_posicion(casilla)
      
    end
    
    def comprar_titulo()
      
    end
    
    def devolver_carta_libertad()
      
    end
    
    def ir_a_carcel(casilla)
      
    end
    
    def modificar_saldo()
      
    end
    
    def obtener_capital()
      
    end
    
    def obtener_propiedades_hipotecadas(hipotecada)
      
    end
    
    def pagar_cobrar_por_casa_y_hotel(cantidad)
      
    end
    
    def pagar_libertad(cantidad)
      
    end
        
    def puedo_edificar_casa(casilla)
      
    end
    
    def puedo_edificar_hotel(casilla)
      
    end
    
    def puedo_hipotecar(casilla)
      
    end
    
    def puedo_pagar_hipoteca(casilla)
      
    end
    
    def puedo_vender_propiedad(casilla)
      
    end
    
    def tengo_carta_libertad()
      
    end
    
    def vender_propiedad(casilla)
      
    end
    
    def cuantas_casas_hoteles_tengo()
      
    end
    
    def eliminar_de_mis_propiedades(casilla)
      
    end
    
    def es_de_mi_propiedad(casilla)
      
    end
    
    def tengo_saldo(cantidad)
      
    end
    
  end
end
