CurvedPathDecoder
=================

Command line utility to turn an OsiriX curved path file into something usable.

Positions are in Dicom Patient Space.
Tessellation uses the same flatness as OsiriX does when it is working with the bezier.

A MacOS binary is available at
http://download.naturalimage.ch/curvedPathDecoder.zip

Usage:
curvedPathDecoder [--tessellate] <curvedPathFile>
