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
public class TituloPropiedad {
  private Casilla casilla;
  private Jugador propietario;
  private String nombre;
  private Boolean hipotecado = false;
  private int alquilerBase;
  private double factorRevaloracion;
  private int hipotecaBase;
  private int precioEdificar;
  
  TituloPropiedad (String nombre, int alquilerBase, double factorRevaloracion, int hipotecaBase, int precioEdificar) {
      this.nombre = nombre;
      this.alquilerBase = alquilerBase;
      this.factorRevaloracion = factorRevaloracion;
      this.hipotecaBase = hipotecaBase;
      this.precioEdificar = precioEdificar;
  }
    
    Casilla getCasilla(){
        return casilla;
    }
    
    public String getNombre() {
        return nombre;
    }

    Boolean getHipotecada() {
        return hipotecado;
    }

    int getAlquilerBase() {
        return alquilerBase;
    }

    double getFactorRevaloracion() {
        return factorRevaloracion;
    }

    int getHipotecaBase() {
        return hipotecaBase;
    }

    int getPrecioEdificar() {
        return precioEdificar;
    }

    void setHipotecada(Boolean hipotecado) {
        this.hipotecado = hipotecado;
    }
    
    Boolean propietarioEncacelado() {
        return propietario.getEncarcelado();
    }
    
    void cobrarAlquiler(int coste) {
        propietario.modificarSaldo(coste);
    }
    
    Boolean tengoPropietario() {
        return propietario != null;
    }
    
    void setCasilla(Casilla casilla) {
        this.casilla = casilla;
    }

    void setPropietario(Jugador propietario) {
        this.propietario = propietario;
    }
    
    @Override
    public String toString() {
        return "{ calle= " + nombre + ", hipotecado= " + hipotecado + ", alquilerBase= " + alquilerBase + ", factorRevaloracion= " + factorRevaloracion + ", hipotecaBase= " + hipotecaBase + ", precioEdificar= " + precioEdificar + '}';
    }
    
    
}
