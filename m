From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/43] perf util: Introduce architecture specific errno/name mapping
Date: Tue, 23 Jan 2018 10:12:20 -0300
Message-ID: <20180123131251.28197-13-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Introduce a script that generates a mapping of errno numbers to their
names for each architecture that is supported by perf (i.e.  has a
subdirectory in tools/perf/arch/).

The errno mapping is generated as part of the trace beautifiers and can
be used by including the trace/beauty/arch_errno_names.c file.  Then,
use arch_syscalls__strerrno() to look up an errno value to obtain the
errno name (e.g. ENOENT) for a particular architecture.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1516352177-11106-4-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-8zlsjnuoep2ww39aq5z41fno@git.kernel.org
[ Make x86 be the first arch, most common, add newline to last line, fixing build on centos:5 ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                    |  13 +++-
 tools/perf/trace/beauty/arch_errno_names.c  |   1 +
 tools/perf/trace/beauty/arch_errno_names.sh | 100 ++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h            |   2 +
 4 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/trace/beauty/arch_errno_names.c
 create mode 100755 tools/perf/trace/beauty/arch_errno_names.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9fdefd748e2e..9a9b528a88bb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -462,6 +462,13 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
+arch_errno_hdr_dir := $(srctree)/tools
+arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
+
+$(arch_errno_name_array): $(arch_errno_tbl)
+	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -565,7 +572,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
 	$(perf_ioctl_array) \
-	$(prctl_option_array)
+	$(prctl_option_array) \
+	$(arch_errno_name_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -847,7 +855,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(kcmp_type_array) \
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
-		$(OUTPUT)$(prctl_option_array)
+		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(arch_errno_name_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
 #
diff --git a/tools/perf/trace/beauty/arch_errno_names.c b/tools/perf/trace/beauty/arch_errno_names.c
new file mode 100644
index 000000000000..ede031c3a9e0
--- /dev/null
+++ b/tools/perf/trace/beauty/arch_errno_names.c
@@ -0,0 +1 @@
+#include "trace/beauty/generated/arch_errno_name_array.c"
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
new file mode 100755
index 000000000000..22c9fc900c84
--- /dev/null
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate C file mapping errno codes to errno names.
+#
+# Copyright IBM Corp. 2018
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+
+gcc="$1"
+toolsdir="$2"
+include_path="-I$toolsdir/include/uapi"
+
+arch_string()
+{
+	echo "$1" |sed -e 'y/- /__/' |tr '[[:upper:]]' '[[:lower:]]'
+}
+
+asm_errno_file()
+{
+	local arch="$1"
+	local header
+
+	header="$toolsdir/arch/$arch/include/uapi/asm/errno.h"
+	if test -r "$header"; then
+		echo "$header"
+	else
+		echo "$toolsdir/include/uapi/asm-generic/errno.h"
+	fi
+}
+
+create_errno_lookup_func()
+{
+	local arch=$(arch_string "$1")
+	local nr name
+
+	cat <<EoFuncBegin
+static const char *errno_to_name__$arch(int err)
+{
+	switch (err) {
+EoFuncBegin
+
+	while read name nr; do
+		printf '\tcase %d: return "%s";\n' $nr $name
+	done
+
+	cat <<EoFuncEnd
+	default:
+		return "(unknown)";
+	}
+}
+
+EoFuncEnd
+}
+
+process_arch()
+{
+	local arch="$1"
+	local asm_errno=$(asm_errno_file "$arch")
+
+	$gcc $include_path -E -dM -x c $asm_errno \
+		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
+		|awk '{ print $2","$3; }' \
+		|sort -t, -k2 -nu \
+		|IFS=, create_errno_lookup_func "$arch"
+}
+
+create_arch_errno_table_func()
+{
+	local archlist="$1"
+	local default="$2"
+	local arch
+
+	printf 'const char *arch_syscalls__strerrno(const char *arch, int err)\n'
+	printf '{\n'
+	for arch in $archlist; do
+		printf '\tif (!strcmp(arch, "%s"))\n' $(arch_string "$arch")
+		printf '\t\treturn errno_to_name__%s(err);\n' $(arch_string "$arch")
+	done
+	printf '\treturn errno_to_name__%s(err);\n' $(arch_string "$default")
+	printf '}\n'
+}
+
+cat <<EoHEADER
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <string.h>
+
+EoHEADER
+
+# Create list of architectures and ignore those that do not appear
+# in tools/perf/arch
+archlist=""
+for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
+	test -d arch/$arch && archlist="$archlist $arch"
+done
+
+for arch in x86 $archlist generic; do
+	process_arch "$arch"
+done
+create_arch_errno_table_func "x86 $archlist" "generic"
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index a6dfd04beaee..d8f6b2ec7fc5 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -114,4 +114,6 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size);
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg));
 
+const char *arch_syscalls__strerrno(const char *arch, int err);
+
 #endif /* _PERF_TRACE_BEAUTY_H */
-- 
2.14.3
