/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;

/**
 *
 * 
 */
public abstract class Casilla {
    
    private final int numeroCasilla;
    public final int coste;

 
    
    Casilla (int numeroCasilla, int coste) {
        this.numeroCasilla = numeroCasilla;
        this.coste = coste;       
    }

    public int getNumeroCasilla() {
        return numeroCasilla;
    }

    int getCoste() {
        return coste;
    }
    
    
   public  abstract boolean soyEdificable();



    

    
    
    
}
