# high chip select means writing, low means reading
# clock is negative edged
import RPi.GPIO as GPIO
from time import time, sleep

GPIO.setmode(GPIO.BCM)

data_pins = [24, 4, 17, 22, 9, 25, 18, 23]
clock_pin = 8
chip_select = 10

GPIO.setup(clock_pin, GPIO.OUT)
GPIO.setup(chip_select, GPIO.OUT)


def send_byte(byte_out):
    GPIO.output(clock_pin, 0)
    # set the chip select to write
    GPIO.output(chip_select, 1)
    # send the byte 
    values = [(ord(byte_out) >> i) % 2 for i in range(0, 8)]
    GPIO.setup(data_pins, GPIO.OUT)
    GPIO.output(data_pins, values)
    # flash the clock pin
    GPIO.output(clock_pin, 1)
    GPIO.output(clock_pin, 0)   


def get_byte():
    GPIO.setup(data_pins, GPIO.IN)
    # read the data pins
    GPIO.output(chip_select, 0)
    GPIO.output(clock_pin, 1)
    GPIO.output(clock_pin, 0)

    value = 0
    for i in range(0, 8):
        value += GPIO.input(data_pins[i]) << i
    return value


def read_dimension(dimension):
    # first, set the dimension (x, y, z)
    send_byte(dimension)
    first_byte = get_byte()
    #send_byte(dimension.upper())
    second_byte = get_byte()
    print(first_byte, second_byte)
    return first_byte + second_byte << 8


def echo_box():
    byte_out = 0
    while True:
        start = time()
        send_byte(chr(byte_out))
        byte_out += 1
        if byte_out > 255:
            byte_out = 0
        byte_in = get_byte()
        diff = byte_out-byte_in
        end = time()
        print("diff: ", diff, start-end)


def acc():
    while True:
        start = time()
        x_val = read_dimension(b'x')
        sleep(0.1)
        y_val = read_dimension(b'y')
        sleep(0.1)
        z_val = read_dimension(b'z')
        sleep(0.1)
        print(x_val, y_val, z_val, time()-start)

if __name__ == "__main__":
    acc()
