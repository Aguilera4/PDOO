#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  
  require_relative "sorpresa"
  require_relative "tipo_sorpresa"
  require_relative "tablero"
  require_relative "jugador"
  require_relative "qytetet"
  
  
  class PruebaQytetet
#      attr_accessor :mazo
#    
#    @@mazo = Array.new
#   
#    def initialize(texto_,numero_,sorpresa_)
#      
#      @@mazo<<Sorpresa.new(texto_,numero_,sorpresa_)      
#    end
      
#    def self.inicializar_sorpresas
#   
#      self.new("Un fan anónimo ha pagado tu fianza. Sales de la cárcel", 0, TipoSorpresa::SALIRCARCEL)
#      self.new("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", 9, TipoSorpresa::IRACASILLA)
#      self.new("¡Estás de suerte!, tu jefe te ha dado una bonificación de 500 €", 500, TipoSorpresa::PAGARCOBRAR)
##      self.new("Lo sentimos, un desconocido te ha robado 500 €", -500, TipoSorpresa::PAGARCOBRAR)
##      self.new("¡Ups!, al parecer se te ha caído algo por el camino", 5, TipoSorpresa::IRACASILLA)
##      self.new("Un conocido se ha ofrecido a llevarte en coche", 13, TipoSorpresa::IRACASILLA)
##      self.new("¡Hoy es tu cumpleaños!, invitas el resto de jugadores a una cena", 100, TipoSorpresa::PORJUGADOR)
##      self.new("Dada tu situación económica, el resto de jugadores han decidido ayudarte", 100, TipoSorpresa::PORJUGADOR) 
##      self.new("Paga por cada casa 50 y el doble por cada hotel", 50,TipoSorpresa::PORCASAHOTEL )
##      self.new("Te devolvemos 10 euros por cada casa y el doble por cada hotel", 10,TipoSorpresa::PORCASAHOTEL)
##    end
#
#    def numeromayor(numero=0)
#      
#      mayores = Array.new
#      i=0
#      n=@@mazo.length
#      
#      while i < n
#        
#        if @@mazo[i].valor > numero
#          mayores<<@@mazo[i]
#        end
#        
#        i+=1
#      
#      end    
#      return mayores
#    end
#    
#    def ircasilla(tipo_=TipoSorpresa::IRACASILLA)
#      
#      tipo_s = Array.new
#      i=0
#      n=@@mazo.length
#      
#      while i < n
#        
#        if @@mazo[i].tipo == tipo_
#          tipo_s<<@@mazo[i]
#        end
#        
#        i+=1
#      
#      end 
#      
#      return tipo_s
#    end

    def self.main 
      
   
      juego = Qytetet.instance
      
      
     nombres = Array.new(["Javi", "Sergio","Christian"])
      
      juego.inicializar_juego(nombres)
     puts juego.jugador_actual.to_s
      
      
      casilla = juego.tablero.obtener_casilla_numero(7)
      juego.jugador_actual.actualizar_posicion(casilla)
      
      puts juego.jugador_actual.to_s
      
      juego.comprar_titulo_propiedad
      puts juego.jugador_actual.to_s
      
      
#      casilla = juego.tablero.obtener_casilla_numero(7)
#      juego.jugador_actual.actualizar_posicion(casilla)
#      juego.to_s
      
     
  
  
      
  
      
      
      
      
      
      
      
      
     
#    tablero = Tablero.new
#    puts tablero.esCasillaCarcel(9)
#    puts tablero.obtenerCasillaNumero(9)
#    puts tablero.obtenerNuevaCasilla(tablero.obtenerCasillaNumero(2), 3)
    
      
    
      
      

      end
  end 
  PruebaQytetet.main
end
