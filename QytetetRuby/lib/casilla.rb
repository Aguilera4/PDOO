#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Casilla
 
    attr_reader :numero_casilla, :coste, :tipo
    
    def initialize(nc,c, tipo)
      
      @numero_casilla = nc
      @coste = c
      @tipo = tipo
     
    end
    
    def to_s
      "  Numero de casilla: #{@numero_casilla}  coste: #{@coste}  Tipo: #{@tipo} "
    end  
    
    def soy_edificable
      false
    end
    
  end
end
