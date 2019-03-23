/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
/**
 *
 * 
 */
public class Qytetet {
    
    public int MAX_JUGADORES = 4;
    int MAX_CARTAS = 10;
    int MAX_CASILLAS = 20;
    static final int PRECIO_LIBERTAD = 200;
    static final int SALDO_SALIDA = 1000;
    private Sorpresa cartaActual;
    ArrayList<Sorpresa> mazo = new ArrayList();
    private ArrayList<Jugador> jugadores = new ArrayList();
    private Jugador jugadorActual;
    Tablero tablero;
    GUIQytetet.Dado dado = GUIQytetet.Dado.getInstance();
    
    private static final Qytetet instance = new Qytetet();
    private Qytetet() {
        //inicializarCartasSorpresa();
        //inicializarTablero();
    }
    public static Qytetet getInstance() {
        return instance;
    }
    
    public Boolean aplicarSorpresa(){
               
        Boolean tienePropietario = false;
        Boolean esCarcel;
        
        if ( null != cartaActual.getTipo() )switch (cartaActual.getTipo()) {
            case PAGARCOBRAR:
                jugadorActual.modificarSaldo(cartaActual.getValor());
                break;
            case IRACASILLA:
                esCarcel = tablero.esCasillaCarcel(cartaActual.getValor());
                if ( esCarcel )
                {
                    this.encarcelarJugador();
                }
                else{
                    Casilla nuevaCasilla = tablero.obtenerCasillaNumero(cartaActual.getValor()-1);
                    tienePropietario=  jugadorActual.actualizarPosicion(nuevaCasilla);
                }
                break;
            case PORCASAHOTEL:
                jugadorActual.pagarCobrarPorCasaYHotel(cartaActual.getValor());
                break;
            case PORJUGADOR:
                for ( Jugador jugador: jugadores ){
                    if ( jugador != jugadorActual){
                        jugador.modificarSaldo(-cartaActual.getValor());
                        jugadorActual.modificarSaldo(cartaActual.getValor());
                    }
                }   break;
            case CONVERTIRME:
                Especulador especulador = jugadorActual.convertirme(cartaActual.getValor());
                int i = jugadores.indexOf(jugadorActual);
                jugadores.set(i, especulador);
                System.out.println("FACTORESPECULADOR: " + jugadorActual.getFactorEspeculador() + "\n");
                jugadorActual = especulador;
                break;
            default:
                break;
        }
        if ( cartaActual.getTipo() == TipoSorpresa.SALIRCARCEL){
            jugadorActual.setCartaLibertad(cartaActual);
            mazo.add(cartaActual);
        }
        mazo.add(cartaActual);
        Collections.shuffle(mazo);
        cartaActual=null;
        return tienePropietario;
    }
    
    
    
    public Boolean cancelarHipoteca(Casilla casilla){
        Boolean aux=false;
        if (((Calle)casilla).estaHipotecada()){
        
        int cantidad = ((Calle)casilla).getCosteHipoteca();
        cantidad=(int) (cantidad+cantidad*0.1);
        
        if (jugadorActual.tengoSaldo(cantidad)){          
          ((Calle)casilla).getTituloPropiedad().setHipotecada(false);
          jugadorActual.modificarSaldo(-cantidad);
          aux=true;
        }
          
        }
        return aux;
    }
    
    
    
    
    public Boolean comprarTituloPropiedad(){
        Boolean puedoComprar = false;
        puedoComprar = jugadorActual.comprarTitulo();
        
        return puedoComprar;
    }
    
    
    
    
    public  Boolean edificarCasa(Casilla casilla){
        Boolean puedoEdificar = false;
        Boolean puedoEdificarCasa;
        Boolean sePuedeEdificar=false;
        int costeEdificar;
        
        if (casilla.soyEdificable()){
           
            sePuedeEdificar = ((Calle)casilla).sePuedeEdificarCasa(jugadorActual.getFactorEspeculador());
            
            if ( sePuedeEdificar ){
                puedoEdificar = jugadorActual.puedoEdificarCasa(((Calle)casilla));
                
                if ( puedoEdificar ){
                    costeEdificar = ((Calle)casilla).edificarCasa();
                    jugadorActual.modificarSaldo(-costeEdificar);
                } 
            }     
        }
        puedoEdificarCasa = puedoEdificar;
        
        return puedoEdificarCasa;
        
      }    
       
    public Boolean edificarHotel(Casilla casilla){
        
        Boolean puedoEdificar = false;
        
        if ( ((Calle)casilla).getNumCasas() >= 4 ){
        
        Boolean sePuedeEdificar = false;
        
        if ( casilla.soyEdificable() ){
            sePuedeEdificar = ((Calle)casilla).sePuedeEdificarHotel(jugadorActual.getFactorEspeculador());
            
            if ( sePuedeEdificar ){
                puedoEdificar = jugadorActual.puedoEdificarHotel(((Calle)casilla));
                
                if ( puedoEdificar ){
                    int costeEdificarHotel = ((Calle)casilla).edificarHotel();
                    jugadorActual.modificarSaldo(-costeEdificarHotel);   
                }   
            }   
        }
        }
        
        return puedoEdificar;
    }
    
    public Sorpresa getCartaActual(){
        return cartaActual;
    }
    
    public Jugador getJugadorActual(){
        return this.jugadorActual;
    }
    
    ArrayList<Jugador> getJugadores(){
        
        return jugadores;
    }
    
    public Boolean hipotecarPropiedad(Casilla casilla){
        Boolean puedoHipotecarPropiedad = false;
        Boolean sePuedeHipotecar = false;
        Boolean puedoHipotecar = false;
        int cantidadRecibida;
        
        if(casilla.soyEdificable()){
            sePuedeHipotecar = !((Calle)casilla).estaHipotecada();
            
            if(sePuedeHipotecar){
                puedoHipotecar = jugadorActual.puedoHipotecar(casilla);
                
                if(puedoHipotecar){
                    cantidadRecibida = ((Calle)casilla).hipotecar();
                    jugadorActual.modificarSaldo(cantidadRecibida);
                }
            }
        }
        
        return puedoHipotecarPropiedad;
    }
    
    public void inicializarJuego(ArrayList<String> nombres){
        inicializarJugadores(nombres);
        inicializarCartasSorpresa();
        inicializarTablero();
        salidaJugadores();
    }
    
      
    private void inicializarJugadores(ArrayList<String> nombres ){
        
        for(int i = 0; i < nombres.size(); i++)
            jugadores.add(new Jugador(nombres.get(i)));
    }
    
       private void inicializarCartasSorpresa(){

        mazo.add(new Sorpresa ("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", 9, TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("Un fan anónimo ha pagado tu fianza. Sales de la cárcel", 0, TipoSorpresa.SALIRCARCEL)); 
        mazo.add(new Sorpresa ("¡Estás de suerte!, tu jefe te ha dado una bonificación de 500 €",500, TipoSorpresa.PAGARCOBRAR));
        mazo.add(new Sorpresa ("Lo sentimos, un desconocido te ha robado 500 €",-500, TipoSorpresa.PAGARCOBRAR));
        mazo.add(new Sorpresa ("¡Ups!, al parecer se te ha caído algo por el camino",5, TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("Un conocido se ha ofrecido a llevarte en coche",13, TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("¡Hoy es tu cumpleaños!, el resto de jugadores te invitan a cenar",100, TipoSorpresa.PORJUGADOR));
        mazo.add(new Sorpresa ("Dada tu situación económica, ayudas al resto de jugadores",-100, TipoSorpresa.PORJUGADOR));
        mazo.add(new Sorpresa ("Paga por cada casa 50 y el doble por cada hotel", 50,TipoSorpresa.PORCASAHOTEL ));
        mazo.add(new Sorpresa ("Te devolvemos 10 euros por cada casa y el doble por cada hotel", 10,TipoSorpresa.PORCASAHOTEL));
        mazo.add(new Sorpresa ("Evolucionas a especulador",3000,TipoSorpresa.CONVERTIRME));
        mazo.add(new Sorpresa ("Tus buenas inversiones, te convierten en especulador",5000,TipoSorpresa.CONVERTIRME ));
                
        Collections.shuffle(mazo);
        
    }
       
        private void inicializarTablero(){
        tablero=new Tablero();
    }
        
        private void salidaJugadores(){
        
        Casilla inicio=new OtraCasilla(1, 0, TipoCasilla.SALIDA);
        
        //Coloco a los jugadores en la casilla de salida
        for (int i = 0; i < jugadores.size(); i++){
            jugadores.get(i).setCasillaActual(inicio);
            jugadores.get(i).setSaldo(7500);
        }
        //Le doy el turno a uno de ellos de forma aleatoria
        int j;
        j = (int) (Math.random() * (jugadores.size()-1));
        jugadorActual = jugadores.get(j);
    }
  
    public Boolean intentarSalirCarcel(MetodoSalirCarcel metodo){
      Boolean libre = false;
      
      if ( metodo == MetodoSalirCarcel.TIRANDODADO){
          int valorDado = GUIQytetet.Dado.getInstance().nextNumber();
          libre = valorDado >= 5;
      }
      else if( metodo == MetodoSalirCarcel.PAGANDOLIBERTAD){
          Boolean tengoSaldo = jugadorActual.pagarLibertad(-Qytetet.PRECIO_LIBERTAD);
          if ( tengoSaldo){
          libre = true;
          }
          
      }
      
      if ( libre ){
          jugadorActual.setEncarcelado(false);
      }
      
      return libre;
 
    }
    
    public Boolean Jugar(){
     
        int valorDado = GUIQytetet.Dado.getInstance().nextNumber();     
        
        Casilla casillaPosicion = jugadorActual.getCasillaActual();
        Casilla nuevaCasilla = tablero.obtenerNuevaCasilla(casillaPosicion, valorDado);
        Boolean tienePropietario = jugadorActual.actualizarPosicion(nuevaCasilla);
        
        if ( !nuevaCasilla.soyEdificable() ){
            if( null != ((OtraCasilla)nuevaCasilla).getTipo())
                switch (((OtraCasilla)nuevaCasilla).getTipo()) {
                case JUEZ:
                    System.out.println("\nHas caido en el Juez, vas a la cárcel");
                    this.encarcelarJugador();
                    break;
                case SORPRESA:
                    cartaActual = mazo.get(0);
                    System.out.println("\nSORPRESA!\n" + cartaActual.toString());
                    break;
                case PARKING:
                    System.out.println("\nHas caido en el PARKING");
                    break;
                case CARCEL:
                    System.out.println("\nCárcel, solo visitas");
                    break;
                case IMPUESTO:
                    jugadorActual.modificarSaldo(jugadorActual.getCasillaActual().getCoste());
                    break;
                default:
                    break;
            }            
        }else{
            System.out.println("\nHas caido en:"+nuevaCasilla.toString());
        }
        
        
        return tienePropietario;
    }
    
    public ArrayList<Jugador> obtenerRanking(){
        ArrayList <Jugador> ranking = new ArrayList();
        int capital;
        
        
        // Preguntar add
        for ( Jugador jugador : jugadores){
            capital = jugador.obtenerCapital();
            ranking.add(jugador);
        }
        
        return ranking;
    }
    
    public ArrayList<Casilla> propiedadesHipotecadasJugador(boolean hipotecadas){
        
        ArrayList<Casilla> cas = new ArrayList();
                    
        ArrayList<TituloPropiedad> titulosjugador = new ArrayList();

        titulosjugador = jugadorActual.obtenerPropiedadesHipotecadas(hipotecadas);   

        for( TituloPropiedad titpro : titulosjugador){
            cas.add(titpro.getCasilla());
        }
        
        return cas;           
    }
    
    public Jugador siguienteJugador(){
        
        int i = 0;
        
        i = jugadores.indexOf(jugadorActual);
            
           
            int i2 = (i + 1 ) % jugadores.size();
            jugadorActual = jugadores.get(i2);
        
        return jugadorActual;
       
        
    }
        
    
    
    public Boolean venderPropiedad(Casilla casilla){
        Boolean puedoVender = false;
        
        if (casilla.soyEdificable() ){
            puedoVender = jugadorActual.puedoVenderPropiedad(((Calle)casilla));
            if (puedoVender){
                jugadorActual.venderPropiedad(((Calle)casilla));
            }
        }
            return puedoVender;
    }
    
    private void encarcelarJugador(){
        Casilla casillaCarcel;
        Sorpresa carta;
        if (!jugadorActual.tengoCartaLibertad()){
            casillaCarcel = tablero.getCarcel();
            jugadorActual.irACarcel(casillaCarcel);
        }
        else{
            carta = jugadorActual.devolverCartaLibertad();
            mazo.add(carta);
        }

    }
    
 
   
    

    @Override
    public String toString() {
        return this.jugadores.toString() + "\n******Sorpresa******\n" + this.mazo.toString() + '\n' + this.tablero.toString();
    }
    
    
    
}
