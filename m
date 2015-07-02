From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 02 Jul 2015 15:44:38 +0000
Subject: [PATCH 0/8] math-emu: Update kernel math-emu code from current glibc soft-fp
Message-Id: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, mpe@ellerman.id.au
List-ID: <linux-s390.vger.kernel.org>

From: Joseph Myers <joseph@codesourcery.com>

The include/math-emu code (used for alpha powerpc sh sparc, and to a
very limited extent for s390) was taken from an old version of glibc's
soft-fp code around 15 years ago (in the pre-git era, anyway, and some
of the initial code may have been developed around 1997-9 with a view
to being used in both places).  Since then, there have only been a
handful of small changes in the kernel version, while the glibc
version has been extensively developed, with many bug fixes,
performance improvements and miscellaneous cleanups, and is also now
used in libgcc, including for __float128 on x86_64 since GCC 4.3 (see
<https://ols.fedoraproject.org/GCC/Reprints-2006/sidwell-reprint.pdf>
for more information regarding performance improvements and use in
libgcc).

Thus the kernel version is missing those various improvements and it
would make sense to update it to include them (as was noted back in
2006 <https://sourceware.org/ml/libc-alpha/2006-02/msg00075.html> when
a large group of changes went into glibc).  I believe it also makes
sense to aim to have *exactly* the same code in both places to
simplify future updates of the kernel version.  (And in particular, as
external code imported largely verbatim into the kernel,
include/math-emu has never followed the kernel coding style and it
doesn't make sense for it to do so.)

I made an analysis of what kernel-local changes there were to this
code in <https://sourceware.org/ml/libc-alpha/2013-10/msg00345.html>,
and since then have added the various missing features to the glibc
version so that it is feature-complete regarding features used in the
kernel and so that exactly the same code is usable in both places.
This patch series updates the include/math-emu code, and its kernel
users, so that the shared code is identical to glibc's current soft-fp
code.

Regarding what testing seems appropriate for this patch series, see my
notes in <https://sourceware.org/ml/libc-alpha/2015-02/msg00107.html>.
I've done that testing for powerpc (both e500 and emulation of classic
hard float).  For reports of testing on other architectures, see
<https://sourceware.org/ml/libc-alpha/2015-05/msg00372.html> (alpha),
<https://sourceware.org/ml/libc-alpha/2015-04/msg00154.html> (s390),
<http://marc.info/?l=linux-sh&m2440262415395&w=2> (sh),
<http://marc.info/?l=linux-sparc&m2437304707509&w=2> (sparc); the
fixes indicated in those reports as needed on particular architectures
have been integrated into this version.

The bulk of the changes are updating the code from glibc, and a
detailed review of that part probably does not make sense in this
context if you want to aim for the same code in both places.  The
trickier part is the architecture updates for the various API changes
in soft-fp since the version used by the kernel.  The following
changes have occurred in the soft-fp API since the version used in the
kernel and so are addressed in the architecture updates in this patch
series.  (This list only includes changes relating to features used in
the kernel, not pure new features that aren't relevant to updating
existing code, and not pure bug fixes.)

* <https://sourceware.org/ml/libc-alpha/2006-02/msg00028.html>

  - Semi-raw unpacking is added, as something intermediate between raw
    and cooked unpacking, for efficiency.

  - Addition and subtraction are changed to work on semi-raw values.
    Thus, cooked results of multiplication can't be passed directly
    into addition, as was done in some kernel emulations of fused
    multiply-add, but that isn't a proper fused operation anyway (a
    proper fused operation involves using the unrounded multiplication
    result in twice the input precision, not an intermediate value in
    input precision plus three working bits); the appropriate fix is
    to use the new fused multiply-add support in soft-fp.

  - Conversions from one floating-point type to another now use
    FP_EXTEND (raw) and FP_TRUNC (semi-raw) instead of FP_CONV
    (cooked).  Those operations now deal with quieting signaling NaNs.

  - Conversions from floating-point to integer now use raw inputs, and
    require the integer variable passed to the FP_TO_INT macros to
    have unsigned type.

  - Conversions from integer to floating-point now use raw outputs.

* <https://sourceware.org/ml/libc-alpha/2006-02/msg00044.html>

  - Conversions from integer to floating-point now pass the name of an
    unsigned type to the FP_FROM_INT macros, not a signed type to
    which "unsigned" is added in the macro definition.

* <https://sourceware.org/ml/libc-alpha/2013-04/msg00646.html>

  - soft-fp supports the reversed quiet NaN convention used on MIPS
    and HPPA; sfp-machine.h must define _FP_QNANNEGATEDP (to 0, for
    architectures using the normal convention; to 1, for architectures
    using the MIPS convention).

* <https://sourceware.org/ml/libc-alpha/2013-10/msg00348.html>

  - Negation now works on raw values.

* <https://sourceware.org/ml/libc-alpha/2014-02/msg00068.html>

  - soft-fp now supports after-rounding tininess detection for
    architectures where that is the defined way in which tiny results
    are detected (of the architectures for which the Linux kernel uses
    this code, that's Alpha and SH).  sfp-machine.h must define
    _FP_TININESS_AFTER_ROUNDING to either 0 or 1.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00411.html>

  - FP_CLEAR_EXCEPTIONS is removed; all uses in the Linux kernel are
    no longer needed as, now unpacking only occurs in the correct
    format, exceptions are already clear at that point.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00461.html>

  - The FP_CMP macros have an extra argument to specify when
    exceptions should be set (0 for no exception setting, 1 for
    exceptions only for signaling NaNs, 2 for exceptions for all
    NaNs).  In the old version in the kernel, it was necessary for the
    caller to handle all exception setting for comparisons.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00488.html>

  - FP_DENORM_ZERO does not set "inexact" when flushing to zero, as
    that does not appear to match the documented semantics for either
    of the architectures (Alpha and SH) for which the kernel uses
    FP_DENORM_ZERO.  FP_DENORM_ZERO is also checked for comparisons
    (the documentation for both Alpha and SH is explicit that their
    corresponding control bits do apply to comparisons).

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00462.html>

  - The more precise FP_EX_INVALID_* exceptions include more cases
    than in the kernel version (in particular, FP_EX_INVALID_IMZ_FMA
    is split out from FP_EX_INVALID_IMZ, so if only the latter is
    defined then fma using the new fma support would not raise that
    exception any more - except that this doesn't actually affect
    powerpc because it hardcodes setting various exceptions in
    powerpc-specific code despite also defining FP_EX_INVALID_*).

Generally this patch series only does cleanups and bug fixes to
architecture-specific code when they are closely connected to API
changes in the new code (either required by such API changes, or the
new API means the idiomatic way to do something has changed).  Where
something was already odd with the old version of the code, or
apparently did not match documented instruction set semantics, it's
not changed if that seems unconnected to the update from glibc.  I've
noted various such cases (especially for powerpc) that may be
addressed in followup patch series once the main upgrade is in (or,
where the fix seems more complicated and difficult to fix without
convenient access to the architecture for testing, I may just list the
issues on the relevant architecture mailing list).

The following architecture-specific cleanups or bug fixes (that might
change how the emulation behaves, or that go beyond mechanical
conversion to new APIs) are included in this patch series because of
their close connection to the API changes:

* Alpha and SH now use after-rounding tininess detection.

* On Alpha, extensions from single to double now use FP_EXTEND with
  raw unpacking instead of the previous hardcoded code with cooked
  unpacking; these should be equivalent and the new code, with the
  optimizations in FP_EXTEND relative to the old FP_CONV, should be as
  efficient as the previous hardcoded code.

* On PowerPC and SH, fused multiply-add operations now use the new
  soft-fp fma support (meaning they are properly fused rather than
  only having 3 extra bits precision on the intermediate result of the
  multiplication).

* On PowerPC for SPE floating-point emulation, the pre-existing bug of
  comparisons using cooked unpacking is fixed (as the structure of the
  code meant unpacking types naturally needed specifying explicitly
  for all operations).  This should not in fact change how the
  emulation behaves, other than making it more efficient.  Various
  operations that should not have unpacked at all now no longer unpack
  instead of using cooked unpacking, so avoiding spurious exceptions
  on signaling NaNs (on the other case of arguments that are actually
  a different floating-point type but would wrongly be interpreted as
  signaling NaNs by the unpacking, FP_CLEAR_EXCEPTIONS may have
  avoided the issue).

* On SPARC, comparisons now use raw unpacking (this should not in fact
  change how the emulation behaves, just make it more efficient).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

Compared to the previous version
<https://lkml.org/lkml/2015/5/19/1047>, this patch series is split
into eight patches so that each architecture's changes can be reviewed
individually and the only patch that changes all affected
architectures together is the first mechanical one moving math-emu to
math-emu-old.  Patch 2 depends on patch 1, patches 3-7 depend on
patches 1 and 2 but are independent of each other, patch 8 depends on
all the other patches.  Applying all eight patches gives an identical
tree to applying the previous monolithic patch.

-- 
Joseph S. Myers
joseph@codesourcery.com
