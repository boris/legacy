import adafruit_dht
import time
import board

dhtSensor = adafruit_dht.DHT11(board.D4)

while True:
    humidity = dhtSensor.humidity
    temp_c = dhtSensor.temperature

    print(f"Temp: {temp_c}C \nHumidity: {humidity}%")

    time.sleep(10)
