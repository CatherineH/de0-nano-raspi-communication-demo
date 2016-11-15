# FPGA - Raspberry Pi Communication Demo
Sample code for communicating between a raspberry pi and de0 nano at high speed over the GPIO pins by sending the accelerometer data.

## Serial Example

- Plug GPIO03 on the de0-nano into GPIO 15 on the Raspberry Pi.
- Plug GPIO05 on the de0-nano into GPIO 14 on the Raspberry Pi.

To load the de0nano, can either import the verilog and tcl files into your own
quartus project, or use my [pyquartus tool](https://github
.com/CatherineH/python-quartus). To compile and upload using pyquartus, plug
 your de0-nano into your computer, and run:

```
cd de0-nano-raspi-serial-demo
pyquartus -c -u -i de0nano/common -p de0nano/serial
```

On the raspberry pi side, install the requirements and run the program:

```
cd de0-nano-raspi-serial-demo/raspi
pip install -r requirements.txt
python serial/main.py
```

The serial verilog code was adapted from [Jean P Nicolle at fpga4fun]
(http://fpga4fun.com/).

## Parallel Example

- Plug GPIO 133 on the de0-nano into GPIO 8 on the Raspberry Pi
- Plug GPIO 131 on the de0-nano into GPIO 10 on the Raspberry Pi
- Plug GPIO 129 on the de0-nano into GPIO 24 on the Raspberry Pi
- Plug GPIO 127 on the de0-nano into GPIO 4 on the Raspberry Pi
- Plug GPIO 125 on the de0-nano into GPIO 17 on the Raspberry Pi
- Plug GPIO 132 on the de0-nano into GPIO 22 on the Raspberry Pi
- Plug GPIO 130 on the de0-nano into GPIO 9 on the Raspberry Pi
- Plug GPIO 128 on the de0-nano into GPIO 25 on the Raspberry Pi
- Plug GPIO 126 on the de0-nano into GPIO 18 on the Raspberry Pi
- Plug GPIO 124 on the de0-nano into GPIO 23 on the Raspberry Pi

To load the de0nano, can either import the verilog and tcl files into your own
quartus project, or use my [pyquartus tool](https://github
.com/CatherineH/python-quartus). To compile and upload using pyquartus, plug
 your de0-nano into your computer, and run:

```
cd de0-nano-raspi-serial-demo
pyquartus -c -u -i de0nano/common -p de0nano/parallel
```

On the raspberry pi side, install the requirements and run the program:

```
cd de0-nano-raspi-serial-demo/raspi
pip install -r requirements.txt
python parallel/main.py
```



