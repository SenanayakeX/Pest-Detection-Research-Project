import firebase_admin
from firebase_admin import credentials, db
import time
from datetime import datetime

firebaseKey_path = "C:/Users/Shehan/PycharmProjects/pythonProject/monkeyPredictionUpdated/key.json"
Database_URL = "https://monkeydetection-de11e-default-rtdb.asia-southeast1.firebasedatabase.app"

cred = credentials.Certificate(firebaseKey_path)
try:
    firebase_admin.initialize_app(cred, {'databaseURL': Database_URL})
except:
    print("cant open Database")


alarmRef = db.reference('/alarm')
deviceIDRef = db.reference('/deviceID')
gpsRef = db.reference('/gps')
tempRef = db.reference('/temperature')
humiRef = db.reference('/humidity')
history_ref =  db.reference('/history')

current_date_time = datetime.now()
formatted_date_time = current_date_time.strftime('%Y-%m-%d %H:%M:%S.%f')


while True:
    time.sleep(5)
    #if alarmRef.get():
    if True:
        deviceID = deviceIDRef.get()
        gps = gpsRef.get()
        temperature = tempRef.get()
        humidity = humiRef.get()

        new_data = {
            'date': formatted_date_time,
            'device': deviceID,
            'gps' : gps,
            'humidity' : humidity,
            'temperature' : temperature
        }

        # Push the new data entry to the database
        history_ref.push(new_data)


        time.sleep(5)
        break
