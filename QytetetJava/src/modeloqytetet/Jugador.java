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
public class Jugador {
    
    private Casilla casillaActual = null;
    private Sorpresa cartaLibertad;
    private ArrayList <TituloPropiedad> propiedades = new ArrayList();
    private Boolean encarcelado = false;
    private final String nombre;
    private int saldo = 7500;
    static int FactorEspeculador=1;
    
    private Jugador(Casilla casillaActual, Sorpresa cartaLibertad, Boolean encarcelado, String nombre, ArrayList <TituloPropiedad> propiedades){
        this.casillaActual = casillaActual;
        this.cartaLibertad = cartaLibertad;
        this.encarcelado = encarcelado;
        this.nombre = nombre;
        this.propiedades = propiedades;
    }
    
     
    Jugador(String nombre){
        this.nombre = nombre; 
    }
     
    public Jugador(Jugador nuevo){

       this.casillaActual=nuevo.casillaActual;
       this.cartaLibertad=nuevo.cartaLibertad;
       this.FactorEspeculador = FactorEspeculador;
       this.encarcelado=nuevo.encarcelado;
       this.nombre=nuevo.nombre;
       this.saldo=nuevo.saldo;
       
       
       for( TituloPropiedad i : nuevo.propiedades){
           this.propiedades.add(i);
       }
       
    }
    
    void pagarImpuestos(int cantidad){     
        modificarSaldo(-cantidad);
    }
    
    Especulador convertirme(int fianza){ 
        Especulador nuevo=new Especulador(this,fianza);
        return nuevo;
    }
    
    int getFactorEspeculador(){
        return FactorEspeculador;
    }
   

    public Casilla getCasillaActual() {
        return casillaActual;
    }
    
    public String getNombre(){
        return this.nombre;
    }

    public Boolean getEncarcelado() {
        return encarcelado;
    }

    void setCasillaActual(Casilla casillaActual) {
        this.casillaActual = casillaActual;
    }

    void setCartaLibertad(Sorpresa cartaLibertad) {
        this.cartaLibertad = cartaLibertad;
    }

    void setEncarcelado(Boolean encarcelado) {
        this.encarcelado = encarcelado;
    }
    
    public Boolean tengoPropiedades() {
        
        return !propiedades.isEmpty();
    }
    
    Boolean actualizarPosicion(Casilla casilla) {
        
        Boolean tengoPropietario = false;
        Boolean encarcelado = false;
        
        if (casilla.getNumeroCasilla() < casillaActual.getNumeroCasilla() ){
            modificarSaldo(Qytetet.SALDO_SALIDA);
        }
        
        setCasillaActual(casilla);
        
            if (  casilla.soyEdificable() ){
                tengoPropietario = ((Calle)casilla).tengoPropietario();
            
                if(tengoPropietario){
                  encarcelado = ((Calle)casilla).propietarioEncarcelado();
                  
                    if (!encarcelado){
                        int costeAlquiler = ((Calle)casilla).cobrarAlquiler();
                        System.out.println("\nPagas: " + costeAlquiler );
                        pagarImpuestos(costeAlquiler);                        
                    }
                }
            }        
            else{
                if ( ((OtraCasilla)casilla).getTipo() == TipoCasilla.IMPUESTO){
                    
                    int coste =casilla.getCoste();
                    pagarImpuestos(coste);
                }
            }  
       
            return tengoPropietario;
            
            
    }
  
    Boolean comprarTitulo() {
        Boolean puedoComprar = false;
        Boolean tengoPropietario = false;
        TituloPropiedad titulo;
        int costeCompra;
        
        if ( casillaActual.soyEdificable()){
            tengoPropietario = ((Calle)casillaActual).tengoPropietario();
            
            if( !tengoPropietario){
                costeCompra = casillaActual.getCoste();
                
                if (costeCompra <= saldo){
                    titulo = ((Calle)casillaActual).asignarPropietario(this);
                    propiedades.add(titulo);
                    this.modificarSaldo(-costeCompra);
                    puedoComprar = true;
                }    
            }
        }
        return puedoComprar;

    }
    
    Sorpresa devolverCartaLibertad() {
        
        Sorpresa cartaAux;
        cartaAux = new Sorpresa(cartaLibertad.getTexto(),cartaLibertad.getValor(),cartaLibertad.getTipo());
        
        cartaLibertad=null;
        
        return cartaAux;
        
    }
    
    void irACarcel(Casilla casilla) {
        System.out.println("IR A CARCEL JUGADOR");
        this.setCasillaActual(casilla);
        this.setEncarcelado(true);
    }
    
    public void modificarSaldo(int cantidad) {
        saldo+=cantidad;
    }
    
    int obtenerCapital() {
        
        int suma=saldo;
        
        for(TituloPropiedad i : propiedades ){
            
            if(!i.getHipotecada()){
                suma+= i.getAlquilerBase()+i.getPrecioEdificar()*(((Calle)i.getCasilla()).getNumCasas()+((Calle)i.getCasilla()).getNumHoteles());
            }
        }
        return suma;
    }
    
    ArrayList<TituloPropiedad> obtenerPropiedadesHipotecadas(Boolean hipotecada) {
        
        ArrayList<TituloPropiedad> aux = new ArrayList();
        
        for(TituloPropiedad titpro : propiedades){
            
            if( titpro.getHipotecada() == hipotecada ){
                aux.add(titpro);
            }
            else
                aux.add(titpro);
        }

        return aux;
    }
    
    void pagarCobrarPorCasaYHotel(int cantidad) {
        int numeroTotal = this.cuantasCasasHotelesTengo();
        this.modificarSaldo(numeroTotal);
    }
    
    Boolean pagarLibertad(int cantidad){
        Boolean tengoSaldo = this.tengoSaldo(cantidad);
        if ( tengoSaldo ){
            this.modificarSaldo(cantidad);
        }
        return tengoSaldo;
    }
    
    Boolean puedoEdificarCasa(Casilla casilla) {
      
        Boolean tengoSaldo = false;  
        Boolean esMia = this.esDeMiPropiedad(casilla);
        
        if ( esMia ){
           int costeEdificarCasa = ((Calle)casilla).getPrecioEdificar();
            tengoSaldo = this.tengoSaldo(costeEdificarCasa);
        }
       return tengoSaldo;
    }
    
    Boolean puedoEdificarHotel(Casilla casilla){
        Boolean esMia = this.esDeMiPropiedad(casilla);    
        Boolean tengoSaldo = false;
        
        if ( esMia ){
            int costeEdificarHotel =  ((Calle)casilla).getPrecioEdificar();
            tengoSaldo =  this.tengoSaldo(costeEdificarHotel);
        }
        
        return tengoSaldo;
    }
    
    Boolean puedoHipotecar(Casilla casilla){
      boolean puedoHipotecar=false;
             
        if(((OtraCasilla)casilla).getTipo()==TipoCasilla.CALLE){
            if(propiedades.indexOf(((Calle)casilla).getTituloPropiedad()) != -1)
                puedoHipotecar=true;
        }
        return puedoHipotecar;
    }
    
    Boolean puedoPagarHipoteca(Casilla casilla){
      Boolean valorHipoteca = false;
      
      if ( ((Calle)casilla).getCosteHipoteca() < this.saldo ){
          
        this.modificarSaldo(-((Calle)casilla).cancelarHipoteca());
          valorHipoteca = true;
      }
      return valorHipoteca;
    }
    
    
    
    Boolean puedoVenderPropiedad(Casilla casilla){
        Boolean esMia = false;
        Boolean hipotecada = false;
        
       esMia = this.esDeMiPropiedad(casilla);
       hipotecada = ((Calle)casilla).estaHipotecada();
       
       return esMia && !hipotecada;
       
       
    }
    
    public Boolean tengoCartaLibertad(){
        
        return cartaLibertad!=null;
    }
    
    void venderPropiedad(Casilla casilla){
        int precioVenta = ((Calle)casilla).venderTitulo();
        this.modificarSaldo(precioVenta);
        this.eliminarDeMisPropiedades(casilla);
    }
    
    private int cuantasCasasHotelesTengo(){
        
        int sum=0;
        
        for(TituloPropiedad titpro : propiedades){
            sum+= ((Calle)titpro.getCasilla()).getNumCasas()+((Calle)titpro.getCasilla()).getNumHoteles();
        }
        
        return sum;
    }
    
    private void eliminarDeMisPropiedades(Casilla casilla){
        
        if(esDeMiPropiedad(casilla)){
           int a = propiedades.indexOf(((Calle)casilla).getTituloPropiedad());
           propiedades.remove(a);
        }
    }
    
    private Boolean esDeMiPropiedad(Casilla casilla){
        
        for(TituloPropiedad cas: propiedades ){
            
            if(cas.getCasilla().getNumeroCasilla()==casilla.getNumeroCasilla()){
                return true;
            }
        }
        return false;
    }
    
    public Boolean tengoSaldo(int cantidad){
        return saldo  >= cantidad;
    }  

    @Override
    public String toString() {
        return "\n******JUGADOR******\n"+ " nombre=" + nombre +  ",\n cartaLibertad=" + cartaLibertad + ",\n propiedades=" + propiedades + ",\n encarcelado=" + encarcelado + ",\n saldo=" + saldo +  "\n";
    }

    void setSaldo(int i) {
        saldo=i;
    }

}
