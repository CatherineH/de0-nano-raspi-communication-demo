from time import time
from sys import argv
from serial import Serial

rate = argv[1]
if rate != 0 and rate != 1:
    rate = 0

rates = [460800, 115200]

print("setting rate to: ", rates[rate])

conn = Serial('/dev/ttyAMA0', baudrate=rates[rate], timeout=2)


def read_dimension(dimension):
    global conn
    failure_count = 0
    # the serial connection often fails to read two single bytes
    while True:
        try:
            conn.write(dimension)
            value = ord(conn.read(1))
            value += ord(conn.read(1)) << 8
            return value
        except Exception as e:
            failure_count += 1

while True:
    start = time()
    x_val = read_dimension(b'x')
    y_val = read_dimension(b'y')
    z_val = read_dimension(b'z')
    print(x_val, y_val, z_val, time()-start)
