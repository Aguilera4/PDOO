#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

 require_relative "tipo_casilla"

module ModeloQytetet

  class Calle < Casilla



    attr_accessor :num_hoteles, :num_casas, :titulo

      def initialize (nc,c,tit)
        super(nc,c,TipoCasilla::CALLE)
        @num_hoteles = 0
        @num_casas = 0
        @titulo = tit
      end

      def soy_edificable
         true 
      end

      def coste_alquiler_base
        @titulo.alquiler_base
      end

      def asignar_propietario(jugador)
        @titulo.set_propietario(jugador)
        titulo
      end

      def calcular_valor_hipoteca
        hipoteca_base=@titulo.hipoteca_base      
        (hipoteca_base + @num_casas * 0.5 * hipoteca_base + @num_hoteles * hipoteca_base).to_i
      end

      def cancelar_hipoteca
        @titulo.hipotecado=false
        calcular_valor_hipoteca      
      end

      def cobrar_alquiler
        coste_alquiler = coste_alquiler_base + (@num_casas * 0.5 + @num_hoteles * 2 ).to_i
        @titulo.cobrar_alquiler(coste_alquiler)
        coste_alquiler
      end

      def edificar_casa
        @num_casas+=1
        @titulo.precio_edificar 
      end

      def edificar_hotel
        @num_casas-=4
        @num_hoteles+=1
        @titulo.precio_edificar
      end

      def esta_hipotecada
        @titulo.hipotecado
      end

      def get_coste_hipoteca
        titulo.hipoteca_base + num_casas * 0.5 * titulo.hipoteca_base + num_hoteles * titulo.hipoteca_base
      end

      def get_precio_edificar
        titulo.precio_edificar      
      end 

      def hipotecar
        @titulo.hipotecado=true
        calcular_valor_hipoteca
      end    

      def precio_total_comprar
        titulo.alquiler_base
      end

      def propietario_encarcelado
        @titulo.propietario_encarcelado
      end

      def se_puede_edificar_casa(factor_especulador)
        @num_casas< (4 * factor_especulador)
      end

      def se_puede_edificar_hotel(factor_especulador)
        @num_hoteles<= (4 * factor_especulador) && @num_casas>=4
      end

      def tengo_propietario
        @titulo.tengo_propietario 
      end   

      def vender_titulo
        @titulo.propietario=nil
        @num_hoteles = 0
        @num_casas = 0

        precio_compra = coste + (num_casas + num_hoteles) * titulo.precio_edificar
        (precio_compra + titulo.factor_revalorizacion*precio_compra).to_i;
      end
      
      def to_s
           "  Numero de casilla: #{@numero_casilla}  coste: #{@coste}  Numero de hoteles: #{@num_hoteles}  Numero de casas: #{@num_casas}  Tipo: #{@tipo}  Titulo: #{@titulo}"
      end
  end
end
