#!/usr/bin/perl 


########################################################
# 	This file creates the CPU Graveyard's website
#
# 	Feel free to used it for your site, in whole or any pieces, 
# 	in acordance with GPL. IE give me credit. See below. If you do
# 	use the entire code for ur collections page, please use a
# 	different color scheme and title so it will be distiguishable
# 	from 'the CPU Graveyard'.  Much of the text has been moved 
# 	to 'chip_html_include.pl', so the file isn't as large, easier
#	  to work with.
#
#   This is a version that generates all html pages.
#
# 	Copyright 2021-, Jeff Israel, https://happytrees.org.org
# 	
# 	License: GPLv3
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#	see <https://www.gnu.org/licenses/>
#
#
#todo 
#	404 page with boards support
#	add topbar?maybe
#	script name
#	images in files
#	scaleing, responsive
#	replace lq logos
#	intro box is off
#	long list alt colors
#	anchor architecture, application, tech, datawidth pages, glossary
#	dont show family details if no info, https://happytrees.org/testing/ic/Qualcomm/QSC6270
#  https://happytrees.org/testing/m/Others shows General%20Instruments ()
#	change chip intro, to chip summary
#	center "photo to be added"
#	heading missing manuf	https://happytrees.org/testing/mf/Hitachi/6805
#  Hitachi - HD68450_8	https://happytrees.org/testing/ic/Hitachi/HD68450%5F8
#  New chips on homepage
#
# use warnings; 
use File::stat;
use Time::localtime;
use Switch;
use Archive::Zip;
use Data::Dumper; # ::Perltidy;
# use Spreadsheet::Read;

#############################
# Config
#

$version		= 'v2.10';


$DEBUG = 1;

$scriptName 	= $ENV{'SCRIPT_NAME'};
$serverName 	= $ENV{'SERVER_NAME'};


$script_url = "/home/zymos/Documents/chips/generated_pages"; #https://happytrees.org/chiptesting"; # previously $scriptName # Used for links
$script_files_root = "."; #"/var/www/happytrees.org/cgi-bin/cpu/";


# all binaries are in files root
$include_files_root = "."; #/var/www/happytrees.org/htdocs/files/chips/";
$chip_spreadsheet_file = "chipCollection-v1.03.ods"; # previously$spreadsheetFileName 
$family_order_file =  'familyErasOrdered.txt'; # previously $familyErasOrderedFileName 
$extended_code_include_file = 'chip_html_include-v2.pl';

$contact_page = "https://happytrees.org/contact";

$imageLoc	= 'main-images';
$photoLoc 	= 'main-images/chip-v2';
$thumbLoc 	= 'main-images/chip-v2/sm';
$board_loc 	= 'main-images/boards-v1';
$board_thumb_loc= 'main-images/boards-v1/sm';
$code_loc = 'https://github.com/zymos/cpu_website';

$logoLoc 	= 'main-images/ic-manuf-logos';
$datasheet_loc = 'files/chips/datasheets';

$skipLines 	= 1;

$chip_page_number = 0;
$manuf_page_number = 1;
$family_page_number = 2;
$board_page_number = 3;
$varient_page_number = 4;


@manuf_others_list_global = ('2WIRE','ATI','Alcatel','Broadcom','Conexant','Microsoft','Virata','Zarlink','Zoran','nVIDIA','General Instruments','Nintendo','Sega','GPS','ELAN','ADMtek','Sanyo','STC','Temic','Novatek','Matsushita');


######################################################
############## Coding ################################
######################################################

# sub check_script_location { # no longer used
	# my @scriptParts = split(/\//,$scriptName);
	# $relativeLoc = '.';
	# if($scriptName =~ /\//) {
		# @scriptParts = split(/\//,$scriptName);
		# print "$#scriptParts $scriptParts[$#scriptParts]<br />\n";
		# $scriptName = $scriptParts[$#scriptParts];
		# if($#scriptParts > 1) {
			# $relativeLoc = '..';
		# }
	# }
# }

################## Import ARGS ##############
sub read_input {
    local ($buffer, @pairs, $pair, $name, $value, %FORM);
    # Read in text
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "POST")
    {
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    } else
    {
        $buffer = $ENV{'QUERY_STRING'};
    }
	# $buffer = 'page=manufacturer&manufacturer=AMD&family=AM29000';
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs)
    {
        ($name, $value) = split(/=/, $pair);
        $value =~ tr/+/ /;
        $value =~ s/%(..)/pack("C", hex($1))/eg;
        $FORM{$name} = $value;
    }

	# print "Content-type: text/plain\n\n";
	# print "ENV{'QUERY_STRING'} -> $ENV{'QUERY_STRING'}\n\n";
	# print "FORM{'page'} -> $FORM{'page'}\n\n";
	# exit;


	if( $FORM{'page'} eq '' ){
		@value = split('\/', $FORM{'var'});
		# print Dumper @value;
		# print "<br>0=>$value[0], 1=>$value[1], 2=>$value[2]<br>\n";
		# print "xxxxxxxxxx";
		switch($value[0]){
			case 'categories'{		$query_out{'page'} = 'cat'; }
			case 'families'	{ 	$query_out{'page'} = 'cat';
								$query_out{'type'} = 'family'; }
			case 'manufacturers'{	$query_out{'page'} = 'cat';
									$query_out{'type'} = 'manuf'; }
			case 'architecture'{$query_out{'page'} = 'cat';
								$query_out{'type'} = 'arch'; }
			case 'data_width'{		$query_out{'page'} = 'cat';
									$query_out{'type'} = 'data_width'; }
			case 'chip_types'	{ 	$query_out{'page'} = 'cat';
								$query_out{'type'} = 'type'; }
			case 'ISA'{				$query_out{'page'} = 'cat';
									$query_out{'type'} = 'isa'; }
			case 'technologies'{$query_out{'page'} = 'cat';
								$query_out{'type'} = 'tech'; }
			case 'release_date'{		$query_out{'page'} = 'cat';
									$query_out{'type'} = 'date'; }
			case 'logos'	{	$query_out{'page'} = 'cat';
									$query_out{'type'} = 'logo'; }
			case 'applications'{$query_out{'page'} = 'cat';
								$query_out{'type'} = 'app'; }
			case 'boards'	{ 		$query_out{'page'} = 'board'; }
			case 'board'    { 	$query_out{'page'} = "board";
								$query_out{'manuf'} = $value[1];
								$query_out{'name'} = $value[2]; }
			case 'module_boards'{	$query_out{'page'} = 'board';
									$query_out{'type'} = 'module'; }
			case 'evaluation_boards'{	$query_out{'page'} = 'board';
										$query_out{'type'} = 'eval'; }
			case 'ic'{		$query_out{'page'} = "chip";
							$query_out{'manufacturer'} = $value[1];
							$query_out{'part'} = $value[2]; }
			case 'full_list'{	$query_out{'page'} = 'fullList'; }
			case 'trade'	{ 		$query_out{'page'} = 'tradeList'; }
			case 'glossary'	{ 	$query_out{'page'} = 'glossary'; }
			case 'sitemap'  { 		$query_out{'page'} = 'site_map'; }
			case 'm'  		{ 	$query_out{'page'} = "manufacturer";
								$query_out{'manufacturer'} = "$value[1]"; }
			case 'mf'		{		$query_out{'page'} = "manufacturer";
									$query_out{'manufacturer'} = "$value[1]";
									$query_out{'family'} = "$value[2]";}
			case 'family'	{	$query_out{'page'} = "family";
								$query_out{'family'} = "$value[1]";}
			case '404'		{	$query_out{'page'} = "404";	}
			case ''			{	$query_out = ''; }
			else			{		$query_out{'page'} = '404'; } # unknown page
		}

		if( $DEBUG ){
		print "Content-type: text/html\n\n";
		print "ENV{'QUERY_STRING'} -> '$ENV{'QUERY_STRING'}' <br><br>\n\n";
		print "FORM{'page'} -> $FORM{'page'} <br><br>\n\n";
		print "value0 -> '$value[0]', value1 -> '$value[1]', value2 -> '$value[2]' <br><br>\n\n";
		foreach $key (keys %query_out){
			print "query_out = key -> '$key' value -> '$query_out{$key}'<br>";
		}
		foreach $key (keys %FORM){
			print "FORM = key -> '$key' value -> '$FORM{$key}'<br>";
		}
		print "<br><br>Location: $script_url\n\n";
		}
		# exit;

		return %query_out
	}else{
		# old query style, redirect
		my $man = url_encode($FORM{'manufacturer'});
		my $fam = url_encode($FORM{'family'});
		my $par = url_encode($FORM{'part'});
		my $manu = url_encode($FORM{'manuf'});
		switch( $FORM{'page'} ) {
			case 'cat' {
						switch( $FORM{'type'} )  {
							case 'family' { $url_path = "/families"; }
							case 'manuf' { 	$url_path = "/manufacturers"; }
							case 'arch' { 	$url_path = "/architecture"; }
							case 'data_width' { $url_path = "/data_width"; }
							case 'type' { 	$url_path = "/chip_types"; }
							case 'isa' { 	$url_path = "/ISA"; }
							case 'tech' { 	$url_path = "/technologies"; }
							case 'date' { 	$url_path = "/release_date"; }
							case 'app' { 	$url_path = "/applications"; }
							else { 			$url_path = "/categories"; }
						}
					}
			case 'manufacturer' {
						if( $man eq '' ) {
							$url_path = '';
						}elsif( $fam ne '' ) {
							$url_path = "/mf/$man/$fam";
						}else{
							$url_path = "/m/$man";
						}
					}
			case 'chip' { 
						if( $man eq '' ) {
							$url_path = '';
						} elsif ( $par eq '' ) {
							$url_path = '';
						} else {
							$url_path = "/ic/$man/$par" ;
						}
					}
			case 'board' { 
						if( $FORM{'type'} eq '' && $manu eq '' ) {
							$url_path = '/boards';
						} elsif ( $manu ne '' ) {
							$url_path = "/board/$manu/$par" ; 
						} elsif( $FORM{'type'} eq 'module' ) {
							$url_path = '/module_boards';
						} elsif( $FORM{'type'} eq 'eval' ) {
							$url_path = '/evaluation_boards';
						} else {
							$url_path = "" ;
						}
					}
			case 'family' 	{ $url_path = "/family/$fam"; }
			case 'glossary' { $url_path = "/glossary"; }
			case 'site_map' { $url_path = "/sitemap";}
			case 'tradeList'{ $url_path = "/trade";}
			case 'fullList' { $url_path = "/full_list";}
			else			{ $url_path = ""; }
		}
		
		# redirect old format to new
		# print "Content-type: text/html\n\n";
		# print "ENV{'QUERY_STRING'} -> '$ENV{'QUERY_STRING'}' <br><br>\n\n";
		# print "FORM{'page'} -> $FORM{'page'} <br><br>\n\n";
		# print "value0 -> '$value[0]', value1 -> '$value[1]', value2 -> '$value[2]' <br><br>\n\n";
		# foreach $key (keys %FORM){
			# print "FORM = key -> '$key' value -> '$FORM{$key}'<br>";
		# }
		# print "<br><br>Location: $script_url\n\n";

		# print "<br><br>Redirecting Location: " . $script_url . $url_path . "\n\n";
		 
		# print "Status: 301 Moved Permanently\n";
		print "Status: 307\n";
		print "Location: " . $script_url . $url_path . "\n\n";
		exit;
		# return %FORM;
	}
}
###############Inport ARGS (end) ##################











##################################################
############### Reading Files ####################

#open file
sub openFile { 
	my $fileName = $_[0];
	open(FILEVARIABLE, "< $fileName");
	@fileLines= <FILEVARIABLE>;
	close(FILEVARIABLE);
	return @fileLines;
}


sub bbl_sort {
	# my (@a, @b) = @_;
    my @array =  @_;
	# print_2d(@array);
	my $row_sort = 0;
	# my $array2 =  @{$_[1]};
    my $not_complete = 1;
    my $index;
    my $len = ($#{$array[$row_sort]} - 2);
    # print "|sub=" . scalar @array . " -- " . scalar @array2 . "|";
    while ($not_complete) {
        $not_complete = 0;
        foreach $index (0 .. $len) {
            if ($array[$row_sort][$index] > $array[$row_sort][$index + 1]) {
                my $temp = $array[0][$index + 1];
				my $temp2 = $array[1][$index + 1];
                $array[0][$index + 1] = $array[0][$index];
				$array[1][$index + 1] = $array[1][$index];
                $array[0][$index] = $temp;
				$array[1][$index] = $temp2;
                $not_complete = 1;
				# print @array2[$index]; 
            }
        }
    }
	return (@array);
}


sub parse_ods {
	my $file = $_[0];
	my @sheets = ();
	my @data = ();
	my $sheet_num=0;
	my $row_num=0;
	my $col_num=0;
	my $col_repeated=0;
	# my $content_file_name = $include_files_root . "chip_collection_file/content.xml";

	# unzipping is actually faster than using the uncompressed xml
	my $zip = Archive::Zip->new($file);
	my $content=$zip->contents('content.xml');
	#
	
	# my $content = '';
	# my $content_file_name = $include_files_root . "chip_collection_file/content.xml";

	# if(-r $content_file_name && 0){
		# # read content.xml file without unzip
		# if( open(my $fh, '<:encoding(UTF-8)', $content_file_name) ){
			  # while (my $row = <$fh>) {
				  # $content .= $row;
				  # # print $row . "<br />\n";
			  # }
		# }else{
			# print "Content-type: text/plain\n\n\nCould not open file '$content_file_name' $!";
			# exit 1;
		# }
		# print "content.xml OK";
		# # print $content;
	# }else{
		# # content.xml DNE, slow method
		# if(! -r $file ){
		# # read content.xml file without unzip
			# print "Content-type: text/plain\n\n\nCould not open file '$file'";
			# exit 1;
		# }else{
			# my $zip = Archive::Zip->new($file);
			# my $content=$zip->contents('content.xml');
			# print "Zip: ok";
		# }
	# }
	

	$content =~ s/<\?xml .*\?>\n//;
	$content =~ s/^.*<office:spreadsheet>//;
	$content =~ s/<\/office:spreadsheet>.*$//;
	$content =~ s/<table:named-expressions>.*<\/table:named-expressions>//;
	$content =~ s/<table:database-ranges>.*<\/table:database-ranges>//; #keep greedy?
	$content =~ s/<\/table:table-cell>//; #maybe not neeeded
	$content =~ s/<\/table:table-row>//; #maybe not neeeded
	# $content =~ s///; 
	
	@sheets = split(/<table:table .*?>/,$content);
	shift(@sheets); #skips the first _blank_ element

	foreach $sheet (@sheets) {
		$row_num=-1;
		foreach $row (split(/<table:table-row .*?>/,$sheet)) {
			if ($row_num != -1) {
				#skips first element
				$col_num=-1;
				foreach $cell ( split(/<table:table-cell/,$row )) {
					if ( $col_num == -1 ) {
						#skips first element
						$col_num++;
					} else {
						$cell_content = $cell;
						if ( $cell_content =~ /<text:p>/ ) {
							$cell_content =~ s/.*<text:p>//;
							$cell_content =~ s/<\/text:p>.*//;
						} else { # no content in cell
							$cell_content = '';
						}
						if ($cell =~ /number-columns-repeated/) {
							# repeat cells contents n-times
							$col_repeated = $cell;
							$col_repeated =~ s/table:number-columns-repeated="//;
							$col_repeated =~ s/".*//;
							for (my $x=1;$x<=$col_repeated;$x++) {
								$data[$sheet_num][$row_num][$col_num]=$cell_content;
								$data[$sheet_num][$row_num][$col_num] =~ s/[\s\n]*$//g;  # remove trailing whitespace/newline
								$col_num++;
							}
						} else {
							# no repeated cols
							$data[$sheet_num][$row_num][$col_num]=$cell_content;
							$data[$sheet_num][$row_num][$col_num] =~ s/[\s\n]*$//g; # remove trailing whitespace/newline
							$col_num++;
						}
					}
				}
			}
			$row_num++
		}
		$sheet_num++;
	}
	return @data;
}


############# Reading Files (end) ##################
####################################################






sub url_encode {
	my ($rv) = @_;
	$rv =~ s/([^A-Za-z0-9])/sprintf("%%%2.2X", ord($1))/ge;
	return $rv;
}

sub url_decode {
	my ($rv) = @_;
	$rv =~ s/\+/ /g;
	$rv =~ s/%(..)/pack("c",hex($1))/ge;
	return $rv;
}





########################################################
################# Processing Data ######################


sub getColLabels {
	my $col=1;
	while ( &chipData2(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&chipData2(0,$col)) {
			case "My Label" {$colJeffLable=$col}
			case "#" 		{$colTotal	=$col}
			case "Trade" 	{$colTrade	=$col}
			case "Manufacturer" {$colManuf	=$col}
			case "Part #" 	{$colPart	=$col}
			case "Type" 	{$colType	=$col}
			case "Family" 	{$colFamily	=$col}
			case "Core" 	{$colCore	=$col}
			case "Architecture"	{$colArch	=$col}
			case "Bus Width" 	{$colDataBus=$col}
			case "Address Width" {$colAddBus=$col}
			case "Speed" 	{$colSpeed	=$col}
			case "blank" 	{$colBlank	=$col}
			case "FPU" 		{$colFPU	=$col}
			case "L1 cache" {$colL1		=$col}
			case "L2 cache" {$colL2		=$col}
			case "L3 cache"	{$colL3		=$col}
			case "Package" 	{$colPack	=$col}
			case "Transistors" 	{$colTrans	=$col}
			case "Process Size" {$colProc	=$col}
			case "Technology" 	{$colTech	=$col}
			case "Die Size" {$colDie	=$col}
			case "Vcc" 		{$colVcc	=$col}
			case "Vcc (I/O)" 		{$col_volt_io	=$col}
			case "Power Max" 		{$col_power	=$col}
			case "Date Introduced" 	{$colDate=$col}
			case "Condition" 	{$colCond	=$col}
			case "Variants" 	{$colVar	=$col}
			case "Description" 	{$colDesc	=$col}
			case "Photo 1" 	{$colPhoto1	=$col}
			case "Photo 2" 	{$colPhoto2	=$col}
			case "Photo 3" 	{$colPhoto3	=$col}
			case "Photo 4" 	{$colPhoto4	=$col}
			case "Photo 5" 	{$colPhoto5	=$col}
			case "Datasheet" {$col_datasheet	=$col}
			case "Alt ID 1"	{$col_alt_id	=$col}
			case "Alt ID 2"	{$col_alt_id2	=$col}
			case "Alt ID 3"	{$col_alt_id3	=$col}
			case "Label ID" {$col_label_id	=$col}
			case "ROM Int"	{$col_rom_int	=$col}
			case "ROM type"	{$col_rom_type	=$col}
			case "RAM Int"	{$col_ram_int	=$col}
			case "RAM Max"	{$col_ram_max	=$col}
			case "RAM type"	{$col_ram_type	=$col}
			case "Socket"	{$col_socket	=$col}
			case "Features"	{$col_features	=$col}
			case "# Cores"	{$col_num_cores	=$col}
			case "Designer of Core"	{$col_designer	=$col}
			case "Bus speed"	{$col_bus_speed	=$col}
			case "Applications"	{$col_applications = $col}
			case "Instruction set"	{$col_instruction_set = $col}
			case "Instruction link"	{$col_instruction_link = $col}
			case "Computer architecture"{$col_computer_architecture = $col}
			case "Microarchitecture"	{$col_microarchitecture = $col}	
			case "ISA"	{$col_isa = $col}
			# case ""	{$col_ = $col}
			# case ""	{$col_ = $col}
			# case ""	{$col_ = $col}
			# case ""	{$col_ = $col}
			else {}
		}
		$col++;
	}
	$col=1;
	while ( &manufData2(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&manufData2(0,$col)) {
			case "Short name"	{$colManufName	=$col}
			case "Abrev"	{$colManufAbrev	=$col}
			case "Full name"	{$colManufFullName	=$col}
			case "Date"	{$colManufDate	=$col}
			case "Homepage"	{$colManufHomepage	=$col}
			case "Wiki"	{$colManufWiki	=$col}
			case "Traditional"	{$colManufTrad	=$col}
			case "Current"	{$colManufCurrent	=$col}
			case "Status"	{$colManufStatus	=$col}
			case "Description"	{$colManufDesc	=$col}
			case "Wide logo"	{$colManufWideLogo	=$col}
			case "Logo1"	{$colManufLogo1	=$col}
			case "Logo2"	{$colManufLogo2	=$col}
			case "Logo3"	{$colManufLogo3	=$col}
			case "Logo4"	{$colManufLogo4	=$col}
			case "Logo5"	{$colManufLogo5	=$col}
			else {}
		}
		$col++;
	}
	$col=1;
	while ( &familyData2(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&familyData2(0,$col)) {
			case "Var"		{$colFamilyName	=$col}
			case "Full name"	{$colFamilyFullName	=$col}
			case "Manuf"	{$colFamilyManuf	=$col}
			case "Date"		{$colFamilyDate	=$col}
			case "Chip"		{$colFamilyChip	=$col} #maybe dont use
			case "Arch"		{$colFamilyArch	=$col}
			case "Freq range"	{$colFamilyFreq	=$col}
			case "Technology"	{$colFamilyTech	=$col}
			case "# Intructions"	{$colFamilyIntrucNum	=$col}
			case "Int Set Name"	{$colFamilyInstrucName	=$col}
			case "Intruction link"	{$colFamilyInstrucLink	=$col}
			case "Description"	{$colFamilyDesc	=$col}
			case "Core arch"	{$colFamilyCoreArch	=$col}
			case "Wiki"			{$colFamilyWiki	=$col}
			case "Homepage"		{$colFamilyHomepage	=$col}
			case "Logo"			{$colFamilyLogo	=$col}
			else {}
		}
		$col++;
	}
	$col=1;
	while ( &wanted_data(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&wanted_data(0,$col)) {
			case "Manufacture"	{$col_wanted_man	=$col}
			case "Part #"		{$col_wanted_part	=$col}
			else {}
		}
		$col++;
	}
	$col=1;
	while ( &board_data(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&board_data(0,$col)) {
			case "Board type"	{$col_board_type	=$col}
			case "Type"			{$col_board_type	=$col}
			case "Manuf"		{$col_board_manuf	=$col}
			case "Name"			{$col_board_name	=$col}
			case "Chip manuf"	{$col_board_chip_manuf=$col}
			case "Chip part"	{$col_board_chip_part	=$col}
			case "Chip type"	{$col_board_chip_type	=$col}			
			case "Speed"		{$col_board_speed		=$col}
			case "Arch width"	{$col_board_arch_width=$col}
			case "Socket"		{$col_board_socket	=$col}
			case "Ports"		{$col_board_ports		=$col}
			case "Computers"	{$col_board_computers	=$col}
			case "Features"		{$col_board_features	=$col}
			case "Description"	{$col_board_desc		=$col}
			case "Photo front"	{$col_board_photo_front=$col}
			case "Photo back"	{$col_board_photo_back=$col}
			case "Manuf p1"		{$col_board_manuf_p1	=$col}
			case "Part p1"		{$col_board_part_p1	=$col}
			case "Func p1"		{$col_board_func_p1	=$col}
			case "Manuf p2"		{$col_board_manuf_p2	=$col}
			case "Part p2"		{$col_board_part_p2	=$col}
			case "Func p2"		{$col_board_func_p2	=$col}
			case "Manuf p3"		{$col_board_manuf_p3	=$col}
			case "Part p3"		{$col_board_part_p3	=$col}
			case "Func p3"		{$col_board_func_p3	=$col}
			case "Manuf p4"		{$col_board_manuf_p4	=$col}
			case "Part p4"		{$col_board_part_p4	=$col}
			case "Func p4"		{$col_board_func_p4	=$col}
			case "Manuf p5"		{$col_board_manuf_p5	=$col}
			case "Part p5"		{$col_board_part_p5	=$col}
			case "Func p5"		{$col_board_func_p5	=$col}
			case "Manuf p6"		{$col_board_manuf_p6	=$col}
			case "Part p6"		{$col_board_part_p6	=$col}
			case "Func p6"		{$col_board_func_p6	=$col}
			case "Manuf p7"		{$col_board_manuf_p7	=$col}
			case "Part p7"		{$col_board_part_p7	=$col}
			case "Func p7"		{$col_board_func_p7	=$col}
			case "Manuf p8"		{$col_board_manuf_p8	=$col}
			case "Part p8"		{$col_board_part_p8	=$col}
			case "Func p8"		{$col_board_func_p8	=$col}
			case "Manuf p9"		{$col_board_manuf_p9	=$col}
			case "Part p9"		{$col_board_part_p9	=$col}
			case "Func p9"		{$col_board_func_p9	=$col}
			case "Datasheet"	{$col_board_datasheet	=$col}
			else {}
		}
		$col++;
	}
}

sub getColChipData {
	my $row=$skipLines;
	my @manufList = ();
	my @familyList = ();
	@manufListGlobal = ();
	@familyListGlobal = ();

	while (&chipData2($row,$colPart) ne '') {
		#Makes a list of manuf and fams
		$manufList[$row-1]=&chipData2($row,$colManuf);
		$familyList[$row-1]=&chipData2($row,$colFamily);
		
		# This makes a list and count of manuf
		if ($manufListCountGlobal{&chipData2($row,$colManuf)} eq '') {
			$manufListCountGlobal{&chipData2($row,$colManuf)} =1;
		} else {
			$manufListCountGlobal{&chipData2($row,$colManuf)}++;
		}

		# Count families for this manufacturer
		if ( &chipData2($row,$colManuf) eq $data{'manufacturer'} ) {
			if (&chipData2($row,$colFamily) eq '') {
				$fam='Other';
			} else {$fam=&chipData2($row,$colFamily);}
			if ( $manufFamilyCountGlobal{$fam} eq '' ) {
				$manufFamilyCountGlobal{$fam} = 1;
			} else {
				$manufFamilyCountGlobal{$fam}++;
			}
		}
		$row++;
	}
	$totalChipCountGlobal=$row;

	undef %saw;
	@saw{@manufList} = ();
	@manufListGlobal = sort keys %saw;  
	undef %saw;
	@saw{@familyList} = ();
	@familyListGlobal = sort keys %saw;  
	$totalManufCountGlobal=$#manufListGlobal+1;
	$totalFamilyCountGlobal=$#familyListGlobal+1;

	@manufFamilies = keys %manufFamilyCountGlobal;
	&sortManufFamilies(%manufFamilyCountGlobal);
}



sub sortManufFamilies {
	#this creating two ordered arrays, organized by era to print prettylike
	# @manufFamilyListGlobal
	# @manufFamilyListCountGlobal
	my %manufFamilyCount = %manufFamilyCountGlobal; # $_[0]???
	my $x=0;
	my $hasOther=0;
	my $isInList=0;
	
	foreach $famEra (@chipErasGlobal) { #sorts the families included in chipEras list  
		if ($manufFamilyCount{$famEra} ne '' ) {
			$manufFamilyListGlobal[$x]=$famEra;
			$manufFamilyListCountGlobal[$x]=$manufFamilyCount{$famEra};
			$x++;	
		}
	}
	
	foreach $manufFamily (keys %manufFamilyCount) {
		$isInList=0;
		if ($manufFamily eq 'Other') {
			$hasOther=1;
			$isInList=1; #a bypass
		} else {
			foreach $famEra (@chipErasGlobal) {
				if ( $manufFamily eq $famEra){
					$isInList=1;
				}
			}
		}
		if ($isInList == 0){ #is its not in the list, add it
			$manufFamilyListGlobal[$x]=$manufFamily;
			$manufFamilyListCountGlobal[$x]=$manufFamilyCount{$manufFamily};
			$x++;
		}
	}

	if ($hasOther == 1) { #Adds Other to list
		$manufFamilyListGlobal[$x]='Other';
		$manufFamilyListCountGlobal[$x]=$manufFamilyCount{'Other'};
		$x++
	}

	if ($x >= 2) {
		unshift(@manufFamilyListGlobal, "All");
		unshift(@manufFamilyListCountGlobal, "null");
	}
}


# not currently used
sub sort_family_by {
	my $sort_element = $_[0];
	my %families_sort = ();
	my $row = $skipLines;
	my $col = '';

	switch ($sort_element) {
		case "data-width"	{ $col = $colArch; }
		case "arch"			{ $col = $col_computer_architecture; }
		case "tech"			{ $col = $colTech; }
		# case "family"		{ $col = $colFamily; }
		case "app"			{ $col = $col_applications; }
		case "microarch"	{ $col = $col_microarchitecture; }
		# case ""			{ $col = $; }
		# case ""			{ $col = $; }
		# case ""			{ $col = $; }
		# case ""			{ $col = $; }
		else				{ $col = 'X'; }
	}
	print "$sort_element:$col";

	if ( $col eq 'X' ) {
		print "Error: invalid sort elements.<br />\n";
	} else {
		while (&chipData2($row,$colPart) ne '') {
			if ( (&chipData2($row,$col) ne '' || &chipData2($row,$col) ne '?' || &chipData2($row,$col) ne 'Other') && (&chipData2($row,$colFamily) ne '' || &chipData2($row,$colFamily) ne '?' || &chipData2($row,$colFamily) ne 'Other') ) {
				# print ".";
				if ( $families_sort{&chipData2($row,$col)} eq '' ) {
				   $families_sort{&chipData2($row,$col)} = &chipData2($row,$colFamily);

				} elsif ( $families_sort{&chipData2($row,$col)} !~ /&chipData2($row,$colFamily)/ ) {
					$families_sort{&chipData2($row,$col)} .= '=' . &chipData2($row,$colFamily);
				   # print "-";	
				}
			   # print $families_sort{&chipData2($row,$col)};	
			$row++;
			}
		}
	}
    # for my $key ( keys %families_sort ) {
        # my $value = $families_sort{$key};
        # print "<br />$key => $value\n";
    # }
	return(%families_sort);
}




############### Process Data (end) ######################
#########################################################
#
#

sub chipData2 {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[$chip_page_number][$row][$col];
	# return $chipListSpreadsheet->[1]{cr2cell($col,$row)};
}	
sub manufData2 {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[$manuf_page_number][$row][$col];
	# return $chipListSpreadsheet->[2]{cr2cell($col,$row)};
}	
sub familyData2 {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[$family_page_number][$row][$col];
	# return $chipListSpreadsheet->[3]{cr2cell($col,$row)};
}	
sub wanted_data {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[3][$row][$col];
	# return $chipListSpreadsheet->[3]{cr2cell($col,$row)};
}	

sub board_data {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[$board_page_number][$row][$col];
}	

sub computer_data {
	# Format: $cellContents = &chipData2($row,$col)
	my $col = $_[1];
	my $row = $_[0];
	return $spreadsheetData[5][$row][$col];
}	


######### Process list (end) ############################

sub grapGlobals {
	# $totalChipCountGlobal=1;


	$pageTypeGlobal	= $data{'page'};
		# manufacturer
		# fullList
		# tradeList
	$selectedManufglobal	= $data{'manufacturer'};
	$selectedFamilyGlobal	= $data{'family'};


}



sub wikify { # makes wikipedia links
	my $text=$_[0];
	my $url='https://en.wikipedia.org/wiki/';

	@linkables = qw(CMOS NMOS PMOS CHMOS HMOS PSoC EPROM BIOS I2C);

	foreach $link (@linkables) {
		$text =~ s/ $link / <a href=\"$url$link\">$link<\/a> /;
	}	
	# PLD	prigrammable logic device
	# flash Flash memory
	# PAL Programmable Array Logic
	# ASIC Application-specific integrated circuit
	# DRAM Dynamic random access memory
	# SRAM Static random access memory
	# SPI Serial Peripheral Interface
	# SCI Serial Communication Interface
	# GPIO General Purpose Input/Output
	# CAN Controller-area network
	# ADC Analog-to-digital converter
	# DAC digital-to-analog converter
}



sub does_page_exist {
	$page_DNE_global = 'FALSE';
	
	my $x=$skipLines; 
	my $page_found = 0; # preset as not found

	# Is it a false page type?
	if($data{'page'} ne "fullList" && $data{'page'} ne "tradeList" && $data{'page'} ne "family" && $data{'page'} ne	"manufacturer" && $data{'page'} ne "chip" && $data{'page'} ne "sneezmale" && $data{'page'} ne "site_map" && $data{'page'} ne "cat" && $data{'page'} ne "glossary" && $data{'page'} ne "board" && $data{'page'} ne ""){	  
		print "404 false page";
		$page_DNE_global = 'TRUE';
		$page_DNE_title_global = "404: Page Type Not Found";
		$page_DNE_header2_global = "Page type is invalid";
		return;
	}

	# is it a basic page
	if($data{'page'} eq "fullList" || $data{'page'} eq "tradeList" || $data{'page'} eq "sneezmale" || $data{'page'} eq "site_map" || $data{'page'} eq "cat" || $data{'page'} eq "glossary" || $data{'page'} eq ""){	  
		$page_found = 1;
		return;
	}

	my $manuf, $family, $part, $manuf_query, $family_query, $part_query;
	# parse through list to see if query matchs actuall chips
	while(&chipData2($x,$colPart) ne "") { # searches throught list for chip/fam/man match
		$manuf = &chipData2($x,$colManuf) =~ s/\W/_/gr;#change urlencode 
		$family = &chipData2($x,$colFamily)=~ s/\W/_/gr; #change to urlencode in future
		$part = &chipData2($x,$colPart)=~ s/\W/_/gr; #change to urlencode in future
		
		$manuf_query = $data{'manufacturer'} =~ s/\W/_/gr; #change to urlencode in fut
		$family_query = $data{'family'} =~ s/\W/_/gr; #change to urlencode in future
		$part_query = $data{'part'} =~ s/\W/_/gr; #change to urlencode in future

		# print "$page_found -> $manuf <> $family <> $part <br>\n";
		# Does the chip exist ?
		if($data{'page'} eq "chip" && $manuf_query eq $manuf && $part_query eq $part){
			$page_found = 1;
			return;
		}

		# Does the Manufacturer exist?
		if($data{'page'} eq "manufacturer" && $family_query eq "" && $manuf_query eq $manuf){
			$page_found = 1;
			return;
		}

		# If the Manufacturer is others its ok
		if($data{'page'} eq "manufacturer" && $manuf_query eq 'Others'){
			$page_found = 1;
			return;
		}

		# Does the Manufacturer's Family exist?
		if($data{'page'} eq "manufacturer" && $family_query eq $family && $manuf_query eq $manuf){
			$page_found = 1;
			return;
		}

		# Does manuf exist when family = show all
		if($data{'page'} eq "manufacturer" && $family_query eq 'All'){
			$page_found = 1;
			return;
		}

		# Does the Family exist?
		if($data{'page'} eq "family" && $family_query eq $family){
			$page_found = 1;
			return;
		}	
		$x++;
	}
	
	# Board Pages
	$row = $skipLines;
	if( $data{'page'} eq 'board' ){
		if( $data{'type'} eq 'eval' || $data{'type'} eq 'module' ){
			$page_found = 1;
			return;
		}elsif( $data{'type'} eq "" && $data{'name'} eq '' && $data{'manuf'} eq ''){
			$page_found = 1;
			return;
		}elsif($data{'type'} ne ""){
				$page_DNE_global = 'TRUE';
				$page_DNE_title_global = "404: Board Type Not Found";
				$page_DNE_header2_global = "Board type is invalid";
				return;
		}else{	
			while (&board_data($row,$col_board_board_type) ne '') {
				$manuf = &board_data($row,$col_board_manuf)  =~ s/\W/_/gr;#change urlencode 
				$part = &board_data($row,$col_board_name) =~ s/\W/_/gr; #change to urlencode in future
				$part_query = $data{'name'} =~ s/\W/_/gr; #change to urlencode in fut
				$manuf_query = $data{'manuf'} =~ s/\W/_/gr; #change to urlencode in fut

				# print "<div>$manuf || $part || $part_query || $manuf_query</div>\n";
				# board type exists
				if($manuf eq $manuf_query && $part eq $part_query ){
					$page_found = 1;
					if($DEBUG){print "Board found<br />\n";}
				}	
				$row++;
			}
		}
	}


	if($page_found == 0){
		# print "404 error: page not found";
		$page_DNE_global = 'TRUE';
		if($data{'page'} eq "chip"){
			# part not found
			$page_DNE_title_global = "404 error: Chip Not Found";
			$page_DNE_header2_global = "Chip '$data{'manufacturer'} $data{'part'}' not found";
		} elsif($data{'page'} eq "manufacturer" && $data{'family'} eq ""){
			# Does the Manufacturer exist? no
			$page_DNE_title_global = "404 error: Chip Manufacturer Not Found";
			$page_DNE_header2_global = "Manufacturer '$data{'manufacturer'}' not found";
		} elsif($data{'page'} eq "manufacturer" && $data{'family'} ne ""){ 
			# Does the Manufacturer's Family exist? no
			$page_DNE_title_global = "404 error: Chip manufacturer's Family Not Found";
			$page_DNE_header2_global = "Family '$data{'family'}' of Manufacturer '$data{'manufacturer'}' not found";
		} elsif($data{'page'} eq "family"){ 
			# Does the Family exist no
			$page_DNE_title_global = "404 error: Family Not Found";
			$page_DNE_header2_global = "Family '$data{'family'}' not found";
		}elsif( $data{'page'} eq 'board' ){
			# Board not found
			$page_DNE_title_global = "404 error: Board Not Found";
			$page_DNE_header2_global = "Board '$data{'manuf'} $data{'name'}' not found";
		}

	}
}

###################################################
####### Coding (End) ##############################
###################################################


















############################################################
###################### HTML ################################
############################################################








######################################
############## Tables ################
######################################




sub displayTableData2 { # displays table from multichip list
	my $row = $_[0], $flipColor=$_[1], $thumb;
	#&chipData2($row,...)
	my $sort_element = '';
	my $manufTableSub	=  &chipData2($row,$colManuf);
	my $type	= &chipData2($row,$colType);
	my $part	= &chipData2($row,$colPart);
	my $photo	= "<div style=\"width: 100%; display: inline-block; vertical-align: middle;\"><div style=\"border-width: 1px; border-style: solid; width: 150px; height: 150px;  padding: 10px; text-align: center; display: -webkit-box;
display: -webkit-flex;
display: -moz-box;
display: -ms-flexbox;
display: flex;
-webkit-flex-align: center;
-ms-flex-align: center;
-webkit-align-items: center;
align-items: center;\"><div style=\"text-align:center;    margin: auto;\">PHOTO<br />To be added</div></div></div>\n";
	my $family	= '';
	my $speed	= '?';
	my $arch	= '?';
	my $data	= '?';
	my $address = '?';
	my $package = '?';
	my $trans	= '?';
	my $tech	= '?';
	my $proc	= '?';
	my $die		= '?';
	my $volt	= '?';
	my $date	= '?';
	my $L1		= '?';
	my $L2		= '?';
	my $L3		= '?';
	my $max_ram	= '?';
	my $socket	= '?';
	my $ram_int	= '?';
	my $rom_int = '?';
	my $fpu		= '?';
	my $core	= '?';
	my $datasheet = '?';
	my $features = '?';
	my $num_cores = '?';
	my $core_designer = '?';
	my $text = '';

	my $chip_link_part_var = $part;
	$chip_link_part_var =~ s/\W/_/g; #change to urlencode
	my $chip_link = "<a href=\"$script_url/ic/" . url_encode($manufTableSub) . "/" . url_encode($chip_link_part_var) . "\">";
	my $img_alt_text = $manufTableSub . " " . $part;	


	if (&chipData2($row,$colPhoto1) ne ""){
		$photoFile = &chipData2($row,$colPhoto1);
		$thumb = $photoFile . '_sm.jpg';
		$photo = "$chip_link<img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$img_alt_text\"></a>\n";
		if (&chipData2($row,$colPhoto2) ne ""){
			$photoFile = &chipData2($row,$colPhoto2);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t$chip_link<img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$img_alt_text\"></a>\n";
		} if (&chipData2($row,$colPhoto3) ne ""){
			$photoFile = &chipData2($row,$colPhoto3);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t$chip_link<img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$img_alt_text\"></a>\n";
		} if (&chipData2($row,$colPhoto4) ne ""){
			$photoFile = &chipData2($row,$colPhoto4);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t$chip_link<img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$img_alt_text\"></a>\n";
		} if (&chipData2($row,$colPhoto5) ne ""){
			$photoFile = &chipData2($row,$colPhoto5);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t$chip_link<img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$img_alt_text\"></a>\n";
		}
	}
	if ( &chipData2($row,$colFamily) ne "" && &chipData2($row,$colFamily) ne "Other") {
		$family = &chipData2($row,$colFamily);
	}
	if ( &chipData2($row,$colSpeed) ne '' ) {
		$speed = &chipData2($row,$colSpeed);
	}
	if ( &chipData2($row,$colArch) ne '' ) {
		# if ( &chipData2($row,$colArch) eq '16/32' ) {
			# $arch = "<a href=\"https://en.wikipedia.org/wiki/16-bit\">16/32-bit</a>";
		# } else {
			# $arch = "<a href=\"https://en.wikipedia.org/wiki/&chipData2($row,$colArch)" . "-bit\">" . &chipData2($row,$colArch) . "-bit</a>";
		# }
		 $arch = &chipData2($row,$colArch) . "-bit" ;
	}
	if ( &chipData2($row,$colDate) ne '' ) {
		$date = &chipData2($row,$colDate);
	}
	if ( &chipData2($row,$colCore) ne '' ) {
		$core = &chipData2($row,$colCore);
	}


	$text .= "\t<!-- chip table -->\n";
	$text .= "\t<tr style=\"background-color: #454545\">\n";

	# if ( $flipColor == 0 ) {
		# $text .= "\t<tr style=\"background-color: #454545\">\n";
	# }else{
		# $text .= "\t<tr style=\"background-color: #545454\">\n";
	# }
	$text .= "\t\t<td style=\"width: 256px\">\n\t\t\t$photo\n\t\t</td>\n";

	$text .= "\t\t<td style=\"width: 500px; vertical-align: top;\">\n";
	
	$text .= "\t\t\t<div class=\"tableDisplayPartNum\">$chip_link$manufTableSub $part</a></div><br /><br />\n";

	# $text .= "\t\t\t<div class=\"tableDisplayManufType\">";
	# if ($type ne '') {
		# $text .= "$type";
	# }
	# if ($family ne '') {
		# $text .= " of the $family Family";
	# }
	# $text .= "</div>\n";

	$text .= <<Endhtml;
		<table style="width: 400px">
			<tr>
				<td colspan="4">
					<span class="tableChipSubHeading">General Specifications:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Type:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$type</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Family:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$family</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Speed:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$speed</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Architecture:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$arch</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Introduced:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$date</span>
				</td>
				<td></td>
				<td></td>
			</tr><tr>
				<td colspan="4">
					<br />
					<div style="text-align: center;" class="tableChipFullDetails">$chip_link Full details...</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
Endhtml
	$text .= "\t<!-- chip table (end) -->\n";
	
	# if ( $data{'page'} eq 'manufacturer' ) {
		# getting frequesncy to sort
		my $freq = $speed;
		if ( $freq =~ /kHz/ ) {
			$freq =~ s/kHz//;
			$freq *= 1000;
		} elsif ( $freq =~ /MHz/ ) {
			$freq =~ s/MHz//;
			$freq *= 1000000;
		} elsif ( $freq =~ /GHz/ ) {
			$freq =~ s/GHz//;
			$freq *= 1000000000;
		} 
		# print "<tr><td>Vampires .....  $speed = $freq</td></tr>";
		$sort_element = $freq;
	# } elsif ( $data{'page'} eq 'family' ) {
		# $sort_element = $manufTableSub;
	# }

	return ($text, $sort_element, $type);
}














###########################################
############ Table ##################
###########################################





sub display_board_table_element { 
	# displays table for single board or multi-board list
	# 
	# usage &display_board_table_element($row,$board_type,$flip_color);
	#
	my $row 	= $_[0];		#[$skipLines - EOF]
	my $quality	=$_[1];	#(0=compact) single or multi board
	my $flipColor	=$_[1];	#(0|1)
	my $text = '';

	my $Board_type	='?';
	my $Board_type_nolink	='?';
	my $Type		='?';
	my $Type_no_link = '?';
	my $Manuf		='?';
	my $Name		='?';
	my $Chip_manuf	='?';
	my $Chip_part	='?';
	my $Chip_type	='?';
	my $Speed		='?';
	my $Arch_width	='?';
	my $Ports		='?';
	my $Socket		='?';
	my $Computers	='?';
	my $Features	='?';
	my $Description='?';
	my $Photo_front	="PHOTO<br />To be added\n";
	my $Photo_back	="";
	my $Manuf_p1='?';
	my $Part_p1	='?';
	my $Func_p1	='?';
	my $Manuf_p2='?';
	my $Part_p2	='?';
	my $Func_p2	='?';
	my $Manuf_p3='?';
	my $Part_p3	='?';
	my $Func_p3	='?';
	my $Manuf_p4='?';
	my $Part_p4	='?';
	my $Func_p4	='?';
	my $Manuf_p5='?';
	my $Part_p5	='?';
	my $Func_p5	='?';
	my $Manuf_p6='?';
	my $Part_p6	='?';
	my $Func_p6	='?';
	my $Manuf_p7='?';
	my $Part_p7	='?';
	my $Func_p7	='?';
	my $Manuf_p8='?';
	my $Part_p8	='?';
	my $Func_p8	='?';
	my $Manuf_p9='?';
	my $Part_p9	='?';
	my $Func_p9	='?';
	my $Datasheet = '?';
	my $title = '';
	my $periph = '';
	my $img_alt_text = "More details";
	my $chip_link = '';		
	my $chip_link_back = '';


	if ( &board_data($row,$col_board_board_type) ne '' ) {
		if ( &board_data($row,$col_board_board_type) eq 'module' ) {
			$Board_type_no_link = 'CPU module';
			$Board_type = 'CPU module';
		} elsif ( &board_data($row,$col_board_board_type) eq 'dev' ) {
			$Board_type_no_link = 'Evaluation board';
			$Board_type = 'Evaluation board';
		} else {
			$Board_type_no_link = &board_data($row,$col_board_board_type);
			$Board_type = &board_data($row,$col_board_board_type);
		}
		$board_type_var = &board_data($row,$col_board_board_type);
	}
	if ( &board_data($row,$col_board_type) ne '' ) {
		$Type = &board_data($row,$col_board_type);
		$Type_no_link = &board_data($row,$col_board_type);
	}
	if ( &board_data($row,$col_board_manuf) ne '' ) {
		$Manuf = &board_data($row,$col_board_manuf);
	}
	if ( &board_data($row,$col_board_name) ne '' ) {
		$Name = &board_data($row,$col_board_name);
	}
	if ( &board_data($row,$col_board_chip_manuf) ne '' ) {
		$Chip_manuf = &board_data($row,$col_board_chip_manuf);
	}
	if ( &board_data($row,$col_board_chip_type) ne '' ) {
		$Chip_type = &board_data($row,$col_board_chip_type);
	}
	if ( &board_data($row,$col_board_chip_part) ne '' ) {
		$Chip_part = &board_data($row,$col_board_chip_part);
		if ( $quality == 1 ) {
			$Chip_detail_link = "<a href=\"$script_url/ic/" . url_encode($Chip_manuf) . "/" . url_encode($Chip_part) . "\">$Chip_type Details...</a>";
			$Chip_part = "<a href=\"$script_url/ic/" . url_encode($Chip_manuf) . "/" . url_encode($Chip_part) . "\">$Chip_part</a>";
		}
	}
	if ( &board_data($row,$col_board_speed) ne '' ) {
		$Speed = &board_data($row,$col_board_speed);
	}
	if ( &board_data($row,$col_board_arch_width) ne '' ) {
		$Arch_width = &board_data($row,$col_board_arch_width);
	}
	if ( &board_data($row,$col_board_socket) ne '' ) {
		$Socket = &board_data($row,$col_board_socket);
	}
	if ( &board_data($row,$col_board_ports) ne '' ) {
		$Ports = &board_data($row,$col_board_ports);
	}
	if ( &board_data($row,$col_board_computers) ne '' ) {
		$Computers = &board_data($row,$col_board_computers);
	}
	if ( &board_data($row,$col_board_features) ne '' ) {
		$Features = &board_data($row,$col_board_features);
	}
	if ( &board_data($row,$col_board_description) ne '' ) {
		$Description = &board_data($row,$col_board_description);
	}
	if ( &board_data($row,$col_board_manuf_p1) ne '' ) {
		$Manuf_p1 = &board_data($row,$col_board_manuf_p1);
	}
	if ( &board_data($row,$col_board_part_p1) ne '' ) {
		$Part_p1 = &board_data($row,$col_board_part_p1);
	}
	if ( &board_data($row,$col_board_func_p1) ne '' ) {
		$Func_p1 = &board_data($row,$col_board_func_p1);
	}
	if ( &board_data($row,$col_board_manuf_p2) ne '' ) {
		$Manuf_p2 = &board_data($row,$col_board_manuf_p2);
	}
	if ( &board_data($row,$col_board_part_p2) ne '' ) {
		$Part_p2 = &board_data($row,$col_board_part_p2);
	}
	if ( &board_data($row,$col_board_func_p2) ne '' ) {
		$Func_p2 = &board_data($row,$col_board_func_p2);
	}
	if ( &board_data($row,$col_board_manuf_p3) ne '' ) {
		$Manuf_p3 = &board_data($row,$col_board_manuf_p3);
	}
	if ( &board_data($row,$col_board_part_p3) ne '' ) {
		$Part_p3 = &board_data($row,$col_board_part_p3);
	}
	if ( &board_data($row,$col_board_func_p3) ne '' ) {
		$Func_p3 = &board_data($row,$col_board_func_p3);
	}
	if ( &board_data($row,$col_board_manuf_p4) ne '' ) {
		$Manuf_p4 = &board_data($row,$col_board_manuf_p4);
	}
	if ( &board_data($row,$col_board_part_p4) ne '' ) {
		$Part_p4 = &board_data($row,$col_board_part_p4);
	}
	if ( &board_data($row,$col_board_func_p4) ne '' ) {
		$Func_p4 = &board_data($row,$col_board_func_p4);
	}
	if ( &board_data($row,$col_board_manuf_p5) ne '' ) {
		$Manuf_p5 = &board_data($row,$col_board_manuf_p5);
	}
	if ( &board_data($row,$col_board_part_p5) ne '' ) {
		$Part_p5 = &board_data($row,$col_board_part_p5);
	}
	if ( &board_data($row,$col_board_func_p5) ne '' ) {
		$Func_p5 = &board_data($row,$col_board_func_p5);
	}
	if ( &board_data($row,$col_board_manuf_p6) ne '' ) {
		$Manuf_p6 = &board_data($row,$col_board_manuf_p6);
	}
	if ( &board_data($row,$col_board_part_p6) ne '' ) {
		$Part_p6 = &board_data($row,$col_board_part_p6);
	}
	if ( &board_data($row,$col_board_func_p6) ne '' ) {
		$Func_p6 = &board_data($row,$col_board_func_p6);
	}
	if ( &board_data($row,$col_board_manuf_p7) ne '' ) {
		$Manuf_p7 = &board_data($row,$col_board_manuf_p7);
	}
	if ( &board_data($row,$col_board_part_p7) ne '' ) {
		$Part_p7 = &board_data($row,$col_board_part_p7);
	}
	if ( &board_data($row,$col_board_func_p7) ne '' ) {
		$Func_p7 = &board_data($row,$col_board_func_p7);
	}
	if ( &board_data($row,$col_board_manuf_p8) ne '' ) {
		$Manuf_p8 = &board_data($row,$col_board_manuf_p8);
	}
	if ( &board_data($row,$col_board_part_p8) ne '' ) {
		$Part_p8 = &board_data($row,$col_board_part_p8);
	}
	if ( &board_data($row,$col_board_func_p8) ne '' ) {
		$Func_p8 = &board_data($row,$col_board_func_p8);
	}
	if ( &board_data($row,$col_board_manuf_p9) ne '' ) {
		$Manuf_p9 = &board_data($row,$col_board_manuf_p9);
	}
	if ( &board_data($row,$col_board_part_p9) ne '' ) {
		$Part_p9 = &board_data($row,$col_board_part_p9);
	}
	if ( &board_data($row,$col_board_func_p9) ne '' ) {
		$Func_p9 = &board_data($row,$col_board_func_p9);
	}
	if ( &board_data($row,$col_board_datasheet) ne '' ) {
		$Datasheet = &board_data($row,$col_board_datasheet);
	}
	if ( $quality == 0 ) {
		$title = 'Board details';
		my $Manuf_s = $Manuf;
		my $Name_s	= $Name;
		$Manuf_s 	=~ s/[ \W]/_/g;
		$Name_s		=~ s/[ \W]/_/g;
		$chip_link = "$script_url/board/$Manuf_s/$Name_s";
		if ( length($Manuf . $Name) > 25 ) {
			$sub_title = $Manuf . '<br />' . $Name;
		} else {
			$sub_title = $Manuf . ' - ' . $Name;
		}
	} else {
		$title = 'Full quality image';
		$chip_link = "$relativeLoc/$board_loc/" . &board_data($row,$col_board_photo_front);
		$chip_link_back = "$relativeLoc/$board_loc/" . &board_data($row,$col_board_photo_back);
		if ( length($Manuf . $Name) > 25 ) {
			$sub_title = $Manuf . '<br />' . $Name;
		} else {
			$sub_title = $Manuf . ' - ' . $Name;
		}
	}
	if (&board_data($row,$col_board_photo_front) ne '') {
		$Photo_front = &board_data($row,$col_board_photo_front) . '_sm.jpg';
		my $res = 250;
		if (&board_data($row,$col_board_photo_back) eq '' && $quality == 1) {
			$res = 350;
			$Photo_front = &board_data($row,$col_board_photo_front) . '_med.jpg';
		} else {
			$res = 250;
			$Photo_front = &board_data($row,$col_board_photo_front) . '_sm.jpg';
		}
		$Photo_front = "<a href=\"$chip_link\" title=\"$title\"><img src=\"$relativeLoc/$board_thumb_loc/$Photo_front\" width=\"$res\" alt=\"$img_alt_text\"></a>\n";		
	}
	if ( &board_data($row,$col_board_photo_back) ne '' ) {
		$Photo_back = &board_data($row,$col_board_photo_back) . '_sm.jpg';
		$Photo_back = "<a href=\"$chip_link_back\" title=\"Full quatity image\"><img src=\"$relativeLoc/$board_thumb_loc/$Photo_back\" width=\"250\" alt=\"$img_alt_text\"></a>\n";		
	}

	if ( $quality == 1 ) {
		if ( &board_data($row,$col_board_board_type) ne '' ) {
			if ( &board_data($row,$col_board_board_type) eq 'module' ) {
				$Board_type = "<a href=\"$script_url/module_boards/\">CPU module</a>";
			} elsif ( &board_data($row,$col_board_board_type) eq 'dev' ) {
				$Board_type = "<a href=\"$script_url/evaluation_boards/\">Evaluation board</a>";
			} else {
				$Board_type = &board_data($row,$col_board_board_type);
			}
		}
		if ( &board_data($row,$col_board_type) ne '' ) {
			$Type = "<a href=\"$script_url/family/" . url_encode(&board_data($row,$col_board_type)) . "\">" . &board_data($row,$col_board_type) . "</a>";
		}
		if ( &board_data($row,$col_board_manuf) ne '' ) {
			$Manuf = &board_data($row,$col_board_manuf);
		}
		if ( &board_data($row,$col_board_name) ne '' ) {
			$Name = &board_data($row,$col_board_name);
		}
		if ( &board_data($row,$col_board_chip_manuf) ne '' ) {
			$Chip_manuf = "<a href=\"$script_url/m/" . url_encode(&board_data($row,$col_board_chip_manuf)) . "\">" . &board_data($row,$col_board_chip_manuf) . "</a>";
		}
		if ( &board_data($row,$col_board_chip_type) ne '' ) {
			$Chip_type = &board_data($row,$col_board_chip_type);
		}
		if ( &board_data($row,$col_board_chip_part) ne '' ) {
			my $part = &board_data($row,$col_board_chip_part);
			my $chip_man =  &board_data($row,$col_board_chip_manuf);
			my $chip_type = &board_data($row,$col_board_chip_type);
			my $part_link = &board_data($row,$col_board_chip_part);
			$part_link =~  s/[ \W]/_/g; #tr/\W/_/; 
			$chip_man =~ s/[ \W]/_/g;
			$Chip_detail_link = "<a href=\"$script_url/ic/" . url_encode($chip_man) . "/" . url_encode($part_link) . "\">$chip_type Details...</a>";
			$Chip_part = "<a href=\"$script_url/ic/" . url_encode($chip_man) . "/" . url_encode($part_link) . "\">$part</a>";
		}
	}


	# if ( $flipColor == 0 ) {
		# $text .= "\t<tr style=\"background-color: #454545\">\n";
	# }else{
		# $text .= "\t<tr style=\"background-color: #545454\">\n";
	# }
	if ( $quality == 0 ) {
		#
		# multi-board table (ie module and eval board pages)
		#
		$text .= <<Endhtml;
		<table><!-- multi-board table element -->
			<tr style="background-color: #454545">
				<td style="width: 256px">$Photo_front</td>
				<td style="vertical-align: top; width: 600px;">
					<div class="tableDisplayPartNum"><a href="$chip_link">$sub_title</a></div>
					<div class="heading2">$Type</div><br />

					<table>
						<tr>
							<td colspan="2">
								<span class="tableChipSubHeading">General Information:</span>
							</td>
						</tr><tr>
							<td style="white-space: nowrap; padding-left: 10px; width: 80px;">
								<span class="tableChipParam">Main $Chip_type:</span>
							</td><td style="white-space: nowrap; width: 200px">
								<span class="tableChipValue">$Chip_manuf - $Chip_part</span>
							</td>
						</tr><tr>
							<td style="white-space: nowrap; padding-left: 10px; width: 80px;">
								<span class="tableChipParam">Speed:</span>
							</td><td style="white-space: nowrap;">					
								<span class="tableChipValue">$Speed</span>
							</td>
						</tr><tr>
							<td colspan="2">
								<br />
								<div style="text-align: center;" class="tableChipFullDetails"><a href="$chip_link">Full details...</a></div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table><!-- multi-board table element (end) -->
Endhtml
	
	} elsif ( $quality == 1 ) {
		#
		# single board page
		#

		#Setting title and keywords for single board page
		$title_ext_global = "$Manuf - $Name - $Type_no_link $Board_type_no_link"; 
		$keyword_ext_global = "$Board_type_no_link, $Manuf, $Name, $Type_no_link, $Chip_type";

		$text .= <<Endhtml;	
		<table><!-- single board table element -->
			<tr>
				<td style="width: 100%">
					<h1>$sub_title</h1>
				</td>
			</tr><tr style="background-color: #454545">
				<td style="text-align: center;">
					<table><tr>
						<td style="padding: 10px;">$Photo_front</td>
						<td style="padding: 10px;">$Photo_back</td>
					</tr></table>
				</td>
			</tr><tr style="background-color: #454545;">
				<td>
					<table style="width:100%;">
						<tr>
							<td style="width: 50%; vertical-align: top;">
								<table>
									<tr>
										<td colspan="2">
											<span class="tableChipSubHeading">Board Information:</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
											<span class="tableChipParam">Board type:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Board_type</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; width:100px; padding-left: 10px;">
											<span class="tableChipParam">Family:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Type</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; width:100px; padding-left: 10px;">
											<span class="tableChipParam">Board manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Board ID:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Name</span>
										</td>
									</tr><tr>
Endhtml
		if ( $board_type_var eq 'module' ) {
			$text .= <<Endhtml;
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Socket:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Socket</span>
										</td>
									</tr><tr>
Endhtml
		} else {
			$text .= <<Endhtml;
										<td style="white-space: nowrap; padding-left: 10px; vertical-align: top;">
											<span class="tableChipParam">Ports:</span>
										</td><td style="padding-left: 10px;">
											<span class="tableChipValue">$Ports</span>
										</td>
									</tr><tr>
Endhtml
		}
			$text .= <<Endhtml;
										<td style="height: 5px;"></td><td></td>
									</tr><tr>			
										<td colspan="2">
											<span class="tableChipSubHeading">$Chip_type Information:</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Chip_manuf</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Chip_part</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Speed:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Speed</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Architecture:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Arch_width</span>
										</td>
									</tr><tr>	
										<td style="white-space: nowrap; padding-left: 10px; height: 5px;">
										</td><td style="white-space: nowrap; padding-left: 10px;">
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 70px;" colspan="2">
											<span class="tableChipParam" style="text-align: center;">$Chip_detail_link</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; height: 5px;">
										</td><td style="white-space: nowrap; padding-left: 10px;">
										</td>
									</tr>
								</table>
							</td><td style="vertical-align: top">
								<table>
									<tr>
										<td colspan="2">
											<span class="tableChipSubHeading">Periferal Chips:</span>
										</td>
									</tr><tr>
Endhtml
			if ( $Part_p1 eq '?' ) {
				$text .= <<Endhtml;
						<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
							<span class="tableChipParam">None</span>
						</td><td style="white-space: nowrap; padding-left: 10px;">
							<span class="tableChipValue"></span>
						</td>
Endhtml
			} else {
				$text .= <<Endhtml;
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p1</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p1</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p1</span>
										</td>
Endhtml
			} 
			if ( $Part_p2 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p2</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p2</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p2</span>
										</td>
Endhtml
			} 
			if ( $Part_p3 ne '?' ) {
				$text .= <<Endhtml;
						</tr><tr>
							<td style="height: 5px;"></td><td></td>
						</tr><tr>
							<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
								<span class="tableChipParam">Manuf:</span>
							</td><td style="white-space: nowrap; padding-left: 10px;">
								<span class="tableChipValue">$Manuf_p3</span>
							</td>
						</tr><tr>
							<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
								<span class="tableChipParam">Part:</span>
							</td><td style="white-space: nowrap; padding-left: 10px;">
								<span class="tableChipValue">$Part_p3</span>
							</td>
						</tr><tr>
							<td style="white-space: nowrap; padding-left: 10px;">
								<span class="tableChipParam">Function:</span>
							</td><td style="white-space: nowrap; padding-left: 10px;">
								<span class="tableChipValue">$Func_p3</span>
							</td>
Endhtml
			} 
			if ( $Part_p4 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p4</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p4</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p4</span>
										</td>
Endhtml
			} 	
			if ( $Part_p5 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p5</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p5</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p5</span>
										</td>
Endhtml
			} 
			if ( $Part_p6 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p6</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p6</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p6</span>
										</td>
Endhtml
			} 
			if ( $Part_p7 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p7</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p7</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p7</span>
										</td>
Endhtml
			} 
			if ( $Part_p8 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p8</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p8</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p8</span>
										</td>
Endhtml
			} 
			if ( $Part_p9 ne '?' ) {
				$text .= <<Endhtml;
									</tr><tr>
										<td style="height: 5px;"></td><td></td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;" width: 100px;>
											<span class="tableChipParam">Manuf:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Manuf_p9</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;" width: 100px;>
											<span class="tableChipParam">Part:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Part_p9</span>
										</td>
									</tr><tr>
										<td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipParam">Function:</span>
										</td><td style="white-space: nowrap; padding-left: 10px;">
											<span class="tableChipValue">$Func_p9</span>
										</td>
Endhtml
			} 

			$text .= <<Endhtml;
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table><!-- single-board table element (end) -->
Endhtml
		} #end of quality if statement

	return $text;
	# return "<!-- ==================== blank ======================= -->\n";
}












####################################################
############# Table (end) ##########################
####################################################











##########################################################
############### List methods #############################
##########################################################










######################################################################
######################################################################
######################################################################
##################       Category pages (begin)     ##################
######################################################################
######################################################################
######################################################################




######################################################################
######################################################################
######################################################################
##################       Category pages (end)     ####################
######################################################################
######################################################################
######################################################################


#########################################################
################# List methods (end) ####################
#########################################################











#########################################################
################# Page Organization #####################
#########################################################

############# Page organization (end) #######################

############## head #############################

########## head (end) #####################

######## body ##########

###### body (end) #######



######### tail ############################




















##########################################################################
##########################################################################
##########################################################################
##############               New Crap      ###############################
##########################################################################
##########################################################################
##########################################################################






###########################################################
###########################################################
#################    Category Pages (begin)  ##############
###########################################################
###########################################################

# sub create_html_body_main_category_family {
	# my $text = '';

	# my @col1 = ();
	# my @col2 = ();
	# my $x = 0;
	# my $y = 0;
	# my $max = $#familyListGlobal/2 + 1;
	# # print $max;
	# foreach $fam (@familyListGlobal) {

		# # print "\t\t<li><a href=\"$script_url/family/$fam\">$fam</a>\n";
		# if ( $x < $max ) {
			# $col1[$x] = "\t\t<li><a href=\"$script_url/family/" . url_encode($fam) . "\">$fam</a>\n";
		# } else {
			# $col2[$y] = "\t\t<li><a href=\"$script_url/family/" . url_encode($fam) . "\">$fam</a>\n";
			# $y++;
		# }
		# # if ($NUM % 2 == 1) {
			# # print "</tr><tr>";
		# # }
		# $x++;
	# }

	# $text .= "\t\t<div class=\"heading1\">List of Families</div><br />\n";
	# $text .= "\t\t<table style=\"width:100%;\">\n\t\t<tr><td style=\"width:50%; vertical-align:top;\">\n\t\t<ul>";
	# foreach $col (@col1) {
		# $text .= $col;
	# }
	# $text .= "\t\t</ul></td><td style=\"width:50%; vertical-align:top;\"><ul>\n";
	# foreach $col (@col2) {
		# $text .= $col;
	# }
	# $text .= "\t\t</ul></td></tr></table>";
	# return $text;
# }


sub create_html_body_main_category_family {
	my $text = '';
	$text .= <<EndHTML;
		<table style="width:100%;" class="table_zebra_striped">
			<thead><tr><th>
				<h1>List of Families</h1>
			</th></tr></thead>
			<tbody>
EndHTML
	foreach $fam (@familyListGlobal) {
		if( $fam ne '' && $fam ne 'NA' ){
			$text .= "\t\t\t\t\t<tr><td><a href=\"$script_url/family/" . url_encode($fam) . "\">$fam</a></tr></td>\n";
		}
	}
	$text .= "\t\t\t\t</table>";
	return $text;
}


sub create_html_body_main_category_manuf {
	my $text = '';

	$text .= <<EndHTML;
		<table style="width:100%;" class="table_zebra_striped">
			<thead><tr><th>
				<h1>List of Manufacturers</h1>
			</th></tr></thead>
			<tbody>
EndHTML
	foreach $man (@manufListGlobal) {
		$text .= "\t\t\t\t\t<tr><td><a href=\"$script_url/m/" . url_encode($man) . "\">$man</a></tr></td>\n";
	}
	$text .= "\t\t\t\t</table>";
	return $text;
}

# sub create_html_body_main_category_manuf {
	# my $text = '';
	# my @col1 = ();
	# my @col2 = ();
	# my $x = 0;
	# my $y = 0;
	# my $max = $#manufListGlobal/2 + 1;
	# # print $max;
	# # foreach $man (@manufListGlobal) {

		# # if ( $x < $max ) {
			# # $col1[$x] = "\t\t<li><a href=\"$script_url/m/" . url_encode($man) . "\">$man</a>\n";
		# # } else {
			# # $col2[$y] = "\t\t<li><a href=\"$script_url/m/" . url_encode($man) . "\">$man</a>\n";
			# # $y++;
		# # }
		# # $x++;
	# # }

	# $text .= <<EndHTML;
		# <table style="width:100%;" class="table_zebra_striped">
			# <thead><tr><th>
				# <h1>List of Manufacturers</h1>
			# </th></tr></thead>
			# <tbody>
# EndHTML
	# foreach $man (@manufListGlobal) {
		# $text .= "\t\t\t\t\t<tr><td><a href=\"$script_url/m/" . url_encode($man) . "\">$man</a></tr></td>\n";
	# }
	# $text .= "\t\t\t\t</table>";

	# # foreach $col (@col1) {
		# # $text .= $col;
	# # }
	# # $text .= "\t\t\t\t\t</ul></td><td style=\"width:50%; vertical-align: top\"><ul>\n";
	# # foreach $col (@col2) {
		# # $text .= $col;
	# # }
	# # $text .= "\t\t</ul></td></tr></table>";
	# return $text;
# }


###########################################################
###########################################################
#################    Category Pages (end)  ################
###########################################################
###########################################################




###########################################################
###########################################################
##############    Page Extensions (begin)  ################
###########################################################
###########################################################

sub create_html_page_addition_support_chips {
	my $text = '';
	# my (@supportChips, @supportChipsMan) = @_;
	my @supportChips = @{ $_[0] };
	my @supportChipsMan = @{ $_[1] };
	# my $x=0;
	$text .= "\t<br /><br />\n";
	$text .= "\t<table style=\"border-width: 1px; border-style: solid;\"><!-- summary\"list of support chips for family\" -->\n";
	$text .= "\t\t<tr><td><b>Support chips</b></td></tr>\n";
	for (my $x=0;$x<=$#supportChips;$x++) {
	# foreach $chip (@supportChips) {
		# print "($supportChips[$x], $supportChipsMan[$x])";
		my $chip_link_part_var = $supportChips[$x];
		$chip_link_part_var =~ s/\W/_/g;
		my $manuf_local=$supportChipsMan[$x];
		# print "\t\t<tr><td><a href=\"$script_url/ic/" . url_encode($data{'manufacturer'}) . "&part=" . url_encode($chip_link_part_var) . "\">$chip</a></td></tr>\n";
		$text .= "\t\t<tr><td><a href=\"$script_url/ic/" . url_encode($manuf_local) . "/" . url_encode($chip_link_part_var) . "\">$supportChips[$x]</a></td></tr>\n";
		# $x++;
	}
	$text .= "\t</table>\n";

	return $text;
}

###########################################################
###########################################################
################    Page Extensions (end)  ################
###########################################################
###########################################################





###########################################################
###########################################################
###########    Main Content Pages (begin)  ################
###########################################################
###########################################################

sub create_html_body_main_cpu_boards {
	my $text='';
	my $row = $skipLines;

	if ($data{'type'} eq '' && $data{'manuf'} eq '' ) {
			
		$title_ext_global = 'Processor Modules and Evaluation Boards';
		$keyword_ext_global = 'processor module, CPU module, evaluation board, demonstation board, programmming board, design kit, educational board';

		$text = <<Endhtml;
	<div class="heading1">Processor and Microcontroller Boards</div>
	<br /><br />

	<table style="width: 100%;"><!-- main cpu board -->
		<tr>
			<td style="width: 50%; text-align:center;">
				<a href="$script_url/module_boards/" title="Processor Modules"><img src="$relativeLoc/$board_thumb_loc/processor_module-Sun--501-3041--(Sun--STP1030ABGA-200--UltraSPARC--CPU)-front.JPG_sm.jpg" alt="Sun STP1030ABGA-200 UltraSPARC"></a>
			</td><td style="text-align: center;">
				<a href="$script_url/evaluation_boards/" title="Evaluation Boards"><img src="$relativeLoc/$board_thumb_loc/dev_board--Intel--MCS-80_System_Design_Kit--(Intel--C8080A).JPG_sm.jpg" alt="Intel MCS-80 System Design Kit"></a>
			</td>
		</tr><tr>
			<td style="text-align: center;">
				<span class="heading2"><a href="$script_url/module_boards/">Processor Modules</a></span>
			</td><td style="text-align: center;">
				<span class="heading2"><a href="$script_url/evaluation_boards/">Evaluation Boards</a></span>
			</td>
		</tr>
	</table><!-- main cpu board (end) -->				
Endhtml
	} elsif ( $data{'type'} eq 'module' ) {

	
		$title_ext_global = 'Processor Modules';
		$keyword_ext_global = 'processor module, CPU module';

		$text .= <<Endhtml;
		<div class="heading1">Processor Modules</div>
		<div>A modular circuit board that contains a <a href="$script_url/chip_types/">CPU</a> chip as well as a few peripherals chips, such as an <a href="$script_url/chip_types/">FPU</a> or <a href="$script_url/chip_types/">cache controller</a>.  These often posess power regulation chips</div><br />


Endhtml
		$row = $skipLines;
		while ( &board_data($row,$col_board_board_type) ne '' ) {
			# print ', x: ' . &board_data($row,$col_board_board_type);
			if  ( &board_data($row,$col_board_board_type) eq 'module' ) {
				$text .= &display_board_table_element($row,0,0); # (row,detail,color) 
				# print 'y';
			}
			$row++;			
		}
	} elsif ( $data{'type'} eq 'eval' ) {

		$title_ext_global = 'Evaluation Boards';
		$keyword_ext_global = 'evaluation board, demonstation board, programmming board, design kit, educational board';

		$text .= <<Endhtml;
		<div class="heading1">Evaluation Boards</div>
		<div>Boards used by engineers to test, making it easyer to evaluate the functionality of a chip.  They often contain all the nesesary periferal chips to power it up and preform simple functions.  They are sometimes called development boards or demonstration board.  Some of the ones are educational boards, like the <a href="$script_url/board/Motorola/MC68000_Educational_Computer">Motorola MC68000 Educational Computer</a>, designed for teaching in Universities.</div><br />
Endhtml
		$row = $skipLines;
		while ( &board_data($row,$col_board_board_type) ne '' ) {
			if  ( &board_data($row,$col_board_board_type) eq 'dev' ) {
				$text .= &display_board_table_element($row,0,0); 
			}
			$row++;
		}
	} elsif ( $data{'manuf'} ne '' ) {
		# $text .= "$data{'manuf'} : $data{'name'}";
		my $Manuf_s = $Manuf;
		my $Name_s	= $Name;
		$Manuf_s 	=~ s/[ \W]/_/g;
		$Name_s		=~ s/[ \W]/_/g;
		$row = $skipLines;
		while ( &board_data($row,$col_board_board_type) ne '' ) {
			my $Manuf_s = &board_data($row,$col_board_manuf);
			my $Name_s	= &board_data($row,$col_board_name);
			$Manuf_s 	=~ s/[ \W]/_/g;
			$Name_s		=~ s/[ \W]/_/g;
			# print "$Manuf_s:$Name_s<br />\n";
			if  ($data{'manuf'} eq $Manuf_s && $data{'name'} eq $Name_s) {
				# $text .= "\t\t<table><!-- board element table -->\n";	
				$text .= &display_board_table_element($row,1,0); #detailed 
				# $text .= "\t\t</table><!-- board element table (end) -->\n";
			}
			$row++;
		}

		my $Board_type_s = '';
		if ( &board_data($row,$col_board_board_type) eq 'module' ) {
			$Board_type_s = 'CPU Module';
		} elsif ( &board_data($row,$col_board_board_type) eq 'dev' ) {
			$Board_type_s = 'Evaluation board';
		}
		# $title_ext_global = "xxxxxxxxxxxx$Manuf_s $Name_s $Board_type_s"; 
		# $keyword_ext_global = '$Manuf_s, $Name_s, $Board_type_s';
		
	}
	return $text;
}


sub create_html_body_main_category {
	my $text = '';
	


	if ($data{'type'} eq '') {
		$title_ext_global = 'Categories';
		$keyword_ext_global = 'category';
		$text .= <<Endhtml;
	<div>
		<span class="heading1" style="width:100%; text-align: center ;">Categories of Chips</span><br /><br />
		<span class="heading2">Chips organized by:</span>
		<ul>
			<li><span class="list_element"><a href="$script_url/families/">Families</a></span>
			<li><span class="list_element"><a href="$script_url/manufacturers/">Manufacturers</a></span>
			<li><span class="list_element"><a href="$script_url/architecture/">Architecture</a>: RISC, CISC, etc</span>
			<li><span class="list_element"><a href="$script_url/data_width/">Architecture's data width</a>: 8-bit, 16-bit, ...</span>
			<li><span class="list_element"><a href="$script_url/chip_types/">Chip type</a>: CPU, MCU, FPU, ...</span>
			<li><span class="list_element"><a href="$script_url/technologies/">Integrated circuit technology</a>: Bipolar, BiCMOS, NMOS, HMOS, CMOS, ...</span>
			<li><span class="list_element"><a href="$script_url/ISA/">Instruction Set Architechures</a>: x86, MIPS, SPARC, ARM, ...</span>
			<li><span class="list_element"><a href="$script_url/release_date/">Date</a>: a Processor and Microcontroller Timeline</span>
			<li><span class="list_element"><a href="$script_url/applications/">Application</a>: Desktop computers, Servers, DSL, TV, Calculator...</span>
		</ul>
	</div>
Endhtml
	} elsif ($data{'type'} eq 'arch') {
		$title_ext_global = 'CPU Architectures';
		$keyword_ext_global = 'architecture';
		$text .= &create_html_body_main_category_arch; #&architecture_page;
	} elsif  ($data{'type'} eq 'family') {
		$title_ext_global = 'CPU and MCU Families';
		$keyword_ext_global = 'family, families';
		$text .= &create_html_body_main_category_family; #&family_cat_page;
	} elsif  ($data{'type'} eq 'tech') {
		$title_ext_global = 'Processor Technology';
		$keyword_ext_global = 'technology, CMOS, PMOS, NMOS, Bipolar, HMOS, HCMOS, CHMOS';
		$text .= &create_html_body_main_category_tech; #&tech_page;
	} elsif  ($data{'type'} eq 'data_width') {
		$title_ext_global = 'Processor Data Widths';
		$keyword_ext_global = '8-bit, 16-bit, 32-bit, 24-bit, 64-bit, 4-bit,  2-bit';
		$text .= &create_html_body_main_category_data_width; #&data_width_page;
	} elsif  ($data{'type'} eq 'type') {
		$title_ext_global = 'Chip Types';
		$keyword_ext_global = 'CPU, MCU, FPU, SoC, Bit-slice, GPU, PPU, I/O processor, Cache controller';
		$text .= &create_html_body_main_category_chip_type; #&type_page;
	} elsif  ($data{'type'} eq 'isa') {
		$title_ext_global = 'Instruction Set Architectures';
		$keyword_ext_global = 'ISA, Instruction set, x86, MIPS, SPARC, ARM';
		$text .= &create_html_body_main_category_isa; #&isa_cat_page;
	} elsif  ($data{'type'} eq 'microarch') {
		$title_ext_global = 'Microarchitectures';
		$keyword_ext_global = 'P5, P6, Netburst';
		$text .= &create_html_body_main_category_microarch; #&microarch_cat_page;
	} elsif  ($data{'type'} eq 'date') {
		$title_ext_global = 'CPU and MCU Timeline';
		$keyword_ext_global = 'timeline';
		$text .= &create_html_body_main_category_date; #&date_cat_page;
	} elsif  ($data{'type'} eq 'manuf') {
		$title_ext_global = 'CPU and MCU Manufacturer List';
		$keyword_ext_global = 'manufacturer';
		$text .= &create_html_body_main_category_manuf; #&manuf_cat_page;
	} elsif  ($data{'type'} eq 'logo') {
		$title_ext_global = 'CPU and MCU Manufacturer Logos';
		$keyword_ext_global = 'manufacturer, logo';
		$text .= &create_html_body_main_category_logo; #&logo_page;
	} elsif  ($data{'type'} eq 'app') {
		$title_ext_global = 'CPU and MCU Applications';
		$keyword_ext_global = 'embedded system, desktop, server';
		$text .= &create_html_body_main_category_app; #&app_cat_page;
	}
	return $text;
}


sub create_html_body_main_site_map {
	my $text='';
	
	$title_ext_global = 'Site Map';
	$keyword_ext_global = 'site map';

	$text = <<Endhtml;

		<div class="center"><span class="heading1">Site Map</span></div>
		<br /><br />
		
		<table><!-- site map data -->
			<tr>
				<td style="vertical-align: top">
					<div class="heading2">Chips in collection</div>
					<ul>
						<li><span class="list_element"><a href="$script_url/manufacturers/">Chip manufactures</a></span>
						<li><span class="list_element"><a href="$script_url/families/">Chip families</a></span>
						<li><span class="list_element"><a href="$script_url/boards/">Processor Boards</a></span>
						<li><span class="list_element"><a href="$script_url/full_list/">All chips</a></span>
						<li><span class="list_element"><a href="$script_url/trade/">Trade list</a></span>
					</ul>
					<div class="heading2">Chips orgaized by:</div>
					<ul>
						<li><span class="list_element"><a href="$script_url/architecture/">Architecture</a></span>
						<li><span class="list_element"><a href="$script_url/chip_types/">Type</a></span>
						<li><span class="list_element"><a href="$script_url/ISA/">Instruction set architecture</a> (ISA)</span>
						<li><span class="list_element"><a href="$script_url/release_date/">Date</a></span>
						<li><span class="list_element"><a href="$script_url/technologies/">Technology</a></span>
						<li><span class="list_element"><a href="$script_url/data_width/">Data width</a></span>
						<li><span class="list_element"><a href="$script_url/applications/">Application</a></span>
						<li><span class="list_element"><a href="$script_url/families/">Family</a></span>
						<li><span class="list_element"><a href="$script_url/manufacturers/">Manufacture</a></span>
					</ul>
				</td><td style="vertical-align: top">
					<div class="heading2">Resources</div>
					<ul>
						<li><span class="list_element"><a href="$script_url/release_date/">Processor and Microcontroller Timeline</a></span>
						<li><span class="list_element"><a href="$script_url/glossary/">Glossary</a></span>
						<li><span class="list_element"><a href="https://happytrees.org.org/files/chipCollection-v1.03.ods">Collection data (raw)</a>: Open Office spreadsheet, under the <a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/us/">CC-BY-SA 3.0 license</a></span>
						<li><span class="list_element"><a href="$code_loc">Page source code</a>: under <a href="https://en.wikipedia.org/wiki/GPL_license">GPL-3.0 license</a></span>
						<li><span class="list_element"><a href="$relativeLoc/$photoLoc">Chip images</a>: under the <a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/us/">CC-BY-SA 3.0 license</a></span>
						<li><span class="list_element"><a href="$relativeLoc/$datasheet_loc">Datasheets</a></span>
						<li><span class="list_element"><a href="$script_url/logos/">Manufacture logos</a></span>
						<li><span class="list_element"><a href="$relativeLoc/$logoLoc"></a>Family logos: to be added</span>
					</ul>
					<div class="heading2">Other:</div>
					<ul>
						<li><span class="list_element"><a href="$contact_page">Contact page</a></span>
					</ul>
				</td>
			</tr>
		</table><!-- site map data (end) -->
Endhtml
	return $text;
}


sub create_html_body_main_single_chip_table { # display table for single chip
	my $text = '';
	my $row = $_[0], $thumb;
	#&chipData2($row,...)
	my $manufTableSub	=  &chipData2($row,$colManuf);
	my $manuf_name = &chipData2($row,$colManuf);
	my $type	= '?'; # &chipData2($row,$colType);
	my $type_name = '';
	my $part	= &chipData2($row,$colPart);
	my $photo	= "<div style=\"border-width: 1px; border-style: solid; width: 150px; height: 150px; display: table-cell; vertical-align: middle; margin: 0 auto; padding: 10px;\">PHOTO<br />To be added</div>\n";
	my $family	= '';
	my $speed	= '?';
	my $arch	= '?';
	my $data	= '?';
	my $address = '?';
	my $package = '?';
	my $trans	= '?';
	my $tech	= '?';
	my $proc	= '?';
	my $die		= '?';
	my $volt	= '?';
	my $volt_io	= '?';
	my $date	= '?';
	my $L1		= '?';
	my $L2		= '?';
	my $L3		= '?';
	my $ram_max	= '?';
	my $ram_type= '?';
	my $socket	= '?';
	my $ram_int	= '?';
	my $rom_int = '?';
	my $rom_type= '?';
	my $fpu		= '?';
	my $core	= '?';
	my $datasheet = '?';
	my $features = '?';
	my $num_cores = '?';
	my $core_designer = '?';
	my $text = '';
	my $alt_id = '';
	my $label_id = '';
	my $instruction_set = '?';
	my $instruction_link = '';
	my $isa = '?';
	my $computer_arch = '?';
	my $microarch = '?';
	my $power	= '?';
	my $applications = '?';
	my $bus_speed	= '?';
	my $id_html		= '';
	my $family_short = '?';
	
	$manufTableSub = "<a href=\"$script_url/m/" . url_encode($manufTableSub) . "\">$manufTableSub</a>";

	if (&chipData2($row,$colPhoto1) ne ""){ # making photos
		$photoFile = &chipData2($row,$colPhoto1);
		$thumb = $photoFile . '_sm.jpg';
		$photo = "<a href=\"$relativeLoc/$photoLoc/$photoFile\"><img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"$thumb\"></a>\n";
		if (&chipData2($row,$colPhoto2) ne ""){
			$photoFile = &chipData2($row,$colPhoto2);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t<a href=\"$relativeLoc/$photoLoc/$photoFile\"><img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"Click for larger image\"></a>\n";
		} if (&chipData2($row,$colPhoto3) ne ""){
			$photoFile = &chipData2($row,$colPhoto3);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t<a href=\"$relativeLoc/$photoLoc/$photoFile\"><img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"Click for larger image\"></a>\n";
		} if (&chipData2($row,$colPhoto4) ne ""){
			$photoFile = &chipData2($row,$colPhoto4);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t<a href=\"$relativeLoc/$photoLoc/$photoFile\"><img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\" alt=\"Click for larger image\"></a>\n";
		} if (&chipData2($row,$colPhoto5) ne ""){
			$photoFile = &chipData2($row,$colPhoto5);
			$thumb = $photoFile . '_sm.jpg';
			$photo = $photo . "\t\t\t<br />\n\t\t\t<a href=\"$relativeLoc/$photoLoc/$photoFile\" alt=\"Click for larger image\"><img src=\"$relativeLoc/$thumbLoc/$thumb\" width=\"250\"></a>\n";
		}
	}
	if ( &chipData2($row,$colFamily) ne "" && &chipData2($row,$colFamily) ne "Other") {
		my $famL = &chipData2($row,$colFamily);
		$family_short = "<a href=\"$script_url/family/" . url_encode($famL) . "\">$famL</a>";
		# $family = "<div class=\"tableDisplayFamily\">" . &chipData2($row,$colFamily) ." Family</div>";
	}
	if ( &chipData2($row,$colType) ne '' ) {
		$type = "<a href=\"$script_url/chip_types/\">" .  &chipData2($row,$colType) . "</a>";
		$type_name = &chipData2($row,$colType);
	}
	if ( &chipData2($row,$colSpeed) ne '' ) {
		$speed = &chipData2($row,$colSpeed);
	}
	if ( &chipData2($row,$colArch) ne '' ) {
		# if ( &chipData2($row,$colArch) eq '16/32' ) {
			# $arch = "<a href=\"https://en.wikipedia.org/wiki/16-bit\">16/32-bit</a>";
		# } else {
			$arch = "<a href=\"$script_url/data_width#" . &chipData2($row,$colArch) . "-bit\">" . &chipData2($row,$colArch) . "-bit</a>";
		# }
	}
	if ( &chipData2($row,$colDataBus) ne '' ) {
		$data = &chipData2($row,$colDataBus);
	}
	if ( &chipData2($row,$colAddBus) ne '' ) {
		$address = &chipData2($row,$colAddBus);
	}
	if ( &chipData2($row,$colPack) ne '' ) {
		$package = '<a href="https://howto.wikia.com/wiki/Howto_identify_chip_packages">' . &chipData2($row,$colPack) . "</a>$wiki_attrib";
	}
	if ( &chipData2($row,$colTech) ne '' ) {
		$tech = &chipData2($row,$colTech);
		if ( $tech =~ ' ' ) {
			@techFirst = split(/ /, $tech);
			$tech = $techFirst[0];
		}
		$tech="<a href=\"$script_url/technologies#$tech\">$tech</a> $techFirst[1] $techFirst[2] $techFirst[3]\n";
	}
	if ( &chipData2($row,$colTrans) ne '' ) {
		$trans = &chipData2($row,$colTrans);
	}
	if ( &chipData2($row,$colProc) ne '' ) {
		$proc = &chipData2($row,$colProc);
		$proc =~ s/um/\&mu\;m/;
		$proc =~ s/u/\&mu\;m/;
	}
	if ( &chipData2($row,$colDie) ne '' ) {
		$die = &chipData2($row,$colDie);
		$die =~ s/mm\^2/mm<sup>2<\/sup>/i;
	}
	if ( &chipData2($row,$colVcc) ne '' ) {
		$volt = &chipData2($row,$colVcc);
	}
	if ( &chipData2($row,$colDate) ne '' ) {
		$date = '<a href="' . $script_url . '/release_date#' . &chipData2($row,$colDate) . '">' . &chipData2($row,$colDate) . '</a>';
	}
	if ( &chipData2($row,$colL1) ne '' ) {
		$L1 = &chipData2($row,$colL1);
	}
	if ( &chipData2($row,$colL2) ne '' ) {
		$L2 = &chipData2($row,$colL2);
	}
	if ( &chipData2($row,$colL3) ne '' ) {
		$L3 = &chipData2($row,$colL3);
	}
	if ( &chipData2($row,$colCore) ne '' ) {
		$core = &chipData2($row,$colCore);
	}
	if ( &chipData2($row,$colFPU) ne '' ) {
		$fpu = &chipData2($row,$colFPU);
	}
	if ( &chipData2($row,$col_ram_int) ne '' ) {
		$ram_int = &chipData2($row,$col_ram_int);
	}
	if ( &chipData2($row,$col_ram_max) ne '' ) {
		$ram_max = &chipData2($row,$col_ram_max);
	}
	if ( &chipData2($row,$col_rom_int) ne '' ) {
		$rom_int = &chipData2($row,$col_rom_int);
	}
	if ( &chipData2($row,$col_socket) ne '' ) {
		$socket = &chipData2($row,$col_socket);
	}
	if ( &chipData2($row,$col_datasheet) ne '' ) {
		$datasheet = "<a href=\"$relativeLoc/$datasheet_loc/" . &chipData2($row,$col_datasheet) . "\">" . &chipData2($row,$col_datasheet) . "</a>";
	}
	if ( &chipData2($row,$col_features) ne '' ) {
		$features = &chipData2($row,$col_features);
	}
	if ( &chipData2($row,$col_num_cores) ne '' ) {
		$num_cores = &chipData2($row,$col_num_cores);
	}
	if ( &chipData2($row,$col_designer) ne '' ) {
		$core_designer = &chipData2($row,$col_designer);
	}
	if ( &chipData2($row,$col_bus_speed) ne '' ) {
		$bus_speed = &chipData2($row,$col_bus_speed);
	}
	if ( &chipData2($row,$col_applications) ne '' ) {
		$applications = "<a href=\"$script_url/applications#" . &chipData2($row,$col_applications) . "\">" . &chipData2($row,$col_applications) . '</a>';
	}
	if ( &chipData2($row,$col_instruction_set) ne '' ) {
		$instruction_set = &chipData2($row,$col_instruction_set);
		if ( &chipData2($row,$col_instruction_link) ne '' ) {
			$instruction_set = "<a href=\"" . &chipData2($row,$col_instruction_link) . "\">$instruction_set</a>$wiki_attrib";
		}
	}
	if ( &chipData2($row,$col_computer_architecture) ne '' ) {
		$computer_arch = "<a href=\"$script_url/architecture#" .  &chipData2($row,$col_computer_architecture) . "\">" . &chipData2($row,$col_computer_architecture) . "</a>";
	}
	if ( &chipData2($row,$col_microarchitecture) ne '' ) {
		$microarch = &chipData2($row,$col_microarchitecture);
	}
	if ( &chipData2($row,$col_power) ne '' ) {
		$power = &chipData2($row,$col_power);
	}
	if ( &chipData2($row,$col_alt_id) ne '' ||  &chipData2($row,$col_label_id) ne ''  ) {
	$id_html = <<Endhtml;
				<td colspan="4">
					<span class="tableChipSubHeading">Identification:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
					<span class="tableChipParam">Manufacturer:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$manufTableSub</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Part #:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$part</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
Endhtml
		if (  &chipData2($row,$col_label_id) ne '' ) {
			$label_id = &chipData2($row,$col_label_id);
			$id_html .= <<Endhtml;
					<span class="tableChipParam">Chip label:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$label_id</span>
				</td><td style="white-space: nowrap; width: 100px;">
Endhtml
			if (  &chipData2($row,$col_alt_id) ne '' ) {
				$alt_id = &chipData2($row,$col_alt_id);
				$id_html .= <<Endhtml;
					<span class="tableChipParam">Alt ID:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$alt_id</span>
				</td>
Endhtml
			} else {
				$id_html .= <<Endhtml;
				</td><td style="white-space: nowrap;">					
				</td>
Endhtml
			}
		} else {
			$alt_id = &chipData2($row,$col_alt_id);
			$id_html .= <<Endhtml;
					<span class="tableChipParam">Alt ID:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$alt_id</span>
				</td><td style="white-space: nowrap; width: 100px;">
				</td><td style="white-space: nowrap;">					
				</td>
Endhtml
		}
		$id_html .= "\t\t\t</tr><tr>";
	}
	if ( &chipData2($row,$col_rom_type) ne '' ) {
		$rom_type = &chipData2($row,$col_rom_type);
	}
	if ( &chipData2($row,$col_ram_type) ne '' ) {
		$ram_type = &chipData2($row,$col_ram_type);
	}
	if ( &chipData2($row,$col_volt_io) ne '' ) {
		$volt_io = &chipData2($row,$col_volt_io);
	}
	if ( &chipData2($row,$col_isa) ne '' ) {
		$isa = "<a href=\"$script_url/ISA/\">" . &chipData2($row,$col_isa) . "</a>";
	}

	# if ( &chipData2($row,$col_) ne '' ) {
		# $ = &chipData2($row,$col_);
	# }

	$text .= <<Endhtml;
	<table><!-- chip table -->
		<tr>
			<td colspan="2" style="background-color: #545454">
				<div class="chipTypeHeading">&nbsp;&nbsp;$manufTableSub - $part</div>
			</td>
		</tr><tr style="background-color: #454545;">
			<td style="width: 256px; vertical-align: top; text-align: center; margin: 0 auto;">$photo</td>
			<td style="width: 500px; vertical-align:top;">

		<table style="width:400px;">
			<tr>
			$id_html
				<td colspan="4">
					<span class="tableChipSubHeading">General Specifications:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
					<span class="tableChipParam">Manufacture:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$manufTableSub</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Family:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$family_short</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
					<span class="tableChipParam">Chip type:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$type</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Introduced:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$date</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
					<span class="tableChipParam">Speed:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$speed</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Architecture:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$arch</span>
				</td>	
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; width: 100px;">
					<span class="tableChipParam">Application:</span>
				</td><td colspan="3" style="width: 100px; white-space: nowrap;">
					<span class="tableChipValue">$applications</span>
				</td>
			</tr><tr>
				<td colspan="4" style="height: 5px;"></td>
			</tr>
Endhtml
	if ( $type =~ /(CPU|MCU|DSP)/ ) {
	$text .= <<Endhtml;
			<tr>
				<td colspan="4">
					<span class="tableChipSubHeading">Architecture Specifications:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">CPU arch:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$computer_arch</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">ISA:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$isa</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Microarch:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$microarch</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam"></span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue"></span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Processor core:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$core</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam"># of cores:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$num_cores</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Designer:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$core_designer</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">FPU:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$fpu</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Ext data bus:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$data</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">Address bus:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$address</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Instruction Set:</span>
				</td><td colspan="3">
					<span class="tableChipValue">$instruction_set</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px; vertical-align: top;">
					<span class="tableChipParam">Features:</span>
				</td><td colspan="3" style="vertical-align: top;">
					<span class="tableChipValue">$features</span>
				</td>
			</tr><tr>
				<td colspan="4" style="height: 5px;"></td>
			</tr>
Endhtml
	}
	if ($type =~ /CPU/) {
	$text .= <<Endhtml;
			<tr>
				<td colspan="4">
					<span class="tableChipSubHeading">Memory Specification:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Max RAM:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$ram_max</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L1 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L1</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">RAM type:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$ram_type</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L2 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L2</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam"></span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue"></span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L3 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L3</span>
				</td>
			</tr><tr>
				<td colspan="4" style="height: 5px;"></td>
			</tr>
Endhtml
	} elsif ( $type eq 'MCU' ) {
	$text .= <<Endhtml;
			<tr>
				<td colspan="4">
					<span class="tableChipSubHeading">Memory Specification:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Max RAM:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$ram_max</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L1 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L1</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Internal RAM:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$ram_int</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L2 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L2</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Internal ROM:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$rom_int</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">L3 cache:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$L3</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">ROM type:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$rom_type</span>
				</td><td style="white-space: nowrap;">
				</td><td style="white-space: nowrap;">					
				</td>
			</tr><tr>
				<td colspan="4" style="height: 5px;"></td>
			</tr>
Endhtml
	}
	$text .= <<Endhtml;
			<tr>
				<td colspan="4">
					<span class="tableChipSubHeading">Technology:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Technology:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$tech</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">Process:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$proc</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Transistors:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$trans</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">Die size:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$die</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Vcc:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$volt</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">Voltage I/O:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$volt_io</span>
				</td>
			</tr><tr>
				<td colspan="4" style="height: 5px;"></td>
			</tr><tr>
				<td colspan="4">
					<span class="tableChipSubHeading">Other:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Package:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$package</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipParam">Socket:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$socket</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; padding-left: 10px;">
					<span class="tableChipParam">Datasheet:</span>
				</td><td colspan="3" style="vertical-align: top;">
					<span class="tableChipValue">$datasheet</span>
				</td>				
			</tr><tr>
				<td colspan="4" style="text-align: center;">
					<br />
					<span class="tableChipValue"><a href="$contact_page">Report any problems</a></span>
				</td>
			</tr>
		</table>
		</td>
	</tr>	
	</table><!-- chip table (end) -->	
Endhtml
	
	if($type_name ne ''){
		$title_ext_global = "$manuf_name - $part - $type_name";
		$keyword_ext_global = "$manuf_name, $part, $type_name";
	}else{
		$title_ext_global = "$manuf_name - $part";
		$keyword_ext_global = "$manuf_name, $part";
	}

	return ($text);
}


sub create_html_body_main_single_chip {
	my $text = '';
	# $data{'page'} eq chip
	# ?page=chip&manufacturer=Intel&chipName=A80486SX-33
	my $flipColor=0;
	my $x=$skipLines;
	my $chip_link_part_var = '';

	if( $data{'part'} eq '' || $data{'manufacturer'} eq '' ) {
		$text .= "No chip selected, invalid state<br />\n";
	} else {
		while(&chipData2($x,$colPart) ne ""){
			# print ".";
			$chip_link_part_var = &chipData2($x,$colPart);
			$chip_link_part_var =~ s/\W/_/g;
			if ( $chip_link_part_var eq $data{'part'} && &chipData2($x,$colManuf) eq $data{'manufacturer'} ) {
				# print "-";
				$text .= &create_html_body_main_single_chip_table($x);
			}
			$x++;
		}
	}
	return $text;
}



sub create_html_body_main_full_list {
	my $text = '';
	
	$title_ext_global = 'Full Chip List';
	$keyword_ext_global = 'full chip list';

	my $x=$skipLines; 
	$text .= "<h1>Full chip list</h1>\n\n";
	$text .= "<table class=\"tablespacing5 table_zebra_striped\" style=\"border-width: 1px; border-style: solid;\"><!-- summary=\"full chip list, organized\" --><tr>\n";
	$text .= "<td><b>Manufacturer</b></td>\n";
	$text .= "<td><b>Family</b></td>\n";
	$text .= "<td><b>Part #</b></td>\n";
	# print "<td><b>Photo</b></td></tr>\n";
	
	while(&chipData2($x,$colPart) ne "") {
		my $manuf=&chipData2($x,$colManuf);
		my $family=&chipData2($x,$colFamily);
		my $part=&chipData2($x,$colPart);
		my $photo=&chipData2($x,$colPhoto1);
		$text .= "<tr>\n";
		$text .= "<td>$manuf</td>\n";
		$text .= "<td>$family</td>\n";
		$text .= "<td><a href=\"$script_url/ic/" . url_encode($manuf) . "/" . url_encode($part) . "\">$part</a></td>\n";
		# print "<td><a href=\"../$photoLoc/$photo\">Photo</a></td>\n";
		$text .= "</tr>\n";
		$x++;
	}
	$text .= "</table>\n";
	return $text;
}

sub create_html_body_main_trade_list { 
	my $text = '';
	my $x=$skipLines;

	$text .= "<h1>Trade List</h1>\n\n";
	&create_html_body_main_contact;

	$title_ext_global = 'Trade List';
	$keyword_ext_global = 'trade, trade list';

	$text .= <<EndHTML;
<table style="border-style: solid; border-width: 1px;" class="table_zebra_striped"><!-- trade list table -->
	<thead>
		<tr>
			<th><h2>Trade List</h2></th>
		</tr>
	</thead>
	<tbody><tr><td>

		<table class="tablespacing5"><!-- summary="trade list table" -->
			<tr>
				<td style="width: 20px"><b>Quantity</b></td>
				<td><b>Manufacturer</b></td>
				<td><b>Family</b></td>
				<td><b>Part #</b></td>
EndHTML
	my $x=$skipLines;
	while(&chipData2($x,$colPart) ne "") {
		my $trade=&chipData2($x,$colTrade);
		my $manuf=&chipData2($x,$colManuf);
		my $family=&chipData2($x,$colFamily);
		my $part=&chipData2($x,$colPart);
		my $photo=&chipData2($x,$colPhoto1);
		if(&chipData2($x,$colTrade) ne "X" && &chipData2($x,$colTrade) ne "x") {
			$text .= "<tr>\n";
			$text .= "<td>$trade</td>\n";
			$text .= "<td>$manuf</td>\n";
			$text .= "<td>$family</td>\n";
			$text .= "<td><a href=\"$script_url/ic/" . url_encode($manuf) . "/" . url_encode($part) . "\">$part</a></td>\n";
			# print "<td><a href=\"../$photoLoc/$photo\">Photo</a></td>\n";
			$text .= "</tr>\n";
		}
		$x++;
	}

	$text .= <<EndHTML;
		</table>
	</td></tr></tbody>
	</table>
	<br /><br />

	<table style="border-style: solid; border-width: 1px;"><!-- wanted list table -->
	<thead>
		<tr>
			<th><h2>Wanted List</h2></th>
		</tr>
	</thead>
	<tbody>
	<tr><td>


		<p style="font-weight: bold;">Stuff I really really want.....</p>
		<pre>
AMD		Am29035, Am29027, Am29101, Am29112, Am29117, Am29501
AMD		AM2901DC white ceramic
AMD		Any AM29xx I don't have 
			I have 2901, 2902, 2903, 2904, 2909, 2910, 2918, 2946, 2950, 2952, 2960, 
				2965, 2966
			I need 2905, 2906, 2907, 2908, 2911, 2912, 2913, 2914, 2915, 2916, 2917, 
				2919 thru 2930, 2932, 2940, 2942, 2947, 2948, 2949, 2951, 
				2954 thru 2959, 2961, 2962, 2964

Cyrix 	Cx486DX2-66 Green heatsink (this was the CPU for my first real computer, long gone)

Intergraph	Clipper


MOS			6500/1
MOS			65CE02
MOS			MCS6502
MOS			6503, 6505, 6506, 6507, 6508, 6512, 6513, 6514, 6515
MOS			7501
MOS			8500, 8501, 8502

HP PA-RISC (TS-1, CS-1, NS-1, NS-2, or PCX)
HP PA-RISC (PCX-S 	PA-7000)
HP PA-RISC (PCX-T 	PA-7100)
HP PA-RISC (PCX-T 	PA-7150)
HP PA-RISC (PCX-L 	PA-7100LC)
HP PA-RISC (PCX-L2 	PA-7300LC)
HP PA-RISC (Mako 	PA-8800)
HP PA-RISC (Shortfin 	PA-8900)


Any mainframe CPU
	</pre>


	<p style="font-weight: bold;">Stuff I want.........</p>
	<pre>
Intel		D4040
Intel		Any 8008
Intel		Any Itanium
Intel		A80860XR-33
Intel		Rapid CAD
Intel       Any XScale CPU   
Intel 		Any i376

AMD 		Z8002

Weitek		Any CPU

ICT			Any Loongson
ICT			Any Godson

Monolithic Memories Incorporated 	5701/6701

Motorola 	68012

NEC			V33, V53, V70

National Semi	Any PACE
National Semi	SC/MP
National Semi	32032

Nvidia		Any Tegra

INMOS		any T2xx or T9xxx

VIA			any CPU

Transmeta	any CPU

WDC			65816

Western Electric	32100, 32200

TI TMS390S10 (mircoSPARC I)

Any SPARC64 CPU
Any UltraSPARC T1, T2

Fujitsu MB86900 (SPARC)
Fujitsu MB86907 (TurboSPARC)
Fujitsu MB8683x (SPARClite)

Ross RT620A, RT620B, RT620C, RT620D (hyperSPARC)

Sun STP1021 (SuperSPARC II)
Sun SME1832 (UltraSPARC "RK")
Sun SME1167 (UltraSPARC IV)
Sun SME1052 (UltraSPARC III)

Any Oracle CPU

DEC	
	T11 (DC310)
	LSI-11 (21-11549-01,  WD MCP1600)
    VAX	V-11
	MicroVAX
		KA610, KA620, KA650, KA655, KA660 CPU module
    	MicroVAX 78032
    CVAX
		CVAX 78034 CPU
		CVAX 78034
    Rigel	REX520 (DC520)
    Mariah	 DC595
    NVAX, NVAX+, NVAX++
    MicroPrism
    EV-4
	MMP
	Alpha CPU 
		21164
		21264
		21364
		21464

Compaq Alpha (any)

MIPS I R2000 
	LSI LR52020JC, LR2000GC
	Performance PR2000A , PR2010A
	MIPS R2000A
	Any other
MIPS R3000
	IDT 79R3000A, 79R3000AE, 79R3010L, 79R3010A, 79R3010AE, 793010, 79R3500,
	NEC D3031R VR3000A
	LSI LR3000GC, LR3010LC, LR3220GC
	Performance PR3000, PR3000A, PR3010, PR3010A, PR3400L
	Any other
MIPS III R4000 
	Toshiba TC85R4000PC, TC85R4000SC, 
	NEC D30401RJ VR4000SC
	NEC VR4121 
	NEC D30200GD VR4000SC, 
	NEC D30400RJ VR4000PC
	NEC D30401RJ
	Any other
MIPS R4200 
	Any
MIPS R4300i  
	NEC D30200RD 
	any other
MIPS R4400
	Toshiba TC86R4400MC
	NEC D30412LRJ VR4400MC
	Any other
MIPS R4600 R4640 R4650 
	IDT 79R4600, 79RV4700, 79RV4640
	NKK R4650
	any other
MIPS R4700 
	IDT 79RV4700, R4700 Orion, 
	NKK NR4700LCG,
	VLSI VF4723
	any other
MIPS R4900
	NASDA R4901
	Any other
MIPS R5000
	IDT 79RV5000
	NEC Electronics Solution Gear CMB-VR550
	QED RM5270, RM5230, RM5231
	PMC RM5231A, RM5261A
	NEC D30500RJ VR5000
	NEC D30500S2 VR5000
	Any other
MIPS II R6000 
	Any
MIPS RM7000 
	QED RM7000, RM7000A
	PCM RM7000, RM7000A, RM7000B, RM7000C, RM7900, RM7035C, RM7935, RM7065C, RM7965, RM7965A
	Any other
MIPS 9000
	PMC RM9000x1, RM9200, RM9220, RM9222, RM9224
	Any other
MIPS IV R8000 
	Toshiba T5F52 (R8000)
	Toshiba T5F55 (R8010)
	Any
MIPS R14000
	NEC D30720F5 VR14000
	SGI R14000
MIPS R16000
MIPS MIPS64 
	any


MIPS Realtek RTL8186



</pre>


	<p style="font-weight: bold;">Stuff I take.........</p>
	<pre>
Any CPU I don't have
	</pre>
	


	<p style="font-weight: bold;">Other stuff I could use</p>
	<pre>
Some Antistatic IC tubes
0.6in DIP tubes
0.9in DIP tubes (Used for Motorola 68000)
0.75in DIP tubes (Used by some Shrink DIPs)
	</pre>		
	
	
	
	</td></tr></tbody>
	</table> <!-- wanted list table (end) -->
	<br /><br />	
EndHTML

	return $text;
}



sub create_html_body_main_chip_list {
	my $text = '';
	my $x=$skipLines; #
	my $flipColor=0;
	my $supportChipCount=0;
	my @supportChips=();
	my @freq=();
	my @chip_text=();
	my @chip_text2=();
	my @chip_text3=();
	my @supportChipsMan=();
	my @chip_table_text=(), @sort_elements=();
	my $listed_cnt=0;

	$text .= "\n\t<!-- manuf list -->\n\t<table class=\"tablepadding5\" style=\"background-color: #333333; border-width: 0;\"><!-- summary=\"manufacturer list\" -->\n"; 
	while(&chipData2($x,$colManuf) ne "") {
		if( (&chipData2($x,$colManuf) =~ /^$data{'manufacturer'}$/i) || ($data{'page'} eq 'family') ) {
			if ( (&chipData2($x,$colFamily) eq $data{'family'} || $data{'family'}  eq "All" || (($data{'family'}  eq "Other") && (&chipData2($x,$colFamily) eq ''))) && ($data{'family'} ne "") ) {
				if ( &chipData2($x,$colType) =~ /^Support$/i ) {
					$supportChips[$supportChipCount] = &chipData2($x,$colPart);
					$supportChipsMan[$supportChipCount] = &chipData2($x,$colManuf);
					# need to fix to the send full ship data
					$supportChipCount++;
				} else {
					($chip_table_text[$listed_cnt], $sort_elements[$listed_cnt], $type[$listed_cnt]) = &displayTableData2($x,$flipColor);
					$listed_cnt++;
					if ( $flipColor == 0 ) {$flipColor = 1;} else {$flipColor = 0;}
				}
			}
		}
		$x++;
	}
	# my $row_sort = 0;
    my $not_complete = 1;
    my $index;
    my $len = ($#sort_elements - 1);
	my $temp = '';
	my $temp2 = '';
	my $temp3 = '';
	while ($not_complete) {
		$not_complete = 0;
		foreach $index (0 .. $len) {
			if ($sort_elements[$index] > $sort_elements[$index + 1]) {
				$temp = $sort_elements[$index + 1];
				$temp2 = $chip_table_text[$index + 1];
				$temp3 = $type[$index + 1];
				$sort_elements[$index + 1] = $sort_elements[$index];
				$chip_table_text[$index + 1] = $chip_table_text[$index];
				$type[$index + 1] = $type[$index]; 
				$sort_elements[$index] = $temp;
				$chip_table_text[$index] = $temp2;
				$type[$index] = $temp3;
				$not_complete = 1;
			}
		}
	}

	if ( $data{'page'} eq 'manufacturer' || $data{'page'} eq 'family' ) {
		# print "yelp";
		$x=0;
		my $cpus = '';
		my $mcus = '';
		my $fpus = '';
		my $dsps = '';
		my $socs = '';
		my $others = '';
		while ( $sort_elements[$x] ne '' ) {
			# print ".";
			if ( $type[$x] =~ /^cpu$/i || $type[$x] =~ /^bitslice cpu$/i  ) {
				$cpus .= $chip_table_text[$x];
			}elsif($type[$x] =~ /^soc$/i ){
				$socs .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^mcu$/i ) {
				$mcus .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^dsp$/i ) {
				$dsps .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^fpu$/i ) {
				$fpus .= $chip_table_text[$x];
			} else {
				$others .= $chip_table_text[$x];
			}
			$x++;
		}
		if ( $cpus ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Central Processing Unit (CPU)</div></td></tr>\n";
			$text .= $cpus;
		}
		if ( $socs ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;System-on-Chip (SoC)</div></td></tr>\n";
			$text .= $socs;
		}
		if ( $mcus ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Micro-Controller Unit (MCU)</div></td></tr>\n";
			$text .= $mcus;
		}
		if ( $dsps ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Digital Signal Processor (DSP)</div></td></tr>\n";
			$text .= $dsps;
		}
		if ( $fpus ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Floating Point Unit (FPU)</div></td></tr>\n";
			$text .= $fpus;
		}
		if ( $others ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Other components</div></td></tr>\n";
			$text .= $others;
		}
		$text .= "\t</table>\n";
		if ( $supportChipCount > 0 ) {
			$text .= &create_html_page_addition_support_chips(\@supportChips,\@supportChipsMan);
		}
		$text .= "\t<!-- manuf list (end) -->\n";
	} 
	# elsif ( $data{'page'} eq 'family' ) {
		# foreach $temp ( @chip_table_text ) {
			# print $temp;
		# }
	# }
	
	# Create title extensions
	if ( $data{'page'} eq 'manufacturer' ) {
		if ($data{'family'} eq '' ) {
		 	$title_ext_global = "$data{'manufacturer'} Chips";
			$keyword_ext_global = "$data{'manufacturer'}";
		} else {
		 	$title_ext_global = "$data{'manufacturer'} - $data{'family'} Chips";
			$keyword_ext_global = "$data{'manufacturer'}, $data{'family'}";
		}
	}elsif ($data{'page'} eq 'family' ) {
	 	$title_ext_global = "$data{'family'} Chips";
		$keyword_ext_global = "$data{'family'}";
	}

	return $text;
}


sub create_html_body_main_contact {
	my $text = '';
	
	$title_ext_global = 'Contact Page';
	$keyword_ext_global = 'contact';

	$text .= <<Endhtml;
		<table style="border-width: 1px; border-style: solid;">
			<tr><td style="text-align: center;">
				<a href="/contact">Contact Me</a><br />
			</td></tr>
		</table>
Endhtml
	return $text;
}



sub create_html_body_404 {
	# generates 404 error page not found
	
	my $text = '';
	my $header2 = $page_DNE_header2_global;

	# if( $data{'page'} eq '404' ){
		# $header2 = '';
	# }else{
		# $header2 =~ s/404 error://;
	# }

	$text .= <<Endhtml;
		<div style="padding: 10px;">
			<h1>404 Error: Page not found</h1>
			<div style="padding-left: 15px;"><h2>$header2</h2></div>
		</div>
Endhtml
	return $text;
}




###########################################################
###########################################################
#############    Main Content Pages (end)  ################
###########################################################
###########################################################





###########################################################
###########################################################
##############    Intro Tables (begin)  ###################
###########################################################
###########################################################

sub create_html_intro_single_chip {
	my $text ='';

	my $x=$skipLines;
	my $part=$data{'part'};
	# my $name = $data{'family'};
	my $fullName = '';
	my $manuf = $data{'manufacturer'};
	my $manufSub = '?';
	my $dateSub = '?';
	my $chip= '?';
	my $arch = '?';
	my $coreArch = '?';
	my $freq = '?';
	my $tech = '?';
	my $instrucName = '';
	my $instrucCount = '?';
	my $instrucLink = '?';
	my $homepage = '?';
	my $wiki = '?';
	my $date = '?';
	my $add = '?';
	my $desc = '...';
	my $logo = '';
	my $familyLogo = '';
	# my $famSub = $data{'family'};
	my $link = '';
	my $linkName = '';
	my $datasheet = '?';
	#print "match => &familyData2($x,$colFamilyName] ";
	my $chip_link_part_var = '';


	if ( $data{'page'} eq 'chip' ) {
		# my $flipColor=0;
		$x = $skipLines;
		while(&chipData2($x,$colPart) ne ""){
			$chip_link_part_var = &chipData2($x,$colPart);
			$chip_link_part_var =~ s/\W/_/g;
			if ( $chip_link_part_var eq $data{'part'} && &chipData2($x,$colManuf) eq $data{'manufacturer'} ) {
				# &displayTableData($x,$flipColor);
				$family = &chipData2($x,$colFamily);
				$famSub = $family;
			}
			$x++;
		}
	}
	# print " --|$family|-- ";

	$x = $skipLines;
	while ( &familyData2($x,$colFamilyName) ne '' ) {
		# print ".<br>" . &familyData2($x,$colFamilyName) ;
		if ( &familyData2($x,$colFamilyName) eq $famSub ) {
			# print "match => &familyData2($x,$colFamilyName) ";
			$name 	= &familyData2($x,$colFamilyName);
			if ( &familyData2($x,$colFamilyFullName) ne '' ) {
				$fullName = "aka " . &familyData2($x,$colFamilyFullName) . "family<br />";
			} 
			# else {
				# $fullName = "of the " . $data{'family'} . " Family<br />";
			# }
			if ( &familyData2($x,$colFamilyManuf) ne '' ) {
				$manufSub = &familyData2($x,$colFamilyManuf);
			}
			if ( &familyData2($x,$colFamilyDate) ne '' ) {
				$dateSub 	= &familyData2($x,$colFamilyDate);
			}
			# if ( &familyData2($x,$colFamilyChip) ne '' ) {
				# $chip	= &familyData2($x,$colFamilyChip);
			# }
			if ( &familyData2($x,$colFamilyArch) ne '' ) {
				$arch 	= &familyData2($x,$colFamilyArch) . '-bit';
			}
			if ( &familyData2($x,$colFamilyInstrucName) ne '' ) {
				$instrucName  = &familyData2($x,$colFamilyInstrucName);
			}
			if (&familyData2($x,$colFamilyIntrucNum)  ne '' ) {
				$instrucNum = &familyData2($x,$colFamilyIntrucNum);		
			}
			if ( &familyData2($x,$colFamilyInstrucLink) ne '' ) {
				$instrucLink = &familyData2($x,$colFamilyInstrucLink);
			}
			if ( &familyData2($x,$colFamilyCoreArch) ne '' ) {
				$coreArch = &familyData2($x,$colFamilyCoreArch);	
			}
			if ( &familyData2($x,$colFamilyFreq) ne '' ) {
				$freq = &familyData2($x,$colFamilyFreq);		
			}
			if (&familyData2($x,$colFamilyTech)  ne '' ) {
				$tech =&familyData2($x,$colFamilyTech) ;		
			}
			if ( &familyData2($x,$colFamilyHomepage) ne '' ) {
				if ( &familyData2($x,$colFamilyHomepage) eq 'none' ) {
					$homepage = 'none';
				} else {
					($link,$linkName) = split(/ /,&familyData2($x,$colFamilyHomepage));
					if ($linkName eq '') { 
						$linkName = substr($link,0,20) . '...'; 
					}
					$homepage = "<a href=\"" . &familyData2($x,$colFamilyHomepage) . "\">$linkName</a>";	;		
				}
			}
			if ( &familyData2($x,$colFamilyWiki) ne '' ) {
				$wiki = &familyData2($x,$colFamilyWiki);
				$wiki =~ s/ /_/;
				$wiki = "(<a href=\"https://en.wikipedia.org/wiki/$wiki\">Wikipedia article</a>)";		
			}
			if ( &familyData2($x,$colFamilyLogo) ne '' ) {
				$familyLogo = &familyData2($x,$colFamilyLogo);		
			}

			#if ( $logo ne '' ) {
				#$logo = "<a href=\"https://howto.wikia.com/wiki/Howto_identify_integrated_circuit_%28chip%29_manufacturers_by_their_logos\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\" width=\"70\"></a>";
			#}

			##### EXTRA LOGOs

			if (&familyData2($x,$colFamilyDesc) ne '') {
				$desc 	= &familyData2($x,$colFamilyDesc);
			}
		}
		$x++;
	}
	
	$x = $skipLines;
	while ( &manufData2($x,$colManufName) ne '' ) {
		#print &manufData2($x,$colManufFullName);
		if ( $data{'manufacturer'} eq &manufData2($x,$colManufName) ) {
			$nameManuf	= &manufData2($x,$colManufFullName);
			$logo 	= &manufData2($x,$colManufLogo1);
			#$founded = &manufData2($x,$colManufDate);
			#$homepage= &manufData2($x,$colManufHomepage);
			#$wiki 	= &manufData2($x,$colManufWiki);
			#$trad 	= &manufData2($x,$colManufTrad);
			#$current = &manufData2($x,$colManufCurrent);
			#$status 	= &manufData2($x,$colManufStatus);
			#$desc 	= &manufData2($x,$colManufDesc);
			#print "............. &manufData2($x,$colManufName) ................<br />\n";
		}
		$x++;
	}
	if ( $logo ne '' ) {
		$logo = "<a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\"></a>";
	}
	if ( $nameManuf eq '' ) {
		$nameManuf = $data{'manufacturer'};
	}

	$text .= <<Endhtml;

	<table style="text-align: left; width: 100%"><!-- summary="chip family desc" -->
		<tr>
			<td style="width: 80px; vertical-align: top;">
				$logo
			</td>
			<td>
				<h1 class="tableTitle">$manuf - $part</h1>
			<!-- family caption-->
				<table style="width: 100%;"><!-- summary="family table organization" -->
					<tr>
						<td colspan="2">
							<span class='familyDescTableName' style="margin-left:5px;">$name family description:<br /></span>
<span class='familyDescTableParam'>$fullName</span><br />
							<span class='familyDescTableParam' style="margin-left:15px;">Homepage:</span> <span class='familyDescTableValue'>$homepage <i>$wiki</i></span><br />
							<span class='familyDescTableParam' style="margin-left:15px;">Description:</span> <span class='familyDescTableValue'>$desc</span>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: top; width: 40%;">
						 <table style="border-collapse: collapse; margin-left:15px;">
							<tr>
								<td class='familyDescTableParam'>Designer:</td> 
								<td class='familyDescTableValue'>$manufSub</td>
							</tr>	
							<tr>
								<td class='familyDescTableParam'>Initial release:</td>
								<td class='familyDescTableValue'>$dateSub</td>
							</tr>
							<tr>
								<td class='familyDescTableParam'>Datasheet:</td> 
								<td class='familyDescTableValue'>$datasheet</td>
							</tr>
						</table>
						</td>
						<td style="vertical-align: top; width: 60%;">
						<table style="border-collapse: collapse;">
							<tr>
								<td class='familyDescTableParam'>Architecture:</td>
								<td class='familyDescTableValue'>$arch</td>
							</tr><tr>
								<td class='familyDescTableParam'>Frequencies:</td>
								<td class='familyDescTableValue'>$freq</td>
							</tr><tr>
								<td class='familyDescTableParam'>Technology:</td>
								<td class='familyDescTableValue'>$tech</td>
							</tr>
						 </table>
						</td>
					</tr>
				</table>
			<!--  </td></tr></table> -->
			<!-- Family caption (end) -->
			</td>
		</tr>
	</table>
Endhtml
	return $text;
}


sub create_html_intro_manuf {
	#Creates the intro table for manufacturers
	my $text = '';
	my $manufSub = $_[0];

	my $name	= '';
	my $logo1 	= '';
	my $logo2 	= '';
	my $logo3 	= '';
	my $logo4 	= '';
	my $logo5 	= '';
	my $founded = '';
	my $homepage= ' unknown,';
	my $wiki 	= '';
	my $trad 	= '';
	my $current = '';
	my $status 	= '';
	my $desc 	= '';
 	my $row = $skipLines;
	my @board_rows = ();
	my $does_manuf_exist = 0;

	$text .= "\t<!-- manuf details -->\n";
	# print "$manufSub";

	my $x=$skipLines;
	while ( &manufData2($x,$colManufName) ne '' ) {
		# print &manufData2($x,$colManufName) . ", ";
		if ( $manufSub eq &manufData2($x,$colManufName) ) {
			$does_manuf_exist = 1;
			$name	= &manufData2($x,$colManufFullName);
			$name	=~ s/_/ /g;
			$logo1 	= &manufData2($x,$colManufLogo1);
			$logo2 	= &manufData2($x,$colManufLogo2);
			$logo3 	= &manufData2($x,$colManufLogo3);
			$logo4 	= &manufData2($x,$colManufLogo4);
			$logo5 	= &manufData2($x,$colManufLogo5);
			$founded = &manufData2($x,$colManufDate);
			$homepage= &manufData2($x,$colManufHomepage);
			$wiki 	= &manufData2($x,$colManufWiki);
			$wiki	=~ s/ /_/g;
			$trad 	= &manufData2($x,$colManufTrad);
			$current = &manufData2($x,$colManufCurrent);
			$status 	= &manufData2($x,$colManufStatus);
			$desc 	= &manufData2($x,$colManufDesc);
			$abrev = &manufData2($x,$colManufAbrev);
			#print "............. &manufData2($x,$colManufName) ................<br />\n";
		}
		$x++;
	}

	if ( $name eq '' ) {
		$name = $data{'manufacturer'};
	}
	if ( $logo1 ne '' ) {
		$logo1 = "<div style=\"text-align: center;\"><a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo1\" alt=\"$name\"></a></div>";
	}
	if ( $logo2 ne '' ) {
		$logo2 = "<div style=\"text-align: center;\"><a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo2\" alt=\"$name\"></a></div><br />";
	}
	if ( $logo3 ne '' ) {
		$logo3 = "<div style=\"text-align: center;\"><a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo3\" alt=\"$name\"></a></div><br />";
	}
	if ( $logo4 ne '' ) {
		$logo4 = "<div style=\"text-align: center;\"><a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo4\" alt=\"$name\"></a></div><br />";
	}
	if ( $logo5 ne '' ) {
		$logo5 = "<div style=\"text-align: center;\"><a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo5\" alt=\"$name\"></a></div>";
	}
	if ( $founded eq '' ) {
		$founded = "unknown";
	}
	if ( $homepage ne '' ) {
		if ( $homepage eq 'Dead' || $homepage eq 'dead' ) {
			$homepage = 'dead, ';
		} else {
			$homepage = "<a href=\"$homepage\">$homepage</a>";
		}
	} elsif ( $homepage =~ 'http' ) { $homepage = $homepage; } else { $homepage = "unknown"; }
	if ( $wiki ne '' ) {
		$wiki = ",&nbsp\; (<a href=\"https://en.wikipedia.org/wiki/$wiki\">Wikipedia article</a>)";
	}
	if ( $trad eq '' ) {
		$trad = " - ";
	}
	if ( $current eq '' ) {
		$current = " - ";
	}
	if ( $status eq '' ) {
		$status = ' ? ';
	}
	if ( $desc ne '' ) {
		$desc = "<span class=\"manufTableParam\">Description:</span> <span class=\"manufTableValue\">$desc</span><br />\n";
	}
	if ( $abrev ne '' ) {
		$abrev = '(' . $abrev . ')';
	}

	$text .= <<Endhtml;
	<table><!-- summary="manuf intro alignment" -->
		<tr>
			<td>
Endhtml

	if($does_manuf_exist){
		$text .= <<Endhtml;
				<table style="width:100%; text-align: left;"><!-- summary="manuf description" -->
					<tr>
						<td style="text-align: center;width: 80px;">
							$logo1
						</td>
						<td>
							<span class="tableTitle">$name $abrev</span>
						</td>
					</tr><tr>
						<td style="text-align: center;">
							$logo2
							$logo3
							$logo4
							$logo5
						</td>
						<td style="vertical-align: top">
							<span class=\"tableParam\">Founded:</span> <span class=\"tableValue\">$founded</span><br />\n
							<span class=\"tableParam\">Homepage:</span> <span class=\"tableValue\">$homepage <i>$wiki</i></span><br />\n
							<span class=\"tableParam\">Traditional products:</span> <span class=\"tableValue\">$trad</span><br />\n
							<span class=\"tableParam\">Current semiconductor products:</span> <span class=\"tableValue\">$current</span><br />\n
							<span class=\"tableParam\">Status:</span> <span class=\"tableValue\">$status</span><br />\n
							$desc
						</td>
					</tr>
				</table><!-- summary="manuf description" (end) -->
Endhtml
	}elsif($name eq "Others"){
		$text .= "		<span class=\"tableTitle\">Unsorted Manufacturers</span><br />\n";
		$text .= "		<span class=\"tableParam\">from less significant CPU manufacturers</span><br />\n";	
	}else{
		$text .= "		<span class=\"tableTitle\">$name</span><br />\n";
		$text .= "		<span class=\"tableParam\">Manufacturer details unknown</span><br />\n";
	}

	$text .= "\t\t\t</td>\n\t\t</tr><tr>\n\t\t\t<td>\n";
	$text .= "\t\t<br />\n\t\t<table style=\"border-width: 0;\"><!-- summary=\"family and,or chip list\" -->\n\t<tr>\n\t<td style=\"vertical-align: top; padding: 15px;\">\n"; #table-X1
	if($name eq "Others"){
			$text .= "\t\t<span class=\"heading2\">Manufacturer List:</span><br />\n";
			# Print others list
			foreach $others_manuf (@manuf_others_list_global){
				$others_manuf = url_encode($others_manuf);
				$text .= <<EndHTML;
			<a href="$script_url/m/$others_manuf"><span class="sidebarManufNameSelected">$others_manuf</span></a>&nbsp;<span class="sidebarManufCountSelected">($manufListCountGlobal{$others_manuf})</span><br />
EndHTML
	}
	}else{
		$text .= "\t\t<span class=\"heading2\">List of IC families:</span><br />\n";
	
		$text .= "\t\t<ul>\n";
			for ($x=0;$x<=$#manufFamilyListGlobal;$x++) {
				$text .= "\t\t\t<li><a href=\"$script_url/mf/" . url_encode($data{'manufacturer'}) . "/" . url_encode($manufFamilyListGlobal[$x]) . "\"><span class=\"manufFamilyListSelected\">$manufFamilyListGlobal[$x]</span></a>";
				if ($manufFamilyListGlobal[$x] eq "All") {
					$text .= "</li>\n";
				} else {
					$text .= "<span class=\"manufFamilyListSelected\">&nbsp;($manufFamilyListCountGlobal[$x])</span></li>\n"; 
				}
			}
		$text .= "\t\t</ul>\n";

		# Checking to see if there are any boards by/for the manuf
		$row = $skipLines;
		$x = 0;
		my $set_board = 0;
		while (&board_data($row,$col_board_board_type) ne '') {
			# print ".";
			if (&board_data($row,$col_board_manuf) eq $data{'manufacturer'} || &board_data($row,$col_board_chip_manuf) eq $data{'manufacturer'}) {
				# print "X";
				$board_rows[$x] = $row;
				$set_board = 1;
				$x++;
			}
			$row++;
		}
		if ($set_board == 1) {
			$text .= "\t</td><td style=\"vertical-align: top;\">\n";
			$text .= "\t\t<span class=\"heading2\">Processor Boards:</span>\n";
			$text .= "\t\t<ul>\n";
			foreach $x (@board_rows) {
				my $linky = &board_data($x,$col_board_name);
				my $manuf_locy = &board_data($x,$col_board_manuf);
				my $board_namey = &board_data($x,$col_board_name);
				$manuf_locy =~ s/[ \W]/_/g;
				$linky =~  s/[ \W]/_/g; # tr/\W/_/;
				$linky = "$script_url/boards/&manuf=$manuf_locy&name=$linky";
				$text .= "\t\t\t<li><span class=\"tableParam\"><a href=\"$linky\">" . &board_data($x,$col_board_type) . " ";
				if (&board_data($x,$col_board_board_type) eq 'module') {
					$text .= "CPU module";
				} elsif (&board_data($x,$col_board_board_type) eq 'dev') {
					$text .= "Evaluation board";
				}
				$text .= "<br />$board_namey</a></span>\n";
			}
		    $text .= "\t\t</ul>\n";
		}
	}
	$text .= "\t</td>\n\t</tr>\n\t</table>\n";#table-X1(end)
	$text .= "\t</td></tr></table>\n";
	$text .= "\t<!-- manuf details (end) -->\n";
	return $text;
}



sub create_html_intro_family {
	# Creates the intro table that displays family details
	my $text = '';
	my $x=$skipLines;
	my $name = $data{'family'};
	my $fullName = '';
	my $manufSub = '?';
	my $dateSub = '?';
	my $chip= '?';
	my $arch = '?';
	my $coreArch = '?';
	my $freq = '?';
	my $tech = '?';
	my $instrucName = '';
	my $instrucCount = '?';
	my $instrucLink = '?';
	my $homepage = 'Unknown ?';
	my $wiki = '';
	my $date = '?';
	my $add = '?';
	my $desc = '...';
	my $logo = '';
	my $familyLogo = '';
	my $famSub = $data{'family'};
	my $link = '';
	my $linkName = '';
	my $datasheet = '?';
	my $does_family_exist = 0;
	#print "match => &familyData2($x,$colFamilyName] ";
	my $family_w = '';

	while ( &familyData2($x,$colFamilyName) ne '' ) {
		$family_w =	&familyData2($x,$colFamilyName) ;
		$family_w =~ s/\s*$//g; 				#remove any trailing zeros
		# print "family> '$family_w' --- '$famSub' <br />\n";
		if ( $family_w eq $famSub ) {
			$does_family_exist = 1;# found a family
			# print "\t match => $family_w<br />\n ";
			$name 	= &familyData2($x,$colFamilyName);
			if ( &familyData2($x,$colFamilyFullName) ne '' ) {
				if( &familyData2($x,$colFamilyName) ne &familyData2($x,$colFamilyFullName)  ){
					
					$fullName = "aka " . &familyData2($x,$colFamilyFullName) . " Family<br />";
					$fullName = "<span class=\"familyDescTableParam\" style=\"padding-left: 15px;\">$fullName</span><br />";
				}
			} 
			# else {
				# $fullName = "of the " . $data{'family'} . " Family<br />";
			# }
			if ( &familyData2($x,$colFamilyManuf) ne '' ) {
				if(&familyData2($x,$colFamilyManuf) eq 'ATT'){ 
					$manufSub = "AT&T";
				}else{
					$manufSub = &familyData2($x,$colFamilyManuf);# family designer
				}
			}
			if ( &familyData2($x,$colFamilyDate) ne '' ) {
				$dateSub 	= &familyData2($x,$colFamilyDate);
			}
			# if ( &familyData2($x,$colFamilyChip) ne '' ) {
				# $chip	= &familyData2($x,$colFamilyChip);
			# }
			if ( &familyData2($x,$colFamilyArch) ne '' ) {
				$arch 	= &familyData2($x,$colFamilyArch) . '-bit';
			}
			if ( &familyData2($x,$colFamilyInstrucName) ne '' ) {
				$instrucName  = &familyData2($x,$colFamilyInstrucName);
			}
			if (&familyData2($x,$colFamilyIntrucNum)  ne '' ) {
				$instrucNum = &familyData2($x,$colFamilyIntrucNum);		
			}
			if ( &familyData2($x,$colFamilyInstrucLink) ne '' ) {
				$instrucLink = &familyData2($x,$colFamilyInstrucLink);
			}
			if ( &familyData2($x,$colFamilyCoreArch) ne '' ) {
				$coreArch = &familyData2($x,$colFamilyCoreArch);	
			}
			if ( &familyData2($x,$colFamilyFreq) ne '' ) {
				$freq = &familyData2($x,$colFamilyFreq);		
			}
			if (&familyData2($x,$colFamilyTech)  ne '' ) {
				$tech =&familyData2($x,$colFamilyTech) ;		
			}
			if ( &familyData2($x,$colFamilyHomepage) ne '' ) {
				if ( &familyData2($x,$colFamilyHomepage) eq 'none' ) {
					$homepage = 'none, ';
				} else {
					($link,$linkName) = split(/ /,&familyData2($x,$colFamilyHomepage));
					if ($linkName eq '') {
						$linkName = $link;
						# $linkName =~ s/https?:\/\/www\.//;
						# $linkName =~ s/https?:\/\///;
						$linkName = substr($linkName,0,30) . '...'; 
					}
					$homepage = "<a href=\"" . &familyData2($x,$colFamilyHomepage) . "\">$linkName</a>";	;		
				}
			}
			if ( &familyData2($x,$colFamilyWiki) ne '' ) {
				$wiki = &familyData2($x,$colFamilyWiki);
				$wiki =~ s/ /_/;
				$wiki = "(<a href=\"https://en.wikipedia.org/wiki/$wiki\">Wikipedia article</a>)";		
			}
			if ( &familyData2($x,$colFamilyLogo) ne '' ) {
				$familyLogo = &familyData2($x,$colFamilyLogo);		
			}

			#if ( $logo ne '' ) {
				#$logo = "<a href=\"https://howto.wikia.com/wiki/Howto_identify_integrated_circuit_%28chip%29_manufacturers_by_their_logos\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\" width=\"70\"></a>";
			#}

			##### EXTRA LOGOs

			if (&familyData2($x,$colFamilyDesc) ne '') {
				$desc 	= &familyData2($x,$colFamilyDesc);
			}
		}
		$x++;
	}
	
	$x = $skipLines;
	while ( &manufData2($x,$colManufName) ne '' ) {
		#print &manufData2($x,$colManufFullName);
		if ( $data{'manufacturer'} eq &manufData2($x,$colManufName) ) {
			if($data{'manufacturer'} eq "ATT"){
				$nameManuf	= 'AT&T -';
			}else{
				$nameManuf	= &manufData2($x,$colManufName) . ' -';
			}
			$logo 	= &manufData2($x,$colManufLogo1);
		}
		$x++;
	}
	if ( $logo ne '' ) {
		$logo = "<a href=\"$script_url/logos/\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\"></a>";
	}

	# if($DEBUG){
		# print "<br /><br />nameManuf > $nameManuf<br />";
		# print "datamanuf > $data{'manufacturer'}<br />";
	# }

	if ( $nameManuf eq '' ) {
		if ( $data{'manufacturer'} ne '' ) {
			$nameManuf = $data{'manufacturer'} . ' -';
		} else {
			$nameManuf = '';
		}
	}

	$text .= <<Endhtml;

	<table style="text-align: left;"><!-- summary="chip family desc" -->
		<tr>
			<td style="width: 80px; vertical-align: top;">
				$logo
			</td>
			<td>
				<h1>$nameManuf $name family</h1>
			<!-- family caption for single chip-->
<!--			  <table frame="box"> --><!-- summary="border for family table" --><!-- <tr><td> -->
			<div><!-- class="familyDescTable"> -->
Endhtml

	if($does_family_exist){
		$text .= <<Endhtml;

				<table style="width:100%;"><!-- summary="family table organization" -->
					<tr>
						<td colspan="2" style="padding: 5px;">
							<span class='familyDescTableName'> $name designer's family details:</span><br />
							$fullName
							<div style="padding-left: 10px;">
								<span class='familyDescTableParam'>Homepage:</span> <span class='familyDescTableValue'>$homepage <i>$wiki</i></span><br />
								<div style="padding-top: 5px;"><span class='familyDescTableParam'>Description:</span> <span class='familyDescTableValue'>$desc</span></div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: top; width: 50%;">
						<div style="padding-left: 15px;">
						 <table style="border-collapse: collapse;">
							<tr>
								<td class='familyDescTableParam'>Designer:</td> 
								<td class='familyDescTableValue'>$manufSub</td>
							</tr>	
							<tr>
								<td class='familyDescTableParam'>Initial release:</td>
								<td class='familyDescTableValue'>$dateSub</td>
							</tr>
							<tr>
								<td class='familyDescTableParam'>Datasheet:</td> 
								<td class='familyDescTableValue'>$datasheet</td>
							</tr>
						</table>
						</div>
						</td>
						<td style="vertical-align: top; width: 50%;padding: 5px;">
						<table style="border-collapse: collapse;">
							<tr>
								<td class='familyDescTableParam'>Architecture:</td>
								<td class='familyDescTableValue'>$arch</td>
							</tr><tr>
								<td class='familyDescTableParam'>Frequencies:</td>
								<td class='familyDescTableValue'>$freq</td>
							</tr><tr>
								<td class='familyDescTableParam'>Technology:</td>
								<td class='familyDescTableValue'>$tech</td>
							</tr>
						 </table>
						</td>
					</tr>
				</table>
Endhtml
	}else{
		$text .= <<Endhtml;
				<span class='familyDescTableName'>$name Family<br /></span>
				<span class='familyDescTableParam'>family details unknown</span><br />
Endhtml
	}
		$text .= <<Endhtml;
				</div>
			<!--  </td></tr></table> -->
			<!-- Family caption for single chip (end) -->
			</td>
		</tr>
	</table>
Endhtml
	return $text;
}	

###########################################################
###########################################################
################    Intro Tables (end)  ###################
###########################################################
###########################################################





##################################
####### Main Page (start) ########
##################################

sub create_html_head {
	my $text='';
	# https://www.w3schools.com/css/css_font.asp
	my $meta_robots='';
	if( $script_url 	=~ 'testing') {
		$meta_testing	='	<meta name="robots" content="noindex">' . "\n";
		$meta_testing	.='	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />' . "\n";
		$meta_texting	.='	<meta http-equiv="Pragma" content="no-cache" />' . "\n";
		$meta_testing	.='	<meta http-equiv="Expires" content="0" />' . "\n";
	}

	my $title = "CPU Grave Yard";
   	if ($data{'page'} eq '') {
		$title = $title . " - Chip Collection";
		$meta = "";
	} elsif ($page_DNE_global eq 'TRUE') {
		$title = "$page_DNE_title_global  - $title";
		$meta = "";
	} else	{
		$title = "$title_ext_global - $title";
		$meta = "$keyword_ext_global";
	}
	# body {background-image: url(../grave.gif); background-repeat: no-repeat;opacity:0.4;filter:alpha(opacity=40)}

$text = <<Endhtml;
<!DOCTYPE html>
<html lang="en" xml:lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <base href="$script_url">
	<meta name="description" content="My CPU collection">
	<meta name="keywords" content="CPU, processor, MCU, microcontroller, cpu collection, $meta">

	<title>$title</title>

	<link rel="stylesheet" href="/files/theme/chips_theme.css">
	$meta_testing

	<!-- <link rel="canonical" href=""> -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->

	<!-- Social -->
    <!-- <meta property="og:url" content=""> -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="$title">
	<meta property="og:site_name" content="CPU Grave Yard">
	<meta property="og:description" content="My CPU collection, $meta">

</head>

<body>
<div style="float:right;" class="topChipCount">
$totalChipCountGlobal Chips<br />
updated<br />
$updateDate
</div><br />

<div class="title_box">
<div class="title">CPU Grave Yard</div>
<div class="title_sub">a processor collection</div><br />
</div>

<hr>
<div style="text-align: center; font-size:18px;">
<a href="$script_url">Home</a> -- 
<a href="$script_url/categories/">Categories</a> -- 	
<a href="$script_url/trade/">Trade List</a> --
<a href="$script_url/glossary/">Glossary</a> --
<a href="$script_url/boards/">Processor Boards</a> --
<a href="$script_url/sitemap/">Site Map</a> --
<a href="$contact_page">Contact Me</a>
</div>
<hr>
Endhtml
return $text;
}


sub create_html_body_pre {
my $text = '';
$text = <<Endhtml;
<!-- pagebody -->
<table id="body-id"><!-- summary="table body, aligning sidebar and maincontent areas" -->
<tr>
<td style="vertical-align: top; width: 190px;">
Endhtml
return $text;
}



# Creats the sidebar with family pulldown and manuf list
sub create_html_sidebar {
    my $text = '';
    my $x=0;
# $text = <<Endhtml;

# <!-- sidebar -->
	# <div>
        # <a href="families/">Sorted by Families</a>
		# <form name="family_form" action="$script_url/">
		# <input type="hidden" name="page" value="family" \>
		# <select name="family" style="width:180px;" onChange="family_form.submit()">
		# <option value="null" selected>--family--</option>
# Endhtml
	# foreach $fam (@familyListGlobal) {
		# if( $fam ne '' ){
			# $text .= "\t\t\t<option value=\"" . url_encode($fam) . "\">$fam</option>\n";
		# }
	# }
	# $text .= <<Endhtml;
		# </select>
		# </form>
		# <hr>
# Endhtml

    my $fam_url = $script_url . "/families/";
    $text = <<Endhtml;
<!-- sidebar -->
    <div>
        <a href="$fam_url">Sort by Families</a>
        <hr>
Endhtml


	foreach $manuf (sort keys %manufListCountGlobal) {
		
		# Shorten and correct some names
		if($manuf eq 'ATT'){
			$manuf_display = 'AT&T';
		}elsif( $manuf eq 'National Semiconductor' ){
			$manuf_display = 'National Semi';
		}elsif( $manuf eq 'STMicroelectronics' ){
			$manuf_display = 'STMirco';
		}else{
			$manuf_display = $manuf;
		}

		# Displays the currently selected manufacturer
		if ($manuf eq $data{'manufacturer'}) {
			$text .= "\t\t<span class=\"sidebarManufNameSelected\"><a href=\"$script_url/m/" . url_encode($manuf) . "\">$manuf_display</a>&nbsp;($manufListCountGlobal{$manuf})</span><br />\n";
			$text .= "\t<ul class=\"sidebarManufFamilyList\">\n";
			# &manufFamilyList; #no longer used
			
			for ($x=0;$x<=$#manufFamilyListGlobal;$x++) {
				$text .= "\t\t<li class=\"sidebarManufFamilyListElement\"><span class=\"manufFamilyListSelected\"><a href=\"$script_url/mf/" . url_encode($manuf) . "/" . url_encode($manufFamilyListGlobal[$x]) . "\">$manufFamilyListGlobal[$x]</a>";
				if ($manufFamilyListGlobal[$x] eq "All") {
					$text .= "</span></li>\n";
				} else {
					$text .= "&nbsp;($manufFamilyListCountGlobal[$x])</span></li>\n"; 
				}
			}
			$text .= "\t</ul>\t\n<hr />\n";

		}else{ #displays manufaturers if it is not the selected manufacturer
			# Make sure its not an Other
			if(not(@found = grep(/\b$manuf\b/,@manuf_others_list_global))){
				$unselectedCompanies= $unselectedCompanies .  "\t<div class=\"sidebarManufList\"><a href=\"$script_url/m/" . url_encode($manuf) . "\"><span class=\"sidebarManufName\">$manuf_display</span></a>&nbsp;<span class=\"sidebarManufCount\">($manufListCountGlobal{$manuf})</span></div>\n";
			}
		}
	}

	# displays the manuf as others that arnt worth having there own list
	my $others_count=0;
	foreach $other_manuf (@manuf_others_list_global){
		$others_count += $manufListCountGlobal{"$other_manuf"};
	}
	$unselectedCompanies= $unselectedCompanies .  "\t<div class=\"sidebarManufList\"><a href=\"$script_url/m/Others\"><span class=\"sidebarManufName\">Others</span></a>&nbsp;<span class=\"sidebarManufCount\">($others_count)</span></div>\n";
	$text .= $unselectedCompanies;
	$text .= "\t</div>\n";
	$text .= "\t<!-- sidebar (end) -->\n\n\n";

	return $text;
}


sub create_html_body_mid {
	my $text = '';
	$text = "  </td>\n  <td style=\"vertical-align: top; width: 650px; background-color: #333333; padding:0;\">\n";
	$text .= " <table style=\"width: 100%;\"><!-- summary=\"main content\" -->\n\t<tr>\n\t\t<td>\n";
	return $text;
}



sub create_html_videogame_page {

	my $text = '';

}



sub create_html_body_intro {
	my $text = '';
	my $type=$data{'page'};
	my $manuf=$data{'manufacturer'};
	my $family=$data{'family'};
	my $logo='', $desc='';
	#print "$type, $manuf, $family";

	$text .= "\t<!-- intro -->\n";
	if( $data{'page'} eq '404' || $page_DNE_global eq 'TRUE'){
		# no intro 
	}elsif ( $type eq '' ) { #initial page
		$text .= <<Endhtml;
		<h1 style="text-align: center;">CPU Grave Yard is my collection of CPU / MCU / SoC / FPU </h1>
		<div style="float: right; width: 150px; text-align: center;">
			<a href="$script_url/ic/MOS/MCS6501">
			<img style="width: 120px;" src="$relativeLoc/$photoLoc/sm/ic-photo-MOS--MCS6501--(6501-CPU).JPG_sm.jpg" alt="MOS MCS6501">
			<p>MOS 6501</p>
			</a>
		</div>
		<p>I currently have <b>$totalChipCountGlobal</b> chips in my collection. Allot of them are pretty common, but some are rare, and a few are extreamly rare.  Some of the really rare one are Intel <a href="$script_url/ic/Intel/MD3002_C">MD3002/C</a> and <a href="$script_url/ic/Intel/MC3003">MC3003/C</a>. The rarest one I own is the MOS <a href="$script_url/ic/MOS/MCS6501">MCS6501</a>.  By court order all of these chip where required to be destroyed.  There are less than 10 in existance. </p><br />
		<div style="float: left; width: 150px; text-align: center;">
			<a href="$script_url/ic/AMD/AM2901DC">
			<img style="width: 120px;" src="$relativeLoc/$photoLoc/sm/ic-photo-AMD--AM2901DC-(2900-ALU).png_sm.jpg" alt="AMD AM2901">
			<p>AMD AM2901</p>
			</a>
		</div>
<p>One of my favorite families is the AMD <a href="$script_url/family/AM2900">AM2900</a>.  It is a bitslice processor, meaning the prossesors components are split into multiple chips.  They also have the ability to be joined togetter to create a data-width as large as desired.</p><br />
<p>
	<table>
		<tr>
			<td colspan="2">
				<h2>My larger collections</h2>
			</td>
		</tr>
		<tr>
			<td style="width: 66px; text-align: center;">
				<img src="$relativeLoc/$logoLoc/ic_manuf_logo--AMD-Advanced_Micro_Dev.gif" alt="Advanced Micro Devices" height="32">
			</td>
			<td>
				<span style="font-size: 18px; font-family: Sans-serif;"><a href="?page=manufacturer&manufacturer=AMD">AMD</a> ($manufListCountGlobal{'AMD'})</span> 
			</td>
		</tr><tr>
			<td style="width: 66px; text-align: center;">
				<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Intel_Corp-2.gif" alt="Intel" height="32">
			</td>
			<td>
				<span style="font-size: 18px; font-family: Sans-serif;"><a href="?page=manufacturer&manufacturer=Intel">Intel</a> ($manufListCountGlobal{'Intel'})</span>
			</td>
		</tr><tr>
			<td style="width: 66px; text-align: center;">
				<img src="$relativeLoc/$logoLoc/ic_manuf_logo--Motorola_Semi_Products_inc.gif" alt="Motorola" height="32">
			</td>
			<td>
				<span style="font-size: 18px; font-family: Sans-serif;"><a href="?page=manufacturer&manufacturer=Motorola">Motorola</a> ($manufListCountGlobal{'Motorola'})</span>
			</td>
		</tr>
	</table>
	<table>
		<tbody>
			<tr>
				<td>
		<a href="$script_url/ic/DEC/21064_BB_A233">
		<img src="$relativeLoc/$photoLoc/sm/ic-photo-DEC--21-40532-03-(21064-BB)-(Alpha-AXP).png_sm.jpg" alt="DEC Alpha AXP" width="100">
		<p>DEC Alpha</p>
		</a>
				</td><td>
					<h2>Server Families</h2>
					<a href="family/SPARC">SPARC</a><br />
					<a href="family/PA-RISC">PA-RISC</a><br />
					<a href="family/PDP-11">DEC PDP</a><br />
					<a href="family/POWER">POWER</a><br />
				</td>
			</tr>
		</tbody>
	</table>
	<div>
		<div>
		</div>
	</div>
</p>

Endhtml
	} elsif ( $type eq 'manufacturer' ) { #Manufacturer pages
		if ( $data{'family'} eq '' ) {
			$text .= &create_html_intro_manuf($manuf);
		} elsif ( $data{'family'} eq "All" ) {
			$text .= "\t<h2>$manuf</h2>\n";
			$text .= "All families<br />\n";
		} elsif ( $data{'family'} eq "Other" ) {
			$text .= "\t<h2>$manuf</h2>\n";
			$text .= "Other families<br />\n";
		} else {
			$text .= &create_html_intro_family;
		}
		$text .= "\t<br />\n";
	} elsif ( $data{'page'} eq 'family' ) {
		if ( $data{'family'} ne 'Other' ) {	
			$text .= &create_html_intro_family; 
		}
	} elsif ( $type eq 'trade' ) {
		$text .= "Trade desc\n";
	} elsif ( $type eq 'chip' ) {
		$text .= &create_html_intro_single_chip;
	}
	$text .= "\t<!-- intro (end) -->\n";
	
	return $text;
}


sub create_html_body_main_content {
	my $text ='';

	$text .= "\t  </td>\n\t </tr>\n";
	$text .= "\t <tr>\n\t  <td><!-- main content page -->\n";
	
	if( $data{'page'} eq '404' || $page_DNE_global eq 'TRUE'){
		$text .= &create_html_body_404(); 
	}else{
		switch ($data{'page'}) {
			case "fullList"		{ $text .= &create_html_body_main_full_list; }
			case "tradeList"	{ $text .= &create_html_body_main_trade_list; }
			case "family"		{ $text .= &create_html_body_main_chip_list; }
			case "manufacturer"	{ $text .= &create_html_body_main_chip_list; }
			case "chip"			{ $text .= &create_html_body_main_single_chip; }
			case "sneezmale"	{ $text .= &create_html_body_main_contact; }
			case "site_map"		{ $text .= &create_html_body_main_site_map; }
			case "cat"			{ $text .= &create_html_body_main_category; }
			case "glossary"		{ $text .= &create_html_body_main_glossary; }
			
			case "board"		{ $text .= &create_html_body_main_cpu_boards; }
			case ""				{}	#{ &defaultContent; }
			else				{ 
				$page_DNE_global = 'TRUE';
				$text .= &create_html_body_404(); 
			}
		}
	}
	# chip lists
	$text .= "   </td><!-- main content page (end) -->\n  </tr>\n </table><!-- main content (end) -->\n";
	return $text;
}


sub create_html_body_end {
	my $text = '';
	$text = <<Endhtml;
  </td>
 </tr>
</table>
<!-- pagebody (end) -->
Endhtml
	return $text;
}


sub create_html_content_header {
	my $text='';

	# If page Does Not Exist then may it a 404 Error
	if ($page_DNE_global eq 'TRUE') {
		$text .= "Status: 404 Not Found\n";
	}
	# Makes sure the URL is the short one /chips? if its not redirect
	# if ( $scriptLoc eq 'cgi-bin/chipParse.pl' ) {
		# my $query = $ENV{'QUERY_STRING'};
		# if($query ne ''){ $query = '?' . $query; }
		# $text = "Location: https://happytrees.org/chips$query\n\n";
	# } else {
		$text .= "Content-type:text/html\n\n"; # starting right
	# }
	return $text;
}


sub create_html_tail {
	my $text='';
$text = <<Endhtml;
<br />
<hr>
<div class="tail">
	This page was created by <a href="/contact">ZyMOS the Tinker</a><br />
	Images and content are under <a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/us/">CC-BY-SA 3.0 license</a>, unless otherwise noted. The <a href="$code_loc">code</a> for this page is licenced under <a href="https://en.wikipedia.org/wiki/GPL_license">GPL</a><br />
	
</div>
</body>
</html>
Endhtml
	return $text;
}


##################################
####### Main Page (stop) #########
##################################


#########################################
########## HTML (end) ###################
#########################################








#########################################
########## Page Structure (start) #######
#########################################

sub create_html {
	# creates all the parts of the page
  # print "vvvvvvvvvvvvvvvvvvvvvv\n";
  # print Dumper $data;
  # print "vvvvvvvvvvvvvvvvvvvvvv\n";
	
  $title_ext_global = '';
	$keywords_ext_global = '';
	
	# Check to see if the page should exist
	&does_page_exist;
	
	# Header
	$page_html_content_header_global = &create_html_content_header;


	# Body
#	$page_html_body_global = &create_html_body;
	$page_html_body_pre_global = &create_html_body_pre;
	$page_html_sidebar_global = &create_html_sidebar;
	$page_html_body_mid_global = &create_html_body_mid;
	$page_html_body_intro_global = &create_html_body_intro;
	# 	--> create_html_intro_family
	# 	--> create_html_intro_manuf 
	# 	--> create_html_intro_single_chip
	$page_html_body_main_content_global = &create_html_body_main_content;
	# 	--> create_html_body_main_full_list
	# 	--> create_html_body_main_trade_list
	# 	--> create_html_body_main_chip_list
	# 		--> create_html_body_main_single_chip_table
	# 	--> create_html_body_main_contact
	# 	--> create_html_body_main_site_map
	# 	--> create_html_body_main_category
	# 	--> create_html_body_main_glossary
	# 	--> create_html_body_main_cpu_boards
	$page_html_body_end_global = &create_html_body_end;

	# Tail
	$page_html_tail_global = &create_html_tail;

	# Form the head last, to form better title and keywords
	$page_html_head_global = &create_html_head;	
}







#########################################
########## Page Structure (end) #########
#########################################

















##########################################################################################################
##########################################################################################################
## Generation html files (Section)
##




#################################################
#
#
sub print_html {
	# Prints all the parts of the page
	
	# Header
	print $page_html_content_header_global; #content-type|redrect|404
	print $page_html_head_global;		#html head

	#Body
	#print $page_html_body;
	print $page_html_body_pre_global;
	print $page_html_sidebar_global;
	print $page_html_body_mid_global;
	print $page_html_body_intro_global;
	print $page_html_body_main_content_global;
	print $page_html_body_end_global;
	# Tail
	print $page_html_tail_global;
}



##############################################
#
#
sub get_printed_html {
	# Prints all the parts of the page
	
  my $txt = '';
	# Header

  # print "////////////data//////////////////\n";
  # print Dumper %data;
  # print "//////////////////////////////\n";

	$txt .= $page_html_content_header_global; #content-type|redrect|404
	$txt .=$page_html_head_global;		#html head

	#Body
	#$txt .=$page_html_body;
	$txt .=$page_html_body_pre_global;
	$txt .=$page_html_sidebar_global;
	$txt .=$page_html_body_mid_global;
	$txt .=$page_html_body_intro_global;
	$txt .=$page_html_body_main_content_global;
	$txt .=$page_html_body_end_global;
	# Tail
	$txt .=$page_html_tail_global;

  return $txt;
}




##########################
# 
sub set_query_vars{
  # sets the variables used in for web query vars



  # my %info = $_; # pass the hashref to local hash
  # print $_[0]{'page'} . '1xcxcx\n';
  # print $_{'page'} .    '2xcxcx\n';
  # print $$_{'page'} .   '3xcxcx\n';
  # print @$_{'page'} .   '4xcxcx\n';
  # print $info{'page'} . '5xcxcx\n';
  # print $info{'page'} . '6xcxcx\n';
  # print $info{'page'} . '7xcxcx\n';
  # print "----------set_query_vars info----------\n";
  # print Dumper $_[0];
  # print "+++++++++++++++++++++++++++++++++++++++\n";
  #
  %data = ( page => $_[0]{'page'},
			name => $_[0]{'name'},
			type => $_[0]{'type'},
			manuf => $_[0]{'manuf'},
			manufacture => $_[0]{'manufacture'},
			family => $_[0]{'family'},
			cat => $_[0]{'cat'},
			category => $_[0]{'category'},
			part => $_[0]{'part'} );

  # print "----------set_query_vars [data]----------\n";
  # print Dumper \%data;
  # print "+++++++++++++++++++++++++++++++++++++++\n";
  return %data;
}







############################
# Save html to file
#
sub html_to_file{
  my $html = $_[0];
  my $filename = $_[1];

  # print "filename = $filename \n";
  #
  # if ($html ne ''){
  #   print "html exists\n";
  # }else{
  #   print "html not set \n"
  # }

  # make dirs if needed: get list of directories
  @dirs = split('/', $filename);
  my $dir_inc = '';
  foreach $dir (@dirs){
    # create the full incremental dir
    if ($dir_inc eq ''){ $dir_inc = $dir; }else{ $dir_inc = $dir_inc . '/' . $dir; }
    # make dir in needed
    if($dir ne 'index.html'){
      mkdir $dir_inc unless -d $dir_inc;
      print ">making directory: $dir_inc\n";
    }
  }

  # print Dumper \@dirs;

  # Write file
  open my $fileHandle, ">", $filename or die "Can't open: $filename\n";
  print ">writing file: $filename\n";
  print $fileHandle $html;
  close $fileHandle;

}







##########################################################
# Extract page content
#
sub extract_pages_content{
  
  # print Dumper \@_;

  my @p_info = @_; # for some reason its is an array of arrays so use [0] for first array 
 
  # print "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm\n";
  # print Dumper \@p_info;
  # print "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\n";
  # print  $p_info[0][1]{'page_varables'}{'page'};
  # print "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\n";
  # print "...........data extract...\n";
  # print Dumper %data;
  # print "..........................\n";
  #
  # my @p_contents;

  $x = 0;
  foreach my $a (@p_info){ # not sure why there is a extra single surrounding array
    @ar = @{$a};
    print " > page entries: " . $#ar . "\n";
    foreach my $page_info (@{$a}){ # array of pages
      # print "######################################## LOOP ##########################################";
      # print "---extract loop [page_info]----------\n";
      # # print ref($page_info{'page_varables'});
      # print Dumper $$page_info{'page_varables'};
      print "--------------------------------------------------------\n";

      # %data = $$page_info{'page_varables'};

      # get the query params from page_info, and set to data var
      # %data = set_query_vars($$page_info{'page_varables'});
      %$data = ();
      %data = {  
        page => 'manufacturer',
	  		manufacture => 'AMD'
      };

      # $data{'category'} = 'fullList' ;
      # print "xxxxxxxxxxxxxxxxxxxxxxxxxxxx\n";
      # print ref(%data);
      # print Dumper $$page_info{'page_varables'};
      # print "...........data loop...\n";
      # print Dumper \%data;
      # print "..........................\n";

      # Create the parts of the page
      # generate all html from subroutines
      create_html();

      # Get full html for pagee
      my $pages_html = get_printed_html();

      # Save html to file
      my $filename = $$page_info{'file_location'};
      html_to_file($pages_html, $filename);

    }
  }
  

  return @pages_contents;
}
# extract_pages_content (END)





##################################
# Get manuf family list
#
sub get_manuf_fam_list{

  my %man_fam;

  my $row = $skipLines;
  # Loop all chips
	while (&chipData2($row,$colPart) ne '') {
		foreach my $manuf (@manufListGlobal){
      if ($manuf eq chipData2($row,$colManuf)){
        # Check all manuf
        foreach my $fam (@familyListGlobal){
          if ($fam eq chipData2($row,$colFamily)){
            # set all manuf's family
            #   will set multiple times, but doesn;t mater
            $man_fam{$manuf}{$fam} = 1;
          }
        }
      }
    }
    $row++;
	}

  # print Dumper \%man_fam;
  return %man_fam;
}




##########################################################
# Create all the pages
sub create_page_list{
  # This creates a list of all pages and the query vars to get them


			# case 'categories'{		$query_out{'page'} = 'cat'; }
			# case 'families'	{ 	$query_out{'page'} = 'cat';
			#           $query_out{'type'} = 'family'; }
			# case 'manufacturers'{	$query_out{'page'} = 'cat';
			#             $query_out{'type'} = 'manuf'; }
			# case 'architecture'{$query_out{'page'} = 'cat';
			#           $query_out{'type'} = 'arch'; }
			# case 'data_width'{		$query_out{'page'} = 'cat';
			#             $query_out{'type'} = 'data_width'; }
			# case 'chip_types'	{ 	$query_out{'page'} = 'cat';
			#           $query_out{'type'} = 'type'; }
			# case 'ISA'{				$query_out{'page'} = 'cat';
			#             $query_out{'type'} = 'isa'; }
			# case 'technologies'{$query_out{'page'} = 'cat';
			#           $query_out{'type'} = 'tech'; }
			# case 'release_date'{		$query_out{'page'} = 'cat';
			#             $query_out{'type'} = 'date'; }
			# case 'logos'	{	$query_out{'page'} = 'cat';
			#             $query_out{'type'} = 'logo'; }
			# case 'applications'{$query_out{'page'} = 'cat';
			#           $query_out{'type'} = 'app'; }
			# case 'boards'	{ 		$query_out{'page'} = 'board'; }
			# case 'board'    { 	$query_out{'page'} = "board";
			#           $query_out{'manuf'} = $value[1];
			#           $query_out{'name'} = $value[2]; }
			# case 'module_boards'{	$query_out{'page'} = 'board';
			#             $query_out{'type'} = 'module'; }
			# case 'evaluation_boards'{	$query_out{'page'} = 'board';
			#               $query_out{'type'} = 'eval'; }
			# case 'ic'{		$query_out{'page'} = "chip";
			#         $query_out{'manufacturer'} = $value[1];
			#         $query_out{'part'} = $value[2]; }
			# case 'full_list'{	$query_out{'page'} = 'fullList'; }
			# case 'trade'	{ 		$query_out{'page'} = 'tradeList'; }
			# case 'glossary'	{ 	$query_out{'page'} = 'glossary'; }
			# case 'sitemap'  { 		$query_out{'page'} = 'site_map'; }
			# case 'm'  		{ 	$query_out{'page'} = "manufacturer";
			#           $query_out{'manufacturer'} = "$value[1]"; }
			# case 'mf'		{		$query_out{'page'} = "manufacturer";
			#             $query_out{'manufacturer'} = "$value[1]";
			#             $query_out{'family'} = "$value[2]";}
			# case 'family'	{	$query_out{'page'} = "family";
			#           $query_out{'family'} = "$value[1]";}
			# case '404'		{	$query_out{'page'} = "404";	}
      #


  # array $pages_to_create[0] = (
  #   'page_varables' => (
  #       'page' => 'cat',
  #       'category' => 'arch'
  #   ),
  #   file_location = 'chips/architecture/index.html'
  # )
  #
  my @file_locations;
  my @page_varables;
  my @pages_to_get = ();
    my $webpage_root = 'generated_pages';

  # Home
  push @pages_to_get, { page_varables => { page => "" },
                        file_location => "$webpage_root/chips/index.html" };


  #
  # # Page types
  # $pages = ["fullList", "tradeList", "family", "manufacturer", "chip", "site_map", "cat", "glossary", "board", "404"];
  # # chip, cat,
  push @pages_to_get, { page_varables =>     { page => "fullList" },
                        file_location => "$webpage_root/chips/full_list/index.html" };
  push @pages_to_get, { page_varables =>   { page => "tradeList" },
                        file_location => "$webpage_root/chips/trade/index.html" };
  # push @pages_to_get, { page_varables =>  { page => "cat", "category" => "manufacturers" },
  #                       file_location => "$webpage_root/chips/manufacturers/index.html" };
  # push @pages_to_get, { page_varables =>  { page => "cat", "category" => "families" },
                        # file_location => "$webpage_root/chips/families/index.html" };
  push @pages_to_get, { page_varables => { page => "site_map" }, 
                        file_location => "$webpage_root/chips/sitemap/index.html" };
  push @pages_to_get, { page_varables => { page => "glossary" }, 
                        file_location => "$webpage_root/chips/glossary/index.html" };

  # #/
  #
  # # Organized by...
  # #  $page = "cat";
  # #   $categories = ["family", "manuf", "arch", "data_width", "type", "isa", "tech", "date", "logo", "app"];
  # # foreach $cat (@categories){
  # #   push @page_varables, ("page" => "cat", "category" => $cat);
  # #   push @file_locations,
  # # }
  push @pages_to_get, { page_varables => { page => "cat", type => "family" },
                        file_location => "$webpage_root/chips/families/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "manuf" },
                        file_location => "$webpage_root/chips/manufacturers/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "arch" },
                        file_location => "$webpage_root/chips/architecture/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "data_width" },
                        file_location => "$webpage_root/chips/data_width/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "type" },
                        file_location => "$webpage_root/chips/chip_types/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "isa" },
                        file_location => "$webpage_root/chips/ISA/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "tech" },
                        file_location => "$webpage_root/chips/technologies/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "date" },
                        file_location => "$webpage_root/chips/release_date/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "logo" },
                        file_location => "$webpage_root/chips/logos/index.html" };
  push @pages_to_get, { page_varables => { page => "cat", type => "app" },
                        file_location => "$webpage_root/chips/applications/index.html" };
  #
  #
  # # Manufacture Pages (m)
  # #   $page = "manufacturer";
  # #   $manufacturer =
	# # @manufListGlobal
  # print Dumper \@manufListGlobal;
  foreach $manuf (@manufListGlobal){
     push @pages_to_get, { page_varables => { page => "manufacturer", manufacturer=> $manuf },
                        file_location => "$webpage_root/chips/m/$manuf/index.html" };
  }

  #
  #
  #
  # # Manufacture Family Pages (mf)
  # #   $page = "manufacturer";
	# #   $manufacturer =
	# #   $family =
  # @manufFamilyListGlobal
  
  # make a manuf family list in keys
  my %man_fam = get_manuf_fam_list();
  #manuf
  foreach my $manuf (keys %man_fam){
    foreach my $fam (keys %{ $man_fam{$manuf} }){
      push @pages_to_get, { page_varables => { page => "manufacturer", manufacturer => $manuf, family => $fam },
                        file_location => "$webpage_root/chips/mf/$manuf/$fam/index.html" };
      # print " --> $manuf - $fam\n";
    }
  }

  #
  #
  #
  # # Single IC Pages (ic)
  # #   $page = "chip";
	# #   $manufacturer =
	# #   $part =
  #
  #
  #
  # # Family Pages
  # #   $page = "family";
	# #   $family =
  # # @familyListGlobal
    foreach $family (@familyListGlobal){
      push @pages_to_get, { page_varables => { page => "family", family => $family },
                        file_location => "$webpage_root/chips/family/$family/index.html" };
  }

  # Board pages (module and eval pages)
  # #   $page = "board";
  # #   $type = ("eval", "module");
  push @pages_to_get, { page_varables => { page => "board" },
                        file_location => "$webpage_root/chips/module_boards/index.html" };
  push @pages_to_get, { page_varables => { page => "board", type => "module" },
                        file_location => "$webpage_root/chips/module_boards/index.html" };
  push @pages_to_get, { page_varables => { page => "board", type => "eval" },
                        file_location => "$webpage_root/chips/evaluation_boards/index.html" };
  #
  #
  # Individual board pages
  #   $page = "board";
  #   $manuf =
  #   $name = 




  # print Dumper \@pages_to_get;

  return (@pages_to_get)
}












##################################################
########## Main code #############################
##################################################

#===Global Vars===#
# List of Manuf		=	@manuf						(string)
# List of families	=	@family						(string)
# chip info			=	&chipData2(chipNum,colNum)	(string)
#
# input manuf		=	$data{'manufacturer'}			(string)
#  manuf ID #		=	$selectedManufIDglobal						(int)
# input family		=	$data{'family'}					(string)
# 	family ID #		=	
# input page type	=	$data{'page'}					(string
#
# manuf families 	=	@manufFamUnique					(string)
# manuf chip cnt	=	$manufCount[$selectedManufIDglobal]			(int)
# manuf fam chip cnt=	$familyCount[$selectedManufIDglobal][family]	(int)


#===Page organization===
#
# Main page
#	&pageHead
#	&pagebody
#	&pageTail
#
#	pageBody ->
#		&sidebar
#		&maincontent
#
#	sidebar ->
#		&manufFamilyList
#
# 	maincontent ->
#  		&intro
#  		options->
#			&fullList
#			&tradeList
#			&familyList
#			&manuList
#
#	intro ->
#		&displayTableManuf2
#		&displayTableFamily
#
#	manufList ->
#		foreach(chip)
#			 &displayTableData
# 
#
use Time::HiRes qw/ time sleep /;
my $start = time;
	
#Initialize
our %data;
# $data{'butt'} = 'poop';
# $data{'page'} = 'a';
# $data{'type'} = '';
# $data{'manuf'} = '';
# $data{'name'} = '';
# $data{'manufacturer'} = '';
# $data{'part'} = '';
# $data{'family'} = '';




$updateDate = '';
@updateDateA = ();

#Initialize Global Varables
$page_DNE_global = 'FALSE';
$title_ext_global = '';
$keywords_ext_global = '';
$page_html_content_header_global = '';
$page_html_body_global = '';
$page_html_body_pre_global = '';
$page_html_sidebar_global = '';
$page_html_body_mid_global = '';
$page_html_body_intro_global = '';
$page_html_body_main_content_global = '';
$page_html_body_end_global = '';
$page_html_tail_global = '';
$page_html_head_global = '';
$page_DNE_title_global = '';
$page_DNE_header2_global = '';


# Gets input args NO LONGER USED
#%data = &read_input; #get input



# Gets spreadsheet's last edit date
$spreadsheetFileName = $include_files_root . '/' . $chip_spreadsheet_file;
$updateDate = ''; # ctime(stat($spreadsheetFileName)->mtime);
@updateDateA = split(/ /,$updateDate);
if ( $updateDateA[4] =~ /:/ ) {
	$updateDate = $updateDateA[1] . " " . $updateDateA[3] . ", " . $updateDateA[5]; 
} else {
	$updateDate = $updateDateA[1] . " " . $updateDateA[2] . ", " . $updateDateA[4]; 
}

# Gets the scripts location -> $scriptLoc
# &check_script_location; # no longer used
# foreach (keys %ENV){ print "$_ -> $ENV{$_}<br>"; }


# Load spreadsheet data
@spreadsheetData = &parse_ods($spreadsheetFileName);

# Load a file listing the order families should be listed
$familyErasOrderedFileName = $include_files_root . '/' . $family_order_file;
@chipErasGlobal = &openFile($familyErasOrderedFileName);
chomp(@chipErasGlobal);
# foreach $chipEra (@chipErasGlobal) {print "$chipEra, ";}

# Gets the column numbers for each of the chip parameters
&getColLabels;
&getColChipData;


&grapGlobals;

$wiki_attrib = "<img src=\"$relativeLoc/$imageLoc/share/wiki_super_script2.gif\" alt=\"wiki\" style=\"position: relative; right: 3px; border-width: 0;\">";

# %result = &sort_family_by('data-width'); 

# I moved large amounts of html/txt 3000+ lines to a seperate file
#
# for $file ( $script_files_root . '/' . $extended_code_include_file)
# {
#   unless ($return = do $file) {
#       print "Content-type:text/html\n\n";
#             warn "couldn't parse $file: $@" if $@;
#             warn "couldn't do $file: $!"    unless defined $return;
#             warn "couldn't run $file"       unless $return;
#       exit;
#         }
# }
do './' . $extended_code_include_file;


@pages_infoG = create_page_list();
print Dumper \@pages_infoG;
@pages_content = extract_pages_content(\@pages_infoG);
# &main_page; # display page

# Create the parts of the page
# &create_html;
# my $end   = time;
# if( $DEBUG ){print '\n<br />Page proccessing time: ', ( $end - $start ) , "<br />\n";}


# Prints out the page
# &print_html;

######## Main code (end) ###############
print "\n";
