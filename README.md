# FPGA - Raspberry Pi Serial Communication Demo
Sample code for communicating between a raspberry pi and de0 nano at high speed over the uart port

## Getting it Running

Plug GPIO03 on the de0-nano into pin 10 on the Raspberry Pi.
Plug GPIO05 on the de0-nano into pin 8 on the Raspberry Pi.

To load the de0nano, can either import the verilog and tcl files into your own
quartus project, or use my [pyquartus tool](https://github
.com/CatherineH/python-quartus). To compile and upload using pyquartus, plug
 your de0-nano into your computer, and run:

```
cd de0-nano-raspi-serial-demo
pyquartus -c -u -p de0nano
```

On the raspberry pi side, install the requirements and run the program:

```
cd de0-nano-raspi-serial-demo/raspi
pip install -r requirements.txt
python main.py
```

## Credits

The serial verilog code was adapted from [Jean P Nicolle at fpga4fun]
(http://fpga4fun.com/).
