#!/usr/bin/env python

import time, os, sys, signal, traceback

passive = 57

def call(command):
    acpi = open('/proc/acpi/call', 'w')
    acpi.write(command)
    acpi.close()

    acpi = open('/proc/acpi/call')
    response = acpi.read()
    acpi.close()

    return response

def getTemp():
    return int(call('\\_SB.PCI0.SBRG.EC0.ECPU')[:4], 16)

def updateLED():
    if getTemp() < 45:
        call('\\_SB.SGOV 0x11 1')
    if getTemp() >= 45:
        call('\\_SB.SGOV 0x11 0')
    if getTemp() < 50:
        call('\\_SB.SGOV 0x18 1')
    if getTemp() >= 50:
        call('\\_SB.SGOV 0x18 0')

def updateFan():
    global passive
    if getTemp() <= passive:
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x95')
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x9b')
    else:
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x85')
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x8b')

def cleanup(signal = None, frame = None):
    call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x85')
    call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x8b')

    call('\\_SB.SGOV 0x11 1')
    call('\\_SB.SGOV 0x18 1')

    print('Reset fan control to automatic. Exiting...')
    sys.exit(0)

def main():
    signal.signal(signal.SIGTERM, cleanup)
    try:
        while True:
            updateLED()
            updateFan()
            time.sleep(4)
    except:
        traceback.print_exc()
    finally:
        cleanup()

if __name__ == '__main__':
    main()
