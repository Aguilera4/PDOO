#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  
  require_relative "casilla"
  require_relative "tipo_casilla"
  require_relative "titulo_propiedad"
  
  class Tablero

    attr_reader :casillas
    
   
    
    def initialize
      
       @casillas = Array.new
       inicializar
    end


    def inicializar

       @casillas << Casilla.inicializar_casilla(1, 0, TipoCasilla::SALIDA)
       @casillas << Casilla.inicializar_casilla(1, 0, TipoCasilla::SALIDA)
       @casillas << Casilla.inicializar_casilla(9, 0, TipoCasilla::CARCEL)
       @casillas << Casilla.new(2, 400, TipoCasilla::CALLE, TituloPropiedad.inicializar("Abad", 50, 0.10, 400, 300))
       @casillas << Casilla.new(4, 500, TipoCasilla::CALLE, TituloPropiedad.inicializar("Elvira", 70, 0.15, 300, 250))
       @casillas << Casilla.new(6, 1300,  TipoCasilla::CALLE,TituloPropiedad.inicializar("Maitena", 85, 0.13, 600, 450))
       @casillas << Casilla.new(7, 1000, TipoCasilla::CALLE,TituloPropiedad.inicializar("Bolivia", 60, 0.12, 200, 400))
       @casillas << Casilla.new(8, 300, TipoCasilla::CALLE, TituloPropiedad.inicializar("Cadiar", 85, 0.15, 500, 350))
       @casillas << Casilla.new(10, 2000,  TipoCasilla::CALLE,TituloPropiedad.inicializar("Duero", 90, 0.17, 150, 600))
       @casillas << Casilla.new(11, 600, TipoCasilla::CALLE, TituloPropiedad.inicializar("Ecuador", 50, 0.11, 250, 550))
       @casillas << Casilla.new(13, 1200,  TipoCasilla::CALLE, TituloPropiedad.inicializar("Fatima", 70, 0.18, 650, 450))
       @casillas << Casilla.new(15, 1500,  TipoCasilla::CALLE, TituloPropiedad.inicializar("Galileo", 100, 0.20, 300, 250))
       @casillas << Casilla.new(17, 1700,  TipoCasilla::CALLE, TituloPropiedad.inicializar("Horacio", 60, 0.15, 500, 400))
       @casillas << Casilla.new(18, 700,  TipoCasilla::CALLE, TituloPropiedad.inicializar("Imperio", 95, 0.19, 550, 750))
       @casillas << Casilla.new(20, 2000,  TipoCasilla::CALLE, TituloPropiedad.inicializar("Jativa", 100, 0.20, 1000, 750))
       @casillas << Casilla.inicializar_casilla(3, 0, TipoCasilla::SORPRESA)
       @casillas << Casilla.inicializar_casilla(14, 0, TipoCasilla::SORPRESA)
       @casillas << Casilla.inicializar_casilla(19, 0, TipoCasilla::SORPRESA)
       @casillas << Casilla.inicializar_casilla(12, 0, TipoCasilla::JUEZ)
       @casillas << Casilla.inicializar_casilla(5, 0, TipoCasilla::PARKING)
       @casillas << Casilla.inicializar_casilla(16, -2000, TipoCasilla::IMPUESTO)

    end
    
    def to_s
      
      salida = ""
     
      for casilla in @casillas
        salida += casilla.to_s
      end
        salida
       
    end

    def esCasillaCarcel(numeroCasilla)
      
    end
    
    def obtenerCasillaNumero(numeroCasille)
    
    end
    
    def obtenerNuevaCasilla(casilla, desplazamiento)
  
    end
   
    
  end
end
