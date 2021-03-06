����      ]�(]�(X  pngstest.c
 *
 * Copyright (c) 2021 Cosmin Truta
 * Copyright (c) 2013-2017 John Cunningham Bowler
 *
 * This code is released under the libpng license.
 * For conditions of distribution and use, see the disclaimer
 * and license in png.h
 *
 * Test for the PNG 'simplified' APIs.�KKe]�(�!glibc facility: turn on debugging�KKe]�(�mDefine the following to use this test against your installed libpng, rather
 * than the one being built here:�KKe]�(��1.6.1 added support for the configure test harness, which uses 77 to indicate
 * a skipped test, in earlier versions we need to succeed on a skipped test, so:�K&K(e]�(�Else nothing can be done�K/K/e]�(X  KNOWN ISSUES
 *
 * These defines switch on alternate algorithms for format conversions to match
 * the current libpng implementation; they are set to allow pngstest to pass
 * even though libpng is producing answers that are not as correct as they
 * should be.�K2K8e]�(X6  If true include unused static GPC functions and declare an external array
    * of them to hide the fact that they are unused.  This is for development
    * use while testing the correct function to use to take into account libpng
    * misbehavior, such as using a simple power law to correct sRGB to linear.�K:K>e]�(�BThe following is to support direct compilation of this file as C++�K@K@e]�(�__cplusplus�KHKHe]�(��During parallel runs of pngstest each temporary file needs a unique name,
 * this is used to permit uniqueness using a command line argument which can be
 * up to 22 characters long.�KJKMe]�(XJ  Generate random bytes.  This uses a boring repeatable algorithm and it
 * is implemented here so that it gives the same set of numbers on every
 * architecture.  It's a linear congruential generator (Knuth or Sedgewick
 * "Algorithms") but it comes from the 'feedback taps' table in Horowitz and
 * Hill, "The Art of Electronics".�KPKUe]�(��There are thirty three bits, the next bit in the sequence is bit-33 XOR
    * bit-20.  The top 1 bit is in u1, the bottom 32 are in u0.�K\K^e]�(�8First generate 8 new bits then shift them in at the end.�KbKbe]�(��Math support - neither Cygwin nor Visual Studio have C99 support and we need
 * a predictable rounding function, so make one here:�K~K�e]�(� Cast support: remove GCC whines.�K�K�e]�(��sRGB support: use exact calculations rounded to the nearest int, see the
 * fesetround() call in main().  sRGB_to_d optimizes the 8 to 16-bit conversion.�K�K�e]�(�range 0.0 .. 1.0�K�K�e]�(�not used�K�K�e]�(�.Arbitrary, but consistent with the libpng code�K�K�e]�(�unused�K�K�e]�(��The error that results from using a 2.2 power law in place of the correct
 * sRGB transform, given an 8-bit value which might be either sRGB or power-law.�K�K�e]�(�0Always allow an extra 1 here for rounding errors�K�K�e]�(�by experiment�K�K�e]�(�iRound trip the value through an 8-bit representation but using
       * non-matching to/from conversions.�MMe]�(�0Always allow an extra 1 here for rounding errors�MMe]�(��"multiple_algorithms" in this case means that a color-map has been
    * involved somewhere, so we can deduce that the values were forced to 8-bit
    * (like the via_linear case for 8-bit.)�M4M7e]�(�unused�MEMEe]�(�else memory�MGMGe]�(�else use file name�MHMHe]�(�fail on warnings too�MIMIe]�(�else delete temporary files�MKMKe]�(�do not reseed on each new file�MPMPe]�(�Zdo not ignore the gamma+background_rgb_to_gray
                          * libpng warning.�MQMRe]�(�--fast is currently the default�MeMee]�(�else on by default�MkMke]�(�additional flag�MqMqe]�(�ZA name table for all the formats - defines the format of the '+' arguments to
 * pngstest.�MsMue]�(�&Decode an argument to a format number.�M�M�e]�(�!Bitset/test functions for formats�M�M�e]�(�All off�M�M�e]�(�currently unused�M�M�e]�(�currently unused�MMe]�(�2set everything, including flags that are pointless�MMe]�(�-Eliminate redundant and unsupported settings.�M"M"e]�(�BGR is meaningless if no color:�M$M$e]�(�HACK: fixed value�M(M(e]�(�"AFIRST is meaningless if no alpha:�M,M,e]�(�HACK: fixed value�M1M1e]�(�THE Image STRUCTURE�M:M:e]�(��The super-class of a png_image, contains the decoded image plus the input
 * data necessary to re-read the file with a different format.�M;M=e]�(�GInitializer: also sets the permitted error limit for 16-bit operations.�MPMPe]�(�MReset the image to be read again - only needs to rewind the FILE* at present.�MWMXe]�(�WFree the image buffer; the buffer is re-used on a re-read, this is just for
 * cleanup.�M`Mbe]�(�ZDelete function; cleans out all the allocated data and the temporary file in
 * the image.�MlMne]�(��This is actually a re-initializer; allows an image structure to be re-used by
 * freeing everything that relates to an old image.�M�M�e]�(�aMake sure the image buffer is big enough; allows re-use of the buffer if the
 * image is re-read.�M�M�e]�(�(Make sure 16 bytes match the given byte.�M�M�e]�(�(Check for overwrite in the image buffer.�M�M�e]�(�ERROR HANDLING�M�M�e]�(�KLog a terminal error, also frees the libpng part of the image if necessary.�M�M�e]�(�YLog an error and close a file (just a utility to do both things in one
 * function call.)�M�M�e]�(�tMake sure the png_image has been freed - validates that libpng is doing what
 * the spec says and freeing the image.�M�M�e]�(�kSeparate out the gamma+background_rgb_to_gray warning because it may
    * produce opaque component errors:�MMe]�(�IMAGE COMPARISON/CHECKING�MMe]�(�~Compare the pixels of two images, which should be the same but aren't.  The
 * images must have been checked for a size match.�MMe]�(��The components, for grayscale images the gray value is in 'g' and if alpha
    * is not present 'a' is set to 255 or 65535 according to format.�MMe]�(��The background as the original sRGB 8-bit value converted to the final
    * integer format and as a double precision linear value in the range 0..1
    * for with partially transparent pixels.�MM!e]�(�linear r,g,b scaled to 0..1�M#M#e]�(�ABasic image formats; control the data but not the layout thereof.�M&M&e]�(��Read a Pixel from a buffer.  The code below stores the correct routine for
 * the format in a function pointer, these are the routines:�M*M,e]�(�>Given a format, return the correct one of the above functions.�M�M�e]�(��The color-map flag is irrelevant here - the caller of the function
    * returned must either pass the buffer or, for a color-mapped image, the
    * correct entry in the color-map.�M�Me]�(X�	  Conversion between pixel formats.  The code above effectively eliminates the
 * component ordering changes leaving three basic changes:
 *
 * 1) Remove an alpha channel by pre-multiplication or compositing on a
 *    background color.  (Adding an alpha channel is a no-op.)
 *
 * 2) Remove color by mapping to grayscale.  (Grayscale to color is a no-op.)
 *
 * 3) Convert between 8-bit and 16-bit components.  (Both directtions are
 *    relevant.)
 *
 * This gives the following base format conversion matrix:
 *
 *   OUT:    ----- 8-bit -----    ----- 16-bit -----
 *   IN     G    GA   RGB  RGBA  G    GA   RGB  RGBA
 *  8 G     .    .    .    .     lin  lin  lin  lin
 *  8 GA    bckg .    bckc .     pre' pre  pre' pre
 *  8 RGB   g8   g8   .    .     glin glin lin  lin
 *  8 RGBA  g8b  g8   bckc .     gpr' gpre pre' pre
 * 16 G     sRGB sRGB sRGB sRGB  .    .    .    .
 * 16 GA    b16g unpg b16c unpc  A    .    A    .
 * 16 RGB   sG   sG   sRGB sRGB  g16  g16  .    .
 * 16 RGBA  gb16 sGp  cb16 sCp   g16  g16' A    .
 *
 *  8-bit to 8-bit:
 * bckg: composite on gray background
 * bckc: composite on color background
 * g8:   convert sRGB components to sRGB grayscale
 * g8b:  convert sRGB components to grayscale and composite on gray background
 *
 *  8-bit to 16-bit:
 * lin:  make sRGB components linear, alpha := 65535
 * pre:  make sRGB components linear and premultiply by alpha  (scale alpha)
 * pre': as 'pre' but alpha := 65535
 * glin: make sRGB components linear, convert to grayscale, alpha := 65535
 * gpre: make sRGB components grayscale and linear and premultiply by alpha
 * gpr': as 'gpre' but alpha := 65535
 *
 *  16-bit to 8-bit:
 * sRGB: convert linear components to sRGB, alpha := 255
 * unpg: unpremultiply gray component and convert to sRGB (scale alpha)
 * unpc: unpremultiply color components and convert to sRGB (scale alpha)
 * b16g: composite linear onto gray background and convert the result to sRGB
 * b16c: composite linear onto color background and convert the result to sRGB
 * sG:   convert linear RGB to sRGB grayscale
 * sGp:  unpremultiply RGB then convert to sRGB grayscale
 * sCp:  unpremultiply RGB then convert to sRGB
 * gb16: composite linear onto background and convert to sRGB grayscale
 *       (order doesn't matter, the composite and grayscale operations permute)
 * cb16: composite linear onto background and convert to sRGB
 *
 *  16-bit to 16-bit:
 * A:    set alpha to 65535
 * g16:  convert linear RGB to linear grayscale (alpha := 65535)
 * g16': as 'g16' but alpha is unchanged�MzM�e]�(�Simple copy:�M�M�e]�(�8-bit to 8-bit conversions�M�M�e]�(�"bckg: composite on gray background�M�M�e]�(�#bckc: composite on color background�M�M�e]�(�-g8: convert sRGB components to sRGB grayscale�MMe]�(�Jg8b: convert sRGB components to grayscale and composite on gray background�M&M&e]�(�8-bit to 16-bit conversions�MBMBe]�(�0lin: make sRGB components linear, alpha := 65535�MCMCe]�(�Gpre: make sRGB components linear and premultiply by alpha (scale alpha)�MgMge]�(�!pre': as 'pre' but alpha := 65535�M�M�e]�(�Gglin: make sRGB components linear, convert to grayscale, alpha := 65535�M�M�e]�(�Hgpre: make sRGB components grayscale and linear and premultiply by alpha�M�M�e]�(�"gpr': as 'gpre' but alpha := 65535�M�M�e]�(�98-bit to 16-bit conversions for gAMA 45455 encoded values�M�M�e]�(�6Lin: make gAMA 45455 components linear, alpha := 65535�M�M�e]�(�MPre: make gAMA 45455 components linear and premultiply by alpha (scale alpha)�MMe]�(�!Pre': as 'Pre' but alpha := 65535�M,M,e]�(�MGlin: make gAMA 45455 components linear, convert to grayscale, alpha := 65535�MRMSe]�(�RGpre: make gAMA 45455 components grayscale and linear and premultiply by
 * alpha.�MeMge]�(�"Gpr': as 'Gpre' but alpha := 65535�MyMye]�(�16-bit to 8-bit conversions�M�M�e]�(�5sRGB: convert linear components to sRGB, alpha := 255�M�M�e]�(�Dunpg: unpremultiply gray component and convert to sRGB (scale alpha)�M�M�e]�(�Funpc: unpremultiply color components and convert to sRGB (scale alpha)�M�M�e]�(�Jb16g: composite linear onto gray background and convert the result to sRGB�M�M�e]�(�Kb16c: composite linear onto color background and convert the result to sRGB�M�M�e]�(�(sG: convert linear RGB to sRGB grayscale�MMe]�(�5sGp: unpremultiply RGB then convert to sRGB grayscale�MMe]�(�+sCp: unpremultiply RGB then convert to sRGB�M M e]�(�Dgb16: composite linear onto background and convert to sRGB grayscale�M5M5e]�(�F(order doesn't matter, the composite and grayscale operations permute)�M6M6e]�(�:cb16: composite linear onto background and convert to sRGB�MLMLe]�(�16-bit to 16-bit conversions�MlMle]�(�A:    set alpha to 65535�MmMme]�(�=g16:  convert linear RGB to linear grayscale (alpha := 65535)�MxMxe]�(�%g16': as 'g16' but alpha is unchanged�M�M�e]�(�AUnused functions (to hide them from GCC unused function warnings)�M�M�e]�(Xt  OUT:    ----- 8-bit -----    ----- 16-bit -----
 *   IN     G    GA   RGB  RGBA  G    GA   RGB  RGBA
 *  8 G     .    .    .    .     lin  lin  lin  lin
 *  8 GA    bckg .    bckc .     pre' pre  pre' pre
 *  8 RGB   g8   g8   .    .     glin glin lin  lin
 *  8 RGBA  g8b  g8   bckc .     gpr' gpre pre' pre
 * 16 G     sRGB sRGB sRGB sRGB  .    .    .    .
 * 16 GA    b16g unpg b16c unpc  A    .    A    .
 * 16 RGB   sG   sG   sRGB sRGB  g16  g16  .    .
 * 16 RGBA  gb16 sGp  cb16 sCp   g16  g16' A    .
 *
 * The matrix is held in an array indexed thus:
 *
 *   gpc_fn[out_format & BASE_FORMATS][in_format & BASE_FORMATS];�M�M�e]�(�aThis will produce a compile time error if the FORMAT_FLAG values don't
 * match the above matrix!�M�M�e]�(�in�M�M�e]�(�out�M�M�e]�(�Iout: G-8     GA-8     RGB-8    RGBA-8    G-16     GA-16   RGB-16  RGBA-16�M�M�e]�(��The array is repeated for the cases where both the input and output are color
 * mapped because then different algorithms are used.�M�M�e]�(�in�M�M�e]�(�out�M�M�e]�(�Iout: G-8     GA-8     RGB-8    RGBA-8    G-16     GA-16   RGB-16  RGBA-16�M�M�e]�(X  The error arrays record the error in the same matrix; 64 entries, however
 * the different algorithms used in libpng for colormap and direct conversions
 * mean that four separate matrices are used (for each combination of
 * colormapped and direct.)
 *
 * In some cases the conversion between sRGB formats goes via a linear
 * intermediate; an sRGB to linear conversion (as above) is followed by a simple
 * linear to sRGB step with no other conversions.  This is done by a separate
 * error array from an arbitrary 'in' format to one of the four basic outputs
 * (since final output is always sRGB not colormapped).
 *
 * These arrays may be modified if the --accumulate flag is set during the run;
 * then instead of logging errors they are simply added in.
 *
 * The three entries are currently for transparent, partially transparent and
 * opaque input pixel values.  Notice that alpha should be exact in each case.
 *
 * Errors in alpha should only occur when converting from a direct format
 * to a colormapped format, when alpha is effectively smashed (so large
 * errors can occur.)  There should be no error in the '0' and 'opaque'
 * values.  The fourth entry in the array is used for the alpha error (and it
 * should always be zero for the 'via linear' case since this is never color
 * mapped.)
 *
 * Mapping to a colormap smashes the colors, it is necessary to have separate
 * values for these cases because they are much larger; it is very much
 * impossible to obtain a reasonable result, these are held in
 * gpc_error_to_colormap.�M�M�e]�(�extra check also required�M�M�e]�(�machine generated�M�M�e]�(�COLORMAP flag check�M�M�e]�(�flag checks�M�M�e]�(�Basic pixel information:�M�M�e]�(�Input image�M�M�e]�(�Output image�M�M�e]�(��'background' is the value passed to the gpc_ routines, it may be NULL if
    * it should not be used (*this* program has an error if it crashes as a
    * result!)�M�M�e]�(�Precalculated values:�M�M�e]�(�#Value of input alpha that is opaque�M�M�e]�(�#Sample values come from the palette�M�M�e]�(�'Accumulate component errors (don't log)�M�M�e]�(�Output is 8-bit (else 16-bit)�M�M�e]�(�,A function to perform the required transform�M�M�e]�(�CFor 'via_linear' transforms the final, from linear, step, else NULL�MMe]�(�eThree error values for transparent, partially transparent and opaque
       * input pixels (in turn).�MMe]�(�=Where these are stored in the static array (for 'accumulate')�M
M
e]�(�>Return a 'transform' as above for the given format conversion.�MMe]�(�,Store the original images for error messages�MMe]�(�set by caller if required�M&M&e]�(�1The loaders (which need the ordering information)�M)M)e]�(� Remove the ordering information:�M-M-e]�(�#Check for an error in this program:�M5M5e]�(��The input is not colormapped but the output is, the errors will
       * typically be large (only the grayscale-no-alpha case permits preserving
       * even 8-bit values.)�MDMGe]�(Xm  The caller handles the colormap->pixel value conversion, so the
       * transform function just gets a pixel value, however because libpng
       * currently contains a different implementation for mapping a colormap if
       * both input and output are colormapped we need different conversion
       * functions to deal with errors in the libpng implementation.�MOMTe]�(��Follow the libpng simplified API rules to work out what to pass to the gpc
    * routines as a background value, if one is not required pass NULL so that
    * this program crashes in the even of a programming error.�M]M`e]�(�default: not required�MaMae]�(�BRule 1: background only need be supplied if alpha is to be removed�McMce]�(X�  The input value is 'NULL' to use the background and (otherwise) an sRGB
       * background color (to use a solid color).  The code above uses a fixed
       * byte value, BUFFER_INIT8, for buffer even for 16-bit output.  For
       * linear (16-bit) output the sRGB background color is ignored; the
       * composition is always on the background (so BUFFER_INIT8 * 257), except
       * that for the colormap (i.e. linear colormapped output) black is used.�MfMle]�(�sRGB output�M�M�e]�(�`TODO: sometimes libpng uses the power law conversion here, how
                * to handle this?�M�M�e]�(�#grayscale: libpng only looks at 'g'�M�M�e]�(�`TODO: sometimes libpng uses the power law conversion here, how
                * to handle this?�M�M�e]�(�]TODO: sometimes libpng uses the power law conversion here, how
             * to handle this?�M�M�e]�(��Else the output is colormapped and a background color must be
          * provided; if pngstest crashes then that is a bug in this program
          * (though libpng should png_error as well.)�M�M�e]�(�not used�M�M�e]�(�not used�M�M�e]�(�)Copy the error values into the Transform:�M�M�e]�(X&  Compare two pixels.
 *
 * OLD error values:
static int error_to_linear = 811; * by experiment *
static int error_to_linear_grayscale = 424; * by experiment *
static int error_to_sRGB = 6; * by experiment *
static int error_to_sRGB_grayscale = 17; * libpng error by calculation +
                                            2 by experiment *
static int error_in_compose = 2; * by experiment *
static int error_in_premultiply = 1;
 *
 * The following is *just* the result of a round trip from 8-bit sRGB to linear
 * then back to 8-bit sRGB when it is done by libpng.  There are two problems:
 *
 * 1) libpng currently uses a 2.2 power law with no linear segment, this results
 * in instability in the low values and even with 16-bit precision sRGB(1) ends
 * up mapping to sRGB(0) as a result of rounding in the 16-bit representation.
 * This gives an error of 1 in the handling of value 1 only.
 *
 * 2) libpng currently uses an intermediate 8-bit linear value in gamma
 * correction of 8-bit values.  This results in many more errors, the worse of
 * which is mapping sRGB(14) to sRGB(0).
 *
 * The general 'error_via_linear' is more complex because of pre-multiplication,
 * this compounds the 8-bit errors according to the alpha value of the pixel.
 * As a result 256 values are pre-calculated for error_via_linear.�M�M�e]�(�Indexed by 8-bit alpha�M�M�e]�(�transparent pixel�M�M�e]�(X�  16-bit values less than 128.5 get rounded to 8-bit 0 and so the worst
       * case error arises with 16-bit 128.5, work out what sRGB
       * (non-associated) value generates 128.5; any value less than this is
       * going to map to 0, so the worst error is floor(value).
       *
       * Note that errors are considerably higher (more than a factor of 2)
       * because libpng uses a simple power law for sRGB data at present.
       *
       * Add .1 for arithmetic errors inside libpng.�M�M�e]�(�(128.5 * 255 / 65535)�M 	M 	e]�(�aThis is actually 14.99, but, despite the closeness to 15, 14 seems to work
    * ok in this case.�M	M	e]�(��And as a result the *read* format which did any background processing
       * was itself linear, so the background color information is also
       * linear.�MC	MF	e]�(�not used�MR	MR	e]�(�or palette index�Mu	Mu	e]�(�CEliminate the case where the input and output values match exactly.�M�	M�	e]�(��Eliminate the case where the output pixel is transparent and the output
    * is 8-bit - any component values are valid.  Don't check the input alpha
    * here to also skip the 16-bit small alpha cases.�M�	M�	e]�(��Check for alpha errors first; an alpha error can damage the components too
    * so avoid spurious checks on components if one is found.�M�	M�	e]�(�(If accumulating check the components too�M�	M�	e]�(�xNow if *either* of the output alphas are 0 but alpha is within tolerance
    * eliminate the 8-bit component comparison.�M�	M�	e]�(�else just signal an alpha error�M�	M�	e]�(�exact match�M�	M�	e]�(�.Mismatch on a component, check the input alpha�M�	M�	e]�(�opaque�M�	M�	e]�(�partially transparent�M�	M�	e]�(�transparent�M�	M�	e]�(�within the error limits�M�	M�	e]�(�[Handle a component mis-match; log it, just return an error code, or
       * accumulate it.�M�	M�	e]�(�!to cause the caller to keep going�M�	M�	e]�(�CFailure to match and not accumulating, so the error must be logged.�M�	M�	e]�(X  Given a format return the number of channels and the location of
    * each channel.
    *
    * The mask 'loc' contains the component offset of the channels in the
    * following order.  Note that if 'format' is grayscale the entries 1-3 must
    * all contain the location of the gray channel.
    *
    * 0: alpha
    * 1: red or gray
    * 2: green or gray
    * 3: blue or gray�M�	M�	e]�(�not present�M
M
e]�(��Compare two images, the original 'a', which was written out then read back in
 * to * give image 'b'.  The formats may have been changed.�M#
M%
e]�(�This should never happen:�M:
M:
e]�(�'Set up the background and the transform�M?
M?
e]�(�'Find the first row and inter-row space.�MB
MB
e]�(X	  First shortcut the two colormap case by comparing the image data; if it
    * matches then we expect the colormaps to match, although this is not
    * absolutely necessary for an image match.  If the colormaps fail to match
    * then there is a problem in libpng.�MN
MR
e]�(�0Only check colormap entries that actually exist;�MU
MU
e]�(��Do this the slow way to accumulate the 'in_use' flags, don't break out
       * of the loop until the end; this validates the color-mapped data to
       * ensure all pixels are valid color-map indexes.�M_
Mb
e]�(�1If the buffers match then the colormaps must too.�Mx
Mx
e]�(��Do the color-maps match, entry by entry?  Only check the 'in_use'
          * entries.  An error here should be logged as a color-map error.�M{
M}
e]�(�match by default�M�
M�
e]�(�:This is used in logpixel to get the error message correct.�M�
M�
e]�(X-  The colormap entries should be valid, but because libpng doesn't
             * do any checking at present the original image may contain invalid
             * pixel values.  These cause an error here (at present) unless
             * accumulating errors in which case the program just ignores them.�M�
M�
e]�(�:All the mismatches are logged here; there can only be 256!�M�
M�
e]�(�<If requested, copy the error values back from the Transform.�M�
M�
e]�(�force a continue�M�
M�
e]�(��else the image buffers don't match pixel-wise so compare sample values
       * instead, but first validate that the pixel indexes are in range (but
       * only if not accumulating, when the error is ignored.)�M�
M�
e]�(�2^32: GCC sprintf warning�M�
M�
e]�(�2^8: real maximum value�M�
M�
e]�(�_Check the original image first,
          * TODO: deal with input images with bad pixel values?�M�
M�
e]�(�SAFE�M�
M�
e]�(�SAFE�M�
M�
e]�(X�  We can directly compare pixel values without the need to use the read
    * or transform support (i.e. a memory compare) if:
    *
    * 1) The bit depth has not changed.
    * 2) RGB to grayscale has not been done (the reverse is ok; we just compare
    *    the three RGB values to the original grayscale.)
    * 3) An alpha channel has not been removed from an 8-bit format, or the
    *    8-bit alpha value of the pixel was 255 (opaque).
    *
    * If an alpha channel has been *added* then it must have the relevant opaque
    * value (255 or 65535).
    *
    * The fist two the tests (in the order given above) (using the boolean
    * equivalence !a && !b == !(a || b))�M�
M�
e]�(�Was an alpha channel changed?�M�
M�
e]�(��Was an alpha channel removed?  (The third test.)  If so the direct
       * comparison is only possible if the input alpha is opaque.�M�
M�
e]�(�Was an alpha channel added?�M�
M�
e]�(X  The channels may have been moved between input and output, this finds
       * out how, recording the result in the btoa array, which says where in
       * 'a' to find each channel of 'b'.  If alpha was added then btoa[alpha]
       * ends up as 4 (and is not used.)�M�
M�
e]�(Xe  The following are used only if the formats match, except that
          * 'bchannels' is a flag for matching formats.  btoa[x] says, for each
          * channel in b, where to find the corresponding value in a, for the
          * bchannels.  achannels may be different for a gray to rgb transform
          * (a will be 1 or 2, b will be 3 or 4 channels.)�M�
Me]�(�Hence the btoa array.�MMe]�(�may be '4' for alpha�MMe]�(�$location of alpha channel in image b�MMe]�(�Won't match an image b channel�MMe]�(�$location of alpha channel in image a�MMe]�(�ZDirect compare is not possible, cancel out all the corresponding local
       * variables.�MM e]�(�4 == not present�M#M#e]�(�Do the fast test if possible.�M9M9e]�(X>  Check each 'b' channel against either the corresponding 'a'
             * channel or the opaque alpha value, as appropriate.  If
             * alpha_removed value is set (not 4) then also do this only if the
             * 'a' alpha channel (alpha_removed) is opaque; only relevant for
             * the 8-bit case.�M<MAe]�(�16-bit checks�MBMBe]�(�FALLTHROUGH�MKMKe]�(�FALLTHROUGH�MNMNe]�(�FALLTHROUGH�MQMQe]�(�x loop�MUMUe]�(�
impossible�MWMWe]�(�FALLTHROUGH�MaMae]�(�FALLTHROUGH�MdMde]�(�FALLTHROUGH�MgMge]�(�x loop�MkMke]�(�
impossible�MmMme]�(�VIf we get to here the fast match failed; do the slow match for this
          * pixel.�MrMte]�(�
error case�MvMve]�(�<If requested, copy the error values back from the Transform.�MzMze]�(�gRead the file; how the read gets done depends on which of input_file and
 * input_memory have been set.�M�M�e]�(�+This must be set after the begin_read call:�M�M�e]�(��Have an initialized image with all the data we need plus, maybe, an
    * allocated file (myfile) or buffer (mybuffer) that need to be freed.�M�M�e]�(�'Print both original and output formats.�M�M�e]�(��'NO_CHANGE' combined with the color-map flag forces the base format
       * flags to be set on read to ensure that the original representation is
       * not lost in the pass through a colormap format.�M�M�e]�(��Reads from a filename, which must be in image->file_name, but uses
 * image->opts to choose the method.  The file is always read in its native
 * format (the one the simplified API suggests).�M�M�e]�(�memory or stdio.�M�M�e]�(�memory�M�M�e]�(��cb is the length of the file as a (long) and
                      * this is greater than the maximum amount of
                      * memory that can be requested from malloc.�M$M'e]�(X<  Experimental. Coverity says tmpfile() is insecure because it
       * generates predictable names.
       *
       * It is possible to satisfy Coverity by using mkstemp(); however,
       * any platform supporting mkstemp() undoubtedly has a secure tmpfile()
       * implementation as well, and doesn't need the fix.  Note that
       * the fix won't work on platforms that don't support mkstemp().
       *
       * https://www.securecoding.cert.org/confluence/display/c/
       * FIO21-C.+Do+not+create+temporary+files+in+shared+directories
       * says that most historic implementations of tmpfile() provide
       * only a limited number of possible temporary file names
       * (usually 26) before file names are recycled. That article also
       * provides a secure solution that unfortunately depends upon mkstemp().�MMM[e]�(�gHide the filename immediately and ensure that the file does
         * not exist after the program ends�MfMhe]�(�SIMPLIFIED_WRITE_STDIO�M�M�e]�(�SIMPLIFIED_WRITE_STDIO�M�M�e]�(�(Afterwards, or freeimage will delete it!�M�M�e]�(�SIMPLIFIED_WRITE_STDIO�M�M�e]�(�SIMPLIFIED_WRITE_STDIO�M�M�e]�(�
use memory�M�M�e]�(�fThis is non-fatal but ignoring it was causing serious problems in
          * the macro to be ignored:�M�M�e]�(�>This is also non-fatal but it safes safer to error out anyway:�M�M�e]�(X�  'output' has an initialized temporary image, read this back in and compare
    * this against the original: there should be no change since the original
    * format was written unmodified unless 'convert_to_8bit' was specified.
    * However, if the original image was color-mapped, a simple read will zap
    * the linear, color and maybe alpha flags, this will cause spurious failures
    * under some circumstances.�M�M�e]�(�
via linear�M�M�e]�(�0Copy the original data, stealing it from 'image'�M�M�e]�(��Use the low bit of 'counter' to indicate whether or not to do alpha
       * removal with a background color or by composting onto the image; this
       * step gets skipped if it isn't relevant�M
Me]�(XH  If there is a format change that removes the alpha channel then
          * the background is relevant.  If the output is 8-bit color-mapped
          * then a background color *must* be provided, otherwise there are
          * two tests to do - one with a color, the other with NULL.  The
          * NULL test happens second.�MMe]�(�pAlpha/transparency will be removed, the background is
                * relevant: make it a color the first time�M!M#e]�(��BUT if the output is to a color-mapped 8-bit format then
                * the background must always be a color, so increment 'counter'
                * to skip the NULL test.�M'M*e]�(��Otherwise an alpha channel is not being eliminated, just leave
             * background NULL and skip the (counter & 1) NULL test.�M0M2e]�(�!else just use NULL for background�M6M6e]�(�$in case read_file needs to change it�M9M9e]�(�7Make sure the file just read matches the original file.�M?M?e]�(�
via linear�M@M@e]�(��Write the *copy* just made to a new file to make sure the write
             * side works ok.  Check the conversion to sRGB if the copy is
             * linear.�MEMHe]�(�convert to 8bit�MJMJe]�(��Validate against the original too; the background is needed here
             * as well so that compare_two_images knows what color was used.�MNMPe]�(�='output' is linear, convert to the corresponding sRGB format.�MXMYe]�(�convert to 8bit�M[M[e]�(X�  This may involve a conversion via linear; in the ideal world
                * this would round-trip correctly, but libpng 1.5.7 is not the
                * ideal world so allow a drift (error_via_linear).
                *
                * 'image' has an alpha channel but 'output' does not then there
                * will a strip-alpha-channel operation (because 'output' is
                * linear), handle this by composing on black when doing the
                * comparison.�M_Mge]�(�
via_linear�MhMhe]�(�PNG_SIMPLIFIED_WRITE_SUPPORTED�MmMme]�(�9ensure that the random numbers don't depend on file order�M�M�e]�(�/Ensure that stderr is flushed into any log file�M�M�e]�(�=stdout may not be line-buffered if it is piped to a file, so:�M�M�e]�(�,This error should not exist in 1.7 or later:�M�M�e]�(�initialize random number seeds�M�M�e]�(�skipped: no support�M�M�e]�(�skipped: no support�M�M�e]�(�Safe: checked above�MMe]�(�oLoop reading files, use a static buffer to simplify this and just
             * stop if the name gets to long.�M4M6e]�(��Don't allow '\0' in file names, and terminate with '\n' or,
                * for -0, just '\0' (use -print0 to find to make this work!)�M=M?e]�(�.so that the increment below sets it to 0 again�MLMLe]�(X�  contrib/libtests/pngstest-errors.h\n");
      printf(" *\n");
      printf(" * BUILT USING:" PNG_HEADER_VERSION_STRING);
      printf(" *\n");
      printf(" * This code is released under the libpng license.\n");
      printf(" * For conditions of distribution and use, see the disclaimer\n");
      printf(" * and license in png.h\n");
      printf(" *\n");
      printf(" * THIS IS A MACHINE GENERATED FILE: do not edit it directly!\n");
      printf(" * Instead run:\n");
      printf(" *\n");
      printf(" *    pngstest --accumulate\n");
      printf(" *\n");
      printf(" * on as many PNG files as possible; at least PNGSuite and\n");
      printf(" * contrib/libtests/testpngs.\n");
      printf("�MfMte]�(�in�MwMwe]�(�out�MwMwe]�(�a�MwMwe]�(�	input: %s�M|M|e]�(�out�M�M�e]�(�	input: %s�M�M�e]�(�i�M�M�e]�(�o�M�M�e]�(�	input: %s�M�M�e]�(�END MACHINE GENERATED�M�M�e]�(�!PNG_SIMPLIFIED_READ_SUPPORTED�M�M�e]�(�So the test is skipped:�M�M�e]�(�PNG_SIMPLIFIED_READ_SUPPORTED�M�M�ee.