#!/data/data/com.termux/files/usr/bin/bash
# TrashFinder for Android (Termux/Terminal) - Snappy Dev Style

ROOT="/sdcard"
shiz=0
[ $(command -v shizuku 2>/dev/null) ] && shiz=1

hr() {
    n=$1
    awk 'BEGIN{ split("B KB MB GB TB",u); i=1; while($1>=1024){$1/=1024; i++} printf "%.2f %s", $1, u[i] }' <<< "$n"
}

# Empty dirs
d1=$(find "$ROOT" -type d -empty 2>/dev/null)
n1=$(echo "$d1" | grep -c "/" || echo 0)

# Trash files
f1=$(find "$ROOT" -type f \( -iname "*.log" -o -iname "*.tmp" -o -iname "*.bak" \) 2>/dev/null)
n2=$(echo "$f1" | grep -c "/" || echo 0)
s2=$(echo "$f1" | xargs -r stat -c %s 2>/dev/null | awk '{s+=$1} END {print s+0}')

# Old screenshots
ss="$ROOT/Pictures/Screenshots"
if [ -d "$ss" ]; then
    f2=$(find "$ss" -type f -mtime +7 2>/dev/null)
    n3=$(echo "$f2" | grep -c "/" || echo 0)
    s3=$(echo "$f2" | xargs -r stat -c %s 2>/dev/null | awk '{s+=$1} END {print s+0}')
else
    f2=""
    n3=0
    s3=0
fi

# Output
echo -e "\n[Empty Folders] ($n1)"
echo "$d1"
echo -e "\n[Logs/Temp/Backup Files] ($n2, $(hr $s2))"
echo "$f1"
echo -e "\n[Screenshots >7d] ($n3, $(hr $s3))"
echo "$f2"

echo -e "\n===== SUMMARY ====="
echo "Empty: $n1"
echo "Trash: $n2, $(hr $s2)"
echo "Screenshots: $n3, $(hr $s3)"

menu() {
    echo -e "\nSee file paths by group:"
    echo "1) Empty"
    echo "2) Trash"
    echo "3) Screenshots"
    echo "4) Quit"
    read -p "Pick [1-4]: " x
    case $x in
        1) echo -e "\n[Empty]:"; echo "$d1";;
        2) echo -e "\n[Trash]:"; echo "$f1";;
        3) echo -e "\n[Screenshots]:"; echo "$f2";;
        4) exit 0;;
        *) echo "Nope";;
    esac
}

read -p "\nSee file paths by group? (y/n): " y
[[ "$y" =~ ^[Yy]$ ]] && while :; do menu; done

[ $shiz -eq 1 ] && echo -e "\n[Shizuku: available for more access]"

exit 0 