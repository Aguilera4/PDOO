#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

 require_relative "jugador"
module ModeloQytetet

  class Especulador < Jugador   
   @fianza=0
  
  def initialize ( jugador, fi )
    Jugador(jugador)
    @fianza = fi    
  end
  
  def to_s
    salida = "*ESPECULADOR* \n"  
    salida += "  \n Nombre: #{@nombre} \n Saldo: #{@saldo}  \n Encarcelado: #{@encarcelado} \n Casilla Actual: [#{@casilla_actual}] \n Carta Libertad: #{@carta_libertad} \n Propiedades: ["

    for p in @propiedades
      salida += p.to_s
    end
    salida += "]"
  end
  
  
  def get_factor_especulador
    @@FACTOR_ESPECULADOR*2
  end  
 
  def convertirme ( f )
    @fianza = f
    self
  end

  
  protected
  def pagar_impuestos ( cantidad )
    modificar_saldo(-cantidad/get_factor_especulador)
  end
  
  def ir_a_carcel ( casilla )
    fianza_ = pagar_fianza(@fianza)
    
    if ( fianza_ )
     super.modificar_saldo(-@fianza)
     
    else
      super.ir_a_carcel(casilla)
    end
    
  end
  
  private
  def pagar_fianza ( cantidad )
    self.tengo_saldo(cantidad)
  end
  
  end
end
