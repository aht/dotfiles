#### Use curl to query dict.org over DICT protocol

# Given one arg, look in WordNet (elsewhere if not found).
# Given two, look in the specified database.
d () {
    local query=$(echo $1 | sed 's/ /%20/g')
    case $# in
        1) curl -s dict://dict.org/d:${query}:wn > /tmp/$$
           if grep '^552 no match' /tmp/$$ >& /dev/null
           then
               curl -s dict://dict.org/d:${query} > /tmp/$$
               if grep '^552 no match' /tmp/$$ >& /dev/null
               then
                   curl -s dict://dict.org/m:${query}:english > /tmp/$$
               fi
           fi
           ;;
        2) curl -s dict://dict.org/d:${query}:${2} > /tmp/$$;;
    esac 
    grep -vE '^(150|220|250|221|\.)' /tmp/$$
    /bin/rm /tmp/$$
}

# Look in Webster
wd () { d $1 web1913; } 

# Find matches with optional strat/db.
# Avaialbe strategies, optained with "curl -s dict://dict.org/show:strat", are:
#   exact "Match headwords exactly"
#   prefix "Match prefixes"
#   substring "Match substring occurring anywhere in a headword"
#   suffix "Match suffixes"
#   re "POSIX 1003.2 (modern) regular expressions"
#   regexp "Old (basic) regular expressions"
#   soundex "Match using SOUNDEX algorithm"
#   lev "Match headwords within Levenshtein distance one"
#   word "Match separate words within headwords"
m () {
    local strat db

    if [ $1 = -s ]; then
      strat=$2
      shift 2
    fi

    if [ $# = 2 ]; then
        db=$2
    else
        db=english
    fi

    local query=$(echo $1 | sed 's/ /%20/g')

    curl -s dict://dict.org/m:${query}:${db}:${strat} \
    | grep -vE '^(220|250|221|\.)'
}

#### Query wikipedia via DNS.
wiki () {
    local query=$(echo $@ | sed 's/ /_/g')
    dig +short txt ${query}.wp.dg.cx \
    | 9 sed -e 's/(^")|("$)//g' -e 's/" "//g' \
    | 9 fmt
}
