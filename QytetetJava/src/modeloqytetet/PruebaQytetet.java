/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;
import java.awt.List;
import java.util.ArrayList;
import java.util.Collections;
/**
 *
 */
public class PruebaQytetet {
    private static ArrayList <Sorpresa> mazo = new ArrayList();
    private static void inicializarSorpresas() {
        mazo.add(new Sorpresa ("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", tablero.getCarcel().getNumeroCasilla(), TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("Un fan anónimo ha pagado tu fianza. Sales de la cárcel", 0, TipoSorpresa.SALIRCARCEL)); 
        mazo.add(new Sorpresa ("¡Estás de suerte!, tu jefe te ha dado una bonificación de 500 €",500, TipoSorpresa.PAGARCOBRAR));
        mazo.add(new Sorpresa ("Lo sentimos, un desconocido te ha robado 500 €",-500, TipoSorpresa.PAGARCOBRAR));
        mazo.add(new Sorpresa ("¡Ups!, al parecer se te ha caído algo por el camino",5, TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("Un conocido se ha ofrecido a llevarte en coche",13, TipoSorpresa.IRACASILLA));
        mazo.add(new Sorpresa ("¡Hoy es tu cumpleaños!, invitas el resto de jugadores a una cena",100, TipoSorpresa.PORJUGADOR));
        mazo.add(new Sorpresa ("Dada tu situación económica, el resto de jugadores han decidido ayudarte",100, TipoSorpresa.PORJUGADOR));
        mazo.add(new Sorpresa ("Paga por cada casa 50 y el doble por cada hotel", 50,TipoSorpresa.PORCASAHOTEL ));
        mazo.add(new Sorpresa ("Te devolvemos 10 euros por cada casa y el doble por cada hotel", 10,TipoSorpresa.PORCASAHOTEL));
        Collections.shuffle(mazo);
    }
    
 
    
    private static Tablero tablero = new Tablero();
    
   /* 
     public static ArrayList  NumeroMayor0(){
        ArrayList <Sorpresa> p = new ArrayList();
        
        for (Sorpresa i:p){
            if(i.getValor() > 0){
                p.add(i);
            }
        }
        return p;
    }
    
    public static ArrayList Sorpresa_IRACASILLA(){
        ArrayList <Sorpresa> m = new ArrayList();
        
        for (Sorpresa i:m){
            if(i.getTipo() == TipoSorpresa.IRACASILLA){
                m.add(i);
            }            
        }
        
        return m;
    }
    
    public static ArrayList Sorpresa_Parametro(TipoSorpresa tipo){
        ArrayList <Sorpresa> c= new ArrayList();
        
        for ( Sorpresa i:c){
            if(i.getTipo() == tipo){
                c.add(i);                
            }
        }
        return c;
    }*/
    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        //TODO code application logic here
        
        OtraCasilla c= new OtraCasilla(1, 0, TipoCasilla.SALIDA);
        Casilla cas;
        cas=c;
        cas.soyEdificable();
        
        
        System.out.println(cas.soyEdificable());
//        
//      Qytetet juego = Qytetet.getInstance();
//      
//      ArrayList<String> jug = new ArrayList();
//      
//      jug.add("Javi");
//      jug.add("Sergio");
//      jug.add("Christian");
//      
//      juego.inicializarJuego(jug);
//      
//      Casilla casilla = juego.tablero.obtenerCasillaNumero(7);
//
//      System.out.println(juego.getJugadorActual());
//      
//      juego.getJugadorActual().actualizarPosicion(casilla);
//        
//      juego.comprarTituloPropiedad();
//      
//      System.out.println(juego.getJugadorActual());
//      
//      juego.edificarCasa(casilla);
//      System.out.println(juego.getJugadorActual());
//      
      
    }
    
}
