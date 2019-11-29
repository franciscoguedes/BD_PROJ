from random import randrange, uniform
import itertools

cidades = []
for i in range(10):
    cidades += ["cidade" + str(i)]

nomes = []
for i in range(30):
    nomes += ["nome" + str(i)]
nomesCertificados = nomes[:len(nomes)//2]
nomesRegulares = nomes[len(nomes)//2:]

passwords = ['panados', '123', 'password', 'paopao', '123sadiujkasdq', 'asADSsadsaXZCPF']
mailSufixes = ['@gmail.com', '@hotmail.com', '@outlook.com.pt']
emailCertificados = []
emailRegulares = []
emails = []



latitudes = []
longitudes = []
#create latitudes
for i in range(20):
    latitudes += [uniform(0, 1000)]
#create longitudes
for i in range(20):
    longitudes += [uniform(0, 100)]
    


coords = []


anomaliaIds = []
zonasImagem = ["cima", "baixo", "esquerda", "meio", "direita"]
anos = [1999, 2000, 2010, 2019, 2020]
meses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
dias = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]
horas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
minutos = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60]
timestamps = []
images = []
descricoes = []
linguas = ["PT", "EN", "GB", "CH", "FR"]
booleans = ["true", "false"]

textos = []
for i in range(500):
    textos.append("texto" + str(i));


itemIds = []

file = open("populate.sql", "w");




result = ""
#populate users
usersPopulate = "--users certificados\n"
for nome in nomesCertificados:
    for mail_sufix in mailSufixes:
        email =  nome + str(randrange(0, 100)) + mail_sufix
        emailCertificados.append(email)
        usersPopulate += "INSERT INTO utilizador values ('" + email + "', '" + passwords[randrange(0, len(passwords) )] + "');\n" +\
                        "INSERT INTO utilizador_certificado values ('" + email + "');\n"


usersPopulate += "\n--users regular\n"
for nome in nomesRegulares:
    for mail_sufix in mailSufixes:
        email =  nome + str(randrange(0, 100)) + mail_sufix
        if (email not in emailCertificados):
            emailRegulares.append(email)
            usersPopulate += "INSERT INTO utilizador values ('" + email + "', '" + passwords[randrange(0, len(passwords))] + "');\n" +\
                            "INSERT INTO utilizador_regular values ('" + email + "');\n"
usersPopulate += "\n"



emails = emailRegulares + emailCertificados
result += usersPopulate


localsPopulate = "--locais publicos\n"
#create possible coords
for latitude in latitudes:
    coords.append((latitude, longitudes[randrange(0, len(longitudes))]))
#populate locais publicos
for coord in coords:
    cidade = cidades[randrange(0, len(cidades))]
    localsPopulate += "INSERT INTO local_publico values (" + str(coord[0]) + ", " + str(coord[1]) + ", '" + cidade + "');\n"
localsPopulate += '\n'

result += localsPopulate





#create possible timestamps
for ano in anos:
    for mes in meses:
        for dia in dias:
            timestamps.append("'" + str(ano) + "-" + str(mes) + "-" + str(dia) + " " + str(horas[randrange(0, len(horas))]) + ":" + str(minutos[randrange(0, len(minutos) )]) + ":" + str(minutos[randrange(0, len(minutos) )]) + "'")
#create images
for i in range(100):
    images.append("test" + str(randrange(0, 500)) + ".jpg")
#create descricoes
for i in range(100):
    descricoes.append("descricao" + str(randrange(0, 500)))
#create ids
for i in range(100):
    anomaliaIds.append(randrange(0, 500))
#populate anomalias
anomaliasPopulate = "--anomalias\n"
anomaliaTraducaoIds = []
for id in anomaliaIds:
    boolean = str(booleans[randrange(0, len(booleans))])
    anomaliasPopulate += "INSERT INTO anomalia values (" + str(id) + ", '" + str(zonasImagem[randrange(0, len(zonasImagem))]) + "', '" + str(images[randrange(0, len(images))]) + "', '" + str(linguas[randrange(0, len(linguas))]) + "', " + str(timestamps[randrange(0, len(timestamps))]) + ", '" + str(descricoes[randrange(0, len(descricoes))]) + "', '" + boolean+ "');\n"
    if boolean == "false":
        anomaliaTraducaoIds.append(id)
anomaliasPopulate += "\n"
result += anomaliasPopulate



#populate anomalias_traducao
anomalias_traducaoPopulate = "--anomalias traducao\n"
for id in anomaliaTraducaoIds:
    if randrange(0, 2) == 1:
        anomalias_traducaoPopulate += "INSERT INTO anomalia_traducao values (" + str(id) +  ", '" + str(zonasImagem[randrange(0, len(zonasImagem))]) + "', '" + str(linguas[randrange(0, len(linguas))]) + "');\n"

anomalias_traducaoPopulate += "\n"
result += anomalias_traducaoPopulate



#create item ids
for i in range(100):
    itemIds.append(randrange(0, 500))
#populate items
itemsPopulate = "--items\n"
createdItemIds = []
for (itemId, latitude, longitude) in zip(itemIds, latitudes, longitudes):
    createdItemIds += [itemId]
    itemsPopulate += "INSERT INTO item values (" + str(itemId) + ", '" + str(descricoes[randrange(0, len(descricoes))]) + "', " + \
                        "'" + str(cidades[randrange(0, len(cidades))]) + "', " + str(latitude) + ", " + str(longitude) +");\n" 

itemIds = createdItemIds
itemsPopulate += "\n"
result += itemsPopulate


#populate duplicados
duplicadosPopulate = "--duplicados\n"
for itemId1 in itemIds:
    for itemId2 in itemIds:
        if itemId1 < itemId2 and itemId1 in createdItemIds and itemId2 in createdItemIds:
            createdItemIds.remove(itemId1)
            createdItemIds.remove(itemId2)
            duplicadosPopulate += "INSERT INTO duplicado values (" + str(itemId1) +", " + str(itemId2) + ");\n"

duplicadosPopulate += "\n"
result += duplicadosPopulate


#populate incidencia
incidenciaPopulate = "--incidencia\n"
for anomaliaId in anomaliaIds:
    incidenciaPopulate += "INSERT INTO incidencia values (" + str(anomaliaId) + ", " + str(itemIds[randrange(0, len(itemIds))]) + ", " + \
                            "'" + emails[randrange(0, len(emails))] + "');\n"

incidenciaPopulate += "\n"
result += incidenciaPopulate



#create correction timestamps
correctionTimestamps = []
for ano in [2021, 2022]:
    for mes in meses:
        for dia in dias:
            correctionTimestamps.append("'" + str(ano) + "-" + str(mes) + "-" + str(dia) + " " + str(horas[randrange(0, len(horas))]) + ":" + str(minutos[randrange(0, len(minutos) )]) + ":" + str(minutos[randrange(0, len(minutos) )]) + "'")

#populate proposta correcao
propostaDeCorrecaoPopulate = "--proposta_de_correcao\n"
propostaDeCorrecaoIds = []
for i in range(randrange(1, 15)):
    if i not in propostaDeCorrecaoIds:
        propostaDeCorrecaoIds.append(i)
        propostaDeCorrecaoPopulate += "INSERT INTO proposta_de_correcao values ('" + emailCertificados[randrange(0, len(emailCertificados))] + "', "  + str(i) + ", " + correctionTimestamps[randrange(0, len(correctionTimestamps))] + ", '" + textos[randrange(0, len(textos))] +"');\n"

propostaDeCorrecaoPopulate += "\n"
result += propostaDeCorrecaoPopulate

#populate correcao
correcaoPopulate = "--correcao\n"
for (email, nro) in zip(emailCertificados, propostaDeCorrecaoIds):
    correcaoPopulate += "INSERT INTO correcao values ('" + email + "', " + str(nro) + ", " + str(anomaliaIds[randrange(0, len(anomaliaIds))]) + ");\n"

result += correcaoPopulate 



file.write(result)


file.close()