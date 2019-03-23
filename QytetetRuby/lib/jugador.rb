#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

 require_relative "qytetet"
 require_relative "calle"

module ModeloQytetet
  class Jugador
    
    attr_accessor :casilla_actual, :encarcelado ,:carta_libertad, :saldo, :propiedades , :nombre
    
    @@FACTOR_ESPECULADOR = 1
    
    def initialize (nom)
      
      
      @encarcelado = false
      @nombre = nom
      @saldo = 7500
      @casilla_actual = nil
      @carta_libertad = nil
      @propiedades = Array.new
     
      
    end
    
    def get_factor_especulador
      @@FACTOR_ESPECULADOR
    end
    
    def to_s
      salida = "  \n Nombre: #{@nombre} \n Saldo: #{@saldo}  \n Encarcelado: #{@encarcelado} \n Casilla Actual: [#{@casilla_actual}] \n Carta Libertad: #{@carta_libertad} \n Propiedades: ["
      
       for p in @propiedades
         salida += p.to_s
       end
       salida += "]"
       salida
    end
    
    def tengo_propiedades
      
      !@propiedades.empty?
    end
    
    def tengo_saldo(cantidad)
      @saldo >= cantidad
    end
    
    def comprar_titulo
      
      puedo_comprar=false
      if @casilla_actual.soy_edificable
        
        tengo_propietario= @casilla_actual.tengo_propietario
        if  !tengo_propietario
          
          coste_compra= @casilla_actual.coste
          if coste_compra<=@saldo
            titulo=@casilla_actual.asignar_propietario(self)
            @propiedades<<titulo
            modificar_saldo(-coste_compra)
            puedo_comprar=true
          end
          
        end
        
      end
      
      puedo_comprar
    end
    
    def devolver_carta_libertad
      
      carta_aux = Sorpesa.new( @carta_libertad.texto, @carta_libertad.valor, @carta_libertad.tipo)
      
      @carta_libertad = nil
      
      carta_aux     
    end   
    
    def ir_a_carcel(casilla)
      @casilla_actual=casilla
      @encarcelado=true
    end
  
    def modificar_saldo(cantidad)   
      @saldo = @saldo + cantidad
    end
    
    def obtener_capital
      
      @suma = saldo
      
      for i in @propiedades
        
        if @propiedades.esta_hipotecada == false
          suma += i.alquiler_base + i.precio_edificar * (i.num_casas + i.num_hoteles)
        end
      end
      
      suma
    end
    
    def obtener_propiedades_hipotecadas(hipotecada)
      
      @aux = Array.new
      
      for i in @propiedades
        if i.hipotecado==hipotecada
          @aux<< i
        end
      end
      @aux
    end
    
    def pagar_cobrar_por_casa_y_hotel(cantidad)
      
      numero_total=cuantas_casas_hoteles_tengo
      if numero_total != 0     
        numero_total=numero_total*cantidad
        modificar_saldo(numero_total)
      end
    end  
    
    def pagar_libertad(cantidad)
      if tengo_saldo(cantidad)
        modificar_saldo(cantidad)
      end
    end
    
    def puedo_edificar_casa(casilla)
      es_mia=self.es_de_mi_propiedad(casilla)
      
      if es_mia
        
        coste_edificar_casa=casilla.get_precio_edificar
        
        tengo_saldo=self.tengo_saldo(coste_edificar_casa)
      end
      tengo_saldo
    end
   
    def puedo_edificar_hotel(casilla)
      es_mia=self.es_de_mi_propiedad(casilla)
      
      if es_mia
        coste_edificar_hotel=casilla.get_precio_edificar
        
        tengo_saldo=self.tengo_saldo(coste_edificar_hotel)        
      end
      tengo_saldo
    end
    
    def puedo_hipotecar(casilla)
      self.es_de_mi_propiedad(casilla)
    end
    
    def puedo_vender_propiedad(casilla)
      es_mia=es_de_mi_propiedad(casilla) 
      hipotecada=casilla.esta_hipotecada
    
      es_mia && !hipotecada
    end
    
    def tengo_carta_libertad
      carta_libertad != nil
    end
 
    def vender_propiedad(casilla)
      precio_venta=casilla.vender_titulo
      modificar_saldo(precio_venta)
      eliminar_de_mis_propiedades(casilla)
      
    end
    
    def cuantas_casas_hoteles_tengo
     sum=0
      if tengo_propiedades
          for i in @propiedades
            sum += i.casilla.num_casas + i.casilla.num_hoteles
          end
      end
      sum
    end
    
    def eliminar_de_mis_propiedades(casilla)
      
      if es_de_mi_propiedad(casilla)
        index = @propiedades.index(casilla.titulo)
        @propiedades.delete_at(index)
      end
      
    end
    
    def es_de_mi_propiedad(casilla)
      
      aux=false
      
      for i in @propiedades
        if i.casilla.numero_casilla == casilla.numero_casilla
          aux=true
        end
      end
      aux
    end
    
    protected
    
    def  Jugador( jugador )
      
      self.encarcelado = jugador.encarcelado
      self.nombre = jugador.nombre
      self.saldo = jugador.saldo
      self.casilla_actual = jugador.casilla_actual     
  
      if self.carta_libertad!=nil
        self.carta_libertad = jugador.carta_libertad
      end
      @propiedades=Array.new
      for i in jugador.propiedades
        self.propiedades << i
      end 

    end 
    
    def pagar_impuestos( cantidad )
      modificar_saldo(-cantidad/get_factor_especulador)
    end
    
    public
    def actualizar_posicion(casilla)
      if  ( casilla.numero_casilla < casilla_actual.numero_casilla )
        modificar_saldo(1000)
      end  
      
      tengo_propietario = false
      @casilla_actual = casilla
       
        if ( @casilla_actual.soy_edificable )
          tengo_propietario = casilla.tengo_propietario
          
          if ( tengo_propietario )
            encarcelado = casilla.propietario_encarcelado
          
            if ( !encarcelado )
             coste_alquiler = casilla.cobrar_alquiler
             puts "\n Pagas: #{coste_alquiler}"
             modificar_saldo(-coste_alquiler)             
            end
          end
       
        elsif ( casilla.tipo == TipoCasilla::IMPUESTO )
            coste = casilla.coste
            pagar_impuestos(-coste)
        end           
    end
   
    def convertirme (  fianza )
     return Especulador.new(self,fianza)
    end

  end
end
