require "rubygems"
require "ai4r"

CAREER = ['Ingeniero:', 'Abogado:  ', 'Medico:   ', 'Diseñador:', 'Contador: ']
skills = ARGV[0][1..-2].split(',').collect! {|n| n.to_i}

def result_label(result) #Match te optimal result
  if result[0] > result[1] && result[0] > result[2] && result[0] > result[3] && result[0] > result[4]
    return "Ingeniero"
  elsif result[1] > result[2] && result[1] > result[3] && result[1] > result[4]
    return "Abogado"
  elsif result[2] > result[3] && result[2] > result[4]
    return "Medico"
  elsif result[3] > result[4]
  	return "Diseñador"
  else
    return "Contador"
  end
end

def result_values(result)
  max = result.size - 1
  for i in 0..max
     puts "#{CAREER[i]} #{result[i]}"
  end
  puts "\n"
end

#Create the network with 5 inputs, 2 hidden layer with 10 neurons, and 5 outputs
net = Ai4r::NeuralNetwork::Backpropagation.new([5, 10, 10, 5])

#Configurate the network
net.momentum = 0.1
net.learning_rate = 0.1
net.propagation_function = lambda { |x| 1/(1+Math.exp(-1*(x))) }
net.disable_bias = false

#Train the network 
5000.times do |i|
  net.train([0, 1, 0, 0, 0], [1, 0, 0, 0, 0]) #Ingeniero
  net.train([0, 0, 1, 0, 0], [1, 0, 0, 0, 0])
  net.train([0, 0, 0, 0, 1], [1, 0, 0, 0, 0])

  net.train([0, 0, 1, 0, 0], [0, 1, 0, 0, 0]) #Abogado
  net.train([0, 0, 0, 1, 0], [0, 1, 0, 0, 0])
  net.train([0, 0, 0, 0, 1], [0, 1, 0, 0, 0])

  net.train([0, 1, 0, 0, 0], [0, 0, 1, 0, 0]) #Medico
  net.train([0, 0, 0, 1, 0], [0, 0, 1, 0, 0])

  net.train([1, 0, 0, 0, 0], [0, 0, 0, 1, 0]) #Diseñador

  net.train([0, 1, 0, 0, 0], [0, 0, 0, 0, 1]) #Contador
  net.train([0, 0, 0, 0, 1], [0, 0, 0, 0, 1]) 
end


#Evaluate data with the trained network
result_values(net.eval(skills)) 
puts "Resultado optimo: #{result_label(net.eval(skills))}"


#creativo (1), analitico (2), trabajo en equipo (3), facilidad para expresarse (4), facilidad de negocioacion (5)
#ingeniero (1), abogado (2), medico (3), diseñador (4), contador (5)

