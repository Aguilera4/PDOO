/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;

public class Especulador extends Jugador{
    
    private int fianza;
    
    protected Especulador(Jugador jugador, int fianza_) {
        super(jugador);
        this.fianza=fianza_;
    }
    
    @Override
    protected int getFactorEspeculador(){
        return FactorEspeculador*2;
    }
    
    
    @Override
    protected void pagarImpuestos(int cantidad){
        super.pagarImpuestos(cantidad/this.FactorEspeculador);
        
    }
    
    @Override
    protected void irACarcel(Casilla casilla) {
        System.out.println("IR A CARCEL ESPECULADOR");
        boolean pfianza=pagarFianza(fianza);
        
        if(pfianza){
            System.out.println("\nHas podido salir, al ser especulador pagando" + fianza);
            super.modificarSaldo(-fianza);
        }
        else{
            super.irACarcel(casilla);
        }
    }    
    
    @Override
    protected Especulador convertirme(int fianza_){
        super.convertirme(fianza_);
        return this;
    }
    
    private Boolean pagarFianza(int cantidad){  
        System.out.println("*****" + this.tengoSaldo(cantidad));
        return this.tengoSaldo(cantidad);
    }
    
      @Override
    public String toString() {
        return super.toString() + " **ESPECULADOR**" + "\n\n";
    }
    
    
        
}
