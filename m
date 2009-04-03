Return-Path: <linux-kernel-owner+w=401wt.eu-S1762347AbZDCPrs@vger.kernel.org>
Date: Fri, 3 Apr 2009 17:41:10 +0200
From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 2/5] libgcc: Add config and support headers
Message-ID: <20090403154110.GB7200@wavehammer.waldi.eu.org>
References: <20090403153941.GA7045@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20090403153941.GA7045@wavehammer.waldi.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Disable all floating point functions and add support for generic
longlong divisions.

Signed-off-by: Bastian Blank <waldi@debian.org>
---
 include/asm-generic/libgcc/longlong.h |  183 +++++++++++++++++++++++++++++++++
 lib/libgcc/coretypes.h                |    1 +
 lib/libgcc/longlong.h                 |    1 +
 lib/libgcc/tconfig.h                  |    8 ++
 lib/libgcc/tm.h                       |    3 +
 lib/libgcc/tsystem.h                  |    1 +
 6 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-generic/libgcc/longlong.h
 create mode 100644 lib/libgcc/coretypes.h
 create mode 100644 lib/libgcc/longlong.h
 create mode 100644 lib/libgcc/tconfig.h
 create mode 100644 lib/libgcc/tm.h
 create mode 100644 lib/libgcc/tsystem.h

diff --git a/include/asm-generic/libgcc/longlong.h b/include/asm-generic/libgcc/longlong.h
new file mode 100644
index 0000000..b5b9158
--- /dev/null
+++ b/include/asm-generic/libgcc/longlong.h
@@ -0,0 +1,183 @@
+/*
+ * Definitions for mixed size 32/64 bit arithmetic, generic parts.
+ *
+ * Copyright (C) 1991-2009 Free Software Foundation, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define __BITS4 (W_TYPE_SIZE / 4)
+#define __ll_B ((UWtype) 1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((UWtype) (t) & (__ll_B - 1))
+#define __ll_highpart(t) ((UWtype) (t) >> (W_TYPE_SIZE / 2))
+
+extern const UQItype __clz_tab[256];
+
+#include <asm/libgcc/longlong.h>
+
+#if !defined (add_ssaaaa)
+#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
+  do {									\
+    UWtype __x;								\
+    __x = (al) + (bl);							\
+    (sh) = (ah) + (bh) + (__x < (al));					\
+    (sl) = __x;								\
+  } while (0)
+#endif
+
+#if !defined (sub_ddmmss)
+#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
+  do {									\
+    UWtype __x;								\
+    __x = (al) - (bl);							\
+    (sh) = (ah) - (bh) - (__x > (al));					\
+    (sl) = __x;								\
+  } while (0)
+#endif
+
+/* If we lack umul_ppmm but have smul_ppmm, define umul_ppmm in terms of
+   smul_ppmm.  */
+#if !defined (umul_ppmm) && defined (smul_ppmm)
+#define umul_ppmm(w1, w0, u, v)						\
+  do {									\
+    UWtype __w1;							\
+    UWtype __xm0 = (u), __xm1 = (v);					\
+    smul_ppmm (__w1, w0, __xm0, __xm1);					\
+    (w1) = __w1 + (-(__xm0 >> (W_TYPE_SIZE - 1)) & __xm1)		\
+		+ (-(__xm1 >> (W_TYPE_SIZE - 1)) & __xm0);		\
+  } while (0)
+#endif
+
+/* If we still don't have umul_ppmm, define it using plain C.  */
+#if !defined (umul_ppmm)
+#define umul_ppmm(w1, w0, u, v)						\
+  do {									\
+    UWtype __x0, __x1, __x2, __x3;					\
+    UHWtype __ul, __vl, __uh, __vh;					\
+									\
+    __ul = __ll_lowpart (u);						\
+    __uh = __ll_highpart (u);						\
+    __vl = __ll_lowpart (v);						\
+    __vh = __ll_highpart (v);						\
+									\
+    __x0 = (UWtype) __ul * __vl;					\
+    __x1 = (UWtype) __ul * __vh;					\
+    __x2 = (UWtype) __uh * __vl;					\
+    __x3 = (UWtype) __uh * __vh;					\
+									\
+    __x1 += __ll_highpart (__x0);/* this can't give carry */		\
+    __x1 += __x2;		/* but this indeed can */		\
+    if (__x1 < __x2)		/* did we get it? */			\
+      __x3 += __ll_B;		/* yes, add it in the proper pos.  */	\
+									\
+    (w1) = __x3 + __ll_highpart (__x1);					\
+    (w0) = __ll_lowpart (__x1) * __ll_B + __ll_lowpart (__x0);		\
+  } while (0)
+#endif
+
+#if !defined (__umulsidi3)
+#define __umulsidi3(u, v) \
+  ({DWunion __w;							\
+    umul_ppmm (__w.s.high, __w.s.low, u, v);				\
+    __w.ll; })
+#endif
+
+/* If the processor has no udiv_qrnnd but sdiv_qrnnd, go through
+   __udiv_w_sdiv (defined in libgcc or elsewhere).  */
+#if !defined (udiv_qrnnd) && defined (sdiv_qrnnd)
+#define udiv_qrnnd(q, r, nh, nl, d) \
+  do {									\
+    USItype __r;							\
+    (q) = __udiv_w_sdiv (&__r, nh, nl, d);				\
+    (r) = __r;								\
+  } while (0)
+#endif
+
+#if !defined (udiv_qrnnd)
+#define udiv_qrnnd(q, r, n1, n0, d) \
+  do {									\
+    UWtype __d1, __d0, __q1, __q0;					\
+    UWtype __r1, __r0, __m;						\
+    __d1 = __ll_highpart (d);						\
+    __d0 = __ll_lowpart (d);						\
+									\
+    __r1 = (n1) % __d1;							\
+    __q1 = (n1) / __d1;							\
+    __m = (UWtype) __q1 * __d0;						\
+    __r1 = __r1 * __ll_B | __ll_highpart (n0);				\
+    if (__r1 < __m)							\
+      {									\
+	__q1--, __r1 += (d);						\
+	if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
+	  if (__r1 < __m)						\
+	    __q1--, __r1 += (d);					\
+      }									\
+    __r1 -= __m;							\
+									\
+    __r0 = __r1 % __d1;							\
+    __q0 = __r1 / __d1;							\
+    __m = (UWtype) __q0 * __d0;						\
+    __r0 = __r0 * __ll_B | __ll_lowpart (n0);				\
+    if (__r0 < __m)							\
+      {									\
+	__q0--, __r0 += (d);						\
+	if (__r0 >= (d))						\
+	  if (__r0 < __m)						\
+	    __q0--, __r0 += (d);					\
+      }									\
+    __r0 -= __m;							\
+									\
+    (q) = (UWtype) __q1 * __ll_B | __q0;				\
+    (r) = __r0;								\
+  } while (0)
+#define UDIV_NEEDS_NORMALIZATION 1
+#endif
+
+#if !defined (count_leading_zeros)
+#define count_leading_zeros(count, x) \
+  do {									\
+    UWtype __xr = (x);							\
+    UWtype __a;								\
+									\
+    if (W_TYPE_SIZE <= 32)						\
+      {									\
+	__a = __xr < ((UWtype)1<<2*__BITS4)				\
+	  ? (__xr < ((UWtype)1<<__BITS4) ? 0 : __BITS4)			\
+	  : (__xr < ((UWtype)1<<3*__BITS4) ?  2*__BITS4 : 3*__BITS4);	\
+      }									\
+    else								\
+      {									\
+	for (__a = W_TYPE_SIZE - 8; __a > 0; __a -= 8)			\
+	  if (((__xr >> __a) & 0xff) != 0)				\
+	    break;							\
+      }									\
+									\
+    (count) = W_TYPE_SIZE - (__clz_tab[__xr >> __a] + __a);		\
+  } while (0)
+#define COUNT_LEADING_ZEROS_0 W_TYPE_SIZE
+#endif
+
+#if !defined (count_trailing_zeros)
+#define count_trailing_zeros(count, x) \
+  do {									\
+    UWtype __ctz_x = (x);						\
+    UWtype __ctz_c;							\
+    count_leading_zeros (__ctz_c, __ctz_x & -__ctz_x);			\
+    (count) = W_TYPE_SIZE - 1 - __ctz_c;				\
+  } while (0)
+#endif
+
+#ifndef UDIV_NEEDS_NORMALIZATION
+#define UDIV_NEEDS_NORMALIZATION 0
+#endif
diff --git a/lib/libgcc/coretypes.h b/lib/libgcc/coretypes.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/lib/libgcc/coretypes.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/lib/libgcc/longlong.h b/lib/libgcc/longlong.h
new file mode 100644
index 0000000..5127ca8
--- /dev/null
+++ b/lib/libgcc/longlong.h
@@ -0,0 +1 @@
+#include <asm-generic/libgcc/longlong.h>
diff --git a/lib/libgcc/tconfig.h b/lib/libgcc/tconfig.h
new file mode 100644
index 0000000..16df0dc
--- /dev/null
+++ b/lib/libgcc/tconfig.h
@@ -0,0 +1,8 @@
+#include <asm/libgcc/config.h>
+
+#define LIBGCC2_DOUBLE_TYPE_SIZE 0
+#define LIBGCC2_LONG_DOUBLE_TYPE_SIZE 0
+#define LIBGCC2_HAS_SF_MODE 0
+#define LIBGCC2_HAS_DF_MODE 0
+#define LIBGCC2_HAS_XF_MODE 0
+#define LIBGCC2_HAS_FF_MODE 0
diff --git a/lib/libgcc/tm.h b/lib/libgcc/tm.h
new file mode 100644
index 0000000..59f75d6
--- /dev/null
+++ b/lib/libgcc/tm.h
@@ -0,0 +1,3 @@
+#include <asm/bug.h>
+
+#define abort() do { BUG(); return 0; } while (0)
diff --git a/lib/libgcc/tsystem.h b/lib/libgcc/tsystem.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/lib/libgcc/tsystem.h
@@ -0,0 +1 @@
+/* empty */
-- 
1.6.2.1
