/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASL4I7DOW.aml, Fri Jun 12 21:56:00 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000116 (278)
 *     Revision         0x02
 *     Checksum         0xE2
 *     OEM ID           "ACDT"
 *     OEM Table ID     "SsdtEC"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 * Uncomment replacing EC0 with your own value in case your
 * motherboard has an existing embedded controller of PNP0C09 type.
 *
 * While renaming EC0 to EC might potentially work initially,
 * it connects an incompatible driver (AppleACPIEC) to your hardware.
 * This can make your system unbootable at any time or hide bugs that
 * could trigger randomly.
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "SsdtEC", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.H_EC, DeviceObj)

    Scope (\_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                           
                    })
                }

                Return (Package (0x08)
                {
                    "kUSBSleepPowerSupply", 
                    0x13EC, 
                    "kUSBSleepPortCurrentLimit", 
                    0x0834, 
                    "kUSBWakePowerSupply", 
                    0x13EC, 
                    "kUSBWakePortCurrentLimit", 
                    0x0834
                })
            }
        }
        Scope (\_SB.PCI0.LPCB.H_EC)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0)
                }
                Else
                {
                    Return (0x0F)
                }
            }
        }
        
        Scope (\_SB.PCI0.LPCB)
        {
            Device (EC)
            {
                Name (_HID, "ACID0001")  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (_OSI ("Darwin"))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }
    }
}