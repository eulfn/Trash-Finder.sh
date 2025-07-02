# TrashFinder.sh

A snappy shell script for Android (Termux/terminal) that helps you find junk files and empty folders in your storage—without deleting anything for you. Great for manual cleanup and seeing where your space is going!

## What It Does
- Scans `/sdcard` and subfolders for:
  - **Empty folders**
  - **.log, .tmp, .bak files**
  - **Screenshots older than 7 days** (in `Pictures/Screenshots/`)
- Groups results under clear headers
- Shows how many items and how much space each group takes
- Lets you review everything before you delete anything
- Optional interactive menu to browse file paths by group
- Detects [Shizuku](https://shizuku.rikka.app/) if available (for more access)

## How To Use
1. **Copy `TrashFinder.sh` to your Android device.**
2. **Open Termux or your favorite terminal app.**
3. Make it executable:
   ```sh
   chmod +x TrashFinder.sh
   ```
4. Run it:
   ```sh
   ./TrashFinder.sh
   ```
5. Review the output. If you want to see file paths by group, answer `y` when prompted.

## Output Explained
- `[Empty Folders]` — All empty directories found under `/sdcard`.
- `[Logs/Temp/Backup Files]` — All `.log`, `.tmp`, `.bak` files, with total count and size.
- `[Screenshots >7d]` — Screenshots older than 7 days, with count and size.
- `===== SUMMARY =====` — Quick stats for each group.
- **Interactive menu** — Lets you pick a group and see all file paths in that group.
- **Shizuku detected** — If you see this, you can use Shizuku for more file access (root-like, but safer).

## Notes
- **Nothing is deleted automatically!** You decide what to remove.
- Script uses only built-in tools (`find`, `stat`, `awk`, etc.) for max portability.
- Works best on Android with Termux, but should run in any POSIX shell with access to `/sdcard`.

---

Don't Forget To Add As Star!