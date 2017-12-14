From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/34] perf trace: Use generated syscall table on s390 too
Date: Thu, 14 Dec 2017 14:42:30 -0300
Message-ID: <20171214174247.16841-18-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

It also enables users to specify wildcards, for example, perf trace -e
'open*', just like was already possible on x86.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1512635281-20733-2-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-htplh3nbrivi7g3cffbh4fsu@git.kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config   | 10 +++++++++-
 tools/perf/util/syscalltbl.c |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 79b117a03fd7..6f73c2316740 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -22,6 +22,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 NO_PERF_REGS := 1
+NO_SYSCALL_TABLE := 1
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
@@ -33,7 +34,8 @@ endif
 ifeq ($(SRCARCH),x86)
   $(call detected,CONFIG_X86)
   ifeq (${IS_64_BIT}, 1)
-    CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -DHAVE_SYSCALL_TABLE -I$(OUTPUT)arch/x86/include/generated
+    NO_SYSCALL_TABLE := 0
+    CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -I$(OUTPUT)arch/x86/include/generated
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
     LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
     $(call detected,CONFIG_X86_64)
@@ -56,12 +58,18 @@ endif
 
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
+  NO_SYSCALL_TABLE := 0
+  CFLAGS += -I$(OUTPUT)arch/s390/include/generated
 endif
 
 ifeq ($(NO_PERF_REGS),0)
   $(call detected,CONFIG_PERF_REGS)
 endif
 
+ifneq ($(NO_SYSCALL_TABLE),1)
+  CFLAGS += -DHAVE_SYSCALL_TABLE
+endif
+
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 6eea7cff3d4e..303bdb84ab5a 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,6 +26,10 @@
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_x86_64_MAX_ID;
 static const char **syscalltbl_native = syscalltbl_x86_64;
+#elif defined(__s390x__)
+#include <asm/syscalls_64.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_s390_64;
 #endif
 
 struct syscall {
-- 
2.13.6
