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

def escreve_arquivo(vetor4,vetor2,vetor1):
    newFile = open("modelo.tv","w")
    for i in range(0,len(vetor4)):
        for j in range(0,len(vetor2)):
            for k in range(0,len(vetor1)):
                newFile.write('{0}_{1}_{2}\n'.format(vetor4[i], vetor2[j], vetor1[k]))
    return


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
    sel0 = vetor1
    sel1 = vetor1
    A = vetor4
    for i in range(0,len(A)):
        for j in range(0,len(sel0)):
            for k in range(0,len(sel1)):
                print(i,'\t',j,'\t',k)
                if j ==1 and k==1:
                    #subtrai A de ACC
                    pass
                if j == 1 and k==0:
                    #Copia !A para ACC
                    pass
                if j == 0 and k==1:
                    #Soma A com ACC e grava em ACC
                    pass
                if j == 0 and k ==0:
                    #Copia A para ACC
                    pass
    return

def inversor(vetor4):
    print(vetor4)
    vetor4_inversor = []
    aux = ''
    for i in range(0,len(vetor4)):
        for j in vetor4[i]:
            if j == str(1):
                aux =  aux + str(0)
            else:
                aux = aux + str(1)
        vetor4_inversor.append(aux)
        aux = ''

    print(vetor4_inversor)

    newFile = open("inversor.tv","w")
    for i in range(0,len(vetor4)):
        newFile.write('{0}_{1}\n'.format(vetor4[i], vetor4_inversor[i]))

    return

def main():
    vetor4, vetor2, vetor1 = combina()
    inversor(vetor4)
    #vetor_res = acumulador(vetor4,vetor1)
    #modelo(vetor_res,vetor4,vetor1)
    return

main()
