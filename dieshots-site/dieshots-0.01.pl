#!/usr/bin/perl 


########################################################
# 	This file creates the CPU Graveyard's website (Dieshots
#
# 	Feel free to used it for your site, in whole or any pieces, 
# 	in acordance with GPL. IE give me credit. See below. If you do
# 	use the entire code for ur collections page, please use a
# 	different color scheme and title so it will be distiguishable
# 	from 'the CPU Graveyard'.  Much of the text has been moved 
# 	to 'chip_html_include.pl', so the file isn't as large, easier
#	to work with.
#
# 	Copyright 2008-2020, Zef the Tinker, http://www.happytrees.org
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
#	see <http://www.gnu.org/licenses/>
#
#
# Requires:
# 	Archive::Zip
#	use URI::Encode;
#		Ubuntu: liburi-encode-perl
#	URL::Find
#		liburi-find-perl
#	jquery
#		http://code.jquery.com/jquery-latest.min.js
#	lightGallery
#		https://github.com/sachinchoolur/lightgallery.js
#
#https://developer.yahoo.com/performance/rules.html
# todo 
#
#
#
#	fix highres link
#
#	make Author instead of just license
#	
#	add photo page
#	make home and about the same
#	family dropdown not working
#	manuf with less than X show all
#	rotate imaged to match others in fam
#	tail, better wording
#	sitemap gives error
#	add 'Unknown' manufacture
#
#	create family tree
#
#	wiki link http://happytrees.org/dieshots/m/AMD
#
#  permisions/usage/DMCA page?
#
#  make responsive
#
#  search
#
#	image size
#
##	manuf/family/part with slash fails, [/+&
# Special chars
#  http://happytrees.org/dieshots/mf/IBM/BlueGene/L fail
#  http://happytrees.org/dieshots/mf/IBM/z12?
#  http://happytrees.org/dieshots/mf/GeneralPlus/%C3%8E%C2%BC%C3%A2%C2%80%C2%99nSP
# last image doent show
# http://happytrees.org/testing/mf/GeneralPlus/All
#
#	 maybe join MOS/CBM/...
#
#  http://happytrees.org/dieshots/mf/CBM/6502
#  6502 is listed twice
#
#  optimize background image
#
#  sidebar width broki
#
#  (All) to show manuf details
#
#  family links to family page
#  type links to type page
#
#http://happytrees.org/testing/m/VLSI - i/o
#http://happytrees.org/testing/m/Lucent - network
# http://happytrees.org/testing/m/Broadcom - network
#  Broadcom - BCM1103 shown twice
#
#
#
#http://happytrees.org/testing/m/Sharp
#image missing
#
#
#
#http://happytrees.org/testing/m/GeneralPlus
#image missing




# use warnings; 
use File::stat;
use Time::localtime;
use Switch;
use Archive::Zip;
use URI::Encode qw(uri_encode uri_decode);
# use Spreadsheet::Read;
use URI::Find;
use Data::Dumper;

#############################
# Config
#

$version		= 'v0.01';

# Enable debug output
$DEBUG = 1;

$scriptName 	= $ENV{'SCRIPT_NAME'};
$serverName 	= $ENV{'SERVER_NAME'};

$script_url = "http://happytrees.org/testing"; # previously $scriptName 
# $script_files_root = "/var/www/happytrees.org/cgi-bin/cpu/";


# all binaries are in files root
# $include_files_root = "/var/www/happytrees.org/htdocs/files/chips/";
$dieshots_include_files_root = "/var/www/happytrees.org/htdocs/files/dieshots/";
$chip_spreadsheet_file = "dieshot_db.ods"; # previously$spreadsheetFileName 
$family_order_file =  'familyErasOrdered.txt'; # previously $familyErasOrderedFileName 
# $extended_code_include_file = 'chip_html_include-v2.pl';

$contact_page = "http://happytrees.org/contact";

# $imageLoc	= 'main-images';
$photoLoc 	= 'files/dieshots/images/';
# $thumbLoc 	= 'files/dieshots/thumbs';
# $board_loc 	= 'main-images/boards-v1';
# $board_thumb_loc= 'main-images/boards-v1/sm';
$code_loc = 'http://www.happytrees.org/cgi-bin/chipParse-source.pl';

$logoLoc 	= 'main-images/ic-manuf-logos';
# $datasheet_loc = 'files/chips/datasheets';

$skipLines 	= 1;

$chip_page_number = 0;
$manuf_page_number = 1;
$family_page_number = 2;
$board_page_number = 3;
$varient_page_number = 4;

$relativeLoc = ''; # not really but makes it root instead of relative

@manuf_others_list_global = ('');



######################################################
############## Coding ################################
######################################################


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
		# @value = split('\/', $FORM{'var'});
		$buffer =~ s/var=//;
		$buffer =~ s/&$//;
		@value = split('\/', url_encode($buffer));
	
		$query_out{'values'} = "$ENV{'QUERY_STRING'} :::: 0={" . $value[0] . "}, 1=" . $value[1] . ",2=" . $value[2] . ",3=" . $value[3] . "\n<br />";

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
								$query_out{'manufacturer'} = url_decode($value[1]); }
			case 'mf'		{		$query_out{'page'} = "manufacturer";
									$query_out{'manufacturer'} = url_decode($value[1]);
									$query_out{'family'} = url_decode($value[2]);}
			case 'family'	{	$query_out{'page'} = "family";
								$query_out{'family'} = url_decode($value[1]);}
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

		

		$query_out{'values'} .= "manuf ::: $query_out{'manufacturer'}\n";
		



		return %query_out
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
	
    # my $theURL = $_[0];
   # $theURL =~ s/([\W])/"%" . uc(sprintf("%2.2x",ord($1)))/eg;
   # return $theURL;

	my ($rv) = @_;
	# $rv =~ s/([^A-Za-z0-9])/sprintf("%%%2.2X", ord($1))/ge;
	# $rv =~ s/\//-_and_-/g;
	# $rv = uri_encode($rv);
	# $rv =~ s/\&amp;/%26/g;
	return $rv;
}



sub url_decode {

	# my $theURL = $_[0];
	# $theURL =~ tr/+/ /;
	# $theURL =~ s/%([a-fA-F0-9]{2,2})/chr(hex($1))/eg;
    # $theURL =~ s/<!--(.|\n)*-->//g;
    # return $theURL;
	my ($rv) = @_;
	# my ($rv) = uri_decode($rv);
	# $rv = "c";
	# $rv =~ s/-_and_-/\//g;
	# $rv =~ s/-_and_-/\&/g;
	# $rv =~ s/\+/ /g;
	# $rv =~ s/%(..)/pack("c",hex($1))/ge;
	return $rv;
}





########################################################
################# Processing Data ######################


sub getColLabels {
	my $col=0;
	while ( &chipData2(0,$col) ) {
		# print &chipData2(1,$col) . ", ";
		switch (&chipData2(0,$col)) {
			case "Manufacturer" {$colManuf	=$col}
			case "Part" 	{$colPart	=$col}
			case "Type" 	{$colType	=$col}
			case "Family" 	{$colFamily	=$col}
			case "Core/Codename/Microarchitecture" 	{$colCore	=$col}
			case "Die Size" {$colDie_size	=$col}
			case "Photo (die)" 	{$colPhoto_die	=$col}
			case "License (die)" 	{$colPhoto_die_license	=$col}
			case "Link (die)" 	{$colPhoto_die_link	=$col}
			case "High Res (die)" 	{$colPhoto_die_high_res_link	=$col}
			case "Floorplan image" 	{$colPhoto_floorplan	=$col}
			case "License (floorplan)" 	{$colPhoto_floorplan_license	=$col}
			case "Link (floorplan)" 	{$colPhoto_floorplan_link	=$col}
			case "High Res (floorplan)" {$colPhoto_floorplan_high_res_link=$col}
			case "Notes" 	{$colNotes	=$col}
			case "# Cores"	{$col_num_cores	=$col}
			# case ""	{$col_ = $col}
			case "Sub-Family"	{$colSubFamily	=$col}
			case "Description"	{$colDesc	=$col}

			else {}
		}
		$col++;
	}
	$col=0;
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
	$col=0;
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
}

sub getColChipData {
	my $row=$skipLines;
	my @manufList = ();
	my @familyList = ();
	@manufListGlobal = ();
	@familyListGlobal = ();

	while (!(&chipData2($row,$colPart) eq '' && &chipData2($row,$colManuf) eq '' && &chipData2($row,$colFamily) eq '' && &chipData2($row,$colPhoto_die) eq '' && &chipData2($row,$colPhoto_floorplan) eq '')) {
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
	my $url='http://en.wikipedia.org/wiki/';

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
		$text .= "404 false page";
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


	$manuf_query = $data{'manufacturer'}; #change to urlencode in fut??
	$family_query = $data{'family'}; #change to urlencode in future??
	$part_query = $data{'part'}; #change to urlencode in future??
	

	# if($DEBUG){
		# $alert_global .= "boop" . &chipData2(1,$colPart) . &chipData2(2,$colPart) . &chipData2(3,$colPart) . &chipData2(4,$colPart) . &chipData2(5,$colPart) ;
	# }

	my $manuf, $family, $part, $manuf_query, $family_query, $part_query;
	# parse through list to see if query matchs actuall chips
	while (!(&chipData2($x,$colPart) eq '' && &chipData2($x,$colManuf) eq '' && &chipData2($x,$colFamily) eq '' && &chipData2($x,$colPhoto_die) eq '' && &chipData2($x,$colPhoto_floorplan) eq '')) { # searches throught list for chip/fam/man match
		# if($DEBUG){
			# $alert_global .= "!" . &chipData2($x,$colFamily) . "!($family_query)";
	# }

		$manuf = &chipData2($x,$colManuf);#change urlencode ??
		$family = &chipData2($x,$colFamily); #change to urlencode in future??
		$part = &chipData2($x,$colPart); #change to urlencode in future??
		

		# print "$page_found -> $manuf <> $family <> $part <br>\n";
		#

		# Chip page
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

		# manufacturer is Others
		# If the Manufacturer is others its ok
		if($data{'page'} eq "manufacturer" && $manuf_query eq 'Others'){
			$page_found = 1;
			return;
		}

		# manufacturer's family page is Other
		# If the Manufacturer is others its ok
		if($data{'page'} eq "manufacturer" && $family_query eq 'Other'){
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
			$page_found .= 1;
			return;
		}

		# Does the Family exist?
		if($data{'page'} eq "family" && $family_query eq $family){
			$page_found = 1;
			return;
		}	
		$x++;
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




# Generates links for license & licensee
sub get_license_attr_text {
	my $license_info = $_[0];

	my ($license, $lic_name, $lic_link) = split(/, /, $license_info);
	my $link;

	# Create a linked license
	if($license eq "CC-BY-SA-1.0" || $license eq "CC BY-SA 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-sa/1.0/">CC BY-SA-1.0</a>';
	} elsif($license eq "CC-BY-1.0" || $license eq "CC BY 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by/1.0/">CC BY-1.0</a>';
	} elsif($license eq "CC-BY-NC-1.0" || $license eq "CC BY-NC 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc/1.0/">CC BY-NC-1.0</a>';
	} elsif($license eq "CC-BY-NC-SA-1.0" || $license eq "CC BY-NC-SA 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-sa/1.0/">CC BY-NC-SA-1.0</a>';
	} elsif($license eq "CC-BY-ND-1.0" || $license eq "CC BY-ND 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nd/1.0/">CC BY-ND-1.0</a>';
	} elsif($license eq "CC-BY-NC-ND-1.0" || $license eq "CC BY-NC-ND 1.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-nd/1.0/">CC BY-NC-ND-1.0</a>';
	} elsif($license eq "CC-BY-SA-2.0" || $license eq "CC BY-SA 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC BY-SA-2.0</a>';
	} elsif($license eq "CC-BY-2.0" || $license eq "CC BY 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by/2.0/">CC BY-2.0</a>';
	} elsif($license eq "CC-BY-NC-2.0" || $license eq "CC BY-NC 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc/2.0/">CC BY-NC-2.0</a>';
	} elsif($license eq "CC-BY-NC-SA-2.0" || $license eq "CC BY-NC-SA 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-sa/2.0/">CC BY-NC-SA-2.0</a>';
	} elsif($license eq "CC-BY-ND-2.0" || $license eq "CC BY-ND 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nd/2.0/">CC BY-ND-2.0</a>';
	} elsif($license eq "CC-BY-NC-ND-2.0" || $license eq "CC BY-NC-ND 2.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-nd/2.0/">CC BY-NC-ND-2.0</a>';
	} elsif($license eq "CC-BY-SA-3.0" || $license eq "CC BY-SA 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA-3.0</a>';
	} elsif($license eq "CC-BY-3.0" || $license eq "CC BY 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by/3.0/">CC BY-3.0</a>';
	} elsif($license eq "CC-BY-NC-3.0" || $license eq "CC BY-NC 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc/3.0/">CC BY-NC-3.0</a>';
	} elsif($license eq "CC-BY-NC-SA-3.0" || $license eq "CC BY-NC-SA 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">CC BY-NC-SA-3.0</a>';
	} elsif($license eq "CC-BY-ND-3.0" || $license eq "CC BY-ND 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nd/3.0/">CC BY-ND-3.0</a>';
	} elsif($license eq "CC-BY-NC-ND-3.0" || $license eq "CC BY-NC-ND 3.0") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-nd/3.0/">CC BY-NC-ND-3.0</a>';
	} elsif($license eq "CC-BY-SA-4.0" || $license eq "CC BY-SA 4.0" || $license eq "CC-BY-SA" || $license eq "CC BY-SA") {
		$link = '<a href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA-4.0</a>';
	} elsif($license eq "CC-BY-4.0" || $license eq "CC BY 4.0" || $license eq "CC-BY" || $license eq "CC BY") {
		$link = '<a href="https://creativecommons.org/licenses/by/4.0/">CC BY-4.0</a>';
	} elsif($license eq "CC-BY-NC-4.0" || $license eq "CC BY-NC 4.0" || $license eq "CC-BY-NC" || $license eq "CC BY-NC") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc/4.0/">CC BY-NC-4.0</a>';
	} elsif($license eq "CC-BY-NC-SA-4.0" || $license eq "CC BY-NC-SA 4.0" || $license eq "CC-BY-NC-SA" || $license eq "CC BY-NC-SA") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-sa/4.0/">CC BY-NC-SA-4.0</a>';
	} elsif($license eq "CC-BY-ND-4.0" || $license eq "CC BY-ND 4.0" || $license eq "CC-BY-ND" || $license eq "CC BY-ND") {
		$link = '<a href="https://creativecommons.org/licenses/by-nd/4.0/">CC BY-ND-4.0</a>';
	} elsif($license eq "CC-BY-NC-ND-4.0" || $license eq "CC BY-NC-ND 4.0" || $license eq "CC-BY-NC-ND" || $license eq "CC BY-NC-ND") {
		$link = '<a href="https://creativecommons.org/licenses/by-nc-nd/4.0/">CC BY-NC-ND-4.0</a>';
	} elsif($license eq "CC0-1.0" || $license eq "CC0 1.0" || $license eq "CC0" || $license eq "PD") {
		$link = '<a href="https://creativecommons.org/publicdomain/zero/1.0/">PD</a>';
	}else{
		# not sure so just copying without link
		$link = $license;
	}

	# $license_info ($license, $lic_name, $lic_link)
	
	# check for the licensee
	if($lic_name ne ''){
		# checks if there is a link
		if ( $lic_link ne '' ){
			my $link_found;
			my $finder = URI::Find->new(sub {
				$link_found = shift;
			});
			$finder->find(\$lic_link);
			# link is found
			if($link_found ne ''){
				$licensee = "<a href=\"$link_found\">$lic_name</a>";
			}else{
				$licensee = $lic_name;
			}
		}else{
			# no licensee link
			$licensee = "$lic_name";
		}
		# $link = "((($license_info ($license: $lic_name: $lic_link) )))
# link $link, licensee $licensee";
		# licensee exists, joins with license
		$link = "$link, $licensee";
	}

	# returns a linked license, and linked licensee (if links exists)
	return $link;
}




sub get_image_links{
	my $image_link = $_[0];
	my $high_res_link = $_[1];

	my $image_thumb_file = $image_link;
	my $image_small_file = $image_link;
	my $image_med_file = $image_link ;
	my $image_large_file = $image_link;

	$image_thumb_file =~ s/(.*)\.(...)$/$1-thumb.$2/;
	$image_small_file =~ s/(.*)\.(...)$/$1-small.$2/;
	$image_med_file =~ s/(.*)\.(...)$/$1-med.$2/;
	$image_large_file =~ s/(.*)\.(...)$/$1-large.$2/;


	$image_thumb = $dieshots_include_files_root . "images/thumbs/" . $image_thumb_file;
	$image_small = $dieshots_include_files_root . "images/small/" . $image_small_file;
	$image_med = $dieshots_include_files_root . "images/medium/" . $image_med_file;
	$image_large = $dieshots_include_files_root . "images/large/" . $image_large_file;

	# if($DEBUG){
		# $alert_global .= <<EndHTML;

		# ************************<br/>
		# $image_link<br/>
 # <br/>
	# $image_thumb_file <br/>
	# $image_small_file  <br/>
	# $image_med_file  <br/>
	# $image_large_file 
 # <br/>
	# $image_thumb  <br/>
	# $image_small  <br/>
	# $image_med  <br/>
	# $image_large  <br/>
	# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%<br/>
# EndHTML
	# }

	# my $text='';

	# $photoLoc
	# if ( $high_res_link ne "" ){ 
		# $text .= "(<a href=\"$high_res_link\">High Res</a>) ";
	# }
	# if (-e $image_large) {
		# $text .= "(<a href=\"$relativeLoc/$photoLoc/large/$image_large_file\">Large</a>) ";
	# }
	# if (-e $image_med) {
		# $text .= "(<a href=\"$relativeLoc/$photoLoc/medium/$image_med_file\">Medium</a>) ";
	# }
	# if (-e $image_small) {
		# $text .= "(<a href=\"$relativeLoc/$photoLoc/small/$image_small_file\">Small</a>) ";
	# }
	# if (-e $image_thumb) {
		# $text .= "(<a href=\"$relativeLoc/$photoLoc/thumbs/$image_thumb_file\">Thumb</a>) ";
	# }
	

	my $high = '';
	my $large = '';
	my $med = '';
	my $small = '';
	my $thumb = '';



	if ( $high_res_link ne "" ){ 
		$high = "$high_res_link";
	}
	if (-e $image_large) {
		$large = "$relativeLoc/$photoLoc/large/$image_large_file";
	}
	if (-e $image_med) {
		$med = "$relativeLoc/$photoLoc/medium/$image_med_file";
	}
	if (-e $image_small) {
		$small = "$relativeLoc/$photoLoc/small/$image_small_file";
	}
	if (-e $image_thumb) {
		$thumb = "$relativeLoc/$photoLoc/thumbs/$image_thumb_file";
	}

	return ($high, $large, $med, $small, $thumb);
}




sub displayTableData2 { # displays table from multichip list
	my $row = $_[0], $flipColor=$_[1], $thumb;
	#&chipData2($row,...)
	
	my $text='';

	my $manuf	=  &chipData2($row,$colManuf);
	my $sub_fam_text = &chipData2($row,$colSubFamily);
	my $Core = 	&chipData2($row,$colCore);
	

	$alert_global .= "^$row^";
	##################
	# [IC Type]
	my $type	= &chipData2($row,$colType);
	if($type eq ''){
		$type = 'unknown?';
	}


	########################
	# [Part Number]
	my $part = &chipData2($row,$colPart);
	if($part eq ''){
		$part = 'unknown?';
		$img_alt_text = $manuf;	
		$chip_heading = $manuf;	
	}else{
		$img_alt_text = $manuf . " " . $part;	
		$chip_heading = $manuf . " " . $part;	
	}


	##############################
	# [Heading]
	#
	$core = $Core; # quick fix
	if($part eq '' || $part eq 'unknown?'){ # no part number
		if($family eq '' || $manuf eq $family){ # fam bad
			if($core eq ''){
				$chip_heading = $manuf;
			}else{
				$chip_heading = $manuf . " - " . $core;
			}
		}else{ # fam good
			if ($family ne $sub_fam_text){ # subfamily: good
				if($core eq ''){
					$chip_heading = $manuf . " - " . $family . ": " . $sub_fam_text ;
				}else{ # subfamily, core: good
					$chip_heading = $manuf . " - " . $family. ": " . $sub_fam_text . " - " . $core;
				}
			}else{ # subfam bad
				if($core eq ''){
					$chip_heading = $manuf . " - " . $family;
				}else{
					$chip_heading = $manuf . " - " . $family . " - " . $core;
				}
			}
		}
	}else{ # part num good
		$chip_heading = $manuf . " - " . $part;
	}






	# my $photo	= "<div style=\"width: 100%; display: inline-block; vertical-align: middle;\"><div style=\"border-width: 1px; border-style: solid; width: 150px; height: 150px;  padding: 10px; text-align: center; display: -webkit-box;
# display: -webkit-flex;
# display: -moz-box;
# display: -ms-flexbox;
# display: flex;
# -webkit-flex-align: center;
# -ms-flex-align: center;
# -webkit-align-items: center;
# align-items: center;\"><div style=\"text-align:center;    margin: auto;\">PHOTO<br />To be added</div></div></div>\n";
	


	######################
	# [Description]: code
	my $desc = &chipData2($row,$colDesc);
	if($desc ne ''){
			$desc  = <<Endhtml;
			 </tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Description:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$desc</span>
				</td>
Endhtml
	}else{
		$desc = '';
	}



	##################
	# [Notes]: code
	my $notes = &chipData2($row,$colNotes);
	if($notes ne ''){
			$notes  = <<Endhtml;
			 </tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Notes:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$notes</span>
				</td>
Endhtml
	}else{
		$notes = '';
	}



	# $Manuf = 	&chipData2($row,$colManuf);
	# $Part = 	&chipData2($row,$colPart);
	# $Type = 	&chipData2($row,$colType);
	


	###################
	# [Die Size]
	$die_size_text = 	&chipData2($row,$colDie_size);
	if( $die_size_text ne '' ){
		$die_size_text =~ s/\^2/<sup>2<\/sup>/;
		$die_size_text  = <<Endhtml;
				<td style="white-space: nowrap; width: 100px;" padding-left: 10px;>
					<span class="tableChipParam">Die size:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$die_size_text</span>
				</td>
Endhtml
	}



	#######################
	# [High Res]: Generate high res link text 
	# TODO small/medium/large/high res link
	# my $Photo_die_high_res_link = 	&chipData2($row,$colPhoto_die_high_res_link);
	# if($Photo_die_high_res_link ne ''){
		# $high_res_link_text = "		</tr><tr>
				# <td style=\"white-space: nowrap; width: 100px;\">
					# <span class=\"tableChipParam\">Die photo high resolution version:</span>
				# </td><td style=\"white-space: nowrap;\" colspan=\"3\">					
					# <span class=\"tableChipValue\"><a href=\"" . url_encode($Photo_die_high_res_link) . "\">$Photo_die_high_res_link<\a></span>
				# </td>";
	# }else{
		# $high_res_link_text = '';
	# }
	
	######################
	# [Sub-Family]
	if($sub_fam_text ne ''){
		$sub_fam_text  = <<Endhtml;
				<td style="white-space: nowrap; width: 100px;">
					<span class="tableChipParam">Sub-Family:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$sub_fam_text</span>
				</td>
Endhtml
	}else{
		$sub_fam_text  = <<Endhtml;
				<td style="white-space: nowrap; width: 100px;">
				</td><td style="white-space: nowrap;">
				</td>
Endhtml
	}




	# DEBUG stuff
	if($DEBUG == 1){
	$t_Manuf = &chipData2($row,$colManuf);
	$t_Part = &chipData2($row,$colPart);
	$t_Type = &chipData2($row,$colType);
	$t_Family = &chipData2($row,$colFamily);
	$t_Core = &chipData2($row,$colCore);
	$t_Die_size = &chipData2($row,$colDie_size);
	$t_Photo_die = &chipData2($row,$colPhoto_die);
	$t_Photo_die_license = &chipData2($row,$colPhoto_die_license);
	$t_Photo_die_link = &chipData2($row,$colPhoto_die_link);
	$t_Photo_die_high_res_link = &chipData2($row,$colPhoto_die_high_res_link);
	$t_Photo_floorplan = &chipData2($row,$colPhoto_floorplan);
	$t_Photo_floorplan_license = &chipData2($row,$colPhoto_floorplan_license);
	$t_Photo_floorplan_link = &chipData2($row,$colPhoto_floorplan_link);
	$t_Notes = &chipData2($row,$colNotes);
	$t_num_cores = &chipData2($row,$col_num_cores);
	$t_colSubFamily= &chipData2($row,$colSubFamily);
	$t_colDesc= &chipData2($row,$colDesc);
	$debug_info  = <<Endhtml;
<!--
DEBUG
<br /><b>info</b><br />
Manuf: $Manuf<br />
Part: $Part<br />
Type: $Type<br />
Family: $Family<br />
Core: $Core<br />
Die_size: $Die_size<br />
Photo_die: $Photo_die<br />
Photo_die_license: $Photo_die_license<br />
Photo_die_link: $Photo_die_link<br />
Photo_die_high_res_link: $Photo_die_high_res_link<br />
Photo_floorplan: $Photo_floorplan<br />
Photo_floorplan_license: $Photo_floorplan_license<br />
Photo_floorplan_link: $Photo_floorplan_link<br />
Notes: $Notes<br /><br />

num_cores: $num_cores<br />
	t_Manuf = $t_Manuf<br />
	t_Part = $t_Part<br />
	t_Type = $t_Type<br />
	t_Family = $t_Family<br />
	t_Core = $t_Core<br />
	t_Die_size = $t_Die_size<br />
	t_Photo_die = $t_Photo_die<br />
	t_Photo_die_license = $t_Photo_die_license<br />
	t_Photo_die_link = $t_Photo_die_link<br />
	t_Photo_die_high_res_link = $t_Photo_die_high_res_link<br />
	t_Photo_floorplan = $t_Photo_floorplan<br />
	t_Photo_floorplan_license = $t_Photo_floorplan_license<br />
	t_Photo_floorplan_link = $t_Photo_floorplan_link<br />
	t_Notes = $t_Notes<br />
	t_num_cores = $t_num_cores<br />
	t_colSubFamily=$t_colSubFamily
	t_colDesc= $t_colDesc
<br /><br />
<b>Cols</b><br />
colManuf: $colManuf<br />
colPart: $colPart<br />
colType: $colType<br />
colFamily: $colFamily<br />
colCore: $colCore<br />
colDie_size: $colDie_size<br />
colPhoto_die: $colPhoto_die<br />
colPhoto_die_license: $colPhoto_die_license<br />
colPhoto_die_link: $colPhoto_die_link<br />
colPhoto_die_high_res_link: $colPhoto_die_high_res_link<br />
colPhoto_floorplan: $colPhoto_floorplan<br />
colPhoto_floorplan_license: $colPhoto_floorplan_license<br />
colPhoto_floorplan_link: $colPhoto_floorplan_link<br />
colNotes: $colNotes<br />
col_num_cores: $col_num_cores<br />												
-->
Endhtml
	}

	##################
	# [Die Photo]: Create die image/link/attribution code
	if (&chipData2($row,$colPhoto_die) ne ""){

		################
		# [Image Links]
		
		# get links for each size
		my ($high, $large, $med, $small, $thumb) = &get_image_links( &chipData2($row,$colPhoto_die), &chipData2($row,$colPhoto_die_high_res_link) );
		my $die_image_links_text = '';
		if ( $high ne "" ){
			$die_image_links_text .= "(<a href=\"$high\">High Res</a>) ";
		}
		if ($large) {
			$die_image_links_text .= "(<a href=\"$large\">Large</a>) ";
		}
		if ( $med) {
			$die_image_links_text .= "(<a href=\"$med\">Medium</a>) ";
		}
		if ( $small) {
			$die_image_links_text .= "(<a href=\"$small\">Small</a>) ";
		}
		if ( $thumb) {
			$die_image_links_text .= "(<a href=\"$thumb\">Thumb</a>) ";
		}
		# $alert_global .= "$high, $large, $med, $small, $thumb";
		$die_image_links  = <<Endhtml;
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Die photo links:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$die_image_links_text</span>
				</td>
Endhtml
		

		###############
		# [Die Image]
		# $thumb = &chipData2($row,$colPhoto_die);
		# $thumb =~ s/(.*)\.(...)$/$1-thumb.$2/;
		# $text .= "$thumb - $colPhoto_die - " . &chipData2($row,$colPhoto_die) . "<br />\n";
		$photo_die = "<a href=\"$small\" data-lightbox-title=\"$img_alt_text\" data-lightbox-group=\"grouped\" data-lightbox-description=\"poop\"><img src=\"$thumb\" width=\"250\" alt=\"$img_alt_text\" style=\"display: block; margin-left: auto; margin-right: auto; border: 2px solid #cccccc;\"></a>\n";

		# [Die License]: Create Die 
		$Photo_die_license = &chipData2($row,$colPhoto_die_license);
		if ( $Photo_die_license ne "" ){
				$license = get_license_attr_text($Photo_die_license);
		}else{
			$Photo_die_license = "unknown? [this should not be, please correct]";
		}
		$die_license_source_text  = <<Endhtml;
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Die photo license:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$license</span>
				</td>
Endhtml
		# [Die Link]: Create Die link
		# $colPhoto_die_link
		$Photo_die_link = 	&chipData2($row,$colPhoto_die_link);
		if ( $Photo_die_link ne "" ){
			$Photo_die_link = "<a href=\"" . url_encode($Photo_die_link) . "\">$Photo_die_link</a>";
		}else{
			$Photo_die_link = "unknown?";
		}
		$die_license_source_text  .= <<Endhtml;
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Die photo source:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$Photo_die_link</span>
				</td>
Endhtml

	}else{
		# die not found
		$photo_die = '<div style="border: 2px solid #cccccc; width: 225px; height: 225px; font-size: 26px; text-align: center; vertical-align: middle;margin-left: auto; margin-right: auto;">no<br />die photo<br />available</div>';

		$die_license_source_text  = '';
	}


	###########################
	# [Floor Plan] photo: create floorplan image code
	if (&chipData2($row,$colPhoto_floorplan) ne ""){
		# $thumb = &chipData2($row,$colPhoto_floorplan);

		# $thumb =~ s/(.*)\.(...)$/$1-thumb.$2/;

		my ($high, $large, $med, $small, $thumb) = &get_image_links( &chipData2($row,$colPhoto_floorplan), &chipData2($row,$colPhoto_floorplan_high_res_link) );
		my $die_image_links_text = '';
		if ( $high ne "" ){
			$floorplan_image_links_text .= "(<a href=\"$high\">High Res</a>) ";
		}
		if ($large) {
			$floorplan_image_links_text .= "(<a href=\"$large\">Large</a>) ";
		}
		if ( $med) {
			$floorplan_image_links_text .= "(<a href=\"$med\">Medium</a>) ";
		}
		if ( $small) {
			$floorplan_image_links_text .= "(<a href=\"$small\">Small</a>) ";
		}
		if ( $thumb) {
			$floorplan_image_links_text .= "(<a href=\"$thumb\">Thumb</a>) ";
		}

		# \.(...)$
		$photo_floorplan = "<a href=\"$small\" data-lightbox-title=\"$img_alt_text\" data-lightbox-group=\"grouped\" data-lightbox-description=\"poop\"><img src=\"$thumb\" alt=\"$img_alt_text\" style=\"border: 2px solid #cccccc; width: 250px; display: block; margin-left: auto; margin-right: auto; margin-top: 10px;\"></a>\n";

		# [Floorplan License]: Create Die link
		$Photo_floorplan_license = &chipData2($row,$colPhoto_floorplan_license);
		if ( $Photo_floorplan_license ne "" ){
			$license = get_license_attr_text($Photo_die_license);
		}else{
			$Photo_floorplan_license = "unknown? [this should not be, please correct]";
		}
		$floorplan_license_source_text  = <<Endhtml;
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Die floorplan license:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$Photo_floorplan_license</span>
				</td>
Endhtml
		# [Floorplan Link]: Create link
		$Photo_floorplan_link = 	&chipData2($row,$colPhoto_floorplan_link);
		if ( $Photo_floorplan_link ne "" ){
			$Photo_floorplan_link = "<a href=\"" . url_encode($Photo_floorplan_link) . "\">$Photo_floorplan_link</a>";
		}else{
			$Photo_floorplan_link = "unknown?";
		}
		$floorplan_license_source_text  .= <<Endhtml;
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Die floorplan source:</span>
				</td><td style="white-space: nowrap;" colspan="3">					
					<span class="tableChipValue">$Photo_floorplan_link</span>
				</td>
Endhtml
	}else{
		# no floorplan
		$photo_floorplan = '';
		$floorplan_license_source_text  = '';
	}


	#################
	# Family: 
	if ( &chipData2($row,$colFamily) ne "" && &chipData2($row,$colFamily) ne "Other") {
		$family = &chipData2($row,$colFamily);
	}else{
		$family = 'unknown?';
	}

	################
	# Core Name:
	if ($Core eq "" ){
		$Core = '?';
	}

	################
	# Core Count: 
	my $core_cnt = &chipData2($row,$col_num_cores);
	if(	$core_cnt eq '' ){
		$core_cnt = '?';
	}


	#####################################################
	# ------------Chip--Table HTML-----------------------
	$text .= "\t<!-- chip table -->\n";
	# $text .= "\t<tr style=\"background-color: #454545\">\n";
	$text .=  "\t<tr>\n";

	# if ( $flipColor == 0 ) {
		# $text .= "\t<tr style=\"background-color: #454545\">\n";
	# }else{
		# $text .= "\t<tr style=\"background-color: #545454\">\n";
	# }
	$text .= <<Endhtml;
		
		<td class="manuf-chip-list-photos" style="margin: 5px 5px 0 0; background-color: #3f3f3f; border-right: 3px solid #333333; border-top: 3px solid #333333; ">
			$photo_die
			$photo_floorplan
		</td>
		<td class="manuf-chip-list-data" style="background-color: #3f3f3f; margin-top: 5px; border-top: 3px solid #333333; ">
			<div class="tableDisplayPartNum">$chip_heading</div><br /><br />
		<table style="width: 400px">
			<tr>
				<td colspan="4" style="white-space: nowrap;">
					<span class="tableChipSubHeading">General Specifications:</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Manufacturer:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$manuf</span>
				</td><td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Type:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$type</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Family:</span>
				</td><td style="white-space: nowrap;">
					<span class="tableChipValue">$family</span>
				</td>
$sub_fam_text
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Part number:</span>
				</td><td style="white-space: nowrap;">					
					<span class="tableChipValue">$part</span>
				</td>
			</tr><tr>
				<td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Core/Code/uArch:</span> 
				</td><td style="white-space: nowrap;">						
					<span class="tableChipValue">$Core</span> 
				</td><td style="white-space: nowrap; width: 100px; padding-left: 10px;">
					<span class="tableChipParam">Cores:</span>
				</td><td style="white-space: nowrap; width: 100px;">
					<span class="tableChipValue">$core_cnt</span>
				</td>
			</tr><tr>
$die_image_links
$die_size_text <!-- 2cols -->
$die_license_source_text
$floorplan_license_source_text
$desc
$notes
			</tr>
		</table>
		$debug_info
		</td>
	</tr>
Endhtml
	$text .= "\t<!-- chip table (end) -->\n";
	
	#THis was used to sort each chip in list(table)
	my $sort_element = $type;
	$alert_global .="####$type####";
	return ($text, $sort_element, $type);
}














###########################################
############ Table ##################
###########################################















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
		while (!(&chipData2($x,$colPart) eq '' && &chipData2($x,$colManuf) eq '' && &chipData2($x,$colFamily) eq '' && &chipData2($x,$colPhoto_die) eq '' && &chipData2($x,$colPhoto_floorplan) eq '')) {
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
	
	while(!(&chipData2($x,$colPart) eq '' && &chipData2($x,$colManuf) eq '' && &chipData2($x,$colFamily) eq '' && &chipData2($x,$colPhoto_die) eq '' && &chipData2($x,$colPhoto_floorplan) eq '')) {
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



sub create_html_body_main_chip_list {
	

	my $list_all = $_[0];
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
	
	my $search_manuf = $data{'manufacturer'};
	my $search_family= $data{'family'};
	if ($list_all == 1){
		$search_family = 'All';
		$alert_global .= "mode: display all chips<br />\n";
	}
	my $search_page = $data{'page'};


	$text .= "\n\t<!-- manuf list -->\n\t<div id=\"lightgallery\">\n\t<table class=\"tablepadding5 manuf-chip-list\" style=\"background-color: #333333; border-width: 0;\"><!-- summary=\"manufacturer list\" -->\n"; 
	while(!(&chipData2($x,$colpart) eq '' && &chipData2($x,$colManuf) eq '' && &chipData2($x,$colFamily) eq '' && &chipData2($x,$colPhoto_die) eq '' && &chipData2($x,$colPhoto_floorplan) eq '')) {
		# $text .= ".";
		if( (&chipData2($x,$colManuf) =~ /^$search_manuf$/i) || ($search_page eq 'family') ) {
			if ( ($list_all == 1) || (&chipData2($x,$colFamily) eq $search_family || $search_family eq "All" || (($search_family  eq "Other") && (&chipData2($x,$colFamily) eq ''))) && ($search_family ne "") ) {
				# $text .= "+";
				# if ( &chipData2($x,$colType) =~ /^Support$/i ) {
					# $supportChips[$supportChipCount] = &chipData2($x,$colPart);
					# $supportChipsMan[$supportChipCount] = &chipData2($x,$colManuf);
					# need to fix to the send full ship data
					# $supportChipCount++;
				# } else {
				
				$alert_global .= "+";

				($chip_table_text[$listed_cnt], $sort_elements[$listed_cnt], $type[$listed_cnt]) = &displayTableData2($x,$flipColor);
				# ($text_out, $text_t, $type[$listed_cnt]) = &displayTableData2($x,$flipColor);

				# $text .= "<tr><td>RHAAAAA($listed_cnt)</td></tr>\n";
				# $text .= "<tr>\n$text_out\n</tr>\n";

				 # $text .= "========unsorted part($listed_cnt): =========<br \>";
				$listed_cnt++;
				if ( $flipColor == 0 ) {$flipColor = 1;} else {$flipColor = 0;}
				# }
			}
		}
		$x++;
	}

	# $text .= "<br />data page = $data{'page'}<br />";
	if ( $data{'page'} eq 'manufacturer' || $data{'page'} eq 'family' ) {
		$alert_global .= "!:::::::!";
		$x=0;
		my $cpus = '';
		my $mcus = '';
		my $fpus = '';
		my $dsps = '';
		my $socs = '';
		my $others = '';
		my $math = '';
		my $alus = '';
		my $memmory = '';
		my $cache = '';
		my $apu = '';


		while ( $chip_table_text[$x] ne '' ) {
			$alert_global .= "!***!";


			# $text .= "x";
			# $text .= "========un-unsorted part($x): =========<br \>";

# !!! TEMP unsorted fix !!!!!!!!!
			# $text .= $chip_table_text[$x];

			# $text .= "========unsorted part($x): " . $chip_table_text[$x] . "=========<br \>";
			if ( $type[$x] =~ /^cpu$/i ){
				$cpus .= $chip_table_text[$x];
			}elsif ( $type[$x] =~ /^bit[ -_]?slice.*$/i  ) {
				$bitslices .= $chip_table_text[$x];
			}elsif($type[$x] =~ /^soc$/i ){
				$socs .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^mcu$/i ) {
				$mcus .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^dsp$/i ) {
				$dsps .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^fpu$/i ){
 				$fpu.= $chip_table_text[$x];
				$math = 1;
			} elsif ( $type[$x] =~ /^alu$/i ){
				$alu .= $chip_table_text[$x];
				$math = 1;
			} elsif ( $type[$x] =~ /^co-processor$/i ) {
				$co_proc .= $chip_table_text[$x];
				$math = 1;
			}elsif ( $type[$x] =~ /^multiplier$/i ){
				$multiplier .= $chip_table_text[$x];
				$math = 1;
			}elsif ( $type[$x] =~ /^math[ -]processor$/i || $type[$x] =~ /^math[ -]co[ -]?processor$/i){
				$math_proc .=  $chip_table_text[$x];
				$math = 1;
			}elsif ( $type[$x] =~ /^integer.*$/i) {
				$integer .= $chip_table_text[$x];
				$math = 1;
			} elsif ( $type[$x] =~ /^graphics$/i){
				$graphics_gen .= $chip_table_text[$x];
				$graphics = 1;
			}elsif ($type[$x] =~ /^gpu$/i ){
				$gpu .= $chip_table_text[$x];
				$graphics = 1;
			}elsif ($type[$x] =~ /^ppu$/i){
				$ppu .= $chip_table_text[$x];
				$graphics = 1;
			}elsif ($type[$x] =~ /^ramdac$/i ) {
				$ramdac .= $chip_table_text[$x];
				$graphics = 1;
			} elsif ( $type[$x] =~ /^audio$/i ) {
				$audio .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^mmus$/i ) {
				$mmus .= $chip_table_text[$x];
		
			} elsif ( $type[$x] =~ /^audio$/i ) {
				$audio .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^cache$/i ) {
				$cache .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^networking$/i || $type[$x] =~ /^network.*$/i ) {
				$networking .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^memmory.*$/i ) {
				$memmory .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^apu$/i ) {
				$apu .= $chip_table_text[$x];
			} elsif ( $type[$x] =~ /^bus[ -]controller$/i ||  $type[$x] =~ /^i\/o[ -]controller$/i ||  $type[$x] =~ /^bus switch$/i  ||  $type[$x] =~ /^i\/o[ -]processor$/i ||  $type[$x] =~ /^.*port[ -]controller$/i ) {
				$bus .= $chip_table_text[$x];

	
			} else {
				$others .= $chip_table_text[$x];
			}
			$x++;
		}


# !!! TEMP unsorted fix !!!!!!!!!
		if ( $cpus ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Central Processing Unit (CPU)</div></td></tr>\n";
			$text .= $cpus;
		}
		if ( $apu ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Accelerated Processing Unit (APU)</div></td></tr>\n";
			$text .= $apu;
		}
		
		if ( $bitslices ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Bit-Slice Processor (BSP)</div></td></tr>\n";
			$text .= $bitslices;
		}
		if ( $socs ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;System-on-Chip (SoC)</div></td></tr>\n";
			$text .= $socs;
		}
		if ( $mcus ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Micro-Controller Unit (MCU)</div></td></tr>\n";
			$text .= $mcus;
		}
		if ( $dsps ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Digital Signal Processor (DSP)</div></td></tr>\n";
			$text .= $dsps;
		}
		if ( $math ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Math Units</div></td></tr>\n";
 			$text .= 	$fpu;
			$text .= 	$alu ;
			$text .= 	$co_proc ;
			$text .= 	$multiplier ;
			$text .= 	$math_proc;
			$text .= $integer ;
			$text .= $math;
		}
		# if ( $alus ne '' ) {
			# $text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Arithmatic Logic Unit (ALU)</div></td></tr>\n";
			# $text .= $alus;
		# }
		if ( $graphics ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Graphics Controllers</div></td></tr>\n";
				$text .= $graphics_gen ;
				$text .= $gpu ;
				$text .= $ppu ;
				$text .= $ramdac ;
		}
		if ( $networking ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Network Controllers</div></td></tr>\n";
			$text .= $networking;
		}
		if ( $bus ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;I/O and Bus Controllers</div></td></tr>\n";
			$text .= $bus;
		}
		# if ( $cache ne '' ) {
			# $text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Cache Controller</div></td></tr>\n";
			# $text .= $cache;
		# }
		if ( $audio ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Audio Controllers</div></td></tr>\n";
			$text .= $audio;
		}
		if ( $memmory ne '' ) {
			$text .= "\t<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Memory Controllers</div></td></tr>\n";
			# : Memory Managment Unit (MMU), Direct Memory Addessing Controller (DMA), Cache Controller
			$text .= $mmus;
			$text .= $cache;
			$text .= $dma;
			$text .= $memmory;
		}


		if ( $others ne '' ) {
			$text .= "<tr><td colspan=\"2\" style=\"background-color: #545454\"><div class=\"chipTypeHeading\">&nbsp;&nbsp;Other components</div></td></tr>\n";
			$text .= $others;
		}
		$text .= "\t</table></div>\n";
		$text .= "\t<!-- manuf list (end) -->\n";
	} 
	
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


# sub create_html_body_main_contact {
	# my $text = '';
	
	# $title_ext_global = 'Contact Page';
	# $keyword_ext_global = 'contact';

	# $text .= <<Endhtml;
		# <table style="border-width: 1px; border-style: solid;">
			# <tr><td style="text-align: center;">
				# <a href="/contact">Contact Me</a><br />
			# </td></tr>
		# </table>
# Endhtml
	# return $text;
# }



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
		$wiki = ",&nbsp\; (<a href=\"http://en.wikipedia.org/wiki/$wiki\">Wikipedia article</a>)";
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
		
		# display all chips of manuf if there are less than screate_html_body_main_chip_listix chips
		if(  $manufListCountGlobal{$manufSub} < 6 ){
			my $list_all = 1;
			$text .= &create_html_body_main_chip_list($list_all);

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
		}
		# Checking to see if there are any boards by/for the manuf
		# $row = $skipLines;
		# $x = 0;
		# my $set_board = 0;
		# while (&board_data($row,$col_board_board_type) ne '') {
			# # print ".";
			# if (&board_data($row,$col_board_manuf) eq $data{'manufacturer'} || &board_data($row,$col_board_chip_manuf) eq $data{'manufacturer'}) {
				# # print "X";
				# $board_rows[$x] = $row;
				# $set_board = 1;
				# $x++;
			# }
			# $row++;
		# }
		# if ($set_board == 1) {
			# $text .= "\t</td><td style=\"vertical-align: top;\">\n";
			# $text .= "\t\t<span class=\"heading2\">Processor Boards:</span>\n";
			# $text .= "\t\t<ul>\n";
			# foreach $x (@board_rows) {
				# my $linky = &board_data($x,$col_board_name);
				# my $manuf_locy = &board_data($x,$col_board_manuf);
				# my $board_namey = &board_data($x,$col_board_name);
				# $manuf_locy =~ s/[ \W]/_/g;
				# $linky =~  s/[ \W]/_/g; # tr/\W/_/;
				# $linky = "$script_url/boards/&manuf=$manuf_locy&name=$linky";
				# $text .= "\t\t\t<li><span class=\"tableParam\"><a href=\"$linky\">" . &board_data($x,$col_board_type) . " ";
				# if (&board_data($x,$col_board_board_type) eq 'module') {
					# $text .= "CPU module";
				# } elsif (&board_data($x,$col_board_board_type) eq 'dev') {
					# $text .= "Evaluation board";
				# }
				# $text .= "<br />$board_namey</a></span>\n";
			# }
			# $text .= "\t\t</ul>\n";
		# }
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
					$homepage = "<a href=\"" . url_encode(&familyData2($x,$colFamilyHomepage)) . "\">$linkName</a>";	;		
				}
			}
			if ( &familyData2($x,$colFamilyWiki) ne '' ) {
				$wiki = &familyData2($x,$colFamilyWiki);
				$wiki =~ s/ /_/;
				$wiki = "(<a href=\"http://en.wikipedia.org/wiki/" . url_encode($wiki) . "\">Wikipedia article</a>)";		
			}
			if ( &familyData2($x,$colFamilyLogo) ne '' ) {
				$familyLogo = &familyData2($x,$colFamilyLogo);		
			}

			#if ( $logo ne '' ) {
				#$logo = "<a href=\"http://howto.wikia.com/wiki/Howto_identify_integrated_circuit_%28chip%29_manufacturers_by_their_logos\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\" width=\"70\"></a>";
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
		$logo = "<a href=\"$script_url/logos/\" data-lightbox=\"lie hard\" data-title=\"testing\"><img src=\"$relativeLoc/$logoLoc/$logo\" alt=\"$name\"></a>";
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
	# http://www.w3schools.com/css/css_font.asp
	my $meta_robots='';
	if( $script_url 	=~ 'testing') {
		$meta_testing	='	<meta name="robots" content="noindex">' . "\n";
		$meta_testing	.='	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />' . "\n";
		$meta_texting	.='	<meta http-equiv="Pragma" content="no-cache" />' . "\n";
		$meta_testing	.='	<meta http-equiv="Expires" content="0" />' . "\n";
	}

	my $title = "CPU Grave Yard - Dieshots";
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
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1" />

	<meta name="description" content="My CPU collection"/>
	<meta name="keywords" content="CPU, processor, MCU, microcontroller, die, dieshot, die photo, $meta"/>

	<title>$title</title>

	
    <script src="/files/dieshots/theme/responsive/responsive.ie10mobilefix.min.js"></script>
    <link href="/files/dieshots/theme/responsive/responsive.min.css" rel="stylesheet" />
    <!--[if lt IE 9 &!(IEMobile)]>
        <script src="vendor/html5shiv.min.js"></script>
        <script src="vendor/respond.min.js"></script>
    <![endif]-->

	<link rel="stylesheet" href="/files/dieshots/theme/dieshots_theme.css"/>

	$meta_testing

	<!-- <link rel="canonical" href=""> -->

	<!-- Social -->
    <!-- <meta property="og:url" content=""> -->
    <meta property="og:type" content="website"/>
    <meta property="og:title" content="$title"/>
	<meta property="og:site_name" content="CPU Grave Yard - Dieshots"/>
	<meta property="og:description" content="die photos, $meta"/>

</head>

<body>
<div style="float:right;" class="topChipCount">
$totalChipCountGlobal Dies<br />
updated<br />
$updateDate
</div><br />

<div class="title_box">
<div class="title">CPU Grave Yard - Dieshots</div>
<div class="title_sub">integrated circuit die photos</div><br />
</div>

<hr>
<div style="text-align: center; font-size:18px;">
<a href="$script_url">Home</a> -- 
<a href="$script_url/about/">About</a> -- 	
<a href="$script_url/resources/">Resources</a> --
<a href="$script_url/add/">Add Photo</a> --
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
$text = <<Endhtml;

<!-- sidebar -->
	<div>
		<form name="family_form" action="$script_url/">
		<input type="hidden" name="page" value="family" \>
		<select name="family" style="width:180px;" onChange="family_form.submit()">
		<option value="null" selected>--family--</option>
Endhtml
	# foreach $fam (@familyListGlobal) {
		# if( $fam ne '' ){
			# $text .= "\t\t\t<option value=\"" . url_encode($fam) . "\">$fam</option>\n";
		# }
	# }
	$text .= <<Endhtml;
		</select>
		</form>
		<hr>
Endhtml
	foreach $manuf (sort keys %manufListCountGlobal) {
		
		# Shorten and correct some names
		# if($manuf eq 'ATT'){
			# $manuf_display = 'AT&T';
		# }elsif( $manuf eq 'National Semiconductor' ){
			# $manuf_display = 'National Semi';
		# }elsif( $manuf eq 'STMicroelectronics' ){
			# $manuf_display = 'STMirco';
		# }else{
			$manuf_display = $manuf;
		# }

		# Displays the currently selected manufacturer
		if ($manuf eq $data{'manufacturer'}) {
			$text .= "\t\t<span class=\"sidebarManufNameSelected\"><a href=\"$script_url/m/" . url_encode($manuf) . "\">$manuf_display</a></span><br />\n";
			$text .= "\t<ul class=\"sidebarManufFamilyList\">\n";
			# &manufFamilyList; #no longer used
			
			for ($x=0;$x<=$#manufFamilyListGlobal;$x++) {
				$text .= "\t\t<li class=\"sidebarManufFamilyListElement\"><span class=\"manufFamilyListSelected\"><a href=\"$script_url/mf/" . url_encode($manuf) . "/" . url_encode($manufFamilyListGlobal[$x]) . "\">$manufFamilyListGlobal[$x]</a>";
				if ($manufFamilyListGlobal[$x] eq "All") {
					$text .= "&nbsp;($manufListCountGlobal{$manuf})</span></li>\n";
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
		<p>Currently <b>$totalChipCountGlobal</b> ic die photos in collection. </p><br />

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
		# $text = "Location: http://happytrees.org/chips$query\n\n";
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
	Images are under the license specified alongside photo. The <a href="$code_loc">code</a> for this page is licenced under <a href="http://en.wikipedia.org/wiki/GPL_license">GPL</a><br />
	
</div>

    <!--[if IE 8]>
	    <script src="/files/dieshots/theme/vendor/jquery-1.11.0.min.js"></script>
    <![endif]-->
    <!--[if gt IE 8]><!-->
    	<script src="/files/dieshots/theme/vendor/jquery-2.1.0.min.js"></script>
    <!--<![endif]-->

    <script src="/files/dieshots/theme/responsive/responsive.min.js"></script>

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


#########################################
########## Page Structure (end) #########
#########################################

















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
%data = ();
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
$alert_global = 'none';

# Gets input args
%data = &read_input; #get input

$textmanuf = "manuf in = $data{'manufacturer'}";


# Gets spreadsheet's last edit date
$spreadsheetFileName = $dieshots_include_files_root . '/' . $chip_spreadsheet_file;
if($DEBUG){$alert_global .= "speadsheet=$spreadsheetFileName<br/>\n";}

$updateDate = ctime(stat($spreadsheetFileName)->mtime);
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
$familyErasOrderedFileName = $dieshots_include_files_root . '/' . $family_order_file;
@chipErasGlobal = &openFile($familyErasOrderedFileName);
chomp(@chipErasGlobal);
# foreach $chipEra (@chipErasGlobal) {print "$chipEra, ";}

# Gets the column numbers for each of the chip parameters
&getColLabels;
&getColChipData;


&grapGlobals;

$wiki_attrib = "<img src=\"$relativeLoc/$photoLoc/share/wiki_super_script2.gif\" alt=\"wiki\" style=\"position: relative; right: 3px; border-width: 0;\">";

# %result = &sort_family_by('data-width'); 

# I moved large amounts of html/txt 3000+ lines to a seperate file
# for $file ($script_files_root . '/' . $extended_code_include_file)
# {
	# unless ($return = do $file) {
			# print "Content-type:text/html\n\n"; 
            # warn "couldn't parse $file: $@" if $@;
            # warn "couldn't do $file: $!"    unless defined $return;
            # warn "couldn't run $file"       unless $return;
			# exit;
        # }
# }

# &main_page; # display page

# Create the parts of the page
&create_html;


# debug info
my $end   = time;
if( $DEBUG ){
	print '\n<br />Page proccessing time: ', ( $end - $start ) , "<br />\n";
	my $out_debug = eval(Dumper(&grapGlobals));
	print $out_debug;
	print "---------------------------\n<br/>";
	$Data::Dumper::Indent = 3;
	# print Dumper(@spreadsheetData);
	print "---------------------------\n<br/>";
	print $alert_global;
	print "---------------------------\n<br/>";
}

# $text .= $textmanuf;

# Prints out the page
&print_html;

######## Main code (end) ###############
print "\n";
