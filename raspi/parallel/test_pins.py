import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BCM)
data_clock = 8
data_select = 10
data_pins = [24, 4, 17, 22, 9, 25, 18, 23]

GPIO.setup(data_clock, GPIO.OUT)
GPIO.setup(data_select, GPIO.OUT)

for i in range(len(data_pins)):
    print("initializing pin: ", data_pins[i])
    GPIO.setup(data_pins[i], GPIO.OUT)

i = 0
while True:
    print(i, data_pins[i])
    GPIO.output(data_clock, 1)
    GPIO.output(data_select, 1)
    GPIO.output(data_pins[i], 1)
    sleep(0.5)
    GPIO.output(data_clock, 0)
    GPIO.output(data_select, 0)
    GPIO.output(data_pins[i], 0)
    sleep(0.5)
    i += 1
    if i >= len(data_pins):
        i = 0