#!/bin/bash
clear
#Color list
merah='\e[31m'
ijo='\e[1;32m'
kuning='\e[1;33m'
biru='\e[1;34m'
NC='\e[0m'
#intro
printf "${biru}	
			           Newscat APPS BOT ${ijo}
                      Code By : www.wanjas.com | tambangakun@gmail.com ${merah}
	                Agar Success Silahkan Hubungi Kontak Diatas 
"
printf "${kuning}	___________________________________________________________________________${NC}\n\n"
rm award.tmp aid.txt info.tmp 2> /dev/null
if [[ ! -f token.reg ]]
	then
printf "${kuning}[!]${NC} Insert Your Newscat Token: ";read token
echo "$token"  >> token.reg
fi
ctoken=$(cat token.reg)
regtoken=$(cat token.reg)
if [[ $regtoken == "$ctoken" ]]
	then
		printf "${ijo}[!]${NC} Token Registered To BOT Server | www.wanjas.com\n" 
else
	printf "${merah}[!]${NC} Please Register Your Token\n"
	printf "${kuning}[!]${NC} Contact : tambangakun@gmail.com\n"
	exit
fi
#token='5f52799c29f136364557effbe4cbf40e'
printf "${kuning}[!]${NC} Checking Token..."
checktoken=$(curl -s -d "token=$ctoken" 'http://www.newscat.com/api/user/info' -o "info.tmp")
getok=$(cat info.tmp | grep -Po '(?<=message":")[^"]*')
getid=$(cat info.tmp | grep -Po '(?<=id":")[^"]*')
gold=$(cat info.tmp | grep -Po '(?<=gold":")[^"]*')
if [[ $getok == "OK" ]]
		then
			printf "${ijo}Done${NC}\n"
			printf "${ijo}[!]${NC} Token : OK\n"
			printf "${ijo}[!]${NC} User ID : $getid\n"
			printf "${ijo}[!]${NC} Current Gold : $gold\n"
		else
			printf "${merah}Failed${NC}\n"
			printf "${merah}[!]${NC} Token : Error\n"
				    exit 0
fi
rm info.tmp 2> /dev/null
printf "${kuning}[!]${NC} Getting News ID.."
pages=$(shuf -i 1-5604 -n 1)
getnews=$(curl -s "http://www.newscat.com/api/article/list?page=$pages" -m 60 | grep -Po '(?<="aid":")[^"]*' > aid.txt )
getnewsok=$(cat aid.txt | sed -n 1p)
	if [[ $getnewsok == '' ]]
		then
			printf "${merah}Failer${NC}\n"
			exit
		else
		printf "${ijo}Done${NC}\n"
	fi
printf "${kuning}[!]${NC} Starting Bot..\n"
botstart(){
rm award.tmp 2> /dev/null
bot=$(curl -s -X POST -d "token=$ctoken&aid" 'http://www.newscat.com/api/article/award' -o 'award.tmp')
getmessage=$(cat award.tmp | grep -Po '(?<=message":")[^"]*')
getgold=$(cat award.tmp | grep -Po '(?<=gold":")[^"]*')
getreward=$(cat award.tmp | grep -Po '(?<=award":)[^,]*')
if [[ $getmessage == 'OK' ]]
	then
		printf "${ijo}[!]${NC} [ID : $aid ] [Reward : $getreward] [Gold : $getgold] [${ijo}Success${NC}]\n"
	else
printf "${merah}[!]${NC} [ID : $aid ] [Reward : 0] [Gold : $getgold] [${merah}Failed${NC}]\n"
fi
}
for aid in $(cat aid.txt)
do
botstart
sleep 3
done
