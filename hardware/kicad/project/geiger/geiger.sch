EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "ESP32 Geiger Counter"
Date "2021-03-07"
Rev ""
Comp "Holger Fleischmann"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Timer:TLC555xP U2
U 1 1 60147334
P 1650 3200
F 0 "U2" H 1350 3600 50  0000 C CNN
F 1 "TLC555xP" H 1650 3200 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 2300 2800 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tlc555.pdf" H 2500 2800 50  0001 C CNN
	1    1650 3200
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:BC328 Q1
U 1 1 60149CD9
P 1150 2150
F 0 "Q1" H 1341 2104 50  0000 L CNN
F 1 "BC328" H 1341 2195 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 1350 2075 50  0001 L CIN
F 3 "http://www.redrok.com/PNP_BC327_-45V_-800mA_0.625W_Hfe100_TO-92.pdf" H 1150 2150 50  0001 L CNN
	1    1150 2150
	-1   0    0    1   
$EndComp
$Comp
L project:MPSA44 Q2
U 1 1 6014CD74
P 2850 3000
F 0 "Q2" H 3041 3046 50  0000 L CNN
F 1 "MPSA44" H 3041 2955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 3050 2925 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/MPSA42-D.PDF" H 2850 3000 50  0001 L CNN
	1    2850 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Zener D3
U 1 1 6014D6FE
P 4150 3150
F 0 "D3" V 4104 3230 50  0000 L CNN
F 1 "200V" V 4195 3230 50  0000 L CNN
F 2 "" H 4150 3150 50  0001 C CNN
F 3 "~" H 4150 3150 50  0001 C CNN
	1    4150 3150
	0    1    1    0   
$EndComp
$Comp
L Device:D_Zener D2
U 1 1 6014E074
P 4150 2850
F 0 "D2" V 4104 2930 50  0000 L CNN
F 1 "200V" V 4195 2930 50  0000 L CNN
F 2 "" H 4150 2850 50  0001 C CNN
F 3 "~" H 4150 2850 50  0001 C CNN
	1    4150 2850
	0    1    1    0   
$EndComp
$Comp
L Device:L L1
U 1 1 6014E85C
P 2950 2400
F 0 "L1" H 2800 2450 50  0000 L CNN
F 1 "10m" H 2750 2350 50  0000 L CNN
F 2 "" H 2950 2400 50  0001 C CNN
F 3 "~" H 2950 2400 50  0001 C CNN
	1    2950 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 6015014A
P 2950 1900
F 0 "R7" H 3150 1850 50  0000 R CNN
F 1 "15" H 3150 1950 50  0000 R CNN
F 2 "" V 2880 1900 50  0001 C CNN
F 3 "~" H 2950 1900 50  0001 C CNN
	1    2950 1900
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 60150993
P 2900 3750
F 0 "R6" V 3000 3750 50  0000 C CNN
F 1 "10k" V 2800 3750 50  0000 C CNN
F 2 "" V 2830 3750 50  0001 C CNN
F 3 "~" H 2900 3750 50  0001 C CNN
	1    2900 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 601514C6
P 2350 3750
F 0 "R5" V 2250 3750 50  0000 C CNN
F 1 "100k" V 2450 3750 50  0000 C CNN
F 2 "" V 2280 3750 50  0001 C CNN
F 3 "~" H 2350 3750 50  0001 C CNN
	1    2350 3750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 60152872
P 2950 3300
F 0 "#PWR04" H 2950 3050 50  0001 C CNN
F 1 "GND" H 2955 3127 50  0000 C CNN
F 2 "" H 2950 3300 50  0001 C CNN
F 3 "" H 2950 3300 50  0001 C CNN
	1    2950 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 60154776
P 3650 3000
F 0 "C1" H 3765 3046 50  0000 L CNN
F 1 "47n" H 3765 2955 50  0000 L CNN
F 2 "" H 3688 2850 50  0001 C CNN
F 3 "~" H 3650 3000 50  0001 C CNN
	1    3650 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 601553A6
P 5400 2050
F 0 "R3" H 5470 2096 50  0000 L CNN
F 1 "1M8" H 5470 2005 50  0000 L CNN
F 2 "" V 5330 2050 50  0001 C CNN
F 3 "~" H 5400 2050 50  0001 C CNN
	1    5400 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 6015E49D
P 5400 1750
F 0 "R2" H 5470 1796 50  0000 L CNN
F 1 "1M8" H 5470 1705 50  0000 L CNN
F 2 "" V 5330 1750 50  0001 C CNN
F 3 "~" H 5400 1750 50  0001 C CNN
	1    5400 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 6015E703
P 5400 1450
F 0 "R1" H 5470 1496 50  0000 L CNN
F 1 "1M8" H 5470 1405 50  0000 L CNN
F 2 "" V 5330 1450 50  0001 C CNN
F 3 "~" H 5400 1450 50  0001 C CNN
	1    5400 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6014F66C
P 2350 3000
F 0 "R4" V 2250 3000 50  0000 C CNN
F 1 "1k5" V 2450 3000 50  0000 C CNN
F 2 "" V 2280 3000 50  0001 C CNN
F 3 "~" H 2350 3000 50  0001 C CNN
	1    2350 3000
	0    1    1    0   
$EndComp
Wire Wire Line
	2150 3000 2200 3000
Wire Wire Line
	2500 3000 2600 3000
Wire Wire Line
	2600 3000 2600 3200
Wire Wire Line
	2600 3200 2150 3200
Connection ~ 2600 3000
Wire Wire Line
	2600 3000 2650 3000
$Comp
L power:GND #PWR02
U 1 1 60167B0B
P 1650 3850
F 0 "#PWR02" H 1650 3600 50  0001 C CNN
F 1 "GND" H 1655 3677 50  0000 C CNN
F 2 "" H 1650 3850 50  0001 C CNN
F 3 "" H 1650 3850 50  0001 C CNN
	1    1650 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 3200 2950 3300
$Comp
L power:GND #PWR05
U 1 1 60168350
P 3650 3300
F 0 "#PWR05" H 3650 3050 50  0001 C CNN
F 1 "GND" H 3655 3127 50  0000 C CNN
F 2 "" H 3650 3300 50  0001 C CNN
F 3 "" H 3650 3300 50  0001 C CNN
	1    3650 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 3300 3650 3150
Wire Wire Line
	2950 2800 2950 2650
Wire Wire Line
	3650 2650 3650 2850
Wire Wire Line
	2950 2550 2950 2650
Connection ~ 2950 2650
Connection ~ 2950 2150
Wire Wire Line
	1350 2150 2950 2150
Wire Wire Line
	2950 2150 2950 2050
Wire Wire Line
	2950 2150 2950 2250
Wire Wire Line
	3650 2650 4150 2650
Connection ~ 3650 2650
Text GLabel 4550 2650 2    50   Output ~ 0
400V
Wire Wire Line
	1150 3200 1150 3400
Wire Wire Line
	1050 3000 1150 3000
Wire Wire Line
	2200 3750 1650 3750
Wire Wire Line
	1650 3600 1650 3750
Wire Wire Line
	1650 3750 1650 3850
Connection ~ 1650 3750
Wire Wire Line
	1050 3000 1050 4150
Wire Wire Line
	4150 2650 4150 2700
Connection ~ 4150 2650
Wire Wire Line
	4150 2650 4550 2650
Wire Wire Line
	2600 3400 2600 3750
Connection ~ 2600 3750
Wire Wire Line
	2600 3750 2500 3750
Wire Wire Line
	2600 4150 2600 3750
Wire Wire Line
	1050 2350 1050 3000
Connection ~ 1050 3000
Wire Wire Line
	2950 1750 2950 1650
Wire Wire Line
	1050 1650 1050 1950
Wire Wire Line
	4150 3750 3050 3750
Wire Wire Line
	1050 4150 2600 4150
Wire Wire Line
	2150 3400 2600 3400
Wire Wire Line
	2750 3750 2600 3750
Wire Wire Line
	4150 3300 4150 3750
$Comp
L power:VCC #PWR03
U 1 1 60192168
P 2950 1400
F 0 "#PWR03" H 2950 1250 50  0001 C CNN
F 1 "VCC" H 2965 1573 50  0000 C CNN
F 2 "" H 2950 1400 50  0001 C CNN
F 3 "" H 2950 1400 50  0001 C CNN
	1    2950 1400
	1    0    0    -1  
$EndComp
Connection ~ 2950 1650
$Comp
L power:VCC #PWR01
U 1 1 601944CB
P 1650 2500
F 0 "#PWR01" H 1650 2350 50  0001 C CNN
F 1 "VCC" H 1665 2673 50  0000 C CNN
F 2 "" H 1650 2500 50  0001 C CNN
F 3 "" H 1650 2500 50  0001 C CNN
	1    1650 2500
	1    0    0    -1  
$EndComp
Text Notes 1350 1350 0    118  ~ 0
High Voltage\nGenerator
$Comp
L Sensor:Nuclear-Radiation_Detector V1
U 1 1 601CE94E
P 5400 2500
F 0 "V1" H 5550 2600 50  0000 L CNN
F 1 "Geiger Tube" H 5550 2500 50  0000 L CNN
F 2 "" H 5600 2600 50  0001 C CNN
F 3 "~" H 5400 2500 50  0001 C CNN
	1    5400 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 601D38A3
P 5400 3050
F 0 "R8" H 5470 3096 50  0000 L CNN
F 1 "220k" H 5470 3005 50  0000 L CNN
F 2 "" V 5330 3050 50  0001 C CNN
F 3 "~" H 5400 3050 50  0001 C CNN
	1    5400 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 601D3F54
P 6100 2800
F 0 "R9" V 6000 2800 50  0000 C CNN
F 1 "100k" V 6200 2800 50  0000 C CNN
F 2 "" V 6030 2800 50  0001 C CNN
F 3 "~" H 6100 2800 50  0001 C CNN
	1    6100 2800
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 2700 5400 2800
Connection ~ 5400 2800
Wire Wire Line
	5400 2800 5400 2900
Wire Wire Line
	5400 2300 5400 2200
Text GLabel 5400 1200 1    50   Input ~ 0
400V
Wire Wire Line
	5400 1300 5400 1200
$Comp
L power:GND #PWR06
U 1 1 601DC6F1
P 5400 3300
F 0 "#PWR06" H 5400 3050 50  0001 C CNN
F 1 "GND" H 5405 3127 50  0000 C CNN
F 2 "" H 5400 3300 50  0001 C CNN
F 3 "" H 5400 3300 50  0001 C CNN
	1    5400 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 3200 5400 3300
$Comp
L Transistor_BJT:BC517 Q3
U 1 1 601DDA69
P 6500 2800
F 0 "Q3" H 6691 2846 50  0000 L CNN
F 1 "BC517" H 6691 2755 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 6700 2725 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC517-D74Z-D.PDF" H 6500 2800 50  0001 L CNN
	1    6500 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:D D1
U 1 1 601DEE4A
P 3300 2650
F 0 "D1" H 3300 2500 50  0000 C CNN
F 1 "MUR160" H 3300 2800 50  0000 C CNN
F 2 "" H 3300 2650 50  0001 C CNN
F 3 "~" H 3300 2650 50  0001 C CNN
	1    3300 2650
	-1   0    0    1   
$EndComp
Wire Wire Line
	2950 2650 3150 2650
Wire Wire Line
	3450 2650 3650 2650
$Comp
L Device:D D4
U 1 1 601E31A0
P 5800 3050
F 0 "D4" V 5754 3130 50  0000 L CNN
F 1 "1N4148" V 5845 3130 50  0000 L CNN
F 2 "" H 5800 3050 50  0001 C CNN
F 3 "~" H 5800 3050 50  0001 C CNN
	1    5800 3050
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 601E516A
P 6600 2250
F 0 "R10" H 6670 2296 50  0000 L CNN
F 1 "10k" H 6670 2205 50  0000 L CNN
F 2 "" V 6530 2250 50  0001 C CNN
F 3 "~" H 6600 2250 50  0001 C CNN
	1    6600 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2400 6600 2500
Wire Wire Line
	6250 2800 6300 2800
Wire Wire Line
	5400 2800 5800 2800
Wire Wire Line
	5800 2900 5800 2800
Connection ~ 5800 2800
Wire Wire Line
	5800 2800 5950 2800
$Comp
L power:GND #PWR07
U 1 1 601E833F
P 5800 3300
F 0 "#PWR07" H 5800 3050 50  0001 C CNN
F 1 "GND" H 5805 3127 50  0000 C CNN
F 2 "" H 5800 3300 50  0001 C CNN
F 3 "" H 5800 3300 50  0001 C CNN
	1    5800 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 3300 5800 3200
$Comp
L power:GND #PWR09
U 1 1 601EDA33
P 6600 3300
F 0 "#PWR09" H 6600 3050 50  0001 C CNN
F 1 "GND" H 6605 3127 50  0000 C CNN
F 2 "" H 6600 3300 50  0001 C CNN
F 3 "" H 6600 3300 50  0001 C CNN
	1    6600 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 3000 6600 3300
$Comp
L power:VCC #PWR08
U 1 1 601EE844
P 6600 2000
F 0 "#PWR08" H 6600 1850 50  0001 C CNN
F 1 "VCC" H 6615 2173 50  0000 C CNN
F 2 "" H 6600 2000 50  0001 C CNN
F 3 "" H 6600 2000 50  0001 C CNN
	1    6600 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2000 6600 2100
Text GLabel 7150 2500 2    50   Output ~ 0
PULSE-A
Wire Wire Line
	6600 2500 7150 2500
Connection ~ 6600 2500
Wire Wire Line
	6600 2500 6600 2600
Text Notes 5750 1300 0    118  ~ 0
Detector
$Comp
L Device:C C2
U 1 1 602027DD
P 3250 2150
F 0 "C2" V 3100 2150 50  0000 C CNN
F 1 "100n" V 3400 2150 50  0000 C CNN
F 2 "" H 3288 2000 50  0001 C CNN
F 3 "~" H 3250 2150 50  0001 C CNN
	1    3250 2150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR011
U 1 1 6020354A
P 3550 2250
F 0 "#PWR011" H 3550 2000 50  0001 C CNN
F 1 "GND" H 3555 2077 50  0000 C CNN
F 2 "" H 3550 2250 50  0001 C CNN
F 3 "" H 3550 2250 50  0001 C CNN
	1    3550 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 2150 3100 2150
Wire Wire Line
	1650 2500 1650 2650
$Comp
L Device:CP C4
U 1 1 6020B537
P 3250 1650
F 0 "C4" V 3400 1650 50  0000 C CNN
F 1 "100u" V 3100 1650 50  0000 C CNN
F 2 "" H 3288 1500 50  0001 C CNN
F 3 "~" H 3250 1650 50  0001 C CNN
	1    3250 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3100 1650 2950 1650
Wire Wire Line
	3400 2150 3550 2150
Wire Wire Line
	3550 2150 3550 1650
Connection ~ 3550 2150
Wire Wire Line
	3400 1650 3550 1650
$Comp
L Timer:TLC555xP U3
U 1 1 6021C84F
P 9450 2700
F 0 "U3" H 9150 3100 50  0000 C CNN
F 1 "TLC555xP" H 9450 2700 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 10100 2300 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tlc555.pdf" H 10300 2300 50  0001 C CNN
	1    9450 2700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR013
U 1 1 60233035
P 9450 1650
F 0 "#PWR013" H 9450 1500 50  0001 C CNN
F 1 "VCC" H 9465 1823 50  0000 C CNN
F 2 "" H 9450 1650 50  0001 C CNN
F 3 "" H 9450 1650 50  0001 C CNN
	1    9450 1650
	1    0    0    -1  
$EndComp
Text GLabel 8350 2500 0    50   Input ~ 0
PULSE-A
Wire Wire Line
	8350 2500 8950 2500
$Comp
L Device:C C7
U 1 1 6023B393
P 10200 3200
F 0 "C7" H 10315 3246 50  0000 L CNN
F 1 "100n" H 10315 3155 50  0000 L CNN
F 2 "" H 10238 3050 50  0001 C CNN
F 3 "~" H 10200 3200 50  0001 C CNN
	1    10200 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 6023BE0A
P 8600 3200
F 0 "C5" H 8715 3246 50  0000 L CNN
F 1 "100n" H 8715 3155 50  0000 L CNN
F 2 "" H 8638 3050 50  0001 C CNN
F 3 "~" H 8600 3200 50  0001 C CNN
	1    8600 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 6023C0C4
P 10200 2300
F 0 "R11" H 10270 2346 50  0000 L CNN
F 1 "3k9" H 10270 2255 50  0000 L CNN
F 2 "" V 10130 2300 50  0001 C CNN
F 3 "~" H 10200 2300 50  0001 C CNN
	1    10200 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 3050 8600 2700
Wire Wire Line
	8600 2700 8950 2700
$Comp
L power:GND #PWR014
U 1 1 6024A8F8
P 9450 3500
F 0 "#PWR014" H 9450 3250 50  0001 C CNN
F 1 "GND" H 9455 3327 50  0000 C CNN
F 2 "" H 9450 3500 50  0001 C CNN
F 3 "" H 9450 3500 50  0001 C CNN
	1    9450 3500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6024B0C6
P 8600 3500
F 0 "#PWR012" H 8600 3250 50  0001 C CNN
F 1 "GND" H 8605 3327 50  0000 C CNN
F 2 "" H 8600 3500 50  0001 C CNN
F 3 "" H 8600 3500 50  0001 C CNN
	1    8600 3500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 6024B2C9
P 10200 3500
F 0 "#PWR016" H 10200 3250 50  0001 C CNN
F 1 "GND" H 10205 3327 50  0000 C CNN
F 2 "" H 10200 3500 50  0001 C CNN
F 3 "" H 10200 3500 50  0001 C CNN
	1    10200 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 3350 10200 3500
Wire Wire Line
	9450 3100 9450 3500
Wire Wire Line
	8600 3350 8600 3500
Wire Wire Line
	10200 2450 10200 2700
Wire Wire Line
	9950 2700 10200 2700
Connection ~ 10200 2700
Wire Wire Line
	10200 2700 10200 2900
Wire Wire Line
	10200 2900 9950 2900
Connection ~ 10200 2900
Wire Wire Line
	10200 2900 10200 3050
Text GLabel 10550 2500 2    50   Output ~ 0
PULSE-B
Wire Wire Line
	9950 2500 10550 2500
Wire Wire Line
	8950 2900 8850 2900
$Comp
L Device:C C6
U 1 1 60268467
P 9650 2100
F 0 "C6" V 9500 2100 50  0000 C CNN
F 1 "100n" V 9800 2100 50  0000 C CNN
F 2 "" H 9688 1950 50  0001 C CNN
F 3 "~" H 9650 2100 50  0001 C CNN
	1    9650 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	9450 1650 9450 1750
$Comp
L power:GND #PWR015
U 1 1 6026C1B5
P 9800 2100
F 0 "#PWR015" H 9800 1850 50  0001 C CNN
F 1 "GND" V 9805 1972 50  0000 R CNN
F 2 "" H 9800 2100 50  0001 C CNN
F 3 "" H 9800 2100 50  0001 C CNN
	1    9800 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10200 1750 10200 2150
Connection ~ 9450 1750
Wire Wire Line
	8850 1750 9450 1750
Wire Wire Line
	8850 1750 8850 2900
Wire Wire Line
	9450 1750 10200 1750
Wire Wire Line
	9450 1750 9450 2100
Wire Wire Line
	9500 2100 9450 2100
Connection ~ 9450 2100
Wire Wire Line
	9450 2100 9450 2300
$Comp
L Device:C C3
U 1 1 6027E87B
P 1850 2650
F 0 "C3" V 1700 2650 50  0000 C CNN
F 1 "100n" V 2000 2650 50  0000 C CNN
F 2 "" H 1888 2500 50  0001 C CNN
F 3 "~" H 1850 2650 50  0001 C CNN
	1    1850 2650
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 60280D56
P 2000 2650
F 0 "#PWR010" H 2000 2400 50  0001 C CNN
F 1 "GND" V 2005 2522 50  0000 R CNN
F 2 "" H 2000 2650 50  0001 C CNN
F 3 "" H 2000 2650 50  0001 C CNN
	1    2000 2650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1700 2650 1650 2650
Connection ~ 1650 2650
Wire Wire Line
	1650 2650 1650 2800
Wire Wire Line
	2950 1400 2950 1650
Text Notes 8750 1300 0    118  ~ 0
Pulse Extension
$Comp
L Device:Buzzer BZ1
U 1 1 60297F5A
P 9600 5350
F 0 "BZ1" H 9752 5379 50  0000 L CNN
F 1 "Buzzer" H 9752 5288 50  0000 L CNN
F 2 "" V 9575 5450 50  0001 C CNN
F 3 "~" V 9575 5450 50  0001 C CNN
	1    9600 5350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 6029AEBD
P 9400 5500
F 0 "#PWR018" H 9400 5250 50  0001 C CNN
F 1 "GND" H 9405 5327 50  0000 C CNN
F 2 "" H 9400 5500 50  0001 C CNN
F 3 "" H 9400 5500 50  0001 C CNN
	1    9400 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 5450 9400 5450
Wire Wire Line
	9400 5450 9400 5500
Text GLabel 8850 5250 0    50   Input ~ 0
PULSE-B
$Comp
L Jumper:Jumper_2_Open JP1
U 1 1 6029F8D4
P 9150 5250
F 0 "JP1" H 9150 5485 50  0000 C CNN
F 1 "Buzzer on" H 9150 5394 50  0000 C CNN
F 2 "" H 9150 5250 50  0001 C CNN
F 3 "~" H 9150 5250 50  0001 C CNN
	1    9150 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9350 5250 9500 5250
$Comp
L Connector:Conn_01x02_Male J1
U 1 1 602A360A
P 9700 6100
F 0 "J1" H 9672 5982 50  0000 R CNN
F 1 "Pulse Out" H 9672 6073 50  0000 R CNN
F 2 "" H 9700 6100 50  0001 C CNN
F 3 "~" H 9700 6100 50  0001 C CNN
	1    9700 6100
	-1   0    0    1   
$EndComp
Wire Wire Line
	8850 5250 8950 5250
Text GLabel 8850 6000 0    50   Input ~ 0
PULSE-B
$Comp
L power:GND #PWR019
U 1 1 602AAF13
P 9400 6150
F 0 "#PWR019" H 9400 5900 50  0001 C CNN
F 1 "GND" H 9405 5977 50  0000 C CNN
F 2 "" H 9400 6150 50  0001 C CNN
F 3 "" H 9400 6150 50  0001 C CNN
	1    9400 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 6000 9500 6000
Wire Wire Line
	9400 6150 9400 6100
Wire Wire Line
	9400 6100 9500 6100
$Comp
L Device:R R12
U 1 1 602C68B9
P 1900 6200
F 0 "R12" V 2000 6200 50  0000 C CNN
F 1 "3k3" V 1784 6200 50  0000 C CNN
F 2 "" V 1830 6200 50  0001 C CNN
F 3 "~" H 1900 6200 50  0001 C CNN
	1    1900 6200
	0    1    1    0   
$EndComp
$Comp
L Device:D_Zener D5
U 1 1 602C754E
P 2150 6450
F 0 "D5" V 2104 6530 50  0000 L CNN
F 1 "3V3" V 2195 6530 50  0000 L CNN
F 2 "" H 2150 6450 50  0001 C CNN
F 3 "~" H 2150 6450 50  0001 C CNN
	1    2150 6450
	0    1    1    0   
$EndComp
Text GLabel 1550 6200 0    50   Input ~ 0
PULSE-B
Wire Wire Line
	1550 6200 1750 6200
$Comp
L power:GND #PWR017
U 1 1 602CD14A
P 2150 6750
F 0 "#PWR017" H 2150 6500 50  0001 C CNN
F 1 "GND" H 2155 6577 50  0000 C CNN
F 2 "" H 2150 6750 50  0001 C CNN
F 3 "" H 2150 6750 50  0001 C CNN
	1    2150 6750
	1    0    0    -1  
$EndComp
$Comp
L project:EzSBC_ESP32-01 U1
U 1 1 602D4760
P 3650 6150
F 0 "U1" H 3650 7365 50  0000 C CNN
F 1 "EzSBC_ESP32-01" H 3650 7274 50  0000 C CNN
F 2 "" H 3650 7050 50  0001 C CNN
F 3 "" H 3650 7050 50  0001 C CNN
	1    3650 6150
	-1   0    0    1   
$EndComp
Wire Wire Line
	2050 6200 2150 6200
Wire Wire Line
	2150 6200 2150 6300
Wire Wire Line
	2150 6600 2150 6750
$Comp
L Device:C C8
U 1 1 6032AB87
P 5050 6950
F 0 "C8" H 5165 6996 50  0000 L CNN
F 1 "100n" H 5165 6905 50  0000 L CNN
F 2 "" H 5088 6800 50  0001 C CNN
F 3 "~" H 5050 6950 50  0001 C CNN
	1    5050 6950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C9
U 1 1 6032EF00
P 5800 6950
F 0 "C9" H 5918 6996 50  0000 L CNN
F 1 "1000u" H 5918 6905 50  0000 L CNN
F 2 "" H 5838 6800 50  0001 C CNN
F 3 "~" H 5800 6950 50  0001 C CNN
	1    5800 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 6800 5050 6800
Wire Wire Line
	4600 6900 4750 6900
Wire Wire Line
	4750 6900 4750 7100
Wire Wire Line
	4750 7100 5050 7100
Connection ~ 5050 7100
$Comp
L power:GND #PWR020
U 1 1 60339CCE
P 5050 7150
F 0 "#PWR020" H 5050 6900 50  0001 C CNN
F 1 "GND" H 5055 6977 50  0000 C CNN
F 2 "" H 5050 7150 50  0001 C CNN
F 3 "" H 5050 7150 50  0001 C CNN
	1    5050 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 7100 5050 7150
Wire Wire Line
	5800 7100 5050 7100
$Comp
L power:VCC #PWR021
U 1 1 6033D2F0
P 5800 6350
F 0 "#PWR021" H 5800 6200 50  0001 C CNN
F 1 "VCC" H 5815 6523 50  0000 C CNN
F 2 "" H 5800 6350 50  0001 C CNN
F 3 "" H 5800 6350 50  0001 C CNN
	1    5800 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 5700 2450 5700
Wire Wire Line
	5050 6800 5200 6800
Connection ~ 5050 6800
Wire Wire Line
	5600 6800 5800 6800
Wire Wire Line
	5800 6800 5800 6350
Connection ~ 5800 6800
$Comp
L Jumper:Jumper_2_Bridged JP3
U 1 1 6035A20F
P 5400 6800
F 0 "JP3" H 5400 6995 50  0000 C CNN
F 1 "VCC to uC" H 5400 6904 50  0000 C CNN
F 2 "" H 5400 6800 50  0001 C CNN
F 3 "~" H 5400 6800 50  0001 C CNN
	1    5400 6800
	1    0    0    -1  
$EndComp
Text Notes 4850 6500 0    50   Italic 0
(!) WARNING (!)\nDO NOT CLOSE\nWHEN POWERED FROM\nBOTH USB AND VCC
$Comp
L Connector:Conn_01x04_Female J2
U 1 1 60363882
P 5250 4950
F 0 "J2" V 5200 5200 50  0000 R CNN
F 1 "I2C OLED 128x64 with SH1106" V 5350 5400 50  0000 R CNN
F 2 "" H 5250 4950 50  0001 C CNN
F 3 "~" H 5250 4950 50  0001 C CNN
	1    5250 4950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2700 6900 2550 6900
Wire Wire Line
	2550 6900 2550 7450
Wire Wire Line
	2550 7450 4750 7450
Wire Wire Line
	4750 7100 4750 7450
Connection ~ 4750 7100
Wire Wire Line
	5150 5300 5150 5150
Wire Wire Line
	5450 5600 5450 5150
Wire Wire Line
	4600 5700 5350 5700
Wire Wire Line
	5350 5700 5350 5150
$Comp
L power:GND #PWR022
U 1 1 6038B23D
P 5250 5350
F 0 "#PWR022" H 5250 5100 50  0001 C CNN
F 1 "GND" H 5255 5177 50  0000 C CNN
F 2 "" H 5250 5350 50  0001 C CNN
F 3 "" H 5250 5350 50  0001 C CNN
	1    5250 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 5150 5250 5350
Text Notes 5550 5100 0    50   Italic 0
pin layout depends \non used module
Text Notes 1000 5250 0    118  ~ 0
ESP32\nMicrocontroller
Text Notes 8800 4800 0    118  ~ 0
Outputs
$Comp
L Device:R R13
U 1 1 603B2486
P 4950 5450
F 0 "R13" H 5020 5496 50  0000 L CNN
F 1 "4k7" H 5020 5405 50  0000 L CNN
F 2 "" V 4880 5450 50  0001 C CNN
F 3 "~" H 4950 5450 50  0001 C CNN
	1    4950 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 5600 4950 5600
Wire Wire Line
	4950 5300 5150 5300
Connection ~ 4950 5600
Wire Wire Line
	4950 5600 5450 5600
Text Notes 7150 2350 0    50   ~ 0
pulse\napprox. 200us\nlow 0 V
Text Notes 10550 2350 0    50   ~ 0
pulse\napprox. 400us\nhigh VCC
Wire Wire Line
	3550 2150 3550 2250
NoConn ~ 2700 5200
NoConn ~ 2700 5300
NoConn ~ 2700 5400
NoConn ~ 2700 5500
NoConn ~ 2700 5600
NoConn ~ 2700 5800
NoConn ~ 2700 5900
NoConn ~ 2700 6000
NoConn ~ 2700 6100
NoConn ~ 2700 6300
NoConn ~ 2700 6400
NoConn ~ 2700 6500
NoConn ~ 2700 6700
NoConn ~ 2700 6800
NoConn ~ 4600 5200
NoConn ~ 4600 5500
NoConn ~ 4600 5800
NoConn ~ 4600 5900
NoConn ~ 4600 6000
NoConn ~ 4600 6100
NoConn ~ 4600 6200
NoConn ~ 4600 6300
NoConn ~ 4600 6400
NoConn ~ 4600 6500
NoConn ~ 4600 6600
NoConn ~ 4600 6700
NoConn ~ 4600 7000
NoConn ~ 2700 7000
NoConn ~ 2700 7100
NoConn ~ 4600 7100
$Comp
L power:GND #PWR0101
U 1 1 601D64A6
P 1950 5800
F 0 "#PWR0101" H 1950 5550 50  0001 C CNN
F 1 "GND" H 1955 5627 50  0000 C CNN
F 2 "" H 1950 5800 50  0001 C CNN
F 3 "" H 1950 5800 50  0001 C CNN
	1    1950 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 5700 1950 5700
Wire Wire Line
	1950 5700 1950 5800
$Comp
L Jumper:Jumper_2_Bridged JP2
U 1 1 60343981
P 2250 5700
F 0 "JP2" H 2250 5895 50  0000 C CNN
F 1 "WiFi on" H 2250 5804 50  0000 C CNN
F 2 "" H 2250 5700 50  0001 C CNN
F 3 "~" H 2250 5700 50  0001 C CNN
	1    2250 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1050 1650 2950 1650
$Comp
L power:GND #PWR024
U 1 1 601E1EB9
P 7750 5400
F 0 "#PWR024" H 7750 5150 50  0001 C CNN
F 1 "GND" H 7755 5227 50  0000 C CNN
F 2 "" H 7750 5400 50  0001 C CNN
F 3 "" H 7750 5400 50  0001 C CNN
	1    7750 5400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR023
U 1 1 601E23DB
P 7750 5100
F 0 "#PWR023" H 7750 4950 50  0001 C CNN
F 1 "VCC" H 7765 5273 50  0000 C CNN
F 2 "" H 7750 5100 50  0001 C CNN
F 3 "" H 7750 5100 50  0001 C CNN
	1    7750 5100
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J3
U 1 1 601E2CC3
P 7200 5300
F 0 "J3" H 7200 5100 50  0000 C CNN
F 1 "Power in" H 7500 5250 50  0000 C CNN
F 2 "" H 7200 5300 50  0001 C CNN
F 3 "~" H 7200 5300 50  0001 C CNN
	1    7200 5300
	-1   0    0    1   
$EndComp
Wire Wire Line
	7400 5300 7500 5300
$Comp
L power:GNDPWR #PWR0102
U 1 1 601FD717
P 7500 5400
F 0 "#PWR0102" H 7500 5200 50  0001 C CNN
F 1 "GNDPWR" H 7504 5246 50  0000 C CNN
F 2 "" H 7500 5350 50  0001 C CNN
F 3 "" H 7500 5350 50  0001 C CNN
	1    7500 5400
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 601FEC15
P 7500 5100
F 0 "#FLG0101" H 7500 5175 50  0001 C CNN
F 1 "PWR_FLAG" H 7500 5273 50  0000 C CNN
F 2 "" H 7500 5100 50  0001 C CNN
F 3 "~" H 7500 5100 50  0001 C CNN
	1    7500 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5400 7500 5300
Connection ~ 7500 5300
Wire Wire Line
	7400 5200 7500 5200
Wire Wire Line
	7500 5100 7500 5200
Connection ~ 7500 5200
Wire Wire Line
	7750 5200 7750 5100
Wire Wire Line
	7500 5200 7750 5200
Wire Wire Line
	7750 5300 7750 5400
Wire Wire Line
	7500 5300 7750 5300
Wire Wire Line
	4800 5400 4600 5400
Wire Wire Line
	4800 5300 4800 5400
Wire Wire Line
	4950 5300 4800 5300
Connection ~ 4950 5300
NoConn ~ 4600 5300
Wire Wire Line
	2150 6200 2700 6200
Connection ~ 2150 6200
NoConn ~ 2700 6600
$EndSCHEMATC