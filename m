Return-Path: <linux-kernel-owner+w=401wt.eu-S1762662AbYDVRb0@vger.kernel.org>
Message-Id: <20080422172842.809030360@polymtl.ca>
References: <20080422172404.502954084@polymtl.ca>
Date: Tue, 22 Apr 2008 13:24:11 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 7/9] S390 remove -traditional
Content-Disposition: inline; filename=s390-remove-traditional.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Subject: [RFC patch 7/9] Re: [PATCH] Stringify support commas
 > This is a no-no for those archs that still use -traditional.
 > > I dunno if this is a problem for you at the moment and the
 > > right fix is anyway to nuke -traditional.
 > > 
 > >     Sam

(cross-compile test ok)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: schwidefsky@de.ibm.com
CC: heiko.carstens@de.ibm.com
CC: linux390@de.ibm.com
CC: linux-s390@vger.kernel.org
---
 arch/s390/kernel/Makefile   |    2 --
 arch/s390/lib/Makefile      |    2 --
 arch/s390/math-emu/Makefile |    1 -
 3 files changed, 5 deletions(-)

Index: linux-2.6-lttng/arch/s390/kernel/Makefile
===================================================================
--- linux-2.6-lttng.orig/arch/s390/kernel/Makefile	2008-04-21 10:04:43.000000000 -0400
+++ linux-2.6-lttng/arch/s390/kernel/Makefile	2008-04-21 10:04:47.000000000 -0400
@@ -2,8 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_AFLAGS	:= -traditional
-
 #
 # Passing null pointers is ok for smp code, since we access the lowcore here.
 #
Index: linux-2.6-lttng/arch/s390/lib/Makefile
===================================================================
--- linux-2.6-lttng.orig/arch/s390/lib/Makefile	2008-04-21 10:04:55.000000000 -0400
+++ linux-2.6-lttng/arch/s390/lib/Makefile	2008-04-21 10:05:00.000000000 -0400
@@ -2,8 +2,6 @@
 # Makefile for s390-specific library files..
 #
 
-EXTRA_AFLAGS := -traditional
-
 lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
 obj-$(CONFIG_32BIT) += div64.o qrnnd.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
Index: linux-2.6-lttng/arch/s390/math-emu/Makefile
===================================================================
--- linux-2.6-lttng.orig/arch/s390/math-emu/Makefile	2008-04-21 10:05:04.000000000 -0400
+++ linux-2.6-lttng/arch/s390/math-emu/Makefile	2008-04-21 10:05:08.000000000 -0400
@@ -5,4 +5,3 @@
 obj-$(CONFIG_MATHEMU) := math.o
 
 EXTRA_CFLAGS := -I$(src) -Iinclude/math-emu -w
-EXTRA_AFLAGS := -traditional

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
