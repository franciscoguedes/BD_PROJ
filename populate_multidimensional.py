from random import randrange, uniform
import itertools

latitudes = []
longitudes = []
#create latitudes
for i in range(20):
    latitudes += [uniform(0, 1000)]
#create longitudes
for i in range(20):
    longitudes += [uniform(0, 100)]


nomes = []
#create nomes
for i in range(30):
    nomes += ["nome" + str(i)]

emails = []
mailSufixes = ['@gmail.com', '@hotmail.com', '@outlook.com.pt']

#create emails
for nome in nomes:
    emails.append(nome + mailSufixes.randrange(0, len(mailSufixes)))
