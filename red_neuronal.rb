require "rubygems"
require "ai4r"


def result_label(result) #hacer que muestre los que esten por arriba de 0.3 (o tendria que mostrar el mayor)
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

# Create the network with 4 inputs, 1 hidden layer with 5 neurons, and 4 outputs
net = Ai4r::NeuralNetwork::Backpropagation.new([4, 5, 4])

#net.momentum = 0.15 
#net.learning_rate = 0.5
#net.propagation_function = lambda { |x| Math.tanh(x) }  
#PONER VALORES DEFAULT

# Train the network 
1000.times do |i|
  #net.train(example[i], result[i]) #pones, para lo que entra, que tendria que salir
  net.train([0, 1, 0, 0], [1, 0, 0, 0]) #ingeniero
  net.train([0, 0, 1, 0], [1, 0, 0, 0])

  net.train([0, 0, 1, 0], [0, 1, 0, 0]) #abogado
  net.train([0, 0, 0, 1], [0, 1, 0, 0])

  net.train([0, 1, 0, 0], [0, 0, 1, 0]) #medico
  net.train([0, 0, 0, 1], [0, 0, 1, 0])

  net.train([1, 0, 0, 0], [0, 0, 0, 1]) #diseñador
end
#podes poner 0.3 de limite

# Use it: Evaluate data with the trained network
puts net.eval([0, 1, 1, 0])  
puts result_label(net.eval([0, 1, 1, 0]))
  #=>  [0.86, 0.01]


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




#require 'aws-sdk'
#
#client = Aws::ElastiCache::Client.new(
  #region: 'us-east-1',
  #access_key_id: 'ASIAJGWEXSDSK66E2NYQ',
  #secret_access_key: '8hVwcRVG5XILyDUunKqnOxGM2vYWRPq8vhJCoSuf',
  #session_token: 'AQoDYXdzEGQakALcGt9omVw3Kk1CLZZTUjvdL1AQRwdRLOs5D5J+c35kHYg/z+wM4U7pGTvGnPubAJqV0Oe48wSfuUFTg1PepifZkc5Xa3sDw/qKdyroGlKNkI8yf09aRoDeKAT/6UkGiR3NAeaIfxyUMB5EdzcVL6bHURNY2oO2lcGWW9aa26lPrqbvZAMpVN1V5n5Z2tIygKUjEjHEeXE9fRqB2YlgKOHT+PCiEmSWdsAz6+T5azL/z8dvURB7Hge0zfqUUpUlyqEn6ol40nmpJdVnnErqzDjbT8SuFNriiHgthYoz+mwIjEH95SjTXZBeq0WgPuglRYuAtMz0lb0HzNm8zYwTgshyA4Rs6iWWIQcSfDZgcq/9OSCW/M2uBQ=='
#)
#
#cache = client.describe_cache_clusters({cache_cluster_id: "oso-test", show_cache_node_info: true})
#nodes = []
#cache.cache_clusters[0].cache_nodes.each do |node|
	#nodes.push(node.endpoint.address + ":" + node.endpoint.port.to_s)
#end
#
#p nodes