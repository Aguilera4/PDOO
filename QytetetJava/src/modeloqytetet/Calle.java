/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloqytetet;


public class Calle extends Casilla{
    
    private int numHoteles = 0;
    private int numCasas = 0;
    private TituloPropiedad titulo;
    
    Calle (int numeroCasilla, int coste, int numHoteles, int numCasas, TituloPropiedad titulo) {
       super(numeroCasilla,coste);
       this.numHoteles = numHoteles;
       this.numCasas = numCasas;
       this.titulo = titulo;
       this.titulo.setCasilla(this);     
    }
    
     int getNumHoteles() {
       return numHoteles;
    }

    int getNumCasas() {
       return numCasas;
    }
    
    public TituloPropiedad getTituloPropiedad() {
       return titulo;
    }
    
   public boolean soyEdificable(){
       return !titulo.getHipotecada();
    }

    void setNumHoteles(int numHoteles) {
       this.numHoteles = numHoteles;
    }

    void setNumCasas(int numCasas) {
       this.numCasas = numCasas;
    }

    private void setTitulo(TituloPropiedad titulo) {
       this.titulo = titulo;
    }
    
    int costeAlquilerBase(){
        return titulo.getAlquilerBase();
    } 
    
     public TituloPropiedad asignarPropietario(Jugador propietario){

       titulo.setPropietario(propietario);
       return titulo;
    }
    
    int calcularValorHipoteca(){
        return titulo.getHipotecaBase() + (int)(numCasas * 0.5 * titulo.getAlquilerBase()+ this.numHoteles  * titulo.getAlquilerBase());
    }
    
    int cancelarHipoteca(){
       titulo.setHipotecada(false);
       int cantidadRecibida = this.calcularValorHipoteca();
       
       return cantidadRecibida;
    }
    
    int cobrarAlquiler(){
        int costeAlquilerBase;
        int costeAlquiler;
        
        costeAlquilerBase =  titulo.getAlquilerBase();
        costeAlquiler = costeAlquilerBase + (int) (numCasas * 0.5 + numHoteles * 2);
   
        titulo.cobrarAlquiler(costeAlquiler);    
        
        return costeAlquiler;
    }
    
    public int edificarCasa(){
        int costeEdificarCasa;
        setNumCasas(numCasas+1);
        costeEdificarCasa = titulo.getPrecioEdificar();
        
        return costeEdificarCasa;
    }
    
    int edificarHotel(){
        setNumHoteles(numHoteles+1);
        int costeEdificarHotel = titulo.getPrecioEdificar();

        return costeEdificarHotel;
    }
    
    boolean estaHipotecada(){
        return titulo.getHipotecada();
    }
    
    int getCosteHipoteca(){
       int cantidad = titulo.getHipotecaBase() + (int) (numCasas * 0.5 * titulo.getHipotecaBase()) + (numHoteles * titulo.getHipotecaBase());
       return cantidad;
    }
    
    int getPrecioEdificar(){
        return titulo.getPrecioEdificar();
    }
    
    int hipotecar(){
        titulo.setHipotecada(true);
        int cantidadRecibida = this.calcularValorHipoteca();
       
        return cantidadRecibida;
    }
    
    int precioTotalComprar(){
        return titulo.getAlquilerBase();
    }
    
    Boolean propietarioEncarcelado(){
        return titulo.propietarioEncacelado();
    }
    
    Boolean sePuedeEdificarCasa(int factorEspeculador){
        return getNumCasas()<4*factorEspeculador;

    }
    
    Boolean sePuedeEdificarHotel(int factorEspeculador){
        Boolean aux = this.getNumHoteles()<4*factorEspeculador; 
        if(aux){
            numCasas-=4;
        }
        return aux;

    }
    
     Boolean tengoPropietario(){
       return titulo.tengoPropietario();
    }

    int venderTitulo(){
        
        titulo.setPropietario(null);
        this.setNumHoteles(0);
        this.setNumCasas(0);
        int precioCompra = coste + (numCasas + numHoteles ) * titulo.getPrecioEdificar();
        int precioVenta =  (int)( precioCompra + titulo.getFactorRevaloracion()*precioCompra);
        
        return precioVenta;    
    }
    
    @Override
    public String toString(){
        return " numero: " + getNumeroCasilla()  + ",\n coste: " + getCoste() + titulo +",\n numCasas=" + numCasas + ",\n numHoteles=" + numHoteles + "\n";
    }
    
}
