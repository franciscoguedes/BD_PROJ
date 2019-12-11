from random import randrange, uniform
import itertools

file = open("populate_multi.sql", "w");
#create ids
ids = []
for i in range(20):
    ids.append(i)
#tipos
userTypes = ["Qualificado", "Regular"]

nomes = []
#create nomes
for i in range(10):
    nomes += ["nome" + str(i)]

emails = []
mailSufixes = ['@gmail.com', '@hotmail.com', '@outlook.com.pt']

#create emails
for nome in nomes:
    emails.append(nome + mailSufixes[randrange(0, len(mailSufixes))])


addUsers = ""
for (email, id) in zip(emails,ids):
    addUsers += "INSERT INTO d_utilizador VALUES (" + str(id) +", " + str(email) + ", '" + str(userTypes[randrange(0, len(userTypes))]) + "');\n" 

result = "--populate d_utilizador\n"
result += addUsers


#dia
dias = [] 
for i in range(31):
    dias.append(str(i))
#semana e trimestre
semanas = []
trimestres = []
for i in range(1,5):
    trimestres.append(i)
    semanas.append(i)

#mes
meses = []
for i in range(1,13):
    meses.append(i)
#ano
anos = []
for i in range(1999, 2021):
    anos.append(i)

#dias da semana
diasDaSemana = ["segunda", "terça", "quarta", "quinta", "sexta", "sabado", "domingo"]
addTempo = "--populate d_tempo\n"

for i in ids:
    addTempo += "INSERT INTO d_tempo VALUES (" + str(i) + ", " + str(dias[randrange(0, len(dias))]) + ", '" + diasDaSemana[randrange(0, len(diasDaSemana))] + "', " + str(semanas[randrange(0, len(semanas))]) + ", " + str(meses[randrange(0, len(meses))]) + ", " + str(trimestres[randrange(0, len(trimestres))]) + ", " + str(anos[randrange(0, len(anos))]) + ");\n"

result += addTempo


latitudes = []
longitudes = []
#create latitudes
for i in range(20):
    latitudes += [uniform(0, 1000)]
#create longitudes
for i in range(20):
    longitudes += [uniform(0, 100)]

addLocal = "--populate d_local\n"
for i in ids:
    addLocal += "INSERT INTO d_local VALUES (" + str(i) + ", " + str(latitudes[randrange(0, len(latitudes))]) + ", " + str(longitudes[randrange(0, len(longitudes))]) + ");\n" 


result += addLocal

linguas = ["PT", "EN", "GB", "CH", "FR"]
addLingua = "--populate d_lingua\n"
for (i, lingua) in zip(ids, linguas):
    addLingua += "INSERT INTO d_lingua VALUES (" + str(i) + ", '" + str(linguas[randrange(0, len(linguas))]) + "');\n"

result += addLingua

tiposAnomalia = ["Redação", "Tradução"]
comProposta  = ["True" , "False"]
addAnomalias = "--populate f_anomalia\n"

for i in ids:
    if randrange(0, 1) == 0:
        addAnomalias += "INSERT INTO f_anomalia VALUES (" + str(ids[randrange(0, len(ids))]) + ", " + str(ids[randrange(0, len(ids))]) + ", " + str(ids[randrange(0, len(ids))]) + ", " + str(ids[randrange(0, len(ids))]) + ", '" + str(tiposAnomalia[randrange(0, len(tiposAnomalia))]) + "', " + str(comProposta[randrange(0, len(tiposAnomalia))]) + ");\n"

result += addAnomalias

file.write(result)