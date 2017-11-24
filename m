Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/12] s390: kernel: Remove redundant license text
Date: Fri, 24 Nov 2017 15:00:40 +0100
Message-Id: <20171124140043.10062-10-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all arch/s390/kernel/ files, that identifies
the license in a specific and legally-defined manner.  So the extra GPL
text wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/kprobes.c              | 14 --------------
 arch/s390/kernel/module.c               | 14 --------------
 arch/s390/kernel/perf_cpum_cf.c         |  4 ----
 arch/s390/kernel/perf_cpum_sf.c         |  4 ----
 arch/s390/kernel/perf_event.c           |  4 ----
 arch/s390/kernel/sthyi.c                |  4 ----
 arch/s390/kernel/vdso.c                 |  4 ----
 arch/s390/kernel/vdso32/clock_getres.S  |  4 ----
 arch/s390/kernel/vdso32/clock_gettime.S |  4 ----
 arch/s390/kernel/vdso32/gettimeofday.S  |  4 ----
 arch/s390/kernel/vdso64/clock_getres.S  |  4 ----
 arch/s390/kernel/vdso64/clock_gettime.S |  4 ----
 arch/s390/kernel/vdso64/gettimeofday.S  |  4 ----
 13 files changed, 72 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index ee055f7bdb10..af3722c28fd9 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -2,20 +2,6 @@
 /*
  *  Kernel Probes (KProbes)
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright IBM Corp. 2002, 2006
  *
  * s390 port, used ppc64 as template. Mike Grundy <grundym@us.ibm.com>
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 10d104589978..b7abfad4fd7d 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -9,20 +9,6 @@
  *
  *  based on i386 version
  *    Copyright (C) 2001 Rusty Russell.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/module.h>
 #include <linux/elf.h>
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 8f6296860186..cc085e2d2ce9 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -4,10 +4,6 @@
  *
  *  Copyright IBM Corp. 2012, 2017
  *  Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #define KMSG_COMPONENT	"cpum_cf"
 #define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 6e404caac856..1c9ddd7aa5ec 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2013
  * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #define KMSG_COMPONENT	"cpum_sf"
 #define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 0ef308851374..0d770e513abf 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -4,10 +4,6 @@
  *
  *  Copyright IBM Corp. 2012, 2013
  *  Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #define KMSG_COMPONENT	"perf"
 #define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 12981e197f01..0f474d893650 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -1,10 +1,6 @@
 /*
  * store hypervisor information instruction emulation functions.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  * Copyright IBM Corp. 2016
  * Author(s): Janosch Frank <frankja@linux.vnet.ibm.com>
  */
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 88f6fab68eb2..f3a1c7c6824e 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -4,10 +4,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
diff --git a/arch/s390/kernel/vdso32/clock_getres.S b/arch/s390/kernel/vdso32/clock_getres.S
index eb9f22cbfd47..f61df5253c23 100644
--- a/arch/s390/kernel/vdso32/clock_getres.S
+++ b/arch/s390/kernel/vdso32/clock_getres.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/kernel/vdso32/clock_gettime.S b/arch/s390/kernel/vdso32/clock_gettime.S
index b642c0382238..2d6ec3abe095 100644
--- a/arch/s390/kernel/vdso32/clock_gettime.S
+++ b/arch/s390/kernel/vdso32/clock_gettime.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/kernel/vdso32/gettimeofday.S b/arch/s390/kernel/vdso32/gettimeofday.S
index 8a89b54246d7..aa8bf13a2edb 100644
--- a/arch/s390/kernel/vdso32/gettimeofday.S
+++ b/arch/s390/kernel/vdso32/gettimeofday.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index 416bf711c2aa..faf5213b15df 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
index d2dee331b7cd..6046b3bfca46 100644
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ b/arch/s390/kernel/vdso64/clock_gettime.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/s390/kernel/vdso64/gettimeofday.S b/arch/s390/kernel/vdso64/gettimeofday.S
index cf62a1611054..cc9dbc27da6f 100644
--- a/arch/s390/kernel/vdso64/gettimeofday.S
+++ b/arch/s390/kernel/vdso64/gettimeofday.S
@@ -5,10 +5,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #include <asm/vdso.h>
 #include <asm/asm-offsets.h>
-- 
2.15.0
