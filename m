Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/12] s390: kernel: add SPDX identifiers to the remaining files
Date: Fri, 24 Nov 2017 15:00:32 +0100
Message-Id: <20171124140043.10062-2-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the arch/s390/kernel/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/dis.c                  | 1 +
 arch/s390/kernel/dumpstack.c            | 1 +
 arch/s390/kernel/ipl.c                  | 1 +
 arch/s390/kernel/kprobes.c              | 1 +
 arch/s390/kernel/lgr.c                  | 1 +
 arch/s390/kernel/module.c               | 1 +
 arch/s390/kernel/nmi.c                  | 1 +
 arch/s390/kernel/perf_cpum_cf.c         | 1 +
 arch/s390/kernel/perf_cpum_sf.c         | 1 +
 arch/s390/kernel/perf_event.c           | 1 +
 arch/s390/kernel/setup.c                | 1 +
 arch/s390/kernel/stacktrace.c           | 1 +
 arch/s390/kernel/time.c                 | 1 +
 arch/s390/kernel/topology.c             | 1 +
 arch/s390/kernel/vdso.c                 | 1 +
 arch/s390/kernel/vdso32/clock_getres.S  | 1 +
 arch/s390/kernel/vdso32/clock_gettime.S | 1 +
 arch/s390/kernel/vdso32/gettimeofday.S  | 1 +
 arch/s390/kernel/vdso64/clock_getres.S  | 1 +
 arch/s390/kernel/vdso64/clock_gettime.S | 1 +
 arch/s390/kernel/vdso64/gettimeofday.S  | 1 +
 arch/s390/kernel/vtime.c                | 1 +
 22 files changed, 22 insertions(+)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 465d52b5e470..c33418805ffd 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Disassemble s390 instructions.
  *
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 2aa545dca4d5..5b23c4f6e50c 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Stack dumping functions
  *
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 310e59e6eb4b..8ecb8726ac47 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    ipl/reipl/dump support for Linux on s390.
  *
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 1a6521af1751..ee055f7bdb10 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Kernel Probes (KProbes)
  *
diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
index bf9622f0e6b1..452502f9a0d9 100644
--- a/arch/s390/kernel/lgr.c
+++ b/arch/s390/kernel/lgr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Linux Guest Relocation (LGR) detection
  *
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 7b87991416fd..10d104589978 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Kernel module help for s390.
  *
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 6ff169253cae..c7a627620e5e 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   Machine check handler
  *
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 746d03423333..8f6296860186 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance event support for s390x - CPU-measurement Counter Facility
  *
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 227b38bd82c9..6e404caac856 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance event support for the System z CPU-measurement Sampling Facility
  *
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 93a386f4a3b5..0ef308851374 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance event support for s390x
  *
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 090053cf279b..793da97f9a6e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  S390 version
  *    Copyright IBM Corp. 1999, 2012
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index e66687dc6144..460dcfba7d4e 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Stack trace management functions
  *
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 5cbd52169348..44c012c866d2 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Time of day based timer functions.
  *
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index f9b393d4a078..4d5b65e527b5 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 2007, 2011
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 39a218703c50..88f6fab68eb2 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * vdso setup for s390
  *
diff --git a/arch/s390/kernel/vdso32/clock_getres.S b/arch/s390/kernel/vdso32/clock_getres.S
index eca3f001f081..eb9f22cbfd47 100644
--- a/arch/s390/kernel/vdso32/clock_getres.S
+++ b/arch/s390/kernel/vdso32/clock_getres.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of clock_getres() for 32 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vdso32/clock_gettime.S b/arch/s390/kernel/vdso32/clock_gettime.S
index a5769b83d90e..b642c0382238 100644
--- a/arch/s390/kernel/vdso32/clock_gettime.S
+++ b/arch/s390/kernel/vdso32/clock_gettime.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of clock_gettime() for 32 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vdso32/gettimeofday.S b/arch/s390/kernel/vdso32/gettimeofday.S
index 63b86dceb0bf..8a89b54246d7 100644
--- a/arch/s390/kernel/vdso32/gettimeofday.S
+++ b/arch/s390/kernel/vdso32/gettimeofday.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of gettimeofday() for 32 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index c8513deb8c66..416bf711c2aa 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of clock_getres() for 64 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
index 5d7b56b49458..d2dee331b7cd 100644
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ b/arch/s390/kernel/vdso64/clock_gettime.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of clock_gettime() for 64 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vdso64/gettimeofday.S b/arch/s390/kernel/vdso64/gettimeofday.S
index b02e62f3bc12..cf62a1611054 100644
--- a/arch/s390/kernel/vdso64/gettimeofday.S
+++ b/arch/s390/kernel/vdso64/gettimeofday.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Userland implementation of gettimeofday() for 64 bits processes in a
  * s390 kernel for use in the vDSO
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index dd7178fbb4f3..f24395a01918 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Virtual cpu timer based timer functions.
  *
-- 
2.15.0
