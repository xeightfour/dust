#!/usr/bin/env python

import time, os, sys, signal, traceback

passive = 55
stat = False

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

def updateStat():
    global stat
    sit = call('\\_SB.PCI0.SBRG.EC0.RRAM 0xCC 0x30')[:4]
    stat = sit == '0x95'

def updateFan():
    global passive, stat
    if stat and getTemp() <= passive:
        return
    if not stat and getTemp() > passive:
        return

    if stat:
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x85')
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x8b')
    else:
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x95')
        call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x9b')

    print(getTemp(), '(C)')
    print(call('\\_SB.PCI0.SBRG.EC0.RRAM 0xCC 0x30'), call('\\_SB.PCI0.SBRG.EC0.RRAM 0xCC 0x37'))

    stat = not stat

def cleanup(signal = None, frame = None):
    call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x85')
    call('\\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x8b')

    print('Reset fan control to automatic. Exiting...')
    sys.exit(0)

def main():
    signal.signal(signal.SIGTERM, cleanup)
    try:
        while True:
            updateStat()
            updateFan()
            time.sleep(4)
    except:
        traceback.print_exc()
    finally:
        cleanup()

if __name__ == '__main__':
    main()
