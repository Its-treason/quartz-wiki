**abcde** (**a** **b**etter **CD** **e**ncoder) is a Linux terminal program for ripping CD's. It can automagically search for Music Metadata and encode the Music in various different formats.

### Install (Debian)

abcde is available in the official Repository. The `--no-install-recommends` should be used, because x11 will otherwise be installed.

A package for the target codec should also be installed

- `vorbis-tools` for OGG. This is the default.
- `flac` for FLAC files.
- `lame` for MP3 files.

apt install abcde flac --no-install-recommends

### Usage

#### Config

The config file for abcde is located under `~/.abcde.conf`.

Example Config for FLAC. Extracted music will be used under `~/Music` grouped by Album name.

```ini
OUTPUTTYPE=flac
OUTPUTFORMAT='./Music/${ALBUMFILE}/${ARTISTFILE} - ${TRACKFILE}'
VAOUTPUTFORMAT='./Music/${ALBUMFILE}/${ARTISTFILE} - ${TRACKFILE}'
FLACOPTS='-8'
PADTRACKS=y

# Eject CD after reading is complete
EJECTCD=y
```

#### Ripping CD's

After the config file is created `abcde` can be executed and will automatically start ripping the currently inserted Disk. abcde uses "CD Paranoia" to extract the Music and displaying the progress bar. You can see here: [https://www.xiph.org/paranoia/faq.html#progbar](https://www.xiph.org/paranoia/faq.html#progbar) what the different symbols mean.

The `-N` can be used to make the process non-interactive, abcde will always use the first option for Metadata information.

#### Moving "cover.jpg" back into the extraction folder

If abcde found a Cover to the CD online, it will apply it to all extracted Tracks and will then create an "albumart_backup" folder inside the target folder. For Jellyfin and other Applications, it is useful to have the cover inside the target folder directly. This can be fixed with a script.

```bash
#!/bin/bash

# Set the base directory where your music albums are stored
MUSIC_DIR="./Music"

# Find all albumart_backup directories


find "$MUSIC_DIR" -type d -name "albumart_backup" | while read -r backup_dir; do
    # Get the parent album directory
    album_dir=$(dirname "$backup_dir")
    
    # Check if cover.jpg exists in the backup directory
    if [ -f "$backup_dir/cover.jpg" ]; then
        echo "Moving cover from $backup_dir to $album_dir"
        
        # Move the cover.jpg to the album directory
        mv "$backup_dir/cover.jpg" "$album_dir/"
        
        # Check if the move was successful
        if [ $? -eq 0 ]; then
            echo "Successfully moved cover.jpg to $album_dir"
            
            # Remove the now-empty albumart_backup directory
            rm -rf "$backup_dir"
            echo "Removed $backup_dir"
        else
            echo "Failed to move cover.jpg from $backup_dir to $album_dir"
        fi
    else
        echo "No cover.jpg found in $backup_dir"
        # Remove the directory anyway if it's empty or doesn't have cover.jpg
        rm -rf "$backup_dir"
        echo "Removed $backup_dir"
    fi
    
    echo "-----------------------------------"
done

echo "All album art processing completed."
```
