#!/usr/bin/perl
#


sub create_html_body_main_glossary {
	my $text = '';
	$title_ext_global = 'Glossary';
	$keyword_ext_global = 'glossary';

	$text = <<Endhtml;
	<div class="heading1">Glossary</div>


	<div class="heading2">A</div><br />

	<div class="heading3">A.b - ACCESS.bus</div>
	<div class="gloss_value">
		<b>Definition: a peripheral-interconnect computer bus</b><br />
		<a href="http://en.wikipedia.org/wiki/ACCESS.bus">Wikipedia article</a>
	</div>

	<div class="heading3">ADC - Analog to Digital Converter</div>
	<div class="gloss_value">
		<b>Definition:</b> a unit that takes analog signals and converts them to digital.  Commonly incorporated in MCUs. Sometimes abbreviated as A/D<br />
		<a href="http://en.wikipedia.org/wiki/Analog-to-digital_converter">Wikipedia article</a>
	</div>

	<div class="heading3">ATM - Asynchronous Transfer Mode</div>
	<div class="gloss_value">
		<b>Definition:</b> a networking protocol<br />
		<a href="http://en.wikipedia.org/wiki/Asynchronous_Transfer_Mode">Wikipedia article</a>
	</div>

	<div class="heading3">ATAPI - Advanced Technology Attachment Packet Interface</div>
	<div class="gloss_value">
		<b>Definition: connection for other storage devices such as CD-ROM drives and tape drives to the Parallel ATA interface</b><br />
		<a href="http://en.wikipedia.org/wiki/Parallel_ATA#ATAPI">Wikipedia article</a>
	</div>

	<div class="heading3">ASIC - Application Specific Integrated Circuit</div>
	<div class="gloss_value">
		<b>Definition:</b> a custom IC<br />
		<a href="http://en.wikipedia.org/wiki/Application-specific_integrated_circuit">Wikipedia article</a>
	</div>



	<br /><br /><div class="heading2">B</div><br />

	<div class="heading3">Bipolar</div>
	<div class="gloss_value">
		See: Bipolar junction transistor
	</div>

	<div class="heading3">BJT - Bipolar junction transistor</div>
	<div class="gloss_value">
		<b>Definition:</b> 3-terminal transistor, NPN or PNP. Current controlled-current source<br />
		<a href="http://en.wikipedia.org/wiki/Bipolar_junction_transistor">Wikipedia article</a>
	</div>

	<div class="heading3">BiCMOS</div>
	<div class="gloss_value">
		<b>Definition:</b> combining BJTs and CMOS technology on the same device (die) Pentium, Pentium Pro, and SuperSPARC used BiCMOS<br />
		<a href="http://en.wikipedia.org/wiki/BiCMOS">Wikipedia article</a>
	</div>

	<div class="heading3">BOR - Brown-out Reset</div>
	<div class="gloss_value">
		<b>Definition:</b> Reset when the Vcc drops below a certain level<br />
		<a href="http://en.wikipedia.org/wiki/Immunity-aware_programming#Brown-out">Wikipedia article</a>
	</div>

	<div class="heading3">BSSP - Basic Synchronous Serial Port</div>
	<div class="gloss_value">
		<b>Definition: a serial interface useful for communicating with other peripheral or microcontroller devices uing SPI or I2C</b><br />
		<a href="http://en.wikipedia.org/wiki/Synchronous Serial Port">Wikipedia article</a>
	</div>	



	<br /><br /><div class="heading2"><a name="C">C</a></div><br />

	<div class="heading3">C2SIa - Class II Serial Interface A</div>
	<div class="gloss_value">

		<b>Definition:  a communication module used for transmitting and receiving data over a multi-master network, follows the J1850 Class B protocal</b><br />
	</div>

	<div class="heading3">C2SIb - Class II Serial Interface B</div>
	<div class="gloss_value">
		<b>Definition:  a communication module used for transmitting and receiving data over a multi-master network, follows the J1850 Class B protocal</b><br />
	</div>

		<div class="heading3">Carry look-ahead adder</div>
	<div class="gloss_value">
		<b>Definition:</b> faster binary adder that looks ahead instead of rippling through the bits<br />
		<a href="http://en.wikipedia.org/wiki/Carry_look-ahead_adder">Wikipedia article</a>
	</div>

	<div class="heading3">CAN - Controller-area network</div>
	<div class="gloss_value">
		<b>Definition:</b> A communications protocol for vehicles<br />
		<a href="http://en.wikipedia.org/wiki/Controller-area_network">Wikipedia article</a>
	</div>

	<div class="heading3">CCP - Capture/Compare/PWM</div>
	<div class="gloss_value">
capture register, as a 16-bit compare register or as a 10-bit PWM
		<b>Definition:</b> a module that can operate as capture, compare or PWM register<br />
		<a href="white_sheet-Microchip-compare_capture_pwm_module.pdf">Microchip White sheet</a>
	</div>


	<div class="heading3">CGC - Clock Generator Module</div>
	<div class="gloss_value">
		<b>Definition: generates the base clock signal</b><br />
	</div>

	<div class="heading3">COP - Computer Operating Properly</div>
	<div class="gloss_value">
		<b>See: Watchdog timer</b><br />
		<a href="http://en.wikipedia.org/wiki/Watchdog_timer">Wikipedia article</a>
	</div>
	
	<div class="heading3">CTC - Counter/Timer Circuit</div>
	<div class="gloss_value">
		<b>Definition:</b> a module that can be used as counter or timer<br />
		<a href="http://en.wikipedia.org/wiki/Counter">Wikipedia article</a>
	</div>

	<div class="heading3">Chipset</div>
	<div class="gloss_value">
		<b>Definition:</b> group of chips designed to work with a CPU to preform basic functions such as bus interfaces<br />
		<a href="http://en.wikipedia.org/wiki/Chipset">Wikipedia article</a>
	</div>

	<div class="heading3">Chip package</div>
	<div class="gloss_value">
		<b>Definition:</b> The container that holds the integrated circuits die, wire-bound to the pins<br />
		AKA: chip carrier, chip container <br />
		<a href="http://en.wikipedia.org/wiki/Chip_carrier">Wikipedia article</a>
	</div>

	<div class="heading3">CPU - Central Processing Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> a chip or (rarely) a collection of chips that preforms the processing of data for a computer.  On microcontroller the CPU is a portion of the chip that does the computations or processing of data.<br />
		<a href="http://en.wikipedia.org/wiki/Central_processing_unit">Wikipedia article</a>
	</div>

	<div class="heading3">Core, ie Processor Core</div>
	<div class="gloss_value">
		<b>Definition:</b> the portion of the chip that is defined as the processing unit. Multi-core CPUs have multiply processing unit<br />
		<a href="http://en.wikipedia.org/wiki/Processor_core">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="D">D</a></div><br />

	<div class="heading3">DAC - Digital to Analog Converter</div>
	<div class="gloss_value">
		<b>Definition:</b> Unit used to output analog signals from digital signals.  Sometimes used in MCUs <br />
		<a href="http://en.wikipedia.org/wiki/Digital-to-analog_converter">Wikipedia article</a>
	</div>

	<div class="heading3">DAI - Digital Applications Interface</div>
	<div class="gloss_value">
		<b>Definition:  a module within SHARC DSPs for user-definable access to peripherals</b><br />
	</div>
	
	<div class="heading3">DALI - Digitally Addressable Lighting Interface</div>
	<div class="gloss_value">
		<b>Definition:a electrical interface and bus protocol mainly used to control lightning systems</b><br />
		<a href="http://en.wikipedia.org/wiki/Digital_Addressable_Lighting_Interface">Wikipedia article</a>
	</div>

	<div class="heading3">DDC - Display Data Channel</div>
	<div class="gloss_value">
		<b>Definition: digital communication protocols between a computer display and a graphics adapter.  Protocals include DDC1, DDC2 or DDC2B, DDC2Ab, DDC2B+, DDC3Bi, E-DDC</b><br />
		<a href="http://en.wikipedia.org/wiki/Display_Data_Channel">Wikipedia article</a>
	</div>

	<div class="heading3">DES - Data Encryption Standard</div>
	<div class="gloss_value">
		<b>Definition: a block cipher that uses shared secret encryption</b><br />
		<a href="http://en.wikipedia.org/wiki/Data_Encryption_Standard">Wikipedia article</a>
	</div>

	<div class="heading3">Die</div>
	<div class="gloss_value">
	<b>Definition:</b>  The actual silicon integrated circuit inside the chip package<br />
		<a href="http://en.wikipedia.org/wiki/Die_(integrated_circuit)">Wikipedia article</a>
	</div>

	<div class="heading3">DRAM - Dynamic random access memory</div>
	<div class="gloss_value">
		<b>Definition:</b> Memory that stores each bit in a capacitor, which needs to be refreshed or it will lose it data.<br />
		<a href="http://en.wikipedia.org/wiki/Dynamic_random_access_memory">Wikipedia article</a>
	</div>

	<div class="heading3">DMA - Direct memory access</div>
	<div class="gloss_value">
		<b>Definition:</b> allows hardware to access memory independent of CPU.<br />
		<a href="http://en.wikipedia.org/wiki/Direct_memory_access">Wikipedia article</a>
	</div>

	<div class="heading3">DMOS - Double-Diffused Metal-Oxide-Semiconductor</div>
	<div class="gloss_value">
		<b>Definition:</b> Used in power MOSFETs.<br />
		<a href="http://en.wikipedia.org/wiki/DMOS">Wikipedia article</a>
	</div>

	<div class="heading3">DPI - Digital Peripheral Interface</div>
	<div class="gloss_value">
		<b>Definition: a module within SHARC DSPs for user-definable access to peripherals</b><br />
	</div>


	<br /><br /><div class="heading2"><a name="E">E</a></div><br />

	<div class="heading3">Embedded system</div>
	<div class="gloss_value">
		<b>Definition:</b> A computer system design for a specific operation, unlike general purpose computers like desktop computers, or servers<br />
		<a href="http://en.wikipedia.org/wiki/Embedded_system">Wikipedia article</a>
	</div>

	<div class="heading3">EPROM - Erasable Programmable Read-Only Memory</div>
	<div class="gloss_value">
		<b>Definition:</b> ROM that can be reprogrammed, usually erased using UV light.  See UV-EPROM<br />
		<a href="http://en.wikipedia.org/wiki/EPROM">Wikipedia article</a>
	</div>


	<div class="heading3">EEPROM - Electronically Erasable Programmable Read-Only Memory</div>
	<div class="gloss_value">
		<b>Definition:</b> EPROM that can be erased using electricity, not UV light. Sometimes in circuit, which is much easier and more practical than UV-EPROMs. Flash is a type of EEPROM.<br />
		<a href="http://en.wikipedia.org/wiki/EEPROM">Wikipedia article</a>
	</div>


	<div class="heading3">ECC - Error Correction Code</div>
	<div class="gloss_value">
		<b>Definition:</b> A type of coding by adding redundancy to data for error correction.<br />
		<a href="http://en.wikipedia.org/wiki/Error_detection_and_correction#Error-correcting_code">Wikipedia article</a>
	</div>

	<div class="heading3">EMA - External Memory Addressing</div>
	<div class="gloss_value">
		<b>Definition:</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">EPort</div>
	<div class="gloss_value">
		<b>Definition:</b>?<br />
		<a href="http://en.wikipedia.org/wiki/"></a>
	</div>

	<div class="heading3">ESCI</div>
	<div class="gloss_value">
		<b>Definition:</b>?<br />
		<a href="http://en.wikipedia.org/wiki/"></a>
	</div>



	<br /><br /><div class="heading2"><a name="F">F</a></div><br />

	<div class="heading3">FIFO - First In, First Out</div>
	<div class="gloss_value">
		<b>Definition: a way data stored in a queue is processed</b><br />
		<a href="http://en.wikipedia.org/wiki/FIFO">Wikipedia article</a>
	</div>

	<div class="heading3">FPU - Floating Point Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> a separate unit for preforming floating point operation, as separate chip, sometimes a separate unit on the processor and included in the instruction set.  Sometimes a co-processor is referred to as an FPU, even if its math operations are not all floating point <br />
		<a href="http://en.wikipedia.org/wiki/Floating_point_unit">Wikipedia article</a>
	</div>

	<div class="heading3">FPGA - Field Programmable Gate Array</div>
	<div class="gloss_value">
		<b>Definition:</b> Programmable logic chip, the most complex and expensive programmable logic chip, generally used for development. <br />
		<a href="http://en.wikipedia.org/wiki/Field-programmable_gate_array">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="G">G</a></div><br />

	<div class="heading3">GPIO - General Purpose Input/Output</div>
	<div class="gloss_value">
		<b>Definition:</b> pins that can be assigned input or output and be used for any reason<br />
		<a href="http://en.wikipedia.org/wiki/General_Purpose_Input/Output">Wikipedia article</a>
	</div>

	<div class="heading3">G.Lite</div>
	<div class="gloss_value">
		<b>Definition:</b> an ADSL telecommunications protocol, AKA ITU G.992.2<br />
		<a href="http://en.wikipedia.org/wiki/G.Lite">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="H">H</a></div><br />

	<div class="heading3">HDLC - High-Level Data Link Control</div>
	<div class="gloss_value">
		<b>Definition:</b> Internet data transfer protocol <br />
		<a href="http://en.wikipedia.org/wiki/High-Level_Data_Link_Control">Wikipedia article</a>
	</div>

	<div class="heading3">HMOS - High-preformance NMOS or high-speed NMOS</div>
	<div class="gloss_value">
		<b>Definition:</b> Depletion load NMOS logic gates, for higher speed and lower power consumption<br />
		<a href="http://en.wikipedia.org/wiki/Depletion-load_NMOS_logic">Wikipedia article</a>
	</div>

	<div class="heading3">Hsync - Horizontal Synchronization</div>
	<div class="gloss_value">
		<b>Definition:</b> has to do with synchronizing display on a CRT monitor or TV <br />
		<a href="http://en.wikipedia.org/wiki/sync">Wikipedia article</a>
	</div>


	<div class="heading3">Hyper-threading</div>
	<div class="gloss_value">
		<b>Definition:</b> Intel's term for its simultaneous multi-threading<br />
		<a href="http://en.wikipedia.org/wiki/Hyperthreading">Wikipedia article</a>
	</div>




	<br /><br /><div class="heading2"><a name="I">I</a></div><br />

	<div class="heading3">ICSP - In-Circuit Serial Programming</div>
	<div class="gloss_value">
		<b>Definition:</b> a method of directly programming certain microcontrollers<br />
		<a href="http://en.wikipedia.org/wiki/In-circuit_serial_programming">Wikipedia article</a>
	</div>
	
	<div class="heading3">IDE - Integrated Drive Electronics</div>
	<div class="gloss_value">
		<b>Definition: the first version of ATA/ATAPI interface (ATA-1) for compunications with hard drives, CDROMs, etc</b><br />
		<a href="http://en.wikipedia.org/wiki/Parallel_ATA#IDE_and_ATA-1">Wikipedia article</a>
	</div>

	<div class="heading3">IRSCI - Infrared Serial Communications Interface</div>
	<div class="gloss_value">
		<b>Definition: module which allows high-speed asynchronous communications with peripheral devices and other MCUs</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">IrDA - Infrared Data Association</div>
	<div class="gloss_value">
		<b>Definition: a communications protocol for the short-range exchange of data over infrared light</b><br />
		<a href="http://en.wikipedia.org/wiki/Infrared_Data_Association">Wikipedia article</a>
	</div>

	<div class="heading3">ISA - Instruction Set Architecture</div>
	<div class="gloss_value">
		<b>Definition:</b> Processor's architecture defined by a standard Instruction Set<br />
		<a href="http://en.wikipedia.org/wiki/Instruction_Set_Architecture">Wikipedia article</a>
	</div>

	<div class="heading3">IEBus - Inter Equipment Bus</div>
	<div class="gloss_value">
		<b>Definition:</b> a two wire bus used in the automotive industry as a communications bus between various devices<br />
		<a href="http://en.wikipedia.org/wiki/IEBus">Wikipedia article</a>
	</div>

	<div class="heading3">Interrupt</div>
	<div class="gloss_value">
		<b>Definition:</b> A signal that alerts a unit an event need attending <br />
		<a href="http://en.wikipedia.org/wiki/Interrupt">Wikipedia article</a>
	</div>



	<div class="heading3">I/O - Input/Output</div>
	<div class="gloss_value">
		<b>Definition:</b> IC pins can designated as input or output or in some cases bidirectional, allowing input and output on the same pin<br />
		<a href="http://en.wikipedia.org/wiki/Input/output">Wikipedia article</a>
	</div>

	<div class="heading3">I2C or I<sup>2</sup>C - Inter-Integrated Circuit</div>
	<div class="gloss_value">
		<b>Definition:</b> a popular serial communication protocol, pronounced "I squared C" <br />
		<a href="http://en.wikipedia.org/wiki/I2C">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="J">J</a></div><br />

	<div class="heading3">JTAG</div>
	<div class="gloss_value">
		<b>Definition:</b> a communications protocol commonly used for debugging and programing devices<br />
		<a href="http://en.wikipedia.org/wiki/JTAG">Wikipedia article</a>
	</div>

	<br /><br /><div class="heading2"><a name="L">L</a></div><br />

	<div class="heading3">L1 cache - Level 1 cache</div>
	<div class="gloss_value">
		<b>Definition:</b> the first level of cache memory, used for data and program code, sometimes shared, sometimes separate memory for each. Generally small in size, but is fast running at the speed of the processor.  Data cache is in Bytes or Kilobytes.  Instruction cache is Instructions or Kilo-instructions, size depending on the width of instructions. <br />
		<a href="http://en.wikipedia.org/wiki/L1_cache">Wikipedia article</a>
	</div>

	<div class="heading3">L2 cache - Level 2 cache</div>
	<div class="gloss_value">
		<b>Definition:</b> Shared data and instruction memory, larger in size to L1 cache but slower <br />
		<a href="http://en.wikipedia.org/wiki/L2_cache">Wikipedia article</a>
	</div>

	<div class="heading3">L3 cache - Level 3 cache</div>
	<div class="gloss_value">
		<b>Definition:</b> Shared data and instruction memory, very larger in size, but slower than L2 cache, rarely used except in servers <br />
		<a href="http://en.wikipedia.org/wiki/L3_cache">Wikipedia article</a>
	</div>
	
	<div class="heading3">LIN or LIN-Bus - Local Interconnect Network</div>
	<div class="gloss_value">
		<b>Definition: a vehicle bus standard or computer networking bus-system</b><br />
		<a href="http://en.wikipedia.org/wiki/Local_Interconnect_Network">Wikipedia article</a>
	</div>

	<div class="heading3">LVD - Low Voltage Detection</div>
	<div class="gloss_value">
		<b>Definition: a reset signal when Vcc falls below Vref</b><br />
		<a href="http://en.wikipedia.org/wiki/Low-Voltage_Detect">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="N">N</a></div><br />

	<div class="heading3">NMOS [logic]</div>
	<div class="gloss_value">
		Definition:logic gates made from all N-channel MOSFETs, with a NMOS load <br />
		<a href="http://en.wikipedia.org/wiki/NMOS_logic">Wikipedia article</a>
	</div>

	
	<br /><br /><div class="heading2"><a name="M">M</a></div><br />

	<div class="heading3">McBSP - Multichannel Buffered Serial Port</div>
	<div class="gloss_value">
		<b>Definition: comunication module used by some TMS320 DSPs</b><br />
	</div>

	<div class="heading3">MCU - Micro-Controller Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> a chip that contains a CPU and other support functions designed to reduce the number of needed external components, and simplify users ability to preform tasks. MCUs commonly have on-chip RAM, ROM, timers, and clock generators.  Other common functions are PWM, ADC, and SPI<br />
		<a href="http://en.wikipedia.org/wiki/Microcontroller">Wikipedia article</a>
	</div>

	<div class="heading3">MI Bus - Motorola Interconnect Bus</div>
	<div class="gloss_value">
		<b>Definition: a serial communications interface using a single line from one Master to as many as 8 slave devices.</b><br />
	</div>

	<div class="heading3">MMU - Memory Management Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> unit responsible for handling accesses to memory requested by the CPU<br />
		<a href="http://en.wikipedia.org/wiki/Memory_management_unit">Wikipedia article</a>
	</div>


	<div class="heading3">MMX</div>
	<div class="gloss_value">
		<b>Definition:</b> extension to x86 instruction set, adding single instruction, multiple data (SIMD) instructions<br />
		<a href="http://en.wikipedia.org/wiki/MMX_(instruction_set)">Wikipedia article</a>
	</div>

	<div class="heading3">MSSP - Master Synchronous Serial Port</div>
	<div class="gloss_value">
		<b>Definition: a module is a serial interface useful for communican
ing with other peripheral or microcontroller devices</b><br />
		<a href="http://en.wikipedia.org/wiki/Synchronous_Serial_Port">Wikipedia article</a>
	</div>

	<div class="heading3">Microwire or μWire</div>
	<div class="gloss_value">
		<b>Definition:</b> a restricted subset of Serial Peripheral Interface Bus<br />
		<a href="http://en.wikipedia.org/wiki/Microwire">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="O">O</a></div><br />

	<div class="heading3">OSD - On Screen Display</div>
	<div class="gloss_value">
		<b>Definition:</b> an image superimposed on a screen picture<br />
		<a href="http://en.wikipedia.org/wiki/On-screen_display">Wikipedia article</a>
	</div>

	<div class="heading3">OTP [ROM] - One Time Programmable</div>
	<div class="gloss_value">
		<b>Definition:</b> ROM that can be written only once, one type is fuse-programmable ROM<br />
		<a href="http://en.wikipedia.org/wiki/Programmable_read-only_memory">Wikipedia article</a>
	</div>

	<div class="heading3">OST - Oscillator Start-up Timer</div>
	<div class="gloss_value">
		<b>Definition:</b> a timer that keeps the a microcontroller in reset until the crystal oscillator is stable<br />
		<a href="http://en.wikipedia.org/wiki/Oscillator_start-up_timer">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="P">P</a></div><br />

	<div class="heading3">PAL - Programmable Array Logic</div>
	<div class="gloss_value">
		<b>Definition:</b> A programmable logic chip, to replace a bunch of logic gates and registers. One time programmable (OTP).  The simplest of programmable logic, similar to CPLDs and FPGAs.<br />
		<a href="http://en.wikipedia.org/wiki/Programmable_Array_Logic">Wikipedia article</a>
	</div>

	<div class="heading3">Parity</div>
	<div class="gloss_value">
		<b>Definition:</b> A very simple type of coding by adding redundancy to data for error correction.<br />
		<a href="http://en.wikipedia.org/wiki/Parity_bit">Wikipedia article</a>
	</div>

	<div class="heading3">PMP - Parallel Master Port</div>
	<div class="gloss_value">
		<b>Definition: a parallel 8-bit I/O module, specifically designed to communicate with a wide variety of parallel devices, such as communication peripherals, LCDs, external memory devices and microcontrollers</b><br />
	</div>

	<div class="heading3">PIO - Programmed input/output</div>
	<div class="gloss_value">
		<b>Definition: a method of transferring data between the CPU and a peripheral</b><br />
		<a href="http://en.wikipedia.org/wiki/Programmed_input/output">Wikipedia article</a>
	</div>

	<div class="heading3">POR or PoR - Power-on Reset</div>
	<div class="gloss_value">
		<b>Definition: a microcontroller or microprocessor peripheral that generates a reset signal when power is applied to the device. It ensures that the device starts operating in a known state.</b><br />
		<a href="http://en.wikipedia.org/wiki/Power-on_reset">Wikipedia article</a>
	</div>

	<div class="heading3">PSP - Parallel Slave Port</div>
	<div class="gloss_value">
		<b>Definition: allows 8-bit asynchronous bidirectional data transfer between microcontroller and external devices</b><br />
		<a href="http://en.wikipedia.org/wiki/Parallel_slave_port">Wikipedia article</a>
	</div>

	<div class="heading3">PS/2</div>
	<div class="gloss_value">
		<b>Definition: a keyboard/mouse interface that replaces the AT conection.  It uses serial data at 10 to 16 kHz with 1 stop bit, 1 start bit, 1 parity bit (odd)</b><br />
		<a href="http://en.wikipedia.org/wiki/PS/2_connector">Wikipedia article</a>
	</div>

	<div class="heading3">PWM - Pulse Width Modulator</div>
	<div class="gloss_value">
		<b>Definition:</b> a unit that outputs a clock signal with a constant period, and its on-time is controlled by the input.  Commonly used in MCUs.<br />
		<a href="http://en.wikipedia.org/wiki/Pulse-width_modulation">Wikipedia article</a>
	</div>

	<div class="heading3">PWRT - Power-up Timer</div>
	<div class="gloss_value">
		<b>Definition:</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">PCI</div>
	<div class="gloss_value">
		<b>Definition:</b> A computer bus for connecting peripheral devices.<br />
		<a href="http://en.wikipedia.org/wiki/Conventional_PCI">Wikipedia article</a>
	</div>

	<div class="heading3">PCMCIA</div>
	<div class="gloss_value">
		<b>Definition:</b> A computer bus for cards in laptops, aka PC Card.<br />
		<a href="http://en.wikipedia.org/wiki/PC_Card">Wikipedia article</a>
	</div>


	<div class="heading3">PIO - Programmer Input/Output</div>
	<div class="gloss_value">
		<b>Definition:</b> A method of transferring data between the CPU and peripheral device.<br />
		<a href="http://en.wikipedia.org/wiki/Programmed_input/output">Wikipedia article</a>
	</div>

	<div class="heading3">PLL - Phase-Locked Loop</div>
	<div class="gloss_value">
		<b>Definition:</b> a type of feedback loop to generate stable oscilations for signal generation and recovery.<br />
		<a href="http://en.wikipedia.org/wiki/Phase-locked_loop">Wikipedia article</a>
	</div>

	<div class="heading3">PMOS [logic]</div>
	<div class="gloss_value">
		<b>Definition:</b> logic gates made from all P-channel MOSFETs, with a PMOS load<br />
		<a href="http://en.wikipedia.org/wiki/PMOS_logic">Wikipedia article</a>
	</div>

	<div class="heading3">PMMU - Paged Memory Management Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> unit responsible for handling accesses to memory requested by the CPU<br />
		<a href="http://en.wikipedia.org/wiki/Memory_management_unit">Wikipedia article</a>
	</div>


	<div class="heading3">PPU - Picture Processing Unit</div>
	<div class="gloss_value">
		<b>Definition:</b> the name used by Nintendo for the Graphics Processing Unit (GPU) in the Nintendo and Super Nintendo<br />
		<a href="http://en.wikipedia.org/wiki/Picture_processing_unit">Wikipedia article</a>
	</div>

	<div class="heading3">Prescaler</div>
	<div class="gloss_value">
		<b>Definition:</b> a frequency divider<br />
		<a href="http://en.wikipedia.org/wiki/Prescaler">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="Q">Q</a></div><br />

	<div class="heading3">QMC</div>
	<div class="gloss_value">
		<b>Definition:</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">QSPI - Queued Serial Peripheral Interface</div>
	<div class="gloss_value">
		<b>Definition:</b> One type of SPI controller that uses a data queue with programmable queue pointers<br />
		<a href="http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus#Queued_serial_peripheral_interface_.28QSPI.29">Wikipedia article</a>
	</div>

	<div class="heading3">QUICC - QUad Integrated Communications Controller</div>
	<div class="gloss_value">
		<b>Definition: a family of Motorola and Freescale microcontrollers</b><br />
		<a href="http://en.wikipedia.org/wiki/QUICC">Wikipedia article</a>
	</div>

	<div class="heading3">QzROM - Quick eaSY ROM</div>
	<div class="gloss_value">
		<b>Definition: a programable ROM developed by Renesas, the Quick has to do with quick delivery of products from Renesas to manufacturer</b><br />
		
	</div>



	<br /><br /><div class="heading2"><a name="R">R</a></div><br />

	<div class="heading3">RNG - Random Number Generator</div>
	<div class="gloss_value">
		<b>Definition: a module for generating random numbers</b><br />
		<a href="http://en.wikipedia.org/wiki/Random_number_generation">Wikipedia article</a>
	</div>

	<div class="heading3">RS-232</div>
	<div class="gloss_value">
		<b>Definition:</b> standard serial communications protocol, used in computer serial ports<br />
		<a href="http://en.wikipedia.org/wiki/RS-232">Wikipedia article</a>
	</div>

	<div class="heading3">RS-432</div>
	<div class="gloss_value">
		<b>Definition:</b>  serial communications protocol, similar to RS-232<br />
		<a href="http://en.wikipedia.org/wiki/RS-432">Wikipedia article</a>
	</div>

	<div class="heading3">RS-485</div>
	<div class="gloss_value">
		<b>Definition:</b>  serial communications protocol, similar to RS-232<br />
		<a href="http://en.wikipedia.org/wiki/RS-432">Wikipedia article</a>
	</div>




	<br /><br /><div class="heading2"><a name="S">S</a></div><br />

	<div class="heading3">SCI - Serial Communication Interface</div>
	<div class="gloss_value">
		<b>Definition:</b> Serial communication <br />
		<a href="http://en.wikipedia.org/wiki/Serial_Communication_Interface">Wikipedia article</a>
	</div>

	<div class="heading3">Servo - Servomechanism</div>
	<div class="gloss_value">
		<b>Definition:</b> A controlled device for rotating <br />
		<a href="http://en.wikipedia.org/wiki/Servomechanism">Wikipedia article</a>
	</div>

	<div class="heading3">SIMD - Single Instruction, Multiple Data</div>
	<div class="gloss_value">
		<b>Definition:</b> processor instruction that preforms the same operation on the multiple data sets in parallel<br />
		AKA: vector instructions<br />
		<a href="http://en.wikipedia.org/wiki/SIMD">Wikipedia article</a>
	</div>

	<div class="heading3">SIO - Special Input/Output</div>
	<div class="gloss_value">
		<b>Definition: Special Input/Output (Special I/O or SIO) are inputs and/or outputs designated to perform specialized functions or have specialized features.  These can include hardware interrupts, analog or mixed signal, serial communication, external reset, switch debounce, input pull-up or down resistors.</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">SLDM - Serial Data Link Module</div>
	<div class="gloss_value">

		<b>Definition: serial communication on a J1850 type multiplexed serial bus via an external J1850 bus transceiver</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">SMBus or SMB - System Management Bus</div>
	<div class="gloss_value">
		<b>Definition: a single-ended simple two-wire bus for the purpose of lightweight communication</b><br />
		<a href="http://en.wikipedia.org/wiki/System_Management_Bus">Wikipedia article</a>
	</div>

	<div class="heading3">SPI - Serial Peripheral Interface</div>
	<div class="gloss_value">
		<b>Definition:</b> a serial communication protocol <br />
		<a href="http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus">Wikipedia article</a>
	</div>

	<div class="heading3">SoC - System on Chip</div>
	<div class="gloss_value">
		<b>Definition:</b> Combination of many components on a single chip (die), components which traditionally have their own individual chips. Geode is a SoC, with integrated CPU, chipset, and video controller <br />
		<a href="http://en.wikipedia.org/wiki/System-on-a-chip">Wikipedia article</a>
	</div>


	<div class="heading3">Socket</div>
	<div class="gloss_value">
		<b>Definition:</b> Connector for inserting chips on circuit boards <br />
		<a href="http://en.wikipedia.org/wiki/System-on-a-chip">Wikipedia article</a>
	</div>

	<div class="heading3">SRAM - Static RAM</div>
	<div class="gloss_value">
		<b>Definition:</b> stores data in memory that does not need to be refreshed<br />
		<a href="http://en.wikipedia.org/wiki/Static_random_access_memory">Wikipedia article</a>
	</div>

	<div class="heading3">SSC - Serial Servo Controller</div>
	<div class="gloss_value">
		<b>Definition: interfacing servos with a computer using RS232 communications</b><br />
	</div>

	<div class="heading3">SSI - Serial Synchronous Interface</div>
	<div class="gloss_value">
		<b>Definition: serial interface standard for industrial applications</b> <br />
		<a href="http://en.wikipedia.org/wiki/Synchronous_Serial_Interface">Wikipedia article</a>
	</div>
	<div class="heading3">SSIO - Serial Synchronous Input/Output port</div>
	<div class="gloss_value">
		<b>See: Serial Synchronous Interface</b> <br />
	</div>

	<div class="heading3">SSP - Synchronous Serial Port</div>
	<div class="gloss_value">
		<b>Definition: a controller that supports the Serial Peripheral Interface, 4-wire Synchronous Serial Interface, and Microwire serial buses</b> <br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

	<div class="heading3">SSE - Streaming SIMD Extensions</div>
	<div class="gloss_value">
		<b>Definition:</b> an extension to the x86 instruction set, to preform single instruction, multiple data (SIMD) operation.  SSE, SSE2, SSE3, and SSE4 are all added extensions<br />
		<a href="http://en.wikipedia.org/wiki/Streaming_SIMD_Extensions">Wikipedia article</a>
	</div>

	<div class="heading3">SSSE3 - Supplemental Streaming SIMD Extension 3</div>
	<div class="gloss_value">
		<b>Definition:</b> another extension to the x86 instruction set<br />
		<a href="http://en.wikipedia.org/wiki/SSSE3">Wikipedia article</a>
	</div>

	<div class="heading3">Sync processor</div>
	<div class="gloss_value">
		<b>Definition:</b> unit that generates Vsync and Hsync signals for the display of a CRT monitor or TV <br />
		<a href="http://en.wikipedia.org/wiki/sync">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="U">U</a></div><br />

	<div class="heading3">UART - Universal Asynchronous Receiver/Transmitter</div>
	<div class="gloss_value">
		<b>Definition:</b> Serial communications device, used in combination with a communications protocol such as RS-232 <br />
		<a href="http://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter">Wikipedia article</a>
	</div>

	<div class="heading3">USART - Universal Synchronous/Asynchronous Receiver/Transmitter</div>
	<div class="gloss_value">
		<b>Definition:</b> Serial communications device, using synchronous or asynchronous comunications <br />
		<a href="http://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter">Wikipedia article</a>
	</div>

	<div class="heading3">UPI - Universal Peripheral Interface</div>
	<div class="gloss_value">
		<b>Definition: ?</b><br />
	</div>

	<div class="heading3">USI - Universal Serial Interface</div>
	<div class="gloss_value">
		<b>Definition:</b><br />
		<a href="http://en.wikipedia.org/wiki/">-</a>
	</div>

	<div class="heading3">Utopia</div>
	<div class="gloss_value">
		<b>Definition:</b> an ATM protocol specification <br />
		<a href="http://en.wikipedia.org/wiki/Utopia_(disambiguation)">Wikipedia article</a>
	</div>

	<div class="heading3">USB - Universal Serial Bus</div>
	<div class="gloss_value">
		<b>Definition: an industry standard developed in the mid-1990s that defines the cables, connectors and protocols used for connection, communication and power supply between computers and electronic devices.</b><br />
		<a href="http://en.wikipedia.org/wiki/USB">Wikipedia article</a>
	</div>

	<div class="heading3">USB OTG - USB On-The-Go</div>
	<div class="gloss_value">
		<b>Definition:a specification that allows USB devices such as digital audio players or mobile phones to act as a host allowing a USB Flash Drive, mouse, or keyboard to be attached</b><br />
		<a href="http://en.wikipedia.org/wiki/USB_On-The-Go">Wikipedia article</a>
	</div>

	<div class="heading3">USI - Universal Serial Interface</div>
	<div class="gloss_value">
		<b>Definition: ?</b><br />
	</div>



	<br /><br /><div class="heading2"><a name="V">V</a></div><br />

	<div class="heading3">Vacuum fluorescent display</div>
	<div class="gloss_value">
		<b>Definition:</b> an illuminated display used in equipment such as video cassette recorders, car radios, and microwave ovens. <br />
		<a href="http://en.wikipedia.org/wiki/Vacuum_fluorescent_display">Wikipedia article</a>
	</div>

	<div class="heading3">Vcc</div>
	<div class="gloss_value">
		<b>Definition:</b> positive supply voltage. historically for analog (bipolar) devices. Vdd is used for digital (FET), but Vcc has been used for both <br />
		<a href="http://en.wikipedia.org/wiki/IC_power_supply_pin">Wikipedia article</a>
	</div>

	<div class="heading3">Vsync - Vertical Synchronization</div>
	<div class="gloss_value">
		<b>Definition:</b> has to do with synchronizing display on a CRT monitor or TV <br />
		<a href="http://en.wikipedia.org/wiki/Vsync">Wikipedia article</a>
	</div>


	<br /><br /><div class="heading2"><a name="W">W</a></div><br />

	<div class="heading3">WDT - Watchdog timer</div>
	<div class="gloss_value">
		<b>Definition:</b> a timer that preforms a reset if the main program freezes <br />
		<a href="http://en.wikipedia.org/wiki/Watchdog_timer">Wikipedia article</a>
	</div>

	
	<br /><br /><div class="heading2"><a name="0-9">0-9</a></div><br />

	<div class="heading3">3DNow!</div>
	<div class="gloss_value">
		<b>Definition:</b> addition to the x86 instruction set, by AMD <br />
		<a href="http://en.wikipedia.org/wiki/3DNow!">Wikipedia article</a>
	</div>

	<div class="heading3">1-Wire</div>
	<div class="gloss_value">
		<b>Definition: bus communication protocal using a single wire</b><br />
		<a href="http://en.wikipedia.org/wiki/1-Wire">Wikipedia article</a>
	</div>

	<div class="heading3">2-Wire</div>
	<div class="gloss_value">
		<b>Definition:</b><br />
		<a href="http://en.wikipedia.org/wiki/">Wikipedia article</a>
	</div>

Endhtml
	return $text;
}


sub create_html_body_main_category_isa {
	my $text = '';
	$text .= <<Endhtml;
			<div class="familyDescTable">
				<table cellpadding="5" width="100%">
					<tr>
						<td colspan="2">
							<span class='familyDescTableName'>Instruction Set Architectures (ISA)<br /></span>
							<span class='familyDescTableParam'>Wikipedia:</span> <span class='familyDescTableValue'><a href="http://en.wikipedia.org/wiki/Instruction_set_architecture">Instruction set architecture</a></span><br />
							<span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'> Processors  </span>
						</td>
					</tr>
				</table>
			</div>
	<br />
	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="x86"><br />x86</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/X86_instruction_listings">x86 instruction listings</a><br /><br />
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=186">186</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386">386</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=V20">V20</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">5x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="MIPS"><br />MIPS</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/MIPS_architecture">MIPS architecture</a><br /><br />		
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R3000">R3000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Nintendo 64">Nintendo 64</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Playstation II">Playstation II</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="SPARC"><br />SPARC</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/SPARC">SPARC</a><br /><br />
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="ARM"><br />ARM</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/ARM_architecture">ARM architecture</a><br /><br />	
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Other</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=XScale">XScale</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperH">SuperH</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i960">i960</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM29000">AM29000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alpha">Alpha</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6502">6502</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=1802">1802</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z180">Z180</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8000">Z8000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=2650">2650</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC05">HC05</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC11">HC11</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC12">HC12</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC16">HC16</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-41">MCS-41</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48">MCS-48</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51">MCS-51</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-96">MCS-96</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SAM8">SAM8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=H8">H8</a></span>
				</ul>
			</td>
		</tr>
	</table>
Endhtml

	return $text;
}








sub create_html_body_main_category_date {
	my $text = '';
	
	$text .= <<Endhtml;

	<span class='familyDescTableName'>Processor and Microcontroller Timeline<br /></span>
	<br />
	<table>
		<tr>
			<td colspan="2"><span class="heading1t"><a name="1971"><br />1971</a></span></td>
		</tr><tr>
			<td width="20"></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=4004">4004</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_4004">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="3"><span class="heading1t"><a name="1972"><br />1972</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=4040">4040</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_4040">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - 8008</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8008">Wikipedia</a>)</span></td>
				</tr></table>
			</td>		

		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1973"><br />1973</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=3000">3000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_3000">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1974"><br />1974</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=6800">6800</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_6800">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=8080">8080</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8080">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">TI - <a href="$scriptName?page=family&family=TMS1000">TMS1000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Texas_Instruments_TMS1000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">National - SC/MP</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/National_Semiconductor_SC/MP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MMI - 5701/6701</span></td>
					<td width="120" align="center"><span class="list_element_wiki"></span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1975"><br />1975</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">MOS - <a href="$scriptName?page=family&family=6500">6501</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MOS_Technology_6501">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MOS - <a href="$scriptName?page=family&family=6500">6502</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MOS_6502">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MOS - <a href="$scriptName?page=family&family=6500">6510</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MOS_Technology_6510">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Signetics - <a href="$scriptName?page=family&family=2650">2650</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Signetics_2650">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=AM2900">AM2900</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_Am2900">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Fairchild - <a href="$scriptName?page=family&family=F8">F8</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Fairchild_F8">Wikipedia</a>)</span></td>					
					</tr><tr>
					<td width="17"></td><td><span class="list_element">Intersil - 6100</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intersil_6100">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1976"><br />1976</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=8085">8085</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8085">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">TI - TMS9900</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Texas_Instruments_TMS9900">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - <a href="$scriptName?page=family&family=Z80">Z80</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z80">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">RCA - <a href="$scriptName?page=family&family=1802">CDP1802</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/RCA_1802">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=MCS-48">MCS-48 (8048)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8048">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1977"><br />1977</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Mostek - 3870</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Mostek_3870">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=manufacturer&manufacturer=Motorola&family=6809">6809</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_6809">Wikipedia</a>)</span></td>					
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1978"><br />1978</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=8086">8086</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8086">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1979"><br />1979</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=8088">8088</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8088">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - <a href="$scriptName?page=family&family=Z8000">Z8000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z8000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - F-11</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PDP-11">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Zilog - <a href="$scriptName?page=family&family=Z8">Z8</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z8">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=MCS-41">MCS-41</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki"></span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1980"><br />1980</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=">TI - 16032</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/16032">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=MCS-51">MCS-51 (8051)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_8051">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">DSP</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">NEC - µPD7720</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NEC_µPD7720">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1981"><br />1981</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=186">186</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80186">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=188">188</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80188">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - iAPX 432</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_iAPX_432">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Haris - 6120</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intersil_6100">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - T-11</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PDP-11">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1982"><br />1982</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=286">286</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80286">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Motorola - 68010</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_68010">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">HP - FOCUS</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/HP_FOCUS">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU/DSP</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=MCS-96">MCS-96 (8096)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_MCS-96">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=6805">6805</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_6805">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">TI - <a href="$scriptName?page=family&family=TMS320">TMS320</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Texas_Instruments_TMS320">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
	</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1983"><br />1983</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">DEC - <a href="$scriptName?page=family&family=PDP-11">J-11</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PDP-11">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1984"><br />1984</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=68020">68020</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_68020">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">NEC - <a href="$scriptName?page=family&family=V20">V20</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NEC_V20">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">NEC - V30</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NEC_V30">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=65816">65816</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/WDC_65816/65802">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">National - <a href="$scriptName?page=family&family=32000">32032</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NS320xx">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Inmos - <a href="$scriptName?page=family&family=Transputer">Transputer</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Transputer">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1985"><br />1985</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=386">386 DX</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80386">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">ARM1</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_architecture">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R2000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R2000_(microprocessor)">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - Z800</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z800">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - MicroVax II</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MicroVAX">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">National - NS32332</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NS320xx">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=HC11">HC11</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Freescale_68HC11">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1986"><br />1986</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - Z80000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z80000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">NEC - V60</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NEC_V60">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - 4341</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/IBM_4300">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - 4381</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/IBM_4300">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC TS-1</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-RISC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Fairchild - Clipper C100</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Clipper_architecture">Wikipedia</a>)</span></td>
				</tr>


				</table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1987"><br />1987</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=68030">68030</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_68030">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - Z280</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z280">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - CVAX</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/CVAX">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">ARM2 ?</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_architecture">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">NEC - V70</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NEC_V70">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">National - NS32532</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NS320xx">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC NS-1</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-RISC">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1988"><br />1988</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">MIPS - <a href="$scriptName?page=family&family=R3000">R3000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R3000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=386">386 SX</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80386">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Apollo PRISM</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Apollo_PRISM">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Motorola - MC88100</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/88000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=AM29000">AM29000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_AM29000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Clipper C300</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Clipper_architecture">Wikipedia</a>)</span></td>
				</tr>
				</table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1989"><br />1989</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=486">486 DX</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80486">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=i860">i860</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_i860">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=i960">i960</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_i960">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">ARM3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_architecture">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Gameboy">Gameboy</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Gameboy">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC NS-2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-RISC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-S (PA-7000)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-RISC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - Rigel</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Rigel_(microprocessor)">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1990"><br />1990</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Motorola - <a href="$scriptName?page=family&family=68040">68040</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_68040">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">RS/6000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/RS/6000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - 386 SL</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80386">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER1</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER1">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Clipper C400</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Clipper_architecture">Wikipedia</a>)</span></td>
				</tr>
				</table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1991"><br />1991</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R4000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R4000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - NVAX</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NVAX">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - RSC</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/RISC_Single_Chip">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">ARM6</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_architecture">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1992"><br />1992</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=486">486 DX2</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80486">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=486">486 SL</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80486">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC 601</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_600">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - <a href="$scriptName?page=family&family=Alpha">Alpha 21064</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Alpha_21064">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC I</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SuperSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=MicroSPARC">MicroSPARC I</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MicroSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC PCX-T (PA-7100)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-7100">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - <a href="$scriptName?page=family&family=R4400">R4400</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R4000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARClite</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1993"><br />1993</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium">Pentium</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Hitachi - <a href="$scriptName?page=family&family=SuperH">SuperH</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SuperH">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC 603</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_603">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=hyperSPARC">hyperSPARC</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/hyperSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Weitek - SPARC POWER µP</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Weitek">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM7">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1994"><br />1994</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=486">486 DX4</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80486">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=486">486 SL</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_80486">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC 604</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_604">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC PCX-T (PA-7150)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-7150">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC PCX-T' (PA-7200)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-7200">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-L (PA-7100LC)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-7100LC">Wikipedia</a>)</span></td>
				</tr><tr>

					<td width="17"></td><td><span class="list_element">MIPS - R4400</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R4000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R8000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R8000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Motorola - 68060</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Motorola_68060">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SuperSPARC II</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SuperSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC II</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/microSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Playstation">Playstation</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Playstation">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cambridge Consultants - XAP</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/XAP_processor">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - Z380</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Zilog_Z380">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - <a href="$scriptName?page=family&family=Alpha">Alpha 21064A</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Alpha_21064">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 403</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_400">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">NexGen - Nx586</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/NexGen">Wikipedia</a>)</span></td>
				</tr>
				</table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1995"><br />1995</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_Pro">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC I</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SuperSPARC 2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SuperSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cyrix - <a href="$scriptName?page=family&family=5x86">5x86</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Cyrix_Cx5x86">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cyrix - 6x86</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Cyrix_6x86">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - Alpha 21164</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Alpha_21164">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=Am5x86">Am5x86</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Am5x86">Wikipedia</a>)</span></td>
				</tr><tr>

				</table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">ARM8</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_architecture">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1996"><br />1996</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=K5">K5</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_K5">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R4700</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R4700">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R5000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R5000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=R10000">MIPS - R10000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R10000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_MMX">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Nintendo 64">Nintendo 64</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Nintendo_64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">TurboSPARC</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/TurboSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 II</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-L2 (PA-7300LC)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-7300LC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-U (PA-8000)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cyrix - 6x86</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Cyrix_6x86">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - Alpha 21164</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Alpha_21164">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - P2SC</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/P2SC#P2SC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">StrongARM</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/StrongARM">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 401</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_400">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Atmel - <a href="$scriptName?page=family&family=AVR">AVR</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Atmel_AVR">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/TriMedia_(Mediaprocessor)">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1997"><br />1997</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium 2">Pentium 2</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=K6">K6</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_K6">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC II</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_II">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC 750</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_750">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IDT - <a href="$scriptName?page=family&family=WinChip">WinChip</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/WinChip">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-U+ (PA-8200)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8200">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cyrix - MediaGX</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MediaGX">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">DEC - Alpha 21264</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Alpha_21264">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM9">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Mitsubishi - M32R</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/M32R">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1998"><br />1998</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=K6-2">K6-2</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_K6-2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - Pentium 2 Xeon</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Xeon#Pentium_II_Xeon">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC G3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_G3">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 745/755</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_7xx">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - RM7000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MIPS_architecture">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - <a href="$scriptName?page=family&family=R12000">R12000</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R12000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 III</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Rise - mP6</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/mP6">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-W (PA-8500)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8500">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 405</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_400">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="1999"><br />1999</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Celeron">Celeron</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Celeron">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_III">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Pentium III Xeon</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_III_Xeon">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=K6-III">K6-III</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_K6-III">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - <a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Athlon">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC G4</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_G4">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER3">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - S/390 G5</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/IBM_ESA/390">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">National - <a href="$scriptName?page=family&family=Geode">Geode</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Geode_(processor)">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=MIPS32">MIPS32</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MIPS32">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS64</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MIPS64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 440</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_400">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2000"><br />2000</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_4">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Athlon_XP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Athlon MP</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Athlon_MP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Transmeta - Crusoe</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Transmeta_Crusoe">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 IV</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Playstation II">Emotion Engine (Playstation II)</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Playstation_II">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-W+ (PA-8600)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8600">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">VIA - Cyrix III</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Cyrix_III">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - z900</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/IBM_System_z">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Analog Devices - Blackfin</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Blackfin">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Microchip - PIC18</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PIC_microcontroller#PIC18_high_end_core_devices">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2001"><br />2001</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - Itanium</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Itanium">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC III</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_III">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Xeon_DP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R14000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R14000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC PCX-W2 (PA-8700)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8700">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">VIA - C3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/VIA_C3">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">VIA - Eden</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/VIA_Eden">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER4</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER4">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 7450</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_7450">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Gecko (GameCube)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/GameCubePowerPC_7450">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Microchip - PIC24</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PIC_microcontroller#PIC24_and_dsPIC_16-bit_microcontrollers">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Microchip - dsPIC</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PIC_microcontroller#PIC24_and_dsPIC_16-bit_microcontrollers">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2002"><br />2002</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium 4">Pentium 4 HT</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_4_HT#Pentium_4_HT">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Xeon">Xeon MP</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Xeon_MP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=XScale">XScale</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/XScale">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - Itanium 2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Itanium_2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R16000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/R16000">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 V</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64_V">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">ARM11</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM11">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2003"><br />2003</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - Pentium 4 EE</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_4">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">V-Dragon</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Loongson">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_M">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 970</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_970">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Opteron</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Opteron">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">MIPS - R24000</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/MIPS_architecture">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC IIIi</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 V</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64_V">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC Mako (PA-8800)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8800">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER4+</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER4">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2004"><br />2004</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC IV</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_IV">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM POWER5</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER5">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Athlon XP-M</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Athlon#Athlon_XP.2FMP">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC IV</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_IV">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 V+</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64_V">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">ARM - Cortex</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/ARM_Cortex">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Zilog - Z8 Encore!</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Z8_Encore!">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2005"><br />2005</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - <a href="$scriptName?page=family&family=Pentium D">Pentium D</a></span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Pentium_D">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Athlon 64 X2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Athlon_64_X2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Xenon (Xbox 360)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Xbox_360">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC IV+</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_IV%2B">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC T1</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_T1">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PA-RISC Shortfin</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PA-8000#PA-8900">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">VIA - C7</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/VIA_C7">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Turion</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_Turion">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2006"><br />2006</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - Core</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_Core">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - Core 2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Core_2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Cell</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Cell_(microprocessor)">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Playstation 3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PlayStation_3">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Broadway (Nintendo Wii)</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Nintendo_Wii">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">PowerPC 460</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PowerPC_400">Wikipedia</a>)</span></td>
				</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Atmel - AVR32</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AVR32">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2007"><br />2007</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC T2</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_T2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 VI</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64_VI">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - POWER6</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/POWER6">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
		</tr><tr>
			<td></td><td><span class="heading2t">MCU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Microchip - PIC32</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/PIC_microcontroller#PIC32_32-bit_microcontrollers">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2008"><br />2008</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - Atom</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_Atom">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - Core i7</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Core_i7">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">IBM - z10</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/IBM_z10_(microprocessor)">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">AMD - Phenom</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Phenom_(processor)">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">UltraSPARC T2+</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/UltraSPARC_T2">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC64 VII</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC64_VII">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">VIA - Nano</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/VIA_Nano">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2009"><br />2009</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">AMD - Phenom II</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Phenom_II">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2010"><br />2010</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">Intel - Core i3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_Core">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">Intel - Core i5</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/Intel_Core">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC T3</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC_T3">Wikipedia</a>)</span></td>
				</tr></table>
			</td>

		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2011"><br />2011</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">AMD - Fusion</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/AMD_Fusion">Wikipedia</a>)</span></td>
				</tr><tr>
					<td width="17"></td><td><span class="list_element">SPARC T4</span></td>
					<td width="120" align="center"><span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/SPARC_T4">Wikipedia</a>)</span></td>
				</tr></table>
			</td>
		</tr><tr>
			<td colspan="2"><span class="heading1t"><a name="2012"><br />2012</a></span></td>
		</tr><tr>
			<td></td><td><span class="heading2t">CPU</span></td>
		</tr><tr>
			<td></td><td valign="top">
				<table><tr>
					<td width="17"></td><td><span class="list_element">To be added</span></td>
					<td width="120" align="center"><!-- <span class="list_element_wiki">(<a href="http://en.wikipedia.org/wiki/">Wikipedia</a>)</span>--></td>
				</tr></table>
			</td>
		</tr>
	</table>

	<br /><br /><br />

	<span class="heading1t">References:</span><br />
	<ul>
		<li><span class="list_element"><a href="http://www.intel.com/pressroom/kits/quickreffam.htm">Intel - Microprocessor timeline, by family</a></span>
		<li><span class="list_element"><a href="http://www.islandnet.com/~kpolsson/vidgame/mini.htm">A Brief Timeline of Video Game Systems</a></span>
		<li><span class="list_element"><a href="http://everything2.com/title/CPU%2520history%253A%2520A%2520timeline%2520of%2520microprocessors">everything2: CPU history: A timeline of microprocessors</a></span>
		<li><span class="list_element"><a href="http://en.wikipedia.org/wiki/SPARC">Wikipedia - SPARC</a></span>
		<li><span class="list_element"><a href="http://en.wikipedia.org/wiki/MIPS_architecture">Wikipedia - MIPS Arch</a></span>
		<li><span class="list_element"><a href="http://en.wikipedia.org/wiki/PA-RISC">Wikipedia - PA-RISC</a></span>
		<li><span class="list_element"><a href="http://www.arm.com/aboutarm/milestones.html">ARM Milestones</a></span>
		<li><span class="list_element"><a href="http://www.dos4ever.com/8031board/history8051.pdf">The unofficial history of 8051.</a></span>
		<li><span class="list_element"><a href="http://www.eee.bham.ac.uk/woolleysi/teaching/microhistory.htm">A Brief History of Microprocessors</a></span>
		<li><span class="list_element"><a href="http://www.amd.com/us-en/Weblets/0,,7832_10554,00.html">History of AMD</a></span>
		<li><span class="list_element"><a href="http://en.wikipedia.org/wiki/Microprocessor_chronology">Microprocessor_chronology</a></span>
		<li><span class="list_element"><a href="http://gecko54000.free.fr/?rub=documentations">Gecko's CPU Library: Documentations</a></span>

		</ul>		
Endhtml

	return $text;
}





sub create_html_body_main_category_tech {
	my $text = '';

	$text .= <<Endhtml;
			<div class="familyDescTable">
				<table cellpadding="5" width="100%">
					<tr>
						<td colspan="2">
							<span class='familyDescTableName'>Technology used in integrated circuits<br /></span>
							<span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'> Over the years, different technologies have been used to create digital integrated circuits to create logic gates.  Early gates were created using Bipolar transistors, however the consumed allot of power, and early attemps were slow. MOSFET based logic gates use less power.  NMOS technology was used move commonly that PMOS, for speed. NMOS uses a biased or diode conected transistor as a pull-up resistor, and the gates inputs are attached to the pull-down transistors. PMOS is the opposite.  When the output of the gate is low, it consumes allot of power.  HMOS technology improved this by using Depletion-mode transistors as the resistive load, reducing the required current, while maintaining high speeds.  CMOS technology replaced all these technologies, by using both NMOS and PMOS transistors in their logic gates.  It is faster, and lower power than the other technologies. CHMOS or HCMOS are CMOS technologies that are optimized for higher speeds and densities.</span>
							<ul>
								<li><span class='familyDescTableParam'>Bipolar:</span> <span class='familyDescTableValue'>Bipolar logic (<a href="http://en.wikipedia.org/wiki/Bipolar_junction_transistor">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>BiCMOS:</span> <span class='familyDescTableValue'>Bipolar-CMOS (<a href="http://en.wikipedia.org/wiki/BiCMOS">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>PMOS:</span> <span class='familyDescTableValue'>p-type MOSFET logic (<a href="http://en.wikipedia.org/wiki/PMOS_logic">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>NMOS:</span> <span class='familyDescTableValue'>n-type MOSFET logic (<a href="http://en.wikipedia.org/wiki/NMOS_logic">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>HMOS:</span> <span class='familyDescTableValue'>Depletion-load NMOS, high-performance (<a href="http://en.wikipedia.org/wiki/HMOS">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>COS/MOS:</span> <span class='familyDescTableValue'>complementary-symmetry metal-oxide-semiconductor, same as CMOS </span>
								<li><span class='familyDescTableParam'>CMOS:</span> <span class='familyDescTableValue'>Complementary metal-oxide-semiconductor(<a href="http://en.wikipedia.org/wiki/CMOS">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>HCMOS:</span> <span class='familyDescTableValue'>high-speed CMOS (<a href="http://en.wikipedia.org/wiki/HCMOS">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>EDMOS:</span> <span class='familyDescTableValue'>Extended drain MOS (<a href="http://en.wikipedia.org/wiki/CPU_cache">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>CDMOS:</span> <span class='familyDescTableValue'>Complementary Diffusion Metal Oxide Semiconductor (<a href="http://en.wikipedia.org/wiki/CPU_cache">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>MYMOS:</span> <span class='familyDescTableValue'><a href="http://translate.google.com/translate?prev=hp&hl=en&js=y&u=http%3A%2F%2Fmicrocontroller-online.com%2Fmicrocontroller%2Ftheorie%2Fuc_doku_kapitel_07.html%237.1.2&sl=de&tl=en&history_state0=">desc</a>, <a href="http://microcontroller-online.com/microcontroller/theorie/bilder/bild_7-3.gif">image of gate driver</a></span>
								<li><span class='familyDescTableParam'>ACMOS:</span> <span class='familyDescTableValue'><a href="http://translate.google.com/translate?prev=hp&hl=en&js=y&u=http%3A%2F%2Fmicrocontroller-online.com%2Fmicrocontroller%2Ftheorie%2Fuc_doku_kapitel_07.html%237.1.2&sl=de&tl=en&history_state0=">desc</a>, <a href="http://microcontroller-online.com/microcontroller/theorie/bilder/bild_7-3.gif">image of gate driver</a></span>

								<li><span class='familyDescTableParam'>XMOS:</span> <span class='familyDescTableValue'>?</span>
							</ul>
						</td>
					</tr>
				</table>
			</div>
	<br />
	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1">Bipolar</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM2900">AM2900</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">BiCMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">PMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=4004">4004</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>

		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">NMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=2650">2650</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6502">6502</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8080">8080</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=186">186</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=188">188</a></span>		
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>			
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-41">MCS-41</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48">MCS-48</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51">MCS-51</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">HMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6800">6800</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6809">6809</a></span>						
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68000">68000</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8000">Z8000</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48">MCS-48</a></span>		
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51">MCS-51</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-96">MCS-96</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=6805">6805</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">CMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386">386</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=1802">1802</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=1806">1806</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alchemy">Alchemy</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z180">Z180</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=V20">V20</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SAM8">SAM8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=H8">H8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=CXP80600">CXP80600</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HD6305">HD6305</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">CHMOS/HCMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386">386</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68020">68020</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68030">68030</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68040">68040</a></span>

						<li><span class="list_element"><a href="$scriptName?page=family&family=i960">i960</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC05">HC05</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC11">HC11</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC12">HC12</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC16">HC16</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-96">MCS-96</a></span>	
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">EDMOS</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Mitsubishi&part=M5L8085AP">Mitsubishi M5L8085AP</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr>
	</table>
Endhtml
	return $text;
}

sub create_html_body_main_category_chip_type {
	my $text = '';

	$text .= <<Endhtml;
			<div class="familyDescTable">
				<table cellpadding="5" width="100%">
					<tr>
						<td colspan="2">
							<span class='familyDescTableName'>Chip Type<br /></span>
							<span class='familyDescTableParam'>Wikipedia:</span> <span class='familyDescTableValue'><a href="http://en.wikipedia.org/wiki/CPU_design">CPU design</a> & <a href="http://en.wikipedia.org/wiki/Instruction_set">Instruction set architecture</a></span><br />
							<span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'> </span>
							<ul>
								<li><span class='familyDescTableParam'>CPU:</span> <span class='familyDescTableValue'>central processing unit (<a href="http://en.wikipedia.org/wiki/Microprocessor">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>MCU:</span> <span class='familyDescTableValue'>microcontroller unit (<a href="http://en.wikipedia.org/wiki/Microcontroller">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>FPU:</span> <span class='familyDescTableValue'>floating point unit (<a href="http://en.wikipedia.org/wiki/Floating_point_unit">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>GPU:</span> <span class='familyDescTableValue'>graphics processing unit (<a href="http://en.wikipedia.org/wiki/Graphics_processing_unit">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>PPU:</span> <span class='familyDescTableValue'>picture processing unit (<a href="http://en.wikipedia.org/wiki/Picture_processing_unit">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>I/O processor:</span> <span class='familyDescTableValue'>(<a href="http://en.wikipedia.org/wiki/Channel_I/O">Wikipedia</a>)</span>
								<li><span class='familyDescTableParam'>Cache controller:</span> <span class='familyDescTableValue'> (<a href="http://en.wikipedia.org/wiki/CPU_cache">Wikipedia</a>)</span>
						</td>
					</tr>
				</table>
			</div>
	<br />
	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1">Bit-slice CPU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=3000">3000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM2900">AM2900</a></span>	
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">CPU - Central processing unit</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM29000">AM29000</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i960">i960</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperH">SuperH</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R3000">R3000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alchemy">Alchemy</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alpha">Alpha</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68000">68000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68020">68020</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68030">68030</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68040">68040</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=186">186</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=188">188</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386">386</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Microcontrollers</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68302">68302</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC05">HC05</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC11">HC11</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC12">HC12</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC16">HC16</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48"></a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51"></a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SAM8">SAM8</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">FPU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=manufacturer&manufacturer=Weitek&family=SPARC">Weitek FPUs</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Cyrix&part=CX_83D87_33_GP">Cyrix CX-83D87-33-GP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=C8087_3">Intel C8087-3</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=C8087_8">Intel C8087-8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=D8087_2">Intel D8087-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=D80287_6">Intel D80287-6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=A80387_25">Intel A80387-25</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Cypress&part=CY7C602_40">Cypress CY7C602-40</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=AMD&part=Am29C327GC">AMD Am29C327GC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Motorola&part=MC68882RC20A">Motorola MC68882RC20A</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">I/O Processor</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=GC80312">Intel GC80312</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Sony&part=CXD1869AQ">Sony CXD1869AQ</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=D8089_3">Intel D8089-3</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Zilog&part=Z86C9540ASC">Zilog Z86C9540ASC</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Cache Controller</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Intel&part=A82496_66">Intel A82496-66</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Sony&part=TMX390Z55GF">TI TMX390Z55GF</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Cypress&part=CY7C605_40">Cypress CY7C605-40</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">ALU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=MOS&part=MPS2523">MOS MPS2523</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=NEC&part=uPD977C">NEC uPD977C</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">GPU/PPU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=manufacturer&manufacturer=nVIDIA">nVIDIA GPU</a></span>
					<li><span class="list_element"><a href="$scriptName?page=manufacturer&manufacturer=Nintendo&family=Super Nintendo">Super Nintendo PPU</a></span>
					<li><span class="list_element"><a href="$scriptName?page=chip&manufacturer=Ricoh&part=RP2A03G">Ricoh RP2A03G</a></span>
				</ul>
			</td><td valign="top">
				<ul>
				</ul>
			</td>
		</tr>
	</table>
Endhtml
	return $text;
}

sub create_html_body_main_category_arch {
	my $text = '';

	$text .= <<Endhtml;
			<div class="familyDescTable">
				<table cellpadding="5" width="100%">
					<tr>
						<td colspan="2">
							<span class='familyDescTableName'>Processor Families by Architectures<br /></span>
							<span class='familyDescTableParam'>Wikipedia:</span> <span class='familyDescTableValue'><a href="http://en.wikipedia.org/wiki/CPU_design">CPU design</a> & <a href="http://en.wikipedia.org/wiki/Instruction_set">Instruction set architecture</a></span><br />
							<span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'> There are many different ways to describe a processors architecture.  The most common are <a href="http://www.happytrees.org/cgi-bin/chipParse-v2.05.pl?page=cat&type=data_width">data width</a>, category of instruction set architecture, and microarchitecture.</span>
						</td>
					</tr>
				</table>
				</div>
	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="harvard"><br />Harvard Architecture</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/Harvard_architecture">Harvard architecture</a>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><br />Modified Harvard Architecture</span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/Modified_Harvard_architecture">Modified Harvard architecture</a>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Gameboy">Gameboy</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48"></a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51"></a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="risc"><br />RISC</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/RISC">RISC</a>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM29000">AM29000</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i960">i960</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=XScale">XScale</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperH">SuperH</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R3000">R3000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alchemy">Alchemy</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alpha">Alpha</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Playstation I">Playstation I</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Playstation II">Playstation II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Nintendo 64">Nintendo 64</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1"><a name="VLIW"><br />VLIW</a></span><br />
				Wikipedia: <a href="http://en.wikipedia.org/wiki/VLIW">VLIW</a>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">von Neumann Architecture</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">CISC</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68000">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68020">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68030">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68040">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=186">186</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=188">188</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386">386</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68302">68302</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC05">HC05</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC11">HC11</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC12">HC12</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC16">HC16</a></span>
				</ul>
			</td>
		</tr>
	</table>
Endhtml
	return $text;
}

sub create_html_body_main_category_data_width {
	my $text ='';

	$text .= <<Endhtml;
			<div class="familyDescTable">
				<table cellpadding="5" width="100%">
					<tr>
						<td colspan="2">
							<span class='familyDescTableName'>Processor Families by Architectures Data Width<br /></span>
							<span class='familyDescTableParam'>Wikipedia:</span> <span class='familyDescTableValue'><a href="http://en.wikipedia.org/wiki/Central_processing_unit#Integer_range">CPU: Integer range</a></span><br />
							<span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'>The architechure of a CPU or MCU is often labeled using the size of a data word used in operations.  Add, subtract, shift, etc. The size of data word is usually the same size as the internal data bus, and general purpose registers.  A 32-bit processor usually has a 32-bit internal data bus.  A processor can have many different data buses, and they may have different sizes.  It is common for a FPU to have a larger data bus than the main data bus.  Some processors have external data busses that are different size than the internal data bus.  The 32-bit <a href="$scriptName?page=chip&manufacturer=Motorola&part=MC68008P8">Motorola MC68008</a> has an 8-bit external data bus, so it can reduce the number of pins.  The 32-bit <a href="$scriptName?page=manufacturer&manufacturer=Intel&family=Pentium">Pentium</a> has a 64-bit external data bus to increase data transfer speed.   </span>
						</td>
					</tr>
				</table>
				</div>

	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1">2-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=3000">3000</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">4-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=4004">4004</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM2900">AM2900</a></span>

				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">8-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=1802">1802</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=1806">1806</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=2650">2650</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6502">6502</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6800">6800</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8080">8080</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Gameboy">Gameboy</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6803">6803</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6805">6805</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6809">6809</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=H8">H8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC05">HC05</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC11">HC11</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=HD6305">HD6305</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-41">MCS-41</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-48">MCS-48</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-51">MCS-51</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=3912">3912</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SAM8">SAM8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8">Z8</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z180">Z180</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=CXP80600">CXP80600</a></span>
					
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">16-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8086">8086</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=186">186</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=188">188</a></span>		
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Super Nintendo">Super Nintendo</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=V20">V20</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z8000">Z8000</a></span>					
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC12">HC12</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=HC16">HC16</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=MCS-96">MCS-96</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">24-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU/DSP</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=DSP56000">DSP56000</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">32-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386"></a>386</span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=NS32000">NS32000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i960">i960</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM7">ARM7</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=ARM9">ARM9</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=AM29000">AM29000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68020">68020</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68030">68030</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=68040">68040</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Alchemy">Alchemy</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>

				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>

				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">64-bit</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Nintendo 64">Nintendo 64</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Playstation II">Playstation II</a></span>

				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element">none</span>
				</ul>
			</td>
		</tr>

	</table>
Endhtml
	return $text;
}



sub create_html_body_main_category_app {
	my $text='';
	$text = <<Endhtml;
	<div class="heading1">Chips by Application </div>
	<divi>Microcontrollers and processors are often designed for a general application, for example desktop computers, or motor control</div><br />
 
	<table>
		<tr>
			<td colspan="2" align="center">
				<span class="heading1">Early desktop computers</span>
			</td>
		</tr><tr>
			<td>
				<span class="heading2">CPU</span>
			</td>
			<td>
				<span class="heading2">MCU</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=2650">2650</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6502">6502</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6800">6800</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8080">8080</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8085">8085</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Z80">Z80</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=8088">8088</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=286">286</a></span>
					
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Desktop computers</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=386"></a>386</span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486">486</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=486 Overdrive">486 Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=6x86">6x86</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium">Pentium</a></span>	
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Pro">Pentium Pro</a></span>					
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium MMX">Pentium MMX</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium Overdrive">Pentium Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II">Pentium II</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium II Overdrive">Pentium II Overdrive</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium III">Pentium III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium 4">Pentium 4</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Pentium M">Pentium M</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Celeron">Celeron</a></span>						
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K5">K5</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6">K6</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-2">K6-2</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K6-III">K6-III</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Athlon">K7 Athlon</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=K7 Durron">K7 Durron</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Athlon XP">Athlon XP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=WinChip">WinChip</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PowerPC">PowerPC</a></span>
					
					<li><span class="list_element"><a href="$scriptName?page=family&family=68040">68040</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Servers/Workstations</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Xeon DP">Xeon DP</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SPARC">SPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=SuperSPARC">SuperSPARC</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=i860">i860</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=UltraSPARC">UltraSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R4400">R4400</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R10000">R10000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=R12000">R12000</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=microSPARC">microSPARC</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=PA-RISC">PA-RISC</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Video game systems</span>
			</td>
		</tr><tr>
			<td>
				<ul>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Nintendo 64">Nintendo 64</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Playstation II">Playstation II</a></span>
				</ul>

			</td>
			<td>
				<ul>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Gameboy">Gameboy</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Gamegear">Game Gear</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Super Nintendo">Super Nintendo</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=XBox 360">XBox 360</a></span>
				</ul>
			</td>
		</tr><tr>
			<td colspan="2" align="center">
				<span class="heading1">Embedded system</span>
			</td>
		</tr><tr>
			<td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TMS320">TMS320</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=186"></a>186</span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=188"></a>188</span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=TriMedia">TriMedia</a></span>
				<li><span class="list_element"><a href="$scriptName?page=family&family=Alchemy">Alchemy</a></span>
				</ul>
			</td><td valign="top">
				<ul>
					<li><span class="list_element"><a href="$scriptName?page=family&family=NS32000">NS32000</a></span>
					<li><span class="list_element"><a href="$scriptName?page=family&family=Geode">Geode</a></span>
				</ul>
			</td>
		</tr>

	</table>
Endhtml

	return $text;
}







sub create_html_body_main_category_logo {
	my $text='';
	$text = <<Endhtml;

	<div class="heading1">Chip Manufacturer Logos</div>
	<div><a href="http://howto.wikia.com/wiki/Howto_identify_integrated_circuit_%28chip%29_manufacturers_by_their_logos">More complete list of IC manufacture logos$wiki_attrib</a>: 500+ logos</div><br />
 
	<div style="width: 470; margin-left: auto; margin-right: auto;">
		<table cellpadding="2" style="background-color: #000000;">
			<tr>
				<td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=2Wire">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--2Wire.gif" width="60" title="2Wire"></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--ARM.gif" width="60" title="ARM"></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=Alcatel">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Alcatel-1.gif" width="60" title="Alcatel"></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--AMI-Advanced-Micro-Systems_Inc-1.gif" width="60" title="AMI"></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--AMD-Advanced_Micro_Dev.gif" width="60" title=""></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Auctor.gif" width="60" title=""></a>
				</td><td width="60">
					<a href="$scriptLoc?page=manufacturer&manufacturer=">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Conexant_systems.gif" width="60" title=""></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Cypress">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Cypress_Semi.gif" width="60" title="Cypress"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Cyrix">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Cyrix_Corp.gif" width="60" title="Cyrix"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=DEC">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--DEC-Digital_Electronics_Corp.gif" width="60" title="DEC"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=DEC">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--DEC-Digital_Equipment_Corp.gif" width="60" title="DEC"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Epson">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Epson.gif" width="60" title="Epson"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Freescale">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Freescale_Semi.gif" width="60" title="Freescale"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Fujitsu">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Fujitsu_Ltd-2.gif" width="60" title="Fujitsu"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Fujitsu">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Fujitsu_Ltd-1.jpg" width="60" title="Fujitsu"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=General_Insturments">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--GI-General_Insturments-1.gif" width="60" title="General_Insturments"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=General_Insturments">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--GI-General_Insturments-2.gif" width="60" title="General_Insturments"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=HP">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--HP-Hewlet_Packard-1.jpg" width="60" title="HP"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Harris">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Harris_Semi-1.gif" width="60" title="Harris"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Harris">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Harris_Semi-3.gif" width="60" title="Harris"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=National Semiconductor">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--National_Semi-2.gif" width="60" title="National Semiconductor"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=National Semiconductor">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--National_Semi.gif" width="60" title="National Semiconductor"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=National Semiconductor">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--National_Semi.png" width="60" title="National Semiconductor"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Hitachi">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Hitachi_Ltd.gif" width="60" title="Hitachi"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=IBM">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--IBM.gif" width="60" title="IBM"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=IDT">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--IDT-Integrated_Logic_Tech-1.gif" width="60" title="IDT"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Intel">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Intel_Corp.gif" width="60" title="Intel"></a>
				</td><td align="center">
					<a href="$scriptLoc?page=manufacturer&manufacturer=Intel">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Intel_Corp-2.gif" width="20" title="Intel"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=LSI">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--LSI_Computer_Systems_Inc.jpg" width="60" title="LSI"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=MHS">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--MHS-Matra_Harris_Semi-1.gif" width="60" title="MHS"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=MOS">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--MOS_Tech_Inc.gif" width="60" title="MOS"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=MOSTEK">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--MOSTEK-2.jpg" width="60" title="MOSTEK"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Matsushita">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Matsushita_Electronics_Corp.jpg" width="60" title="Matsushita"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Matsushita">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Matsushita_Electronics_Corp-3.gif" width="60" title="Matsushita"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Matsushita">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Matsushita_Electronics_Corp-2.gif" width="60" title="Matsushita"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Mitsubishi">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Mitsubishi_Electric_Corp.gif" width="60" title="Mitsubishi"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Motorola">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Motorola_Semi_Products_inc.gif" width="60" title="Motorola"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=NEC">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--NEC-Nippon_Electric_Co.jpg" width="60" title="NEC"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=NexGen">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--NexGen.gif" width="60" title="NexGen"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Nintendo">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Nintendo-1.jpg" width="60" title="Nintendo"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Novatek">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--NOVATEK.gif" width="60" title="Novatek"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=OKI">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--OKI_Electric_Industry_Co.jpg" width="60" title="OKI"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Philips">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Philips_Electronic_Components-1.gif" width="60" title="Philips"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Philips">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Philips_Electronic_Components-2.gif" width="60" title="Philips"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=RCA">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--RCA_Corp-1.jpg" width="60" title="RCA"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Raytheon">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Raytheon_Co-1.jpg" width="60" title="Raytheon"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Ricoh">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Ricoh-1.jpg" width="60" title="Ricoh"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Rockwell">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Rockwell.gif" width="60" title="Rockwell"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=SGS">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--SGS-Thomson.gif" width="60" title="SGS"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=STMicroelectronics">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--STMicroelectronics.gif" width="60" title="STMicroelectronics"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Samsung">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Samsung_Semi.gif" width="60" title="Samsung"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Sanyo">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Sanyo-Tokyo_Sanyo_Electric_Co-1.gif" width="60" title="Sanyo"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Sanyo">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Sanyo-Tokyo_Sanyo_Electric_Co-3.gif" width="60" title="Sanyo"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Siemens">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Siemens-1.jpg" width="60" title="Siemens"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Signetics">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Signetics_Corp.gif" width="60" title="Signetics"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Sony">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--SONY-1.jpg" width="60" title="Sony"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Sun">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Sun_Microsystems.gif" width="60" title="Sun"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Synertek">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Synertek.gif" width="60" title="Synertek"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=TI">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--TI-Texas_Insturments_Inc.gif" width="60" title="TI"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Temic">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Temic-1.gif" width="60" title="Temic"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Toshiba">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Toshiba_Corp-1.jpg" width="60" title="Toshiba"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Toshiba">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Toshiba_Corp-2.gif" width="60" title="Toshiba"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Toshiba">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Toshiba_Corp-3.gif" width="60" title="Toshiba"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=VLSI">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--VLSI_Tech.jpg" width="60" title="VLSI"></a>
				</td>
			</tr><tr>
				<td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Virata">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Virata.gif" width="60" title="Virata"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Weitek">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Weitek-1.jpg" width="60" title="Weitek"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Zilog">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Zilog_Semi-1.gif" width="60" title="Zilog"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Zilog">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Zilog_Semi-3.gif" width="60" title="Zilog"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Zilog">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Zilog_Semi-4.gif" width="60" title="Zilog"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=nVIDIA">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Nvidia.gif" width="60" title="Nvidia"></a>
				</td><td>
					<a href="$scriptLoc?page=manufacturer&manufacturer=Broadcom">
					<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Broadcom.gif" width="60" title="Broadcom"></a>
				</td><td>
				</td>
			</tr>
		</table>

Endhtml
	return $text;
}




