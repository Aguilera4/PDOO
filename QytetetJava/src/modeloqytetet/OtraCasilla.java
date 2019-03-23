/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;



public class OtraCasilla extends Casilla{
        public final TipoCasilla tipo;
    
    public OtraCasilla(int numeroCasilla, int coste,  TipoCasilla tipo_) {
        super(numeroCasilla, coste);
        tipo = tipo_;
    }
    
    public TipoCasilla getTipo() {
        return tipo;
    }

        @Override
   public boolean  soyEdificable(){
        return false;
    }
    
        @Override
    public String toString(){
        return "Numero: " + getNumeroCasilla() + ", tipo: " + getTipo() ;
    }
    
}
