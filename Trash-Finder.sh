#!/bin/sh

ROOT="/sdcard"
shiz=0
command -v shizuku >/dev/null 2>&1 && shiz=1

hr() {
    n=$1
    awk 'BEGIN{ split("B KB MB GB TB",u); i=1; while($1>=1024){$1/=1024; i++} printf "%.2f %s", $1, u[i] }' <<EOF
$n
EOF
}

# Empty dirs
d1=$(find "$ROOT" -type d -empty 2>/dev/null)
n1=$(printf "%s\n" "$d1" | grep -c "/" 2>/dev/null || echo 0)

# Trash files
f1=$(find "$ROOT" -type f \( -iname "*.log" -o -iname "*.tmp" -o -iname "*.bak" \) 2>/dev/null)
n2=$(printf "%s\n" "$f1" | grep -c "/" 2>/dev/null || echo 0)
s2=$(printf "%s\n" "$f1" | xargs stat -c %s 2>/dev/null | awk '{s+=$1} END {print s+0}')

# Old screenshots
ss="$ROOT/Pictures/Screenshots"
if [ -d "$ss" ]; then
    f2=$(find "$ss" -type f -mtime +7 2>/dev/null)
    n3=$(printf "%s\n" "$f2" | grep -c "/" 2>/dev/null || echo 0)
    s3=$(printf "%s\n" "$f2" | xargs stat -c %s 2>/dev/null | awk '{s+=$1} END {print s+0}')
else
    f2=""
    n3=0
    s3=0
fi

# Output
echo "\n[Empty Folders] ($n1)"
echo "$d1"
echo "\n[Logs/Temp/Backup Files] ($n2, $(hr $s2))"
echo "$f1"
echo "\n[Screenshots >7d] ($n3, $(hr $s3))"
echo "$f2"

echo "\n===== SUMMARY ====="
echo "Empty: $n1"
echo "Trash: $n2, $(hr $s2)"
echo "Screenshots: $n3, $(hr $s3)"

menu() {
    echo "\nSee file paths by group:"
    echo "1) Empty"
    echo "2) Trash"
    echo "3) Screenshots"
    echo "4) Quit"
    printf "Pick [1-4]: "
    read x
    case "$x" in
        1) echo "\n[Empty]:"; echo "$d1";;
        2) echo "\n[Trash]:"; echo "$f1";;
        3) echo "\n[Screenshots]:"; echo "$f2";;
        4) exit 0;;
        *) echo "Nope";;
    esac
}

echo "\nSee file paths by group? (y/n): "
read y
case "$y" in
    y|Y) while :; do menu; done ;;
esac

[ "$shiz" -eq 1 ] && echo "\n[Shizuku: available for more access]"

exit 0 