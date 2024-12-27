#!/usr/bin/sudo bash

function call {
	echo $1 | sudo tee /proc/acpi/call > /dev/null && sudo cat /proc/acpi/call
}

call '\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x30 0x85' > /dev/null
call '\_SB.PCI0.SBRG.EC0.WRAM 0xCD 0x37 0x8b' > /dev/null

echo BIOS/ACPI Mode
