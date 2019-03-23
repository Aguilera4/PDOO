/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;
import java.util.ArrayList;

/**
 *
 * 
 */
public class Tablero {
    private ArrayList <Casilla> casillas = new ArrayList();
    private Casilla carcel;

    public Tablero() {
        inicializar();
    }

    public Casilla getCarcel() {
        return carcel;
    }
    
    public Boolean esCasillaCarcel(int numeroCasilla){
        
        return numeroCasilla == carcel.getNumeroCasilla();
    }
    
    Casilla obtenerCasillaNumero(int numeroCasilla){
       
        return casillas.get(numeroCasilla);
    }
    
    Casilla obtenerNuevaCasilla(Casilla casilla, int desplazamiento){
        
        return casillas.get((casilla.getNumeroCasilla() + desplazamiento-1)%casillas.size());
    }

    @Override
    public String toString() {
        return "\n******TABLERO******\n" + casillas + "\n";       
    }
    
    public void inicializar() {
        
        casillas.add(new OtraCasilla(1, 0, TipoCasilla.SALIDA));
        casillas.add(new Calle(2, 400, 0, 0, new TituloPropiedad ("Abad", 50, 0.10, 400, 300)));
        casillas.add(new OtraCasilla(3, 0, TipoCasilla.SORPRESA));
        casillas.add(new Calle(4, 500, 0, 0, new TituloPropiedad ("Elvira", 70, 0.15, 300, 250)));
        casillas.add(new OtraCasilla(5, 0, TipoCasilla.PARKING));
        casillas.add(new Calle(6, 1300, 0, 0, new TituloPropiedad ("Maitena", 85, 0.13, 600, 450)));
        casillas.add(new Calle(7, 1000, 0, 0, new TituloPropiedad ("Bolivia", 60, 0.12, 200, 400)));
        casillas.add(new Calle(8, 300, 0, 0,  new TituloPropiedad ("Cadiar", 85, 0.15, 500, 350)));
        casillas.add(new OtraCasilla(9, 0, TipoCasilla.CARCEL));
        casillas.add(new Calle(10, 2000, 0, 0, new TituloPropiedad ("Duero", 90, 0.17, 150, 600)));
        casillas.add(new Calle(11, 600, 0, 0,  new TituloPropiedad ("Ecuador", 50, 0.11, 250, 550)));
        casillas.add(new OtraCasilla(12, 0, TipoCasilla.JUEZ));
        casillas.add(new Calle(13, 1200, 0, 0,  new TituloPropiedad ("Fatima", 70, 0.18, 650, 450)));
        casillas.add(new OtraCasilla(14, 0, TipoCasilla.SORPRESA));
        casillas.add(new Calle(15, 1500, 0, 0,  new TituloPropiedad ("Galileo", 100, 0.20, 300, 250)));
        casillas.add(new OtraCasilla(16, -2000, TipoCasilla.IMPUESTO));
        casillas.add(new Calle(17, 1700, 0, 0,  new TituloPropiedad ("Horacio", 60, 0.15, 500, 400)));
        casillas.add(new Calle(18, 700, 0, 0,  new TituloPropiedad ("Imperio", 95, 0.19, 550, 750)));
        casillas.add(new OtraCasilla(19, 0, TipoCasilla.SORPRESA));
        casillas.add(new Calle(20, 2000, 0, 0,  new TituloPropiedad ("Jativa", 100, 0.20, 1000, 750)));
        
        
        carcel=casillas.get(8);
        
    }
    
    
    
}
