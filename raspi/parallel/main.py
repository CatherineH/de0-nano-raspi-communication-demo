# high chip select means writing, low means reading
# clock is negative edged
import RPi.GPIO as GPIO
from time import time

GPIO.setmode(GPIO.BCM)
clock_pin = 1
chip_select = 0

data_pins = [4, 17, 21, 22, 14, 15, 18, 23]
GPIO.setup(clock_pin, GPIO.OUT)
GPIO.setup(chip_select, GPIO.OUT)


def read_dimension(dimension):
    GPIO.output(clock_pin, 0)
    # set the chip select to write
    GPIO.output(chip_select, 1)
    # first, set the dimension (x, y, z)
    values = [(ord(dimension) >> i) % 2 for i in range(0, 8)]
    GPIO.setup(data_pins, GPIO.OUT)
    GPIO.output(data_pins, values)
    # flash the clock pin
    GPIO.output(clock_pin, 1)
    GPIO.output(clock_pin, 0)
    # read the data pins
    GPIO.output(chip_select, 0)
    GPIO.output(clock_pin, 1)
    GPIO.output(clock_pin, 0)
    GPIO.setup(data_pins, GPIO.IN)
    value = 0
    for i in range(0, 8):
        value += GPIO.input(data_pins[i]) << i
    # do it twice
    GPIO.output(clock_pin, 1)
    GPIO.output(clock_pin, 0)
    GPIO.setup(data_pins, GPIO.IN)
    for i in range(0, 8):
        value += GPIO.input(data_pins[i]) << (i+8)
    return value


while True:
    start = time()
    x_val = read_dimension(b'x')
    y_val = read_dimension(b'y')
    z_val = read_dimension(b'z')
    print(x_val, y_val, z_val, time()-start)
