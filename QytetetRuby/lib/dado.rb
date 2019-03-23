#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require "singleton"
module ModeloQytetet

  class Dado
    include Singleton
  
   def initialize
    
   end
   
   def tirar
    puts "\nPulsa un cualquier boton para tirar el dado"
    gets.chomp()
    valor= 15#rand(5)+1
    puts "\nHas sacado un: #{valor}"
    valor
   end
  
  end

end
