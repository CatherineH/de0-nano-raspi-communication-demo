import RPi.GPIO as GPIO
from time import time, sleep

GPIO.setmode(GPIO.BCM)

data_pins = [1, 0, 4, 17, 21, 22, 14, 15, 18, 23]

for i in range(len(data_pins)):
    GPIO.setup(data_pins[i], GPIO.OUT)

i = 0
while True:
    GPIO.output(data_pins[i], 1)
    sleep(1)
    GPIO.output(data_pins[i], 0)
    sleep(1)
    i += 1
    if i > 9:
        i = 0