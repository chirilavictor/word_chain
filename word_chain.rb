words = File.open("text.txt", "r"){ |f| f.read.split }

puts "Alege input1: "
input1 = gets.chomp.downcase

words3 = []
words.each do |cuv|
	if input1.length == cuv.length
		words3 << cuv.downcase
	end
end
words3.sort!

puts "Alege input2: "
input2 = gets.chomp.downcase

words3.delete(input1)
words3.delete(input2)

# ca un cuvant sa fie prieten cu alt cuvant e nevoie sa existe intre cei doi doar o litera diferenta
def test_prietenie(elem, cuv)
	dif = 0
	elem.length.times do |i| # asta am luat-o de la Bogdan
		dif += 1 if elem[i] != cuv[i]
	end

	if dif == 1
		return true
	else 
		return false
	end
end

# vedem care sunt primii prieteni ai input-ului. Adica prima coloana
def lista_prieteni1(arr1, input)
	temp = []
	prieteni_noi = []
	arr1.each do |prieten_nou|
		if test_prietenie(prieten_nou, input)
			temp.push(prieten_nou, input)
			prieteni_noi << temp
			temp = []
		end
	end
	return prieteni_noi.uniq
end

# cu metoda asta gasim prietenii prietnilor din arr care ne intereseaza
def lista_prieteni(arr1, arr2)
	lista_prieteni = []
	temp = []
	arr1.each do |p_nou|
		arr2.each do |p_vechi|
			if test_prietenie(p_nou, p_vechi[0])
				temp.push(p_nou, p_vechi[0], p_vechi[1], p_vechi[2], p_vechi[3], p_vechi[4], p_vechi[5], p_vechi[6], p_vechi[7])
				lista_prieteni << temp
				temp = []
			end
		end
	end
	return lista_prieteni.uniq # din nu stiu ce motiv la anumite intervale aparea un prieten care deja era trecut pe lista. Pana sa-mi dau seama ca aici e buba am pierdut vreo ora.
end

# daca gasim prieteni comuni ii punem impreuna cu tot lantul de prieteni din ambele directii intr-un arr temporar. Cam ca la nunta..
def verificare_prieteni(arr1, arr2)
	temp = []
	arr1.each do |elem1|
		arr2.each do |elem2|
			if elem1[0] == elem2[0]
				temp.push(elem1.reverse.compact + elem2[1..-1].compact)
			end
		end
	end
	if !temp.empty?
		return temp
	else 
		return false
	end
end

# folosim metoda asta pentru a sterge nivelul anterior de prieteni din arr mare/words3. Au aceeasi diferenta de o litera si ne incurca socotelile
def sterg_prieteni(arr1, arr2)
	arr1.each do |elem1|
		arr2.each do |elem2|
			if elem1 == elem2[0]
				arr1.delete(elem1)
			end
		end
	end
	return arr1
end

p_inp1 = lista_prieteni1(words3, input1) # nivel 1 de prieteni pentru input1
p_inp2 = lista_prieteni1(words3, input2) # nivel 1 de prieteni pentru input2

lant3 = verificare_prieteni(p_inp1, p_inp2) # vericarea prietenilor comuni si afisarea
puts "Numar total de cuvinte: #{words3.length} cu #{input1.length} litere."
puts "Nivel 3" 
puts "Lanturi posibile din directia input1: #{p_inp1.length}"
puts "Lanturi posibile din directia input2: #{p_inp2.length}"
if lant3 
	lant3.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]}" }
end

unless lant3 
	sterg_prieteni(words3, p_inp1) #  stergem prietenii de la nivelul precedent din aceeasi directie
	p2_inp1 = lista_prieteni(words3, p_inp1) # nivel 2 de prieteni pentru input1
	lant4 = verificare_prieteni(p2_inp1, p_inp2) # vericarea prietenilor comuni si afisarea
	puts
	puts "Nivel 4" 
	puts "Lanturi posibile din directia input1: #{p2_inp1.length}"
	puts "Lanturi posibile din directia input2: #{p_inp2.length}"
	if lant4
		lant4.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]}" }
	end

	unless lant4 
		sterg_prieteni(words3, p_inp2) #  stergem prietenii de la nivelul precedent din aceeasi directie
		p2_inp2 = lista_prieteni(words3, p_inp2) 	# nivel 2 de prieteni pentru input2
		lant5 = verificare_prieteni(p2_inp1, p2_inp2)
		puts
		puts "Nivel 5" 
		puts "Lanturi posibile din directia input1: #{p2_inp1.length}"
		puts "Lanturi posibile din directia input2: #{p2_inp2.length}"
		if lant5
			lant5.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]}" }
		end

		unless lant5
			sterg_prieteni(words3, p2_inp1) # stergem prietenii de la nivelul precedent din aceeasi directie
			p3_inp1 = lista_prieteni(words3, p2_inp1) # nivel 3 prieteni pentru input1
			lant6 = verificare_prieteni(p3_inp1, p2_inp2)
			puts
			puts "Nivel 6" 
			puts "Lanturi posibile din directia input1: #{p3_inp1.length}"
			puts "Lanturi posibile din directia input2: #{p2_inp2.length}"
			if lant6
				lant6.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]}" }
			end

			unless lant6
				sterg_prieteni(words3, p2_inp2)
				p3_inp2 = lista_prieteni(words3, p2_inp2) # nivel 3 pentru input2
				lant7 = verificare_prieteni(p3_inp1, p3_inp2)
				puts
				puts "Nivel 7" 
				puts "Lanturi posibile din directia input1: #{p3_inp1.length}"
				puts "Lanturi posibile din directia input2: #{p3_inp2.length}"
				if lant7
					lant7.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]}" }
				end

				unless lant7
					sterg_prieteni(words3, p3_inp1)
					p4_inp1 = lista_prieteni(words3, p3_inp1) # nivel 4 pentru input1
					lant8 = verificare_prieteni(p4_inp1, p3_inp2)
					puts
					puts "Nivel 8" 
					puts "Lanturi posibile din directia input1: #{p4_inp1.length}"
					puts "Lanturi posibile din directia input2: #{p3_inp2.length}"
					if lant8
						lant8.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]}" }
					end

					unless lant8
						sterg_prieteni(words3, p3_inp2)
						p4_inp2 = lista_prieteni(words3, p3_inp2) # nivel 4 pentru input2
						lant9 = verificare_prieteni(p4_inp1, p4_inp2)
						puts
						puts "Nivel 9" 
						puts "Lanturi posibile din directia input1: #{p4_inp1.length}"
						puts "Lanturi posibile din directia input2: #{p4_inp2.length}"
						if lant9
							lant9.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]} - #{elem[8]}" }
						end

						unless lant9
							sterg_prieteni(words3, p4_inp1)
							p5_inp1 = lista_prieteni(words3, p4_inp1) # nivel 5 pentru input1
							lant10 = verificare_prieteni(p5_inp1, p4_inp2)
							puts
							puts "Nivel 10" 
							puts "Lanturi posibile din directia input1: #{p5_inp1.length}"
							puts "Lanturi posibile din directia input2: #{p4_inp2.length}"
							if lant10
								lant10.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]} - #{elem[8]} - #{elem[9]}" }
							end

							unless lant10
								sterg_prieteni(words3, p4_inp2)
								p5_inp2 = lista_prieteni(words3, p4_inp2) # nivel 5 pentru input2
								lant11 = verificare_prieteni(p5_inp1, p5_inp2)
								puts
								puts "Nivel 11" 
								puts "Lanturi posibile din directia input1: #{p5_inp1.length}"
								puts "Lanturi posibile din directia input2: #{p5_inp2.length}"
								if lant11
									lant11.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]} - #{elem[8]} - #{elem[9]} - #{elem[10]}" }
								end

								unless lant11
									sterg_prieteni(words3, p5_inp1)
									p6_inp1 = lista_prieteni(words3, p5_inp1) # nivel 6 pentru input1
									lant12 = verificare_prieteni(p6_inp1, p5_inp2)
									puts
									puts "Nivel 12" 
									puts "Lanturi posibile din directia input1: #{p6_inp1.length}"
									puts "Lanturi posibile din directia input2: #{p6_inp2.length}"
									if lant12
										lant12.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]} - #{elem[8]} - #{elem[9]} - #{elem[10]} - #{elem[11]}" }
									end

									unless lant12
										sterg_prieteni(words3, p5_inp2)
										p6_inp2 = lista_prieteni(words3, p5_inp2) # nivel 6 pentru input2
										puts
										puts "Nivel 13" 
										puts "Lanturi posibile din directia input1: #{p6_inp1.length}"
										puts "Lanturi posibile din directia input2: #{p6_inp2.length}"
										if lant13
											lant13.each { |elem| puts "#{elem[0]} - #{elem[1]} - #{elem[2]} - #{elem[3]} - #{elem[4]} - #{elem[5]} - #{elem[6]} - #{elem[7]} - #{elem[8]} - #{elem[9]} - #{elem[10]} - #{elem[11]} - #{elem[12]}" }
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

