import joblib
import pandas as pd
import requests
import random
import firebase_admin
from firebase_admin import credentials, db
from firebase_admin import storage
from datetime import datetime, timedelta

firebaseKey_path = "C:/Users/Shehan/PycharmProjects/pythonProject/monkeyPredictionUpdated/key.json"
Database_URL = "https://monkeydetection-de11e-default-rtdb.asia-southeast1.firebasedatabase.app"
StorageBucket_URL = "monkeydetectiontest.appspot.com"

loaded_model = joblib.load('linear_regression_model.pkl')

cred = credentials.Certificate(firebaseKey_path)
try:
    firebase_admin.initialize_app(cred, {'databaseURL': Database_URL, 'storageBucket': StorageBucket_URL})
except:
    print("cant open Database")

bucket = storage.bucket()
day0Ref = db.reference('/predictions/day0')
day1Ref = db.reference('/predictions/day1')
day2Ref = db.reference('/predictions/day2')
day3Ref = db.reference('/predictions/day3')
day4Ref = db.reference('/predictions/day4')
day5Ref = db.reference('/predictions/day5')

day0Name = db.reference('/predictions/day0Name')
day1Name = db.reference('/predictions/day1Name')
day2Name = db.reference('/predictions/day2Name')
day3Name = db.reference('/predictions/day3Name')
day4Name = db.reference('/predictions/day4Name')
day5Name = db.reference('/predictions/day5Name')


def set_prediction(day, location):
    try:
        if day == 0:
            day0Ref.set(location)
        if day == 1:
            day1Ref.set(location)
        if day == 2:
            day2Ref.set(location)
        if day == 3:
            day3Ref.set(location)
        if day == 4:
            day4Ref.set(location)
        if day == 5:
            day5Ref.set(location)
    except:
        print("Error seting predictions")

def set_dayNames(day, name):
        try:
            if day == 0:
                day0Name.set(name)
            if day == 1:
                day1Name.set(name)
            if day == 2:
                day2Name.set(name)
            if day == 3:
                day3Name.set(name)
            if day == 4:
                day4Name.set(name)
            if day == 5:
                day5Name.set(name)

        except:
            print("Error seting day names")

def predict(datetime_input, temperature_input, humidity_input, resault=None):
    datetime_input = pd.to_datetime(datetime_input)
    datetime_timestamp = datetime_input.timestamp()
    user_input = pd.DataFrame({'Datetime': [datetime_timestamp],
                               'Temperature (C) ': [temperature_input],
                               'Humidity(%)': [humidity_input]})

    predicted_location_raw = loaded_model.predict(user_input)
    predicted_location_round = [round(value) for value in predicted_location_raw]

    difference_raw = abs(predicted_location_raw - predicted_location_round)
    difference_pre = 100-(difference_raw * 200)

    location = str(predicted_location_round[0])
    precentage = str(round(difference_pre[0],1))

    return location+","+precentage


def send_http_request(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            json_response = response.json()
            return json_response
        else:
            print(f"HTTP request failed with status code: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Error sending HTTP request: {e}")
    return None


url = 'https://api.openweathermap.org/data/2.5/forecast?lat=6.927079&lon=79.861244&appid=0aee4f3c0c116541c8c9897000b4dab2&units=metric'
json_response = send_http_request(url)


daily_data = {}


for forecast in json_response['list']:

    date = forecast['dt_txt'].split()[0]

    temp = forecast['main']['temp']
    humidity = forecast['main']['humidity']

    if date not in daily_data:
        daily_data[date] = {'temperature': temp, 'humidity': humidity}


dayCount =0
for date, values in daily_data.items():
    temp = values['temperature']
    humi = values['humidity']

    temp += random.randrange(-5, 5, 1)
    humi += random.randrange(-20, 20, 1)

    #print(f"Date: {date}, Average Temperature: {temp}, Average Humidity: {humi}")
    predictedLocation=(predict( date+' 00:00:00', temp , humi))

    resault = predictedLocation.split(",")


    if float(resault[1]) > 40: #precentage

        set_prediction(dayCount,resault[0] )
    else:

        set_prediction(dayCount, 0)
    dayCount+=1




today_date = datetime.now()
for i in range(0, 6):

    next_day = today_date + timedelta(days=i)
    day_of_week = next_day.strftime("%A")
    set_dayNames(i,day_of_week)



