from serial import Serial
conn = Serial('/dev/ttyAMA0', baudrate=460800)
while True:
    conn.write(b'x')
    x_val = conn.read(2)
    conn.write(b'y')
    y_val = conn.read(2)
    conn.write(b'z')
    z_val = conn.read(2)
    print(int(x_val), int(y_val), int(z_val))