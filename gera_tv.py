def combina():
    # 4 bits
    vetor4 = []
    i = pow(2, 4)
    for n in range(0, i):
        vetor4.append(bin(n)[2:])
        if len(vetor4[n]) < 2:
            vetor4[n] = str(0)+str(0) + str(0) + vetor4[n]
        if len(vetor4[n]) < 3:
            vetor4[n] = str(0)+ str(0) + vetor4[n]
        if len(vetor4[n]) < 4:
            vetor4[n] = str(0) + vetor4[n]

    # 2bits
    vetor2 = []
    i = pow(2, 2)
    for n in range(0, i):
        vetor2.append(bin(n)[2:])
        if len(vetor2[n]) < 2:
            vetor2[n] = str(0) + vetor2[n]

    vetor1 = [0,1]
    return vetor4,vetor2,vetor1


def acumulador(vetor4,vetor1):
    #Vetor 4  = entrada d
    #Vetor 1  = reset
    vetor_acumulador = []
    for i in range(0,len(vetor4)):
        for j in range(0,len(vetor1)):
            if j == 1:
                vetor_acumulador.append(str(vetor4[i]) +'_' + str(vetor1[j]))
            else:
                vetor_acumulador.append(str(vetor4[i]) +'_' + str(vetor1[j]))

    return vetor_acumulador



def modelo(acumulador,vetor4,vetor1):
    #Realizar testes para os bits de entrada do modelo
	newFile2 = open("modelo.tv","w")
	sel0 = vetor1
	sel1 = vetor1
	A = vetor4
	for i in range(0,len(A)):
	    for j in range(0,len(sel0)):
	        for k in range(0,len(sel1)):
	            #print(i,'\t',j,'\t',k)
	            if j ==1 and k==1:
	                #subtrai A de ACC
	                #res = sub_bit(A-ACC)
	                #chama somador
	                #S,cout = sum_bit(A+res+sel0)
	            	#newFile2.write('{0}_{1}_{2}_{3}\n'.format(A[i], sel0[j], sel1[k],S,cout))
	                pass
	            if j == 1 and k==0:
	            	#Copia !A para ACC
	            	#chama somador
	            	res = inverte_bits(A[i])
	            	#S,cout = sum_bit(A+res+sel0)
	            	#newFile2.write('{0}_{1}_{2}_{3}\n'.format(A[i], sel0[j], sel1[k],S,cout))
	            	#newFile2.write('{0}_{1}_{2}_{3}\n'.format(A[i], sel0[j], sel1[k],res,cout))
	            if j == 0 and k==1:
	                #Soma A com ACC e grava em ACC
	                #chama somador
	                #S,cout = sum_bit(A+res+sel0)
	            	#newFile2.write('{0}_{1}_{2}_{3}\n'.format(A[i], sel0[j], sel1[k],S,cout))
	                pass
	            if j == 0 and k ==0:
	                #Copia A para ACC
	                #chama somador
	                #S,cout = sum_bit(A+A+sel0)
	            	#newFile2.write('{0}_{1}_{2}_{3}\n'.format(A[i], sel0[j], sel1[k],A,cout))
	                pass
	return


def inverte_bits(bits):
	aux = ''
	for i in bits:
		if i == str(1):
			aux =  aux + str(0)
		else:
			aux = aux + str(1)
		
	return aux

def inversor4(vetor4):
    vetor4_inversor = []
    aux = ''
    for i in range(0,len(vetor4)):
    	aux = inverte_bits(vetor4[i])
    	vetor4_inversor.append(aux)

    newFile = open("inversor.tv","w")
    for i in range(0,len(vetor4)):
        newFile.write('{0}_{1}\n'.format(vetor4[i], vetor4_inversor[i]))

    return	
	
def mux4(vetor4_1,vetor4_2,vetor1):
	newFile3 = open("mux.tv","w")
	vetor4_aux = []
	aux = ''
	aux2= ''
	for i in range(0,len(vetor4_1)):
		for j in range(0,len(vetor4_2)):
			aux = vetor4_1[i] + vetor4_2[j]
			aux2 = vetor4_2[j]+vetor4_1[i]
		if aux not in vetor4_aux:
			vetor4_aux.append(aux)
			aux = ''
		if aux2 not in vetor4_aux:
			vetor4_aux.append(aux2)
			aux2 = ''
		else:
			aux = ''
			aux2= ''
			
	for	i in range(0,len(vetor4_aux)):
		print(vetor4_aux[i])
		for j in range(0,len(vetor1)):
			print(j)
			if j == 1:
				print(vetor4_aux[i][:4])
				newFile3.write('{0}_{1}_{2}_{3}\n'.format(vetor4_aux[i][:4], vetor4_aux[i][4:],vetor1[j], vetor4_aux[i][:4]))
			else:
				print(vetor4_aux[i][4:])
				newFile3.write('{0}_{1}_{2}_{3}\n'.format(vetor4_aux[i][:4], vetor4_aux[i][4:], vetor1[j], vetor4_aux[i][4:]))
			
		
			
	return


def main():
    vetor4, vetor2, vetor1 = combina()
    #inversor4(vetor4)
    #mux4(vetor4,vetor4,vetor1)
    #vetor_res = acumulador(vetor4,vetor1)
    #modelo(vetor_res,vetor4,vetor1)
    return

main()
