#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  
  require_relative "casilla"
  require_relative "tipo_casilla"
  require_relative "titulo_propiedad"
  require_relative "calle"
  
  class Tablero

    attr_reader :casillas, :carcel

    def initialize
    
      @casillas = Array.new     
      inicializar_tablero
      @carcel = @casillas[8]      
    end

    def es_casilla_carcel(num_casilla)  
      num_casilla==@carcel.numero_casilla
    end
    
    
    def inicializar_tablero

      @casillas << Casilla.new(1, 0, TipoCasilla::SALIDA)
      @casillas << Calle.new(2, 400, TituloPropiedad.inicializar("Abad", 50, 0.10, 400, 300))
      @casillas << Casilla.new(3, 0, TipoCasilla::SORPRESA)
      @casillas << Calle.new(4, 500, TituloPropiedad.inicializar("Elvira", 70, 0.15, 300, 250))
      @casillas << Casilla.new(5, 0, TipoCasilla::PARKING)
      @casillas << Calle.new(6, 1300, TituloPropiedad.inicializar("Maitena", 85, 0.13, 600, 450))
      @casillas << Calle.new(7, 1000, TituloPropiedad.inicializar("Bolivia", 60, 0.12, 200, 400))
      @casillas << Calle.new(8, 300, TituloPropiedad.inicializar("Cadiar", 85, 0.15, 500, 350))
      @casillas << Casilla.new(9, 0, TipoCasilla::CARCEL)
      @casillas << Calle.new(10, 2000, TituloPropiedad.inicializar("Duero", 90, 0.17, 150, 600))
      @casillas << Calle.new(11, 600,  TituloPropiedad.inicializar("Ecuador", 50, 0.11, 250, 550))
      @casillas << Casilla.new(12, 0, TipoCasilla::JUEZ)
      @casillas << Calle.new(13, 1200, TituloPropiedad.inicializar("Fatima", 70, 0.18, 650, 450))
      @casillas << Casilla.new(14, 0, TipoCasilla::SORPRESA)  
      @casillas << Calle.new(15, 1500, TituloPropiedad.inicializar("Galileo", 100, 0.20, 300, 250))
      @casillas << Casilla.new(16, -2000, TipoCasilla::IMPUESTO)
      @casillas << Calle.new(17, 1700, TituloPropiedad.inicializar("Horacio", 60, 0.15, 500, 400))
      @casillas << Calle.new(18, 700, TituloPropiedad.inicializar("Imperio", 95, 0.19, 550, 750))
      @casillas << Casilla.new(19, 0, TipoCasilla::SORPRESA)
      @casillas << Calle.new(20, 2000, TituloPropiedad.inicializar("Jativa", 100, 0.20, 1000, 750))
      
      for cas in @casillas
        if cas.tipo == TipoCasilla::CALLE          
          cas.titulo.casilla=cas
        end
      end
      
    end
    
    def obtener_casilla_numero(numero_casilla)
        @casillas[numero_casilla-1]    
    end
    
    def obtener_nueva_casilla(casilla, desplazamiento)
      @casillas[(desplazamiento-1 + casilla.numero_casilla)%@casillas.length]
    end
    
    def to_s
      salida = "\n"
      
      for i in @casillas
        salida += " #{i} \n"
      end
      salida
    end
  end
end
