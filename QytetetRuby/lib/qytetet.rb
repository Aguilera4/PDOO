#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

 require "singleton"
 require_relative "tipo_sorpresa"
 require_relative "tipo_casilla"
 require_relative "dado"
 require_relative "tablero"
 require_relative "jugador"
 require_relative "sorpresa"
 require_relative "especulador"
module ModeloQytetet

  class Qytetet  
    include Singleton

    
    
    @@MAX_JUGADORES=4
    @@MAX_CARTAS=10
    @@MAX_CASILLAS=20
    @@PRECIO_LIBERTAD=200
    @@SALDO_SALIDA=1000
    
    
    attr_accessor :carta_actual, :jugador_actual, :jugadores, :tablero
    
    def initialize
      @mazo = Array.new
      @tablero = Tablero.new
      @carta_actual = nil
      @jugador_actual = nil
      @dado = Dado.instance
      @jugadores = Array.new
      inicializar_cartas_sorpresa
      inicializar_tablero
      
    end
    
    def siguiente_jugador
        
        i = 0;
        
      i = @jugadores.index(@jugador_actual)
      i2 = ( i+1 ) % @jugadores.size
      
      @jugador_actual = jugadores[i2]
    
      return jugador_actual
         
    end
      
    def salida_jugadores
      
      for i in @jugadores
        i.casilla_actual = Casilla.new(1, 0, TipoCasilla::SALIDA)
        i.saldo = 7500
      end
      @jugador_actual = jugadores[rand(@jugadores.length)] 
    end
    
    def propiedades_hipotecadas_jugador(hipotecadas)
      
      cas = Array.new
      @titulo_jug = Array.new
      
      @titulo_jug = jugador_actual.obtener_propiedades_hipotecadas(hipotecadas)
      
        for i in @titulo_jug
          cas<<(i.casilla)
        end
      cas
    end  
    
    def to_s
      
       salida = "\n **Jugadores** \n" 
       
      for j in @jugadores
        salida +=" #{j} \n"
      end
       salida+="\n **Sorpesas** "
      for m in @mazo
        salida +=" #{m} \n"
      end
      
       salida +="\n **Tablero** #{@tablero}"
       
    end
    
    def aplicar_sorpresa
     
      tiene_propietario=false
      
      
      if @carta_actual.tipo==TipoSorpresa::PAGARCOBRAR
        
        @jugador_actual.modificar_saldo(@carta_actual.valor)          
   
      elsif @carta_actual.tipo==TipoSorpresa::IRACASILLA

        es_carcel=@tablero.es_casilla_carcel(@carta_actual.valor)       
      
        if es_carcel
          encarcelar_jugador
        else
          nueva_casilla= @tablero.obtener_casilla_numero(@carta_actual.valor)
          tiene_propietario=@jugador_actual.actualizar_posicion(nueva_casilla)
        end
      
      elsif   @carta_actual.tipo == TipoSorpresa::CONVERTIRME
        especulador=@jugador_actual.convertirme(@carta_actual.valor)
        puts especulador
        i=@jugadores.index(@jugador_actual)  
        @jugadores[i]=especulador
        @jugador_actual=especulador
      elsif @carta_actual.tipo == TipoSorpresa::PORCASAHOTEL
      
        @jugador_actual.pagar_cobrar_por_casa_y_hotel(@carta_actual.valor)  
    
      elsif @carta_actual.tipo == TipoSorpresa::PORJUGADOR
          
        for jugador in jugadores
          if jugador != @jugador_actual
            jugador.modificar_saldo(@carta_actual.valor)
            @jugador_actual.modificar_saldo(-@carta_actual.valor)
          end
        end
      else 
        if @carta_actual.tipo==TipoSorpresa::SALIRCARCEL
          jugador_actual.carta_libertad = @carta_actual
        else
          mazo<<(@carta_actual)
        end
      end
        tiene_propietario  
    end 
    

    def cancelar_hipoteca(casilla)
      aux=false
      if casilla.esta_hipotecada
        
        cantidad=casilla.coste
        cantidad=cantidad+cantidad*0.1
        
        if jugador_actual.tengo_saldo(cantidad)
          casilla.titulo.hipotecado=false
          jugador_actual.modificar_saldo(-cantidad)
          aux=true
        end
          
      end
      aux
    end
    
    
    def comprar_titulo_propiedad
     @jugador_actual.comprar_titulo 
    end
    
    
    def edificar_casa(casilla)
      
      puedo_edificar=false
      
      if casilla.soy_edificable
        
        se_puede_edificar=casilla.se_puede_edificar_casa(@jugador_actual.get_factor_especulador)
        
        if se_puede_edificar
          
          puedo_edificar=jugador_actual.puedo_edificar_casa(casilla)
          
          if puedo_edificar
            
            coste_edificar_casa=casilla.edificar_casa
            jugador_actual.modificar_saldo(-coste_edificar_casa)
          end
        end
        
      end
      puedo_edificar
    end
    
    
    def edificar_hotel(casilla)
      puedo_edificar=false
      
      if casilla.soy_edificable
        
        se_puede_edificar=casilla.se_puede_edificar_hotel(@jugador_actual.get_factor_especulador)
        
        if se_puede_edificar
          
          puedo_edificar=jugador_actual.puedo_edificar_hotel(casilla)
          
          if puedo_edificar
            
            coste_edificar_hotel=casilla.edificar_hotel
            jugador_actual.modificar_saldo(-coste_edificar_hotel)
          end
        end
        
      end
      puedo_edificar
    end
    
    
    def hipotecar_propiedad(casilla)
      
      if casilla.soy_edificable
        se_puede_hipotecar=!casilla.esta_hipotecada
        
        if se_puede_hipotecar
          puedo_hipotecar=jugador_actual.puedo_hipotecar(casilla)
          
          if puedo_hipotecar
            cantidad_recibida=casilla.hipotecar
            jugador_actual.modificar_saldo(cantidad_recibida)
          end
        end
      end
    end
    
    
    def inicializar_juego(nombres=Array.new)
      self.inicializar_jugadores(nombres)
      self.inicializar_cartas_sorpresa
      self.inicializar_tablero
      self.salida_jugadores
    end
    
    
    def intentar_salir_carcel(metodo)
      
      libre=false
      
      if metodo==MetodoSalirCarcel::TIRANDODADO
        valor_dado=@dado.tirar
        libre=valor_dado >= 5
      elsif metodo == MetodoSalirCarcel::PAGANDOLIBERTAD
        tengo_saldo=jugador_actual.pagar_libertad(@@PRECIO_LIBERTAD)
        libre=true
      end
      
      if libre
        jugador_actual.encarcelado=false
      end
      
      libre
    end
    
    
    def jugar
      
      valor_dado=@dado.tirar
      casilla_posicion=jugador_actual.casilla_actual
      nueva_casilla=@tablero.obtener_nueva_casilla(casilla_posicion, valor_dado)
      tiene_propietario=jugador_actual.actualizar_posicion(nueva_casilla)
      
      if !nueva_casilla.soy_edificable

        if nueva_casilla.tipo == TipoCasilla::JUEZ
          puts "\nHas caido en el Juez, vas a la cárcel"
          encarcelar_jugador
          tiene_propietario=true
        elsif nueva_casilla.tipo == TipoCasilla::SORPRESA
          @carta_actual=@mazo[rand(@mazo.length)-1]
          puts "\nSORPRESA!\n #{@carta_actual.to_s}"
        elsif nueva_casilla.tipo == TipoCasilla::PARKING
          puts "\nHas caido en el PARKING"
        elsif nueva_casilla.tipo == TipoCasilla::CARCEL
          puts "\nCárcel, solo visitas"
        end
      else
        puts "\nHas caido en:"+nueva_casilla.to_s
      end
      tiene_propietario
    end

    
    def obtener_ranking(ranking=Array.new)
      
      for jugador in @jugadores
        capital=jugador.obtener_capital
        ranking<<[jugador.nombre,capital]
      end
      ranking
    end
    
    def vender_propiedad(casilla)
      
      if casilla.soy_edificable
        puedo_vender=jugador_actual.puedo_vender_propiedad(casilla)
        
        if puedo_vender
          jugador_actual.vender_propiedad(casilla)
        end
      end
    end
    
    
    def encarcelar_jugador
      
      if !@jugador_actual.tengo_carta_libertad
        casilla_carcel=@tablero.carcel
        @jugador_actual.ir_a_carcel(casilla_carcel)
      else
        carta=@jugador_actual.devolver_carta_libertad
        @mazo<<carta
      end
      
    end
    
    def inicializar_cartas_sorpresa
     
     
      @mazo<<Sorpresa.new("Un fan anonimo ha pagado tu fianza. Sales de la carcel", 0, TipoSorpresa::SALIRCARCEL)
      @mazo<< Sorpresa.new("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", 9, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("¡Estás de suerte!, tu jefe te ha dado una bonificación de 500 €", 500, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("Lo sentimos, un desconocido te ha robado 500 €", -500, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("¡Ups!, al parecer se te ha caído algo por el camino", 5, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Un conocido se ha ofrecido a llevarte en coche", 13, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("¡Hoy es tu cumpleaños!, invitas el resto de jugadores a una cena", -100, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Dada tu situación económica, el resto de jugadores han decidido ayudarte", 100, TipoSorpresa::PORJUGADOR) 
      @mazo<< Sorpresa.new("Paga por cada casa 50 y el doble por cada hotel", 50,TipoSorpresa::PORCASAHOTEL )
      @mazo<< Sorpresa.new("Te devolvemos 10 euros por cada casa y el doble por cada hotel", 10,TipoSorpresa::PORCASAHOTEL)
      @mazo<< Sorpresa.new("Evolucionas a especulador",3000,TipoSorpresa::CONVERTIRME)
      @mazo<< Sorpresa.new("Tus buenas impresiones te convierten en especulador", 5000, TipoSorpresa::CONVERTIRME)
      
      @mazo.shuffle
      
    end
      
         
    def inicializar_jugadores(nombres)
      
       for nombre in nombres
          @jugadores << Jugador.new(nombre)
       end
    end
    
    
    def inicializar_tablero
      @tablero = Tablero.new
    end  

  end
end



