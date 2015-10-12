require "rubygems"
require "ai4r"

CAREER = ['Ingeniero:', 'Abogado:  ', 'Medico:   ', 'Diseñador:']
skills = ARGV[0][1..-2].split(',').collect! {|n| n.to_i}

def result_label(result) #Match te optimal result
  if result[0] > result[1] && result[0] > result[2] && result[0] > result[3]
    return "Ingeniero"
  elsif result[1] > result[2] && result[1] > result[3]
    return "Abogado"
  elsif result[2] > result[3]   
    return "Medico"
  else
  	return "Diseñador"
  end
end

def result_values(result)
  max = result.size - 1
  for i in 0..max
     puts "#{CAREER[i]} #{result[i]}"
  end
  puts "\n"
end

#Create the network with 4 inputs, 1 hidden layer with 5 neurons, and 4 outputs
net = Ai4r::NeuralNetwork::Backpropagation.new([4, 10, 4])

#Initialize values
#net.momentum = 0.15 
#net.learning_rate = 0.5
#net.propagation_function = lambda { |x| Math.tanh(x) }  
#PONER VALORES DEFAULT

# Train the network 
1000.times do |i|
  net.train([0, 1, 0, 0], [1, 0, 0, 0]) #Ingeniero
  net.train([0, 0, 1, 0], [1, 0, 0, 0])

  net.train([0, 0, 1, 0], [0, 1, 0, 0]) #Abogado
  net.train([0, 0, 0, 1], [0, 1, 0, 0])

  net.train([0, 1, 0, 0], [0, 0, 1, 0]) #Medico
  net.train([0, 0, 0, 1], [0, 0, 1, 0])

  net.train([1, 0, 0, 0], [0, 0, 0, 1]) #Diseñador
end
#podes poner 0.3 de limite

#Evaluate data with the trained network
#puts skills
result_values(net.eval(skills)) 
puts "Resultado optimo: #{result_label(net.eval(skills))}"


#creativo (1), analitico (2), trabajo en equipo (3), facilidad para expresarse (4)
#ingeniero (1), abogado (2), medico (3), diseñador (4)





#Como le doy los pesos?
#init_weights()



#Configurable momentum: 0.1
#
#Configurable learning rate: 0.25
#
#Configurable initial weight function:
#
#Propagation function: lambda { |x| 1/(1+Math.exp(-1*(x))) }

