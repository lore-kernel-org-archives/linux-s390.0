From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 02 Jul 2015 15:46:21 +0000
Subject: [PATCH 1/8] math-emu: Move math-emu to math-emu-old
Message-Id: <alpine.DEB.2.10.1507021544450.29415@digraph.polyomino.org.uk>
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

This patch moves the include/math-emu code to math-emu-old, updating
#includes, in preparation for importing glibc's current soft-fp code
as include/math-emu without requiring all architectures to be updated
for API changes at the same time.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/alpha/math-emu/math.c b/arch/alpha/math-emu/math.c
index 58c2669..917196e 100644
--- a/arch/alpha/math-emu/math.c
+++ b/arch/alpha/math-emu/math.c
@@ -6,9 +6,9 @@
 #include <asm/uaccess.h>
 
 #include "sfp-util.h"
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
+#include <math-emu-old/double.h>
 
 #define	OPC_PAL		0x00
 #define OPC_INTA	0x10
diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index 0158a16..3c821be 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fadd(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
index 5930f40..14bc579 100644
--- a/arch/powerpc/math-emu/fadds.c
+++ b/arch/powerpc/math-emu/fadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fadds(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index 5bce011..3c4afbf 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
index d4fb1ba..948d9db 100644
--- a/arch/powerpc/math-emu/fcmpu.c
+++ b/arch/powerpc/math-emu/fcmpu.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
index f694440..d3efc14 100644
--- a/arch/powerpc/math-emu/fctiw.c
+++ b/arch/powerpc/math-emu/fctiw.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fctiw(u32 *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
index 71e782f..cce3457 100644
--- a/arch/powerpc/math-emu/fctiwz.c
+++ b/arch/powerpc/math-emu/fctiwz.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fctiwz(u32 *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
index a29239c..f3084fd 100644
--- a/arch/powerpc/math-emu/fdiv.c
+++ b/arch/powerpc/math-emu/fdiv.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fdiv(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
index 526bc26..4fde33b 100644
--- a/arch/powerpc/math-emu/fdivs.c
+++ b/arch/powerpc/math-emu/fdivs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fdivs(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index 8c3f20a..9a2b1ff 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fmadd(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index 794fb31..3dac172 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fmadds(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index 626f6fe..bfcf698 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fmsub(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 3425bc8..144d43a 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fmsubs(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
index 2c19297..1ea819d 100644
--- a/arch/powerpc/math-emu/fmul.c
+++ b/arch/powerpc/math-emu/fmul.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fmul(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
index f5ad5c9..6f62191 100644
--- a/arch/powerpc/math-emu/fmuls.c
+++ b/arch/powerpc/math-emu/fmuls.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fmuls(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index e817bc5..e290ef7 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fnmadd(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index 4db4b7d..41a5a4c 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fnmadds(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index f65979f..7e6168a 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fnmsub(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index 9021dac..bb4a27f 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fnmsubs(void *frD, void *frA, void *frB, void *frC)
diff --git a/arch/powerpc/math-emu/frsp.c b/arch/powerpc/math-emu/frsp.c
index ddcc146..6fda802 100644
--- a/arch/powerpc/math-emu/frsp.c
+++ b/arch/powerpc/math-emu/frsp.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 frsp(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsel.c b/arch/powerpc/math-emu/fsel.c
index 1b0c144..681898d 100644
--- a/arch/powerpc/math-emu/fsel.c
+++ b/arch/powerpc/math-emu/fsel.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
diff --git a/arch/powerpc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
index a55fc7d..f66b52e 100644
--- a/arch/powerpc/math-emu/fsqrt.c
+++ b/arch/powerpc/math-emu/fsqrt.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fsqrt(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
index 31dccbf..b042ff6 100644
--- a/arch/powerpc/math-emu/fsqrts.c
+++ b/arch/powerpc/math-emu/fsqrts.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fsqrts(void *frD, void *frB)
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index 02c5dff..aa2105f 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -3,8 +3,8 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
 
 int
 fsub(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index 5d9b18c..9fd6cf6 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 fsubs(void *frD, void *frA, void *frB)
diff --git a/arch/powerpc/math-emu/lfd.c b/arch/powerpc/math-emu/lfd.c
index 79ac76d..acc5a3f 100644
--- a/arch/powerpc/math-emu/lfd.c
+++ b/arch/powerpc/math-emu/lfd.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/double.h>
+#include <math-emu-old/double.h>
 
 int
 lfd(void *frD, void *ea)
diff --git a/arch/powerpc/math-emu/lfs.c b/arch/powerpc/math-emu/lfs.c
index 434ed27..582e0b8 100644
--- a/arch/powerpc/math-emu/lfs.c
+++ b/arch/powerpc/math-emu/lfs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 lfs(void *frD, void *ea)
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index ab151f0..d6e1a8f 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -10,7 +10,7 @@
 #include <asm/switch_to.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/double.h>
+#include <math-emu-old/double.h>
 
 #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
 
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 28337c9..8d87cf9 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -28,9 +28,9 @@
 #define FP_EX_BOOKE_E500_SPE
 #include <asm/sfp-machine.h>
 
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
+#include <math-emu-old/double.h>
 
 #define EFAPU		0x4
 
diff --git a/arch/powerpc/math-emu/mcrfs.c b/arch/powerpc/math-emu/mcrfs.c
index e948d57..f37ea50 100644
--- a/arch/powerpc/math-emu/mcrfs.c
+++ b/arch/powerpc/math-emu/mcrfs.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mcrfs(u32 *ccr, u32 crfD, u32 crfS)
diff --git a/arch/powerpc/math-emu/mffs.c b/arch/powerpc/math-emu/mffs.c
index 5526cf9..558e621 100644
--- a/arch/powerpc/math-emu/mffs.c
+++ b/arch/powerpc/math-emu/mffs.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mffs(u32 *frD)
diff --git a/arch/powerpc/math-emu/mtfsb0.c b/arch/powerpc/math-emu/mtfsb0.c
index bc98558..7c325d8 100644
--- a/arch/powerpc/math-emu/mtfsb0.c
+++ b/arch/powerpc/math-emu/mtfsb0.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mtfsb0(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsb1.c b/arch/powerpc/math-emu/mtfsb1.c
index fe6ed5a..d15f724 100644
--- a/arch/powerpc/math-emu/mtfsb1.c
+++ b/arch/powerpc/math-emu/mtfsb1.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mtfsb1(int crbD)
diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index 44b0fc8..b352968 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mtfsf(unsigned int FM, u32 *frB)
diff --git a/arch/powerpc/math-emu/mtfsfi.c b/arch/powerpc/math-emu/mtfsfi.c
index fd2acc2..8abeb3c 100644
--- a/arch/powerpc/math-emu/mtfsfi.c
+++ b/arch/powerpc/math-emu/mtfsfi.c
@@ -3,7 +3,7 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 int
 mtfsfi(unsigned int crfD, unsigned int IMM)
diff --git a/arch/powerpc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
index 6122147..8430631 100644
--- a/arch/powerpc/math-emu/stfs.c
+++ b/arch/powerpc/math-emu/stfs.c
@@ -3,9 +3,9 @@
 #include <asm/uaccess.h>
 
 #include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/single.h>
 
 int
 stfs(void *frS, void *ea)
diff --git a/arch/powerpc/math-emu/udivmodti4.c b/arch/powerpc/math-emu/udivmodti4.c
index 6172044..86e4013 100644
--- a/arch/powerpc/math-emu/udivmodti4.c
+++ b/arch/powerpc/math-emu/udivmodti4.c
@@ -1,6 +1,6 @@
 /* This has so very few changes over libgcc2's __udivmoddi4 it isn't funny.  */
 
-#include <math-emu/soft-fp.h>
+#include <math-emu-old/soft-fp.h>
 
 #undef count_leading_zeros
 #define count_leading_zeros  __FP_CLZ
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 99babea..c7d8df7 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -19,8 +19,8 @@
 
 /* Sigh, math-emu. Don't ask. */
 #include <asm/sfp-util.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
 
 int topology_max_mnest;
 
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index 04aa55f..0cd5ec3 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -19,9 +19,9 @@
 #include <asm/io.h>
 
 #include "sfp-util.h"
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-#include <math-emu/double.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
+#include <math-emu-old/double.h>
 
 #define	FPUL		(fregs->fpul)
 #define FPSCR		(fregs->fpscr)
diff --git a/arch/sparc/math-emu/math_32.c b/arch/sparc/math-emu/math_32.c
index 5ce8f2f..3aaaeef 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -71,10 +71,10 @@
 #include <asm/uaccess.h>
 
 #include "sfp-util_32.h"
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-#include <math-emu/double.h>
-#include <math-emu/quad.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/quad.h>
 
 #define FLOATFUNC(x) extern int x(void *,void *,void *)
 
diff --git a/arch/sparc/math-emu/math_64.c b/arch/sparc/math-emu/math_64.c
index 034aadb..c720cbb 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -19,10 +19,10 @@
 #include <asm/cacheflush.h>
 
 #include "sfp-util_64.h"
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-#include <math-emu/double.h>
-#include <math-emu/quad.h>
+#include <math-emu-old/soft-fp.h>
+#include <math-emu-old/single.h>
+#include <math-emu-old/double.h>
+#include <math-emu-old/quad.h>
 
 /* QUAD - ftt = 3 */
 #define FMOVQ	0x003
diff --git a/include/math-emu/double.h b/include/math-emu-old/double.h
similarity index 100%
rename from include/math-emu/double.h
rename to include/math-emu-old/double.h
diff --git a/include/math-emu/op-1.h b/include/math-emu-old/op-1.h
similarity index 100%
rename from include/math-emu/op-1.h
rename to include/math-emu-old/op-1.h
diff --git a/include/math-emu/op-2.h b/include/math-emu-old/op-2.h
similarity index 100%
rename from include/math-emu/op-2.h
rename to include/math-emu-old/op-2.h
diff --git a/include/math-emu/op-4.h b/include/math-emu-old/op-4.h
similarity index 100%
rename from include/math-emu/op-4.h
rename to include/math-emu-old/op-4.h
diff --git a/include/math-emu/op-8.h b/include/math-emu-old/op-8.h
similarity index 100%
rename from include/math-emu/op-8.h
rename to include/math-emu-old/op-8.h
diff --git a/include/math-emu/op-common.h b/include/math-emu-old/op-common.h
similarity index 100%
rename from include/math-emu/op-common.h
rename to include/math-emu-old/op-common.h
diff --git a/include/math-emu/quad.h b/include/math-emu-old/quad.h
similarity index 100%
rename from include/math-emu/quad.h
rename to include/math-emu-old/quad.h
diff --git a/include/math-emu/single.h b/include/math-emu-old/single.h
similarity index 100%
rename from include/math-emu/single.h
rename to include/math-emu-old/single.h
diff --git a/include/math-emu/soft-fp.h b/include/math-emu-old/soft-fp.h
similarity index 96%
rename from include/math-emu/soft-fp.h
rename to include/math-emu-old/soft-fp.h
index 3f284bc..0ce1032 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu-old/soft-fp.h
@@ -180,11 +180,11 @@ do {						\
 
 #define _FP_CLS_COMBINE(x,y)	(((x) << 2) | (y))
 
-#include <math-emu/op-1.h>
-#include <math-emu/op-2.h>
-#include <math-emu/op-4.h>
-#include <math-emu/op-8.h>
-#include <math-emu/op-common.h>
+#include <math-emu-old/op-1.h>
+#include <math-emu-old/op-2.h>
+#include <math-emu-old/op-4.h>
+#include <math-emu-old/op-8.h>
+#include <math-emu-old/op-common.h>
 
 /* Sigh.  Silly things longlong.h needs.  */
 #define UWtype		_FP_W_TYPE


-- 
Joseph S. Myers
joseph@codesourcery.com
