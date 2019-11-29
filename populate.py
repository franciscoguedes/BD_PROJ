from random import randrange

cidades = ['porto', 'lisboa', 'vila nova de gaia', 'ericeira', 'nazare', 'alverca', 'alhandra', 'avintes', 'pombal', 'leiria']
nomesCertificados = ['francisco', 'paulo', 'miguel', 'catarina', 'sofia', 'murteira', 'bruno', 'alexandre']
nomesRegulares = ['ricardo', 'andre', 'rafaela']
passwords = ['panados', '123', 'password', 'paopao', '123sadiujkasdq', 'asADSsadsaXZCPF']
mailSufixes = ['@gmail.com', '@hotmail.com', '@outlook.com.pt']
emailCertificados = []
emailRegulares = []



latitudes = [1, 1.531, 24.124, 211.5]
longitudes = [1.531, 24.124, 31.5123]
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
        emailRegulares.append(email)
        usersPopulate += "INSERT INTO utilizador values ('" + email + "', '" + passwords[randrange(0, len(passwords))] + "');\n" +\
                        "INSERT INTO utilizador_regular values ('" + email + "');\n"
usersPopulate += "\n"




result += usersPopulate


localsPopulate = "--locais publicos\n"
#create possible coords
for latitude in latitudes:
    for longitude in longitudes:
        coords.append((latitude, longitude))
#populate locais publicos
for coord in coords:
    cidade = cidades[randrange(0, len(cidades))]
    localsPopulate += "INSERT INTO local_publico values (" + str(coord[0]) + ", " + str(coord[1]) + ", '" + cidade + "');\n"
localsPopulate += '\n'

result+=localsPopulate





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
for id in anomaliaIds:
    anomaliasPopulate += "INSERT INTO anomalia values (" + str(id) + ", '" + str(zonasImagem[randrange(0, len(zonasImagem))]) + "', '" + str(images[randrange(0, len(images))]) + "', '" + str(linguas[randrange(0, len(linguas))]) + "', " + str(timestamps[randrange(0, len(timestamps))]) + ", '" + str(descricoes[randrange(0, len(descricoes))]) + "', '" + str(booleans[randrange(0, len(booleans))]) + "');\n"
anomaliasPopulate += "\n"
result += anomaliasPopulate



#populate anomalias_traducao
anomalias_traducaoPopulate = "--anomalias traducao\n"
for id in anomaliaIds:
    if (randrange(0, 2) == 1):
        anomalias_traducaoPopulate += "INSERT INTO anomalia_traducao values (" + str(id) +  ", '" + str(zonasImagem[randrange(0, len(zonasImagem))]) + "', '" + str(linguas[randrange(0, len(linguas))]) + "')\n"

anomalias_traducaoPopulate += "\n"
result += anomalias_traducaoPopulate





file.write(result)



file.close()