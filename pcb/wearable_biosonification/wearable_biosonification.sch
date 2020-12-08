EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R7
U 1 1 5FCB70EE
P 4700 3750
F 0 "R7" H 4770 3796 50  0000 L CNN
F 1 "100k" H 4770 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4630 3750 50  0001 C CNN
F 3 "~" H 4700 3750 50  0001 C CNN
	1    4700 3750
	0    -1   -1   0   
$EndComp
$Comp
L MCU_Module:Adafruit_Feather_HUZZAH32_ESP32 A1
U 1 1 5FCCECAA
P 6600 4350
F 0 "A1" H 7100 3800 50  0000 C CNN
F 1 "Adafruit_Feather_HUZZAH32_ESP32" H 7700 3700 50  0000 C CNN
F 2 "Module:Adafruit_Feather" H 6700 3000 50  0001 L CNN
F 3 "https://cdn-learn.adafruit.com/downloads/pdf/adafruit-huzzah32-esp32-feather.pdf" H 6600 3150 50  0001 C CNN
	1    6600 4350
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:LM324 U1
U 1 1 5FCD112D
P 2650 3750
F 0 "U1" H 2700 4000 50  0000 C CNN
F 1 "LM324" H 2750 3900 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2600 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2902-n.pdf" H 2700 3950 50  0001 C CNN
	1    2650 3750
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:LM324 U1
U 2 1 5FCD2F48
P 2650 5100
F 0 "U1" H 2650 5467 50  0000 C CNN
F 1 "LM324" H 2650 5376 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2600 5200 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2902-n.pdf" H 2700 5300 50  0001 C CNN
	2    2650 5100
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:LM324 U1
U 3 1 5FCD4415
P 4700 4450
F 0 "U1" H 4700 4817 50  0000 C CNN
F 1 "LM324" H 4700 4726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4650 4550 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2902-n.pdf" H 4750 4650 50  0001 C CNN
	3    4700 4450
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:LM324 U1
U 5 1 5FCD556E
P 2650 3750
F 0 "U1" H 2608 3796 50  0001 L CNN
F 1 "LM324" H 2608 3705 50  0001 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2600 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2902-n.pdf" H 2700 3950 50  0001 C CNN
	5    2650 3750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J1
U 1 1 5FCDEB91
P 1650 3650
F 0 "J1" H 1730 3642 50  0000 L CNN
F 1 "Electrodes" H 1730 3551 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-3.5-H_1x02_P3.50mm_Horizontal" H 1650 3650 50  0001 C CNN
F 3 "~" H 1650 3650 50  0001 C CNN
	1    1650 3650
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5FCE5C48
P 2050 3350
F 0 "R1" H 2120 3396 50  0000 L CNN
F 1 "1M" H 2120 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 1980 3350 50  0001 C CNN
F 3 "~" H 2050 3350 50  0001 C CNN
	1    2050 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5FCEDD0E
P 2750 5700
F 0 "R2" H 2820 5746 50  0000 L CNN
F 1 "100k" H 2820 5655 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 2680 5700 50  0001 C CNN
F 3 "~" H 2750 5700 50  0001 C CNN
	1    2750 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 5FCEE326
P 3250 3750
F 0 "R3" H 3320 3796 50  0000 L CNN
F 1 "100k" H 3320 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 3180 3750 50  0001 C CNN
F 3 "~" H 3250 3750 50  0001 C CNN
	1    3250 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 5FCF033D
P 3950 4550
F 0 "R5" H 4020 4596 50  0000 L CNN
F 1 "10k" H 4020 4505 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 3880 4550 50  0001 C CNN
F 3 "~" H 3950 4550 50  0001 C CNN
	1    3950 4550
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R6
U 1 1 5FCF0A36
P 3950 5100
F 0 "R6" H 4020 5146 50  0000 L CNN
F 1 "10k" H 4020 5055 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 3880 5100 50  0001 C CNN
F 3 "~" H 3950 5100 50  0001 C CNN
	1    3950 5100
	0    -1   -1   0   
$EndComp
Text GLabel 7100 4150 2    50   Input ~ 0
AnalogIn
$Comp
L power:GND #PWR06
U 1 1 5FD0F0BB
P 6600 5650
F 0 "#PWR06" H 6600 5400 50  0001 C CNN
F 1 "GND" H 6605 5477 50  0000 C CNN
F 2 "" H 6600 5650 50  0001 C CNN
F 3 "" H 6600 5650 50  0001 C CNN
	1    6600 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT_US RV1
U 1 1 5FD31500
P 2050 2950
F 0 "RV1" H 1982 2904 50  0000 R CNN
F 1 "1M" H 1982 2995 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_3386X_Horizontal" H 2050 2950 50  0001 C CNN
F 3 "~" H 2050 2950 50  0001 C CNN
	1    2050 2950
	1    0    0    1   
$EndComp
$Comp
L Device:R_POT_US RV2
U 1 1 5FD34967
P 3050 3000
F 0 "RV2" V 2845 3000 50  0000 C CNN
F 1 "100k" V 2936 3000 50  0000 C CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_3386X_Horizontal" H 3050 3000 50  0001 C CNN
F 3 "~" H 3050 3000 50  0001 C CNN
	1    3050 3000
	0    1    1    0   
$EndComp
Wire Wire Line
	2050 3650 2050 3500
$Comp
L power:GND #PWR02
U 1 1 5FDA74A6
P 2350 3050
F 0 "#PWR02" H 2350 2800 50  0001 C CNN
F 1 "GND" H 2355 2877 50  0000 C CNN
F 2 "" H 2350 3050 50  0001 C CNN
F 3 "" H 2350 3050 50  0001 C CNN
	1    2350 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2950 2350 2950
Wire Wire Line
	2350 2950 2350 3050
Wire Wire Line
	2050 3100 2050 3200
$Comp
L Device:R R4
U 1 1 5FCE6206
P 3750 3750
F 0 "R4" H 3820 3796 50  0000 L CNN
F 1 "10k" H 3820 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 3680 3750 50  0001 C CNN
F 3 "~" H 3750 3750 50  0001 C CNN
	1    3750 3750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2350 3650 2050 3650
Connection ~ 2050 3650
$Comp
L power:GND #PWR03
U 1 1 5FDF7A0D
P 2550 4050
F 0 "#PWR03" H 2550 3800 50  0001 C CNN
F 1 "GND" H 2555 3877 50  0000 C CNN
F 2 "" H 2550 4050 50  0001 C CNN
F 3 "" H 2550 4050 50  0001 C CNN
	1    2550 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 3750 2050 3750
Wire Wire Line
	2950 3750 3050 3750
Wire Wire Line
	2050 5000 2350 5000
Wire Wire Line
	3400 3750 3500 3750
Wire Wire Line
	3500 3750 3500 4350
Wire Wire Line
	3500 4350 2250 4350
Wire Wire Line
	2250 4350 2250 3850
Wire Wire Line
	2250 3850 2350 3850
Connection ~ 3500 3750
Wire Wire Line
	3500 3750 3600 3750
Wire Wire Line
	3900 3750 4200 3750
Wire Wire Line
	4200 3750 4200 4350
Wire Wire Line
	4200 4350 4400 4350
Wire Wire Line
	3050 3150 3050 3750
Connection ~ 3050 3750
Wire Wire Line
	3050 3750 3100 3750
Wire Wire Line
	2900 3000 2600 3000
Wire Wire Line
	2600 3000 2600 2600
Wire Wire Line
	2600 2600 1000 2600
Wire Wire Line
	1000 2600 1000 5200
Wire Wire Line
	1000 5200 2050 5200
Wire Wire Line
	4850 3750 5150 3750
Wire Wire Line
	5150 3750 5150 4450
Wire Wire Line
	5150 4450 5000 4450
Wire Wire Line
	4550 3750 4200 3750
Connection ~ 4200 3750
$Comp
L power:GND #PWR05
U 1 1 5FE9971A
P 5150 4550
F 0 "#PWR05" H 5150 4300 50  0001 C CNN
F 1 "GND" H 5155 4377 50  0000 C CNN
F 2 "" H 5150 4550 50  0001 C CNN
F 3 "" H 5150 4550 50  0001 C CNN
	1    5150 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 4550 5150 4450
Connection ~ 5150 4450
Text GLabel 5350 4450 2    50   Output ~ 0
AnalogIn
Wire Wire Line
	5350 4450 5150 4450
NoConn ~ 6100 3550
NoConn ~ 6100 3650
NoConn ~ 6100 3750
NoConn ~ 6100 3850
NoConn ~ 6100 3950
NoConn ~ 6100 4050
NoConn ~ 6100 4150
NoConn ~ 6100 4250
NoConn ~ 6100 4450
NoConn ~ 6100 4550
NoConn ~ 6100 4650
NoConn ~ 6100 4850
NoConn ~ 6100 4950
NoConn ~ 6100 5150
NoConn ~ 6100 5250
NoConn ~ 7100 4650
NoConn ~ 7100 4550
NoConn ~ 7100 4450
NoConn ~ 7100 4350
NoConn ~ 7100 4250
NoConn ~ 7100 3850
NoConn ~ 7100 3550
NoConn ~ 6500 3150
NoConn ~ 6800 3150
$Comp
L power:GND #PWR04
U 1 1 5FEFD5C5
P 3650 4600
F 0 "#PWR04" H 3650 4350 50  0001 C CNN
F 1 "GND" H 3655 4427 50  0000 C CNN
F 2 "" H 3650 4600 50  0001 C CNN
F 3 "" H 3650 4600 50  0001 C CNN
	1    3650 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 5200 2050 5700
Wire Wire Line
	2050 5700 2600 5700
Connection ~ 2050 5200
Wire Wire Line
	2050 5200 2350 5200
Wire Wire Line
	2900 5700 3650 5700
Wire Wire Line
	4200 4550 4400 4550
Wire Wire Line
	4100 4550 4200 4550
Connection ~ 4200 4550
Wire Wire Line
	3800 4550 3650 4550
Wire Wire Line
	3650 4550 3650 4600
Wire Wire Line
	4200 5100 4100 5100
Wire Wire Line
	4200 4550 4200 5100
Wire Wire Line
	3650 5700 3650 5100
Wire Wire Line
	3650 5100 3800 5100
Wire Wire Line
	2950 5100 3650 5100
Connection ~ 3650 5100
NoConn ~ 3200 3000
NoConn ~ 2050 2800
Text GLabel 6700 3000 1    50   Output ~ 0
Vfeather
Wire Wire Line
	6700 3150 6700 3000
Text GLabel 2550 3400 1    50   Input ~ 0
Vfeather
Wire Wire Line
	2550 3400 2550 3450
Wire Wire Line
	1850 3650 2050 3650
$Comp
L Device:R R8
U 1 1 5FD1634A
P 4700 2550
F 0 "R8" H 4770 2596 50  0000 L CNN
F 1 "1k" H 4770 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4630 2550 50  0001 C CNN
F 3 "~" H 4700 2550 50  0001 C CNN
	1    4700 2550
	0    1    1    0   
$EndComp
$Comp
L Device:LED_ALT D1
U 1 1 5FD1F003
P 4250 2550
F 0 "D1" H 4243 2295 50  0000 C CNN
F 1 "LED" H 4243 2386 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4250 2550 50  0001 C CNN
F 3 "~" H 4250 2550 50  0001 C CNN
	1    4250 2550
	-1   0    0    1   
$EndComp
Wire Wire Line
	4400 2550 4550 2550
Text GLabel 4100 2550 0    50   Input ~ 0
Vfeather
$Comp
L power:GND #PWR01
U 1 1 5FD35904
P 5000 2650
F 0 "#PWR01" H 5000 2400 50  0001 C CNN
F 1 "GND" H 5005 2477 50  0000 C CNN
F 2 "" H 5000 2650 50  0001 C CNN
F 3 "" H 5000 2650 50  0001 C CNN
	1    5000 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 2550 5000 2550
Wire Wire Line
	5000 2550 5000 2650
Wire Wire Line
	2050 3750 2050 5000
$EndSCHEMATC
