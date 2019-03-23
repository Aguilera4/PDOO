#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

 require "singleton"
 require_relative "dado"
 require_relative "tablero"
 require_relative "jugador"
 require_relative "sorpresa"
module ModeloQytetet

  class Qytetet  
    include Singleton

    
    
    @@MAX_JUGADORES=4
    @@MAX_CARTAS=10
    @@MAX_CASILLAS=20
    @@PRECIO_LIBERTAD=200
    @@SALDO_SALIDA=100
    
    
    attr_accessor :cartaActual, :jugadorActual
    
    def initialize
      @mazo = Array.new
      @tablero = Tablero.new
      @cartaActual = nil
      @jugadorActual = nil
      @dado = Dado.instance
      @jugadores = Array.new
      inicializarCartasSorpresa
      inicializarTablero
      
    end
    
    def to_s
      puts "\n Jugadores** #{@jugadores} \n **Sorpesas** "
      
      for m in @mazo
        puts " #{m} "
      end
      
      puts "\n **Tablero** #{@tablero}"
      
    end
    
    def aplicarSorpresa
      
    end
    
    
    def cancelarHipoteca(casilla)
      
    end
    
    
    def comprarTituloPropiedad
      
    end
    
    
    def edificarCasa(casilla)
      
    end
    
    
    def edificarHotel(casilla)
      
    end
    
    
    def hipotecarPropiedad(casilla)
      
    end
    
    
    def inicializarJuego(nombres=array.new)
      
    end
    
    
    def intentarSalirCarcel(metodo)
      
    end
    
    
    def jugar
      
    end

    
    def obtenerRanking
      
    end
    
    
    def propiedadesHipotecadasJugdor
      
    end
    
    
    def siguienteJugador
      
    end
    
    
    def venderPropiedad(casilla)
      
    end
    
    
    def encarcelarJugador
      
    end
    
    
    def salidaJugadores
      
    end
  
    
    def inicializarCartasSorpresa
     
     
      @mazo<<Sorpresa.new("Un fan anonimo ha pagado tu fianza. Sales de la carcel", 0, TipoSorpresa::SALIRCARCEL)
      @mazo<< Sorpresa.new("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", 9, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("¡Estás de suerte!, tu jefe te ha dado una bonificación de 500 €", 500, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("Lo sentimos, un desconocido te ha robado 500 €", -500, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("¡Ups!, al parecer se te ha caído algo por el camino", 5, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Un conocido se ha ofrecido a llevarte en coche", 13, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("¡Hoy es tu cumpleaños!, invitas el resto de jugadores a una cena", 100, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Dada tu situación económica, el resto de jugadores han decidido ayudarte", 100, TipoSorpresa::PORJUGADOR) 
      @mazo<< Sorpresa.new("Paga por cada casa 50 y el doble por cada hotel", 50,TipoSorpresa::PORCASAHOTEL )
      @mazo<< Sorpresa.new("Te devolvemos 10 euros por cada casa y el doble por cada hotel", 10,TipoSorpresa::PORCASAHOTEL)
      
      @mazo.shuffle
      
    end
      
         
    def inicializarJugadores(nombres)
      
       for nombre in nombres
          @jugadores << Jugador.new(nombre)
       end
        
      
      
    end
    
    
    def inicializarTablero
      @tablero = Tablero.new
      
    end
    
  end
end

