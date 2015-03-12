# Tower Defense #
## Running the game from the source ##
In order to run the game from the source code, you need to download and install LÖVE from love2d.org

Drop the folder into love.exe or create a shortcut in a batch file, eg.
`start "" "%PROGRAMFILES%\LOVE\love" .`

# Map Editor #
The map editor is found in maps/editor. To load a map, place the PNG file in a folder called "maps\_local" within maps/editor. Saving the map will generate a file with the same name with a .def extension in %APPDATA%/LOVE/editor/. Copy both files into the grandparent directory "maps".

The editor will similarly scan %APPDATA/LOVE/editor/ for .def files to load.