���      ]�(]�(X�  pngtrans.c - transforms the data in a row (used by both readers and writers)
 *
 * Copyright (c) 2018 Cosmin Truta
 * Copyright (c) 1998-2002,2004,2006-2018 Glenn Randers-Pehrson
 * Copyright (c) 1996-1997 Andreas Dilger
 * Copyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * This code is released under the libpng license.
 * For conditions of distribution and use, see the disclaimer
 * and license in png.h�KKe]�(�Turn on BGR-to-RGB mapping�KKe]�(�Turn on 16-bit byte swapping�K!K!e]�(�Turn on pixel packing�K0K0e]�(�Turn on packed pixel swapping�KDKDe]�(��Add a filler byte on read, or remove a filler or alpha byte on write.
 * The filler type has changed in v0.95 to allow future 2-byte fillers
 * for 48-bit input data, as well as to avoid problems with some compilers
 * that don't like bytes as parameters.�KrKve]�(��In libpng 1.6 it is possible to determine whether this is a read or write
    * operation and therefore to do more checking here for a valid call.�KK�e]�(X�  On read png_set_filler is always valid, regardless of the base PNG
          * format, because other transformations can give a format where the
          * filler code can execute (basically an 8 or 16-bit component RGB or G
          * format.)
          *
          * NOTE: usr_channels is not used by the read code!  (This has led to
          * confusion in the past.)  The filler is only used in the read code.�K�K�e]�(�not used in the write case�K�K�e]�(�write�K�K�e]�(��On write the usr_channels parameter must be set correctly at the
          * start to record the number of channels in the app-supplied data.�K�K�e]�(��There simply isn't any code in libpng to strip out bits
                   * from bytes when the components are less than a byte in
                   * size!�K�K�e]�(�~Here on success - libpng supports the operation, set the transformation
    * and the flag to say where the filler channel is.�K�K�e]�(�Added to libpng-1.2.7�K�K�e]�(�"The above may fail to do anything.�K�K�e]�(� Invert monochrome grayscale data�MMe]�(�PRIVATE�MMe]�(�^This test removed from libpng version 1.0.13 and 1.2.0:
   *   if (row_info->bit_depth == 1 &&�M
Me]�(�'Swaps byte order on 16-bit depth images�M=M=e]�(�PRIVATE�M>M>e]�(�XFeature added to libpng-1.6.11 for testing purposes, not
          * enabled by default.�MLMNe]�(�&Swaps pixel packing order within bytes�M�M�e]�(�PRIVATE�M�M�e]�(�PACKSWAP || WRITE_PACKSWAP�M�M�e]�(Xt  Remove a channel - this used to be 'png_do_strip_filler' but it used a
 * somewhat weird combination of flags to determine what to do.  All the calls
 * to png_do_strip_filler are changed in 1.5.2 to call this instead with the
 * correct arguments.
 *
 * The routine isn't general - the channel must be the channel at the start or
 * end (not in the middle) of each pixel.�M�M�e]�(�PRIVATE�M�M�e]�(�source pointer�M�M�e]�(�destination pointer�M�M�e]�(�One beyond end of row�M�M�e]�(Xt  At the start sp will point to the first byte to copy and dp to where
    * it is copied to.  ep always points just beyond the end of the row, so
    * the loop simply copies (channels-1) channels until sp reaches ep.
    *
    * at_start:        0 -- convert AG, XG, ARGB, XRGB, AAGG, XXGG, etc.
    *            nonzero -- convert GA, GX, RGBA, RGBX, GGAA, RRGGBBXX, etc.�M�M�e]�(�GA, GX, XG cases�M�M�e]�(�Skip initial filler�MMe]�(�,Skip initial channel and, for sp, the filler�MMe]�(�/For a 1 pixel wide image there is nothing to do�M	M	e]�(�Skip initial filler�MMe]�(�,Skip initial channel and, for sp, the filler�MMe]�(�bad bit depth�M$M$e]�(�9Finally fix the color type if it records an alpha channel�M(M(e]�(�RGBA, RGBX, XRGB cases�M-M-e]�(�Skip initial filler�M2M2e]�(�-Skip initial channels and, for sp, the filler�M4M4e]�(�6Note that the loop adds 3 to dp and 4 to sp each time.�M9M9e]�(�Skip initial filler�MDMDe]�(�-Skip initial channels and, for sp, the filler�MFMFe]�(�Copy 6 bytes, skip 2�MMMMe]�(�bad bit depth�MWMWe]�(�9Finally fix the color type if it records an alpha channel�M[M[e]�(�#The filler channel has gone already�MaMae]�(�Fix the rowbytes value.�McMce]�(�'Swaps red and blue bytes within a pixel�MiMie]�(�PRIVATE�MjMje]�(�READ_BGR || WRITE_BGR�M�M�e]�(�Added at libpng-1.5.10�M�M�e]�(�PRIVATE�M�M�e]�(�!num_palette can be 0 in MNG files�M�M�e]�(X\  Calculations moved outside switch in an attempt to stop different
       * compiler warnings.  'padding' is in *bits* within the last byte, it is
       * an 'int' because pixel_depth becomes an 'int' in the expression below,
       * and this calculation is used because it avoids warnings that other
       * forms produced on either GCC or MSVC.�M�M�e]�(�tin this case, all bytes must be 0 so we don't need
             * to unpack the pixels except for the rightmost one.�M�M�e]�(�CHECK_FOR_INVALID_INDEX�MMe]�(��This function returns a pointer to the user_transform_ptr associated with
 * the user transform functions.  The application should free any memory
 * associated with this pointer before png_write_destroy and png_read_destroy
 * are called.�M:M>e]�(�]See the comments in png.h - this is the sub-image row when reading an
    * interlaced image.�MNMPe]�(�!help the app not to fail silently�MTMTe]�(�invalid�M\M\e]�(�USER_TRANSFORM_INFO�M^M^e]�(�+READ_USER_TRANSFORM || WRITE_USER_TRANSFORM�M_M_e]�(�READ || WRITE�M`M`ee.