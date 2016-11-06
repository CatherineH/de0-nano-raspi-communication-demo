from time import sleep

from serial import Serial
conn = Serial('/dev/ttyAMA0', baudrate=460800, timeout=2)
while True:
    conn.write(b'x')
    x_val = ord(conn.read(1))
    x_val += ord(conn.read(1)) << 8
    sleep(1)
    conn.write(b'y')
    y_val = ord(conn.read(1))
    y_val += ord(conn.read(1)) << 8
    sleep(1)
    conn.write(b'z')
    z_val = ord(conn.read(1))
    z_val += ord(conn.read(1)) << 8
    print(x_val, y_val, z_val)