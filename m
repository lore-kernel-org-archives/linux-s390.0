From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 3/3] perf s390: Rework system call table creation by using syscall.tbl
Date: Thu,  8 Feb 2018 12:47:50 +0100
Message-ID: <1518090470-2899-4-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Recently, s390 uses a syscall.tbl input file to generate its system
call table and unistd uapi header files.  Hence, update mksyscalltbl
to use it as input to create the system table for perf.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com
---
 tools/perf/arch/s390/Makefile                    | 10 +++++++---
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl | 18 +++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 48228de..dfa6e31 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -10,15 +10,19 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/s390/include/generated/asm
 header := $(out)/syscalls_64.c
-sysdef := $(srctree)/tools/arch/s390/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls/
+syskrn := $(srctree)/arch/s390/kernel/syscalls/syscall.tbl
+sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+        (diff -B $(sysdef) $(syskrn) >/dev/null) \
+        || echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, s390) $(RM) $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
index 7fa0d0a..72ecbb6 100755
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -3,25 +3,23 @@
 #
 # Generate system call table for perf
 #
-#
-# Copyright IBM Corp. 2017
+# Copyright IBM Corp. 2017, 2018
 # Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
 #
 
-gcc=$1
-input=$2
+SYSCALL_TBL=$1
 
-if ! test -r $input; then
+if ! test -r $SYSCALL_TBL; then
 	echo "Could not read input file" >&2
 	exit 1
 fi
 
 create_table()
 {
-	local max_nr
+	local max_nr nr abi sc discard
 
 	echo 'static const char *syscalltbl_s390_64[] = {'
-	while read sc nr; do
+	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
 	done
@@ -29,8 +27,6 @@ create_table()
 	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
 }
 
-
-$gcc -m64 -E -dM -x c  $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+grep -E "^[[:digit:]]+[[:space:]]+(common|64)" $SYSCALL_TBL	\
+	|sort -k1 -n					\
 	|create_table
-- 
1.8.3.1
