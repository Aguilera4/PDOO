/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package InterfazTextualQytetet;


import java.util.ArrayList;
import java.util.Scanner;
import modeloqytetet.*;

public class ControladorTextualQytetet {
    
private VistaTextualQytetet vista = new VistaTextualQytetet();
Qytetet juego = Qytetet.getInstance();
private Jugador jugador;
private Casilla casilla;
 
    
    ControladorTextualQytetet(){
        
    }
    
    public void inicializacionJuego(){
    
        ArrayList<String> nombres = new ArrayList();
        nombres  = vista.obtenerNombreJugadores();
        juego.inicializarJuego(nombres);
        jugador = juego.getJugadorActual();
        casilla = juego.getJugadorActual().getCasillaActual();
        System.out.println( juego.toString());
        System.out.println("\n ===== Jugador Actual =====");
        System.out.println(jugador.toString());
       // gets.chomp;
    }
    
    public void desarrolloJuego(){
     
        boolean bancarrota=false;
        boolean tienePropietario = false;
        int opcion = 1;
        boolean libre = true;
        boolean comprar = false;
        
        
        do{
            boolean encarcelado = jugador.getEncarcelado();
     
            if ( encarcelado ){
                opcion= vista.menuSalirCarcel();
                
                if ( opcion == 0 ){
                    System.out.println("\nPagas 200 euros.\n\n");
                    encarcelado = !juego.intentarSalirCarcel(MetodoSalirCarcel.PAGANDOLIBERTAD);
                }
                else if ( opcion == 1 ){
                    System.out.println("\nTiras dado.\n\n");
                    encarcelado = !juego.intentarSalirCarcel(MetodoSalirCarcel.TIRANDODADO);
                }
            }
            
            if ( !encarcelado ){
        
                tienePropietario = juego.Jugar();
                casilla = juego.getJugadorActual().getCasillaActual();
                bancarrota = !jugador.tengoSaldo(0);
                      
                if ( !bancarrota && !encarcelado ){ 
                           
                    if ( !casilla.soyEdificable() ){
                        tienePropietario = juego.aplicarSorpresa();
                              
                        if ( !bancarrota && !jugador.getEncarcelado() && casilla.soyEdificable() && !tienePropietario ){              
                            comprar =  vista.elegirQuieroComprar();

                            if ( comprar ){
                            juego.comprarTituloPropiedad();
                            }     
                        }
                    } 
                
                    else if ( casilla.soyEdificable() ){
                            
                        if ( !tienePropietario ){      
                            comprar =  vista.elegirQuieroComprar();

                            if ( comprar ){
                                juego.comprarTituloPropiedad();
                            }  
                        }
                    }
                    
                    
                    
               
                    boolean tengoPropiedades = jugador.tengoPropiedades();
                                              
                    if ( !jugador.getEncarcelado() && !bancarrota && tengoPropiedades ){                              
                      
                        do{
                            
                             opcion = vista.menuGestionInmobiliaria();
    
                             ArrayList <Casilla> listaPropiedadesHipotecadas = new ArrayList();
                             ArrayList <Casilla> listaPropiedadesNoHipotecadas = new ArrayList();
                             Casilla unacasilla =  null;
                             Casilla otracasilla = null;
                             
                            if (  opcion == 5){ 
                            
                            listaPropiedadesHipotecadas = juego.propiedadesHipotecadasJugador(true);
                            if(!listaPropiedadesHipotecadas.isEmpty())
                            unacasilla =  this.elegirPropiedad(listaPropiedadesHipotecadas);                             
                            }    
                            else if ( opcion == 3 || opcion == 4 || opcion == 1 || opcion == 2   ){                                
                            listaPropiedadesNoHipotecadas = juego.propiedadesHipotecadasJugador(false);
                            if(!listaPropiedadesNoHipotecadas.isEmpty())
                            otracasilla =  this.elegirPropiedad(listaPropiedadesNoHipotecadas);
                            }    
                           
                              
                              
                                switch ( opcion ){
                               
                                    case 1: 
                                        if(juego.edificarCasa(otracasilla)){
                                           System.out.println("\nHas edificado una casa");
                                        }else{
                                            System.out.println("\nNo has podido edificar una casa");
                                        }
                                        break;
                                    
                                    case 2:
                                        if(juego.edificarHotel(otracasilla)){
                                           System.out.println("\nHas edificado un hotel");
                                        }else{
                                            System.out.println("\nNo puedes edificar un hotel");
                                        }
                                        break;
                                    
                                    case 3:
                                        if(juego.venderPropiedad(otracasilla)){
                                            System.out.println("\nHas vendido una propiedad");
                                        }else{
                                            System.out.println("\nNo has podido vender la propiedad");
                                        }
                                        
                                        break;
                                        
                                    case 4: 
                                        if(juego.hipotecarPropiedad(otracasilla)){
                                            System.out.println("\nHas hipotecado una propiedad");
                                        }else{                                            
                                            System.out.println("\nNo puedes hipotecar la propiedad seleccionada");
                                        }
                                        break;
                                        
                                    case 5: 
                                        if(juego.cancelarHipoteca(unacasilla)){
                                            System.out.println("\nHas cancelado la hipoteca correctamente");
                                        }else{
                                            System.out.println("\nNo se ha podido cancelar la hipoteca");
                                        }  
                                        break;
                                }
                                
                        }while ( !(opcion == 0 || !jugador.tengoPropiedades() ) );      
                    }
                }
            }
      
            
            
            if ( !bancarrota ){
                Scanner in = new Scanner(System.in);
                System.out.println(jugador.toString());
                System.out.println("\nPulse cualquier tecla para continuar");
                in.nextLine();
                System.out.println("****** SIGUIENTE JUGADOR ******");
                jugador = juego.siguienteJugador();
                System.out.println(jugador.toString());
            }
           
        }while ( !bancarrota );
        
        
        ArrayList puestos = new ArrayList();
        puestos = juego.obtenerRanking();
       
    
    }
    
    public Casilla elegirPropiedad(ArrayList<Casilla> propiedades){ 
        //este metodo toma una lista de propiedades y genera una lista de strings, con el numero y nombre de las propiedades
        //luego llama a la vista para que el usuario pueda elegir.
        vista.mostrar("\tCasilla\tTitulo");
        int seleccion;
        ArrayList<String> listaPropiedades= new ArrayList();
        for ( Casilla casilla: propiedades) {
        listaPropiedades.add( "\t"+casilla.getNumeroCasilla()+"\t"+((Calle)casilla).getTituloPropiedad().getNombre());
        }
        seleccion=vista.menuElegirPropiedad(listaPropiedades);  
        return (Calle)propiedades.get(seleccion);
        }
    
    
    public static void main(String[] args) {
      
        ControladorTextualQytetet controlador =  new ControladorTextualQytetet();
        controlador.inicializacionJuego();
        controlador.desarrolloJuego();
      
      
     
      
    }
 
}
