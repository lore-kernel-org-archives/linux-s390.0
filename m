From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/34] perf s390: Generate system call table from asm/unistd.h
Date: Thu, 14 Dec 2017 14:42:29 -0300
Message-ID: <20171214174247.16841-17-acme@kernel.org>
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

This should speed up accessing new system calls introduced with
the kernel rather than waiting for libaudit updates to include
them.

Committer testing:

  $ rm -rf /tmp/build/perf
  $ mkdir /tmp/build/perf
  $ make srctree=/home/acme/git/perf -C tools/perf/arch/s390 OUTPUT=/tmp/build/perf/ archheaders
  make: Entering directory '/home/acme/git/perf/tools/perf/arch/s390'
  /bin/sh '/home/acme/git/perf/tools/perf/arch/s390/entry/syscalls//mksyscalltbl' 'cc' /home/acme/git/perf/tools/arch/s390/include/uapi/asm/unistd.h > /tmp/build/perf/arch/s390/include/generated/asm/syscalls_64.c
  make: Leaving directory '/home/acme/git/perf/tools/perf/arch/s390'
  $ head -5 /tmp/build/perf/arch/s390/include/generated/asm/syscalls_64.c
  static const char *syscalltbl_s390_64[] = {
	[1] = "exit",
	[2] = "fork",
	[3] = "read",
	[4] = "write",
  $ tail -5 /tmp/build/perf/arch/s390/include/generated/asm/syscalls_64.c
	[378] = "s390_guarded_storage",
	[379] = "statx",
	[380] = "s390_sthyi",
  };
  #define SYSCALLTBL_S390_64_MAX_ID 380
  $

Now to plug this into 'perf trace' proper.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1512635281-20733-2-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-h5km60rdg3rqxvsys85q50l3@git.kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/Makefile                    | 21 ++++++++++++++
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl | 36 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100755 tools/perf/arch/s390/entry/syscalls/mksyscalltbl

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 09ba923debe8..48228de415d0 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -3,3 +3,24 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/s390/include/generated/asm
+header := $(out)/syscalls_64.c
+sysdef := $(srctree)/tools/arch/s390/include/uapi/asm/unistd.h
+sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls/
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, s390) $(RM) $(header)
+
+archheaders: $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
new file mode 100755
index 000000000000..7fa0d0abd419
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate system call table for perf
+#
+#
+# Copyright IBM Corp. 2017
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+#
+
+gcc=$1
+input=$2
+
+if ! test -r $input; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table()
+{
+	local max_nr
+
+	echo 'static const char *syscalltbl_s390_64[] = {'
+	while read sc nr; do
+		printf '\t[%d] = "%s",\n' $nr $sc
+		max_nr=$nr
+	done
+	echo '};'
+	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
+}
+
+
+$gcc -m64 -E -dM -x c  $input	       \
+	|sed -ne 's/^#define __NR_//p' \
+	|sort -t' ' -k2 -nu	       \
+	|create_table
-- 
2.13.6
