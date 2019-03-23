#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "qytetet"
require_relative "tipo_casilla"
require_relative "vista_textual_qytetet"
require_relative "metodo_salir_carcel"
require_relative "dado"
require_relative "jugador"

module InterfazTextualQytetet
  class ControladorQytetet
    
    attr_reader :vista
    
    
    def initialize
      
      @vista = VistaTextualQytetet.new
    end
    
   
    
    def inicializacion_juego
      @juego = ModeloQytetet::Qytetet.instance
      nombres = vista.obtener_nombre_jugadores
      @juego.inicializar_juego(nombres)
      @jugador = @juego.jugador_actual
      @casilla =@juego.jugador_actual.casilla_actual 
      @dado= ModeloQytetet::Dado.instance
      puts @juego.to_s
      
      puts "\n===== Jugador Actual ====="
      puts @jugador.to_s
      gets.chomp
      
    end
    
     def desarrollo_juego
      
      bancarrota=false
      libre = true
      
      begin
        encarcelado=@jugador.encarcelado
         
         if encarcelado
           puts "\nEl jugador está encarcelado"
           metodo= @vista.menu_salir_carcel
           
           if metodo == 0
             puts "\nTirar dado"
             encarcelado= !@juego.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::TIRANDODADO)
           elsif metodo == 1
             puts "\nPagar 200€"
             encarcelado= !@juego.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::PAGANDOLIBERTAD)
           end 
           
         end
         
         if !encarcelado
                     
          tiene_propietario=@juego.jugar          
          @casilla = @juego.jugador_actual.casilla_actual
          bancarrota =! @jugador.tengo_saldo(0)
                   
           
          if !bancarrota && !encarcelado 
          
             if @casilla.tipo == ModeloQytetet::TipoCasilla::SORPRESA              
              tiene_propietario=@juego.aplicar_sorpresa
              if !bancarrota && !@jugador.encarcelado && @casilla.tipo == ModeloQytetet::TipoCasilla::CALLE && !tiene_propietario
                 comprar = @vista.elegir_quiero_comprar
                 if comprar
                   @juego.comprar_titulo_propiedad
                 end
                 
               end              

            elsif @casilla.tipo == ModeloQytetet::TipoCasilla::CALLE
              
              if !tiene_propietario
                comprar = @vista.elegir_quiero_comprar
              end
             
              if comprar==1      
                @juego.comprar_titulo_propiedad 
              end
             
            end#TIPOCASILLA
            
            tengo_propiedades=@jugador.tengo_propiedades
            
                        
            if !@jugador.encarcelado && !bancarrota && tengo_propiedades
                         
             begin
                                          
              opcion=@vista.menu_gestion_inmobiliaria
                 
              lista_propiedades_hipotecadas = Array.new
              lista_propiedades_no_hipotecadas = Array.new
                            
              if (  opcion == 5 )                             
                lista_propiedades_hipotecadas = @juego.propiedades_hipotecadas_jugador(true)
                if !lista_propiedades_hipotecadas.empty?
                   otra_casilla =  elegir_propiedad(lista_propiedades_hipotecadas);            
                end
              elsif ( opcion == 1 || opcion == 2 || opcion == 3 || opcion == 4 )
                lista_propiedades_no_hipotecadas = @juego.propiedades_hipotecadas_jugador(false)
                if !lista_propiedades_no_hipotecadas.empty?
                   una_casilla = elegir_propiedad(lista_propiedades_no_hipotecadas)                  
                end
              end       
             
                case opcion

                  when 1
                   if @juego.edificar_casa(una_casilla)
                     puts "\nHas edificado una casa"
                   else
                     puts "\nNo has podido edificar una casa"
                   end
                  when 2
                    if @juego.edificar_hotel(una_casilla)
                      puts "\nHas edificado un hotel"
                    else
                      puts "\nNo puedes edificar un hotel"
                    end
                  when 3
                    if @juego.vender_propiedad(una_casilla)
                      puts "\nHas vendido una propiedad"
                    else
                      puts "\nNo has podido vender la propiedad"
                    end                     
                  when 4
                    if @juego.hipotecar_propiedad(una_casilla)
                      puts "\nHas hipotecado una propiedad"
                    elsif
                      puts "\nNo puedes hipotecar la propiedad seleccionada"
                    end
                  when 5
                    if @juego.cancelar_hipoteca(otra_casilla)
                      puts "\nHas cancelado la hipoteca correctamente"
                    else
                      puts "\nNo se ha podido cancelar la hipoteca"
                    end
                end#CASE          
                   
               end  while(!(opcion==0 || !@jugador.tengo_propiedades))#WHILE      
            end
          end
         end
           
            if !bancarrota
              puts "\nPulsa cualquier tecla para continuar"
              gets.chomp
              puts "\n****** SIGUIENTE JUGADOR *******"
              @jugador =  @juego.siguiente_jugador
              puts @jugador.to_s 
             
            end
            
      end while !bancarrota
         
      puestos = Array.new
      puestos = @juego.obtener_ranking
      
       puts "*** RANKING ***"
      puestos.each do |(a,b)|
        puts "#{a} #{b}"
      end
      
       
       
     end#FIN DEL MÉTODO 
    
     def elegir_propiedad(propiedades) # lista de propiedades a elegir
       
        vista.mostrar("\tCasilla\tTitulo");
       
        listaPropiedades= Array.new
        puts propiedades.length
          for prop in propiedades  # crea una lista de strings con numeros y nombres de propiedades
              propString= prop.numero_casilla.to_s+' '+prop.titulo.nombre; 
              listaPropiedades<<propString
          end
        seleccion=vista.menu_elegir_propiedad(listaPropiedades)  # elige de esa lista del menu
        propiedades.at(seleccion)
       
       end
    
    def self.main
      
      controlador = ControladorQytetet.new
      controlador.inicializacion_juego
      
      controlador.desarrollo_juego
            
    end
  end
  
  ControladorQytetet.main
end
