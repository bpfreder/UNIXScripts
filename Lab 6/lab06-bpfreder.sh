#!/bin/bash

#pokemontypes--Accepts a Pokemon Type as an argument and returns a list of all Pokemon that belong to that type. Is capable of
# accepting string with any variation of uppercase and lowercase letters and converting them into appropriate capitalization
# for insertion into the source URL. Uses Bulbapedia's wiki page for each individual type, with the selected page dependent
# on user argument. Is capable of recognizing valid and invalid types, and ends the program when an invalid type is entered

if [ $# == 0 ] #runs if no argument given, instructs user what kind of argument to send to the script
then
	echo "Usage: Enter a Pokemon type to recieve a list of Pokemon that are that type."
	echo
	echo "Valid types:"
	echo "Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel,"
	echo "Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy."
	exit 1
fi

type=$(echo $1 | sed 's/[A-Z]/\L&/g' | sed 's/^[a-z]/\U&/') #converts argument into string where the first letter is uppercase and all
							    # other letters are lowercase

if [ $(echo $type) == "Normal" ] #if-elif-else statement runs to check if the type in the argument matches one of the 18 valid types of
then				 # Pokemon. If the type is valid, the typecheck value is set to 1. If the type is invalid, then the
	typecheck=1		 # typecheck value is set to 0
elif [ $(echo $type) == "Fighting" ]
then
	typecheck=1
elif [ $(echo $type) == "Flying" ]
then
	typecheck=1
elif [ $(echo $type) == "Poison" ]
then
	typecheck=1
elif [ $(echo $type) == "Ground" ]
then
	typecheck=1	
elif [ $(echo $type) == "Rock" ]
then
	typecheck=1
elif [ $(echo $type) == "Bug" ]
then
	typecheck=1
elif [ $(echo $type) == "Ghost" ]
then
	typecheck=1		
elif [ $(echo $type) == "Steel" ]
then
	typecheck=1
elif [ $(echo $type) == "Fire" ]
then
	typecheck=1
elif [ $(echo $type) == "Water" ]
then
	typecheck=1
elif [ $(echo $type) == "Grass" ]
then
	typecheck=1	
elif [ $(echo $type) == "Electric" ]
then
	typecheck=1
elif [ $(echo $type) == "Psychic" ]
then
	typecheck=1	
elif [ $(echo $type) == "Ice" ]
then
	typecheck=1
elif [ $(echo $type) == "Dragon" ]
then
	typecheck=1		
elif [ $(echo $type) == "Dark" ]
then
	typecheck=1
elif [ $(echo $type) == "Fairy" ]
then
	typecheck=1
else
	typecheck=0
fi

if [ $typecheck == 1 ] 			#If-else statement checks the result of typecheck. If typecheck is 1, the type is therefore valid and
then		       			# the program outputs a statement that heads the list of Pokemon. If typecheck is anything other than
	echo "All $type type Pokemon:"  # 1 (in this case, 0 is the only other potential value), the type is therefor invalid, and the program
else					# informs the user of valid types to send as an argument before exiting
	echo "Error. Invalid type entered."
	echo
	echo "Valid types:"
	echo "Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel,"
	echo "Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy."
	exit 1
fi
	
source=$(echo "https://bulbapedia.bulbagarden.net/wiki/$type;(type)" | tr ';' '_' ) #Bulbapedia URL used by cURL for collecting Pokemon of the 
										    # argued type. The URL format for Bulbapedia's type pages
										    # is "/Fire_(type)" with Fire type being the example used
										    # here. Since typing "$type_" confuses bash into thinking
										    # the "_" character is part of the variable, we type it as
										    # "$type;" and use tr to translate ';' into '_'

result="$(curl -s -dump $source |\
#cURL dumps the html file from the source URL. Signficant usage of grep sed is needed to pull the information properly

#Many random elements from the type wiki pages on Bulbapedia slip through our grep filter, usually elements from a page's triva section. For each
# unique element that we don't want pulled, we use a grep -v statement and a small segment of text present in the string. 20 grep -v statements
# were required across the 18 type pages
grep -v "<ul><li>" |\
grep -v "title=\"Generation" |\
grep -v "Every Fighting-type Gym" |\
grep -v "With the introduction of" |\
grep -v "A dual-typed Pok" |\
grep -v " is the only non-Legendary" |\
grep -v "In the anime on multiple" |\
grep -v "is one of the two types most commonly paired with" |\
grep -v "were unable to learn any" |\
grep -v "no longer resist Ghost-type attacks" |\
grep -v "A deceased " |\
grep -v "As shown in" |\
grep -v "In Japanese" |\
grep -v "there are only two evolutionary lines" |\
grep -v "was the last type to receive" |\
grep -v "According to the" |\
grep -v "Another reference to" |\
grep -v "the color gold" |\
grep -v "also change from a" |\
grep -v "were able to evolve" |\
grep -v "and the idea of" |\
#This is our grep filter for pulling lines with Pokemon names
grep "Pok%C3%A9mon)\" title=\"" |\
#This sed command removes all HTML formatting present within the cURL data
sed 's/<[^>]*>//g;s/^ //g' |\
#Some Pokemon, such as Gigantamax Pokemon, never change type from their base form, so we remove this string of text from their entry making them identical
# strings as their base form so that sort -u removes them from the list. Some Pokemon have specifc alternate forms that don't affect type, so we've also
# created specfic sed filters to help remove them from the list with sort -u
sed 's/Gigantamax//' |\
sed 's/Partner//' |\
sed 's/Winter//;s/Autumn//;s/Summer//;s/Spring//' |\
sed 's/Incarnate//;s/Therian//' |\
sed 's/GorgingCramorant/Cramorant/;s/GulpingCramorant/Cramorant/' |\
sed 's/ToxtricityLow Key Form/Toxtricity/;s/ToxtricityAmped Form/Toxtricity/' |\
sed 's/EternamaxEternatus/Eternatus/' |\
sed 's/East SeaGastrodon/Gastrodon/;s/West SeaGastrodon/Gastrodon/;s/East SeaShellos/Shellos/;s/West SeaShellos/Shellos/' |\
sed 's/Zygarde10%/Zygarde/;s/Zygarde50%/Zygarde/;s/ZygardeComplete/Zygarde/' |\
sed 's/LycanrocDusk/Lycanroc/;s/LycanrocMidday/Lycanroc/;s/LycanrocMidnight/Lycanroc/' |\
sed -e 's/Shield [Ff]ormeAegislash/Aegislash/;s/Blade [Ff]ormeAegislash/Aegislash/' |\
sed 's/DialgaOrigin//;s/PalkiaOrigin//' |\
sed 's/GiratinaAltered/Giratina/;s/GiratinaOrigin/Giratina/' |\
sed 's/GimmighoulChest/Gimmighoul/;s/GimmighoulRoaming/Gimmighoul/' |\
sed 's/WishiwashiSchool/Wishiwashi /;s/WishiwashiSolo/WishiWashi/' |\
sed 's/White-StripedBasculin/Basculin/;s/Blue-StripedBasculin/Basculin/;s/Red-StripedBasculin/Basculin/' |\
sed 's/Ash-Greninja/Greninja/' |\
sed 's/TatsugiriCurly/Tatsugiri/;s/TatsugiriDroopy/Tatsugiri/;s/TatsugiriStretchy/Tatsugiri/' |\
sed 's/PalafinHero/Palafin/;s/PalafinZero/Palafin/' |\
sed 's/CherrimOvercast/Cherrim/;s/CherrimSunshine/Cherrim/' |\
sed 's/Spiky-earedPichu/Pichu/' |\
sed 's/CosplayPikachu/Pikachu/;s/Pikachuin a cap/Pikachu/' |\
sed 's/MorpekoFull/Morpeko/;s/MorpekoHangry/Morpeko/' |\
sed 's/DeoxysAttack/Deoxys/;s/DeoxysDefense/Deoxys/;s/DeoxysNormal/Deoxys/;s/DeoxysSpeed/Deoxys/' |\
sed 's/WhiteKyurem/Kyurem/;s/BlackKyurem/Kyurem/' |\
sed 's/EiscueIce/Eiscue/;s/EiscueNoice/Eiscue/' |\
sed 's/AlcremieVarious//' |\
#Some Pokemon have spaces in their name, but since we use spaces as a delimiter for separating each line in our output, we need to remove the spaces before
# sorting occurs, then put the spaces back in our output for readability
sed 's/Type: Null/Type:Null/' |\
sed 's/Sandy Shocks/SandyShocks/' |\
sed 's/Flutter Mane/FlutterMane/' |\
sed 's/Hero ofMany Battles/HeroofManyBattles/' |\
sed 's/Crowned Shield/CrownedShield/;s/Crowned Sword/CrownedSword/' |\
sed 's/Mewtwo X/MewtwoX/;s/Mewtwo Y/MewtwoY/' |\
sed 's/Charizard X/CharizardX/;s/Charizard Y/CharizardY/' |\
sed 's/Mr. /Mr./;s/ Jr./Jr./' |\
sed 's/Iron /Iron/' |\
sed 's/Scream /Scream/' |\
sed 's/Slither /Slither/' |\
sed 's/Great /Great/' |\
sed 's/Roaring /Roaring/' |\
sed 's/Tapu /Tapu/' |\
#Some Pokemon have asterisks by their name to indicate that their type changed when the Fairy type was introduced. We remove this character for readability
sed 's/\*//' |\
#Some Pokemon have alternate forms that DO change their typing, so we use sed to keep those forms succinct and organized for sorting, then undo or alter
# our changes in output for readability. Certain Pokemon have also had their naming in the variable rearranged so that they appear next to their other
# forms when being sorted alphabetically
sed 's/FanRotom/RotomFan/;s/HeatRotom/RotomHeat/;s/WashRotom/RotomWash/;s/FrostRotom/RotomFrost/;s/MowRotom/RotomMow/' |\
sed 's/PrimalGroudon/GroudonPrimal/;s/PrimalKyogre/KyogrePrimal/' |\
sed 's/Shadow RiderCalyrex/CalyrexShadowRider/;s/Ice RiderCalyrex/CalyrexIceRider/' |\
sed 's/Dusk ManeNecrozma/NecrozmaDuskMane/;s/Dawn WingsNecrozma/NecrozmaDawnWings/;s/UltraNecrozma/NecrozmaUltra/' |\
sed 's/TaurosPaldean Form(Combat Breed)/TaurosPC/;s/TaurosPaldean Form(Blaze Breed)/TaurosPB/;s/TaurosPaldean Form(Aqua Breed)/TaurosPA/' |\
sed 's/DarmanitanStandard/Darmanitan/;s/DarmanitanZen ModeGalarian Form/DarmanitanZG/' |\
#one of the last things that needs to be done is to sort every entry uniquely so that duplicate Pokemon cause by our sed commands don't make it to the final output
sort -u |\
#this tr command removes all double spaces to prevent empty lines in our output
tr -s '[:space:]' ' ' )"

#printf '%s\n' prints the result variable as a string and converts each space into a new line for readability
printf '%s\n' $result |\
#Mega Pokemon are given a space between Mega and the Pokemon name, for readability
sed 's/Mega/Mega /' |\
#Various forms are attached to a Pokemon's name without a space when pulled from the source URL, while words such as "Form", "Cloak", etc. are
# seperated by a space and thus find their way in as a unique entry. We delete these words to avoid having false entries.
sed 's/Forme//;s/Form//;s/forms//' |\
sed 's/Cloak//' |\
sed 's/Mode//' |\
sed 's/Belly//' |\
sed 's/Face//' |\
sed 's/Strike//' |\
sed 's/Style//' |\
#Many Pokemon have regional forms with different types than their original form. Because these are common, we can translate the three various kinds
# of regional forms by adding a space a the front, and a space and the word "Form" at the end for easy readability across all Pokemon with these
# regional forms. One exception is Tauros, who has multiple versions of its regional form, which is removed here as a specific sed function was
# performed in both the variable and later in the output to account for formatting this correctly
sed 's/Alolan/ Alolan Form/' |\
sed 's/Galarian/ Galarian Form/' |\
sed 's/Hisuian/ Hisuian Form/' |\
sed 's/TaurosPaldean//' |\
sed 's/Paldean/ Paldean Form/' |\
#Some Pokemon have unique forms that have diffent types. Since they are attached to the name with no space, we can add a space before the form name,
# and a space after with the word "Form", for readability 
sed 's/Single/ Single Strike Style/' |\
sed 's/UrshifuRapid/Urshifu Rapid Strike Style/' |\
sed 's/MeloettaAria/Meloetta Aria Form/' |\
sed 's/Pirouette/ Pirouette Form/' |\
sed 's/Ordinary/ Ordinary Form/' |\
sed 's/Resolute/ Resolute Form/' |\
sed 's/Sunny/ Sunny Form/;s/Rainy/ Rainy Form/;s/Snowy/ Snowy Form/' |\
sed 's/Zen/ Zen Mode/;s/DarmanitanZG/Darmanitan Galarian Form Zen Mode/' |\
sed 's/ShayminSky/Shaymin Sky Forme/;s/ShayminLand/Shaymin Land Forme/' |\
sed "s/OricorioBaile/Oricorio Baile/;s/OricorioPa'u/Oricorio Pa'u/;s/OricorioPom-Pom/Oricorio Pom-Pom/;s/OricorioSensu/Oricorio Sensu/" |\
sed 's/MiniorCore/Minior Core/;s/MiniorMeteor/Minior Meteor/' |\
sed 's/RotomFan/Rotom Fan/;s/RotomHeat/Rotom Heat/;s/RotomWash/Rotom Wash/;s/RotomFrost/Rotom Frost/;s/RotomMow/Rotom Mow/' |\
sed 's/GroudonPrimal/Primal Groudon/;s/KyogrePrimal/Primal Kyogre/' |\
sed 's/CalyrexShadowRider/Shadow Rider Calyrex/;s/CalyrexIceRider/Ice Rider Calyrex/' |\
sed 's/NecrozmaDuskMane/Dusk Mane Necrozma/;s/NecrozmaDawnWings/Dawn Wings Necrozma/;s/NecrozmaUltra/Ultra Necrozma/' |\
sed 's/TaurosPC/Tauros Paldean Form (Combat Breed)/;s/TaurosPB/Tauros Paldean Form (Blaze Breed)/;s/TaurosPA/Tauros Paldean Form (Aqua Breed)/' |\
sed 's/BurmyPlant/Burmy Plant Cloak/;s/BurmySandy/Burmy Sandy Coat/;s/BurmyTrash/Burmy Trash Cloak/' |\
sed 's/WormadamPlant/Wormadam Plant Cloak/;s/WormadamSandy/Wormadam Sandy Cloak/;s/WormadamTrash/Wormadam Trash Cloak/' |\
sed 's/HoopaConfined/Hoopa Confined/;s/HoopaUnbound/Hoopa Unbound/' |\
#In our variable, we removed spaces in the names of Pokemon that had spaces in them for easy sorting. We now have to undo this in our output for readability.
sed 's/HeroofManyBattles/ Hero of Many Battles/' |\
sed 's/CrownedShield/ Crowned Shield/;s/CrownedSword/ Crowned Sword/' |\
sed 's/MewtwoX/Mewtwo X/;s/MewtwoY/Mewtwo Y/' |\
sed 's/CharizardX/Charizard X/;s/CharizardY/Charizard Y/' |\
sed 's/Mr./Mr. /;s/Jr./ Jr./' |\
sed 's/Iron/Iron /' |\
sed 's/Scream/Scream /' |\
sed 's/Slither/Slither /' |\
sed 's/Great/Great /' |\
sed 's/Roaring/Roaring /' |\
sed 's/Tapu/Tapu /' |\
sed 's/Type:Null/Type: Null/' |\
sed 's/SandyShocks/Sandy Shocks/' |\
sed 's/FlutterMane/Flutter Mane/' |\
#Lastly, the Pokemon "Meganium" has the word "Mega" in its name, and our sed filter for adding a space between Mega and Pokemon names for Mega Evolution Pokemon
# inadvertently adds a space in Meganium's name, turning it into "Mega nium". This has happened with other Pokemon while testing, as, for example, Meoletta has
# an Aria form, but when the sed filter for this was originally " sed 's/Aria/ Aria Form/'", the Pokemon "Ariados" became " Aria Formdos". This was easily
# fixed by changing that sed filter to "sed 's/MeloettaAria/Meloetta Aria Form/'" to avoid the issue with Ariados. Unfortunatley, there isn't a way to
# change the Mega Evolution filter to account for this, other than to make filters for each individual Mega Evolution, of which there are almost 50, so making
# a specific filter for fixing Meganium in the output is ultimately more efficient
sed 's/Mega nium/Meganium/' |\
#This final line removes all empty lines and lines that appear empty but have some spaces in them. Due to the nature of our sed commands in both our variable
# and output, this significantly cleans things up and gets rid of a lot of random, empty blocks in the output for significantly improved readability.
sed '/^$/d'

exit 0 #exits the program after a valid type had its Pokemon successfully listed

#This script was quite a chore to produce, though I'm proud of the results. There was likley a better way to format output that continuously run the script and
# check for potential errors, but no better idea came to me than to do it that way. In the end, the script functions as intended and gets the job done. I 
# considered having another elment of it that either counts the number of Pokemon outputted or pulls the text from the Bulbapedia page indicating how many
# Pokemon of that type exist, but ultimately the base script became time consuming enough that I decided to scrap it for now.S
