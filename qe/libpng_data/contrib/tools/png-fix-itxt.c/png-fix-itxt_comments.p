���      ]�(]�(X\  png-fix-itxt version 1.0.0
 *
 * Copyright 2015 Glenn Randers-Pehrson
 * Last changed in libpng 1.6.18 [July 23, 2015]
 *
 * This code is released under the libpng license.
 * For conditions of distribution and use, see the disclaimer
 * and license in png.h
 *
 * Usage:
 *
 *     png-fix-itxt.exe < bad.png > good.png
 *
 * Fixes a PNG file written with libpng-1.6.0 or 1.6.1 that has one or more
 * uncompressed iTXt chunks.  Assumes that the actual length is greater
 * than or equal to the value in the length byte, and that the CRC is
 * correct for the actual length.  This program hunts for the CRC and
 * adjusts the length byte accordingly.  It is not an error to process a
 * PNG file that has no iTXt chunks or one that has valid iTXt chunks;
 * such files will simply be copied.
 *
 * Requires zlib (for crc32 and Z_NULL); build with
 *
 *     gcc -O -o png-fix-itxt png-fix-itxt.c -lz
 *
 * If you need to handle iTXt chunks larger than 500000 kbytes you must
 * rebuild png-fix-itxt with a larger values of MAX_LENGTH (or a smaller value
 * if you know you will never encounter such huge iTXt chunks).�KKe]�(�@Read one character (inchar), also return octet (c), break if EOF�K%K%e]�(�Skip 8-byte signature�K2K2e]�(�!EOF�K9K9e]�(�Read the length�K<K<e]�(�must be 32 bits!�K=K=e]�(�Read the chunkname�KCKCe]�(�?The iTXt chunk type expressed as integers is (105, 84, 88, 116)�KJKJe]�(�"To do: handle this more gracefully�KNKNe]�(�Initialize the CRC�KPKPe]�(�Copy the data bytes�KSKSe]�(�EOF�KYKYe]�(�Calculate the CRC�K\K\e]�(�Check the CRC�KaKae]�(�Update the CRC�KpKpe]�(�EOF�KtKte]�(�Update length bytes�KwKwe]�(�4Write the fixed iTXt chunk (length, name, data, crc)�K}K}e]�(�EOF�K�K�e]�(�9Copy bytes that were already read (length and chunk name)�K�K�e]�(�Copy data bytes and CRC�K�K�e]�(�EOF�K�K�e]�(�=The IEND chunk type expressed as integers is (73, 69, 78, 68)�K�K�e]�(�EOF�K�K�ee.