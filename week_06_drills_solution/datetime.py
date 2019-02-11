#datetime test
import datetime

x = datetime.datetime.now()

humanDate = x.strftime("%A")+", "+x.strftime("%B")+" "+x.strftime("%d")+","+x.strftime("%Y")
