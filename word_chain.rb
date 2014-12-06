words = File.open("text.txt", "r"){ |f| f.read.split }
# print words.length
puts "Alege input1: "
input1 = gets.chomp
puts "Alege input2: "
input2 = gets.chomp


words2 = []
words.each do |cuv|
	if input1.length == cuv.length
		words2 << cuv.downcase
	end
end

input1 = input1.scan /\w/
input2 = input2.scan /\w/

def test_prietenie(elem, cuv)
	if (elem.length == 3) && ((elem.include?(cuv[0]) && elem.include?(cuv[1])) || (elem.include?(cuv[0]) && elem.include?(cuv[2])) || (elem.include?(cuv[1]) && elem.include?(cuv[2])))
		return true
	elsif (elem.length == 4) && ( (elem.include?(cuv[0]) && elem.include?(cuv[1]) && elem.include?(cuv[2])) || (elem.include?(cuv[0]) && elem.include?(cuv[2]) && elem.include?(cuv[3])) || (elem.include?(cuv[1]) && elem.include?(cuv[2]) && elem.include?(cuv[3])) || (elem.include?(cuv[0]) && elem.include?(cuv[1]) && elem.include?(cuv[3])) )
		return true
	else 
		return false
	end
end

# def test_chain(arr1, arr2)
# 	arr1.each do |elem1|
# 		arr2.each do |elem2|
# 			if elem1 == elem2
# 				# puts input1.join + " " + elem1.join + " " + input2.join
# 				return true
# 			else
# 				return false
# 			end
# 		end
# 	end
# end

# words2 = ["cisq", "dsna", "Iaqi", "daiz", "anId", "iNsa", "casax", "cast", "astw", "simpl"]

words3 = []
# words2.each { |x| x.downcase! }
words2.each do |x|
	temp = x.scan /\w/
	words3 << temp # arr de arr cu fiecare cuv de marime potrivita
end

# input1 = ['d', 'a', 'n', 'q']
# input2 = ['i', 'n', 's', 'w']
words3 = words3 - input1 - input2

# de abia de aici vedem care sunt primii prieteni ai lui input1
# toti pritenii lui input1 ii punem in arr de arr prieteni1
# in prieteni1 vom memora pe pozitia 0 prietenul nou si pe pozitia urmatoare inputul
prieteni1 = []
temp = []
words3.each do |prieten_nou| 
	if test_prietenie(prieten_nou, input1) 
		temp.push(prieten_nou, input1) 
		prieteni1 << temp
		temp = []	
	end
end
# print "prieteni1 #{prieteni1}"

# aici vedem care sunt primii priteni ai lui input2 
# toti pritenii lui input2 ii punem in arr de arr prieteni2
# adica o luam si din sens invers
prieteni2 = []
words3.each do |prieten_nou|
 if test_prietenie(prieten_nou, input2) 
   prieteni2 << prieten_nou
 end
end
# print "result2 #{result2}"

# bucata asta de cod e buna pentru un lant de 3
# verificarea prietenilor comuni si afisarea
# deci daca avem prieteni comuni inseamna ca am fortmat un lant
# prieteni1.each do |elem1|
# 	priteni2.each do |elem2|
# 		if elem1 == elem2
# 			puts input1.join + " " + elem1.join + " " + input2.join
# 		end
# 	end
# end
 
# prieteni1 = [["d", "s", "n", "a"], ["a", "n", "i", "d"]]
# prieteni2 = [["i", "n", "s", "a"]]

prieteni1_1 = prieteni1 # singurul scop al acestei operati este de a vizualiza mintal mai bine structura codului
prieteni2_1 = prieteni2

# stergem pretenii pe care deja i-am adaugat la lista
words3.each do |elem1|
	prieteni1.each do |elem2|
		if elem1 == elem2[0]
			words3.delete(elem1)
		end
	end
end
words4 = words3
# print "words4: #{words4}"

# in prieteni1_1doi voi memora pe pozitia 0 prietenul nou si pe urmatoarele pozitii lantul format pana acum
prieteni1_1doi = []
temp = []
words4.each do |prieten_nou| 
	prieteni1_1.each do |elem2|
	  if test_prietenie(prieten_nou, elem2[0])
	  		temp.push(prieten_nou, elem2[0], elem2[1])
	  		prieteni1_1doi << temp
	  		temp = []
	  end
	end
end
# print "result1_1doi #{result1_1doi}"

# vericarea prietenilor comuni si afisarea
# deci daca avem prieteni comuni inseamna ca am fortmat un lant
i = 0
prieteni1_1doi.each do |elem1|
		prieteni2.each do |elem2|
			if elem1[0] == elem2 && i == 0
				puts elem1[2].join + " " + elem1[1].join + " " + elem1[0].join + " " + input2.join
				i = 1
			end
		end
	end

# arr_length = []
# words2.each do |elem|
# 	if input1.length == elem.length
# 		arr_length << elem.downcase
# 	end
# end
# # puts arr_length.length

# input_arr1 = input1.scan /\w/
# input_arr2 = input2.scan /\w/




# lungime = input_arr1.length

# rezultat_arr = []

# input_arr1.map! do |elem1|   # ['d', 'a', 'n']
# 	input_arr2.each do |elem2| # ['i', 'n', 's']
# 		elem1 = elem2
# 		rezultat_arr << input_arr1
# 	end
# end

# print rezultat_arr



# i = 0
# while i < lungime

# 	input_arr1[0] = input_arr2[i]
# 	print input_arr1
# 	rezultat_arr << input_arr1

# i += 1
# end
# print rezultat_arr
# # input_arr1[0] = input_arr2[0]
# # # print input_arr1
# input_arr1[0] = input_arr2[1]
# print input_arr1
# # input_arr1[0] = input_arr2[2] 
# # print rezultat_arr







