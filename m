From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/43] perf trace: Remove audit-libs dependency if syscall tables are present
Date: Tue, 23 Jan 2018 10:12:22 -0300
Message-ID: <20180123131251.28197-15-acme@kernel.org>
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

Change the Makefile and build process to no longer require audit-libs
interfaces when the architecture provides system call tables.

Committer notes:

Its not enough to hook into the NO_LIBAUDIT makefile block, we need to
define a CONFIG_TRACE that gets selected by both architectures
generating the syscall tables from the kernel headers and from detecting
the availability of libaudit.

With that in place we will not link against libaudit even if the
necessary files are available for that, in fact we will not even try to
detect its availability, speeding up a bit the feature detection phase.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1516352177-11106-6-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-j68lub6ipm8apvy52vd3l4cm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Build                    |  4 ++--
 tools/perf/Makefile.config          | 20 ++++++++++++--------
 tools/perf/builtin-help.c           |  2 +-
 tools/perf/perf.c                   |  4 ++--
 tools/perf/util/Build               |  2 +-
 tools/perf/util/generate-cmdlist.sh |  2 +-
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index b48ca40fccf9..e5232d567611 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -25,7 +25,7 @@ perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
 
-perf-$(CONFIG_AUDIT) += builtin-trace.o
+perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
 perf-y += bench/
@@ -50,6 +50,6 @@ libperf-y += util/
 libperf-y += arch/
 libperf-y += ui/
 libperf-y += scripts/
-libperf-$(CONFIG_AUDIT) += trace/beauty/
+libperf-$(CONFIG_TRACE) += trace/beauty/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 92265b32dddd..a042ccca4e93 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -531,14 +531,18 @@ ifndef NO_LIBUNWIND
   EXTLIBS += $(EXTLIBS_LIBUNWIND)
 endif
 
-ifndef NO_LIBAUDIT
-  ifneq ($(feature-libaudit), 1)
-    msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
-    NO_LIBAUDIT := 1
-  else
-    CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
-    EXTLIBS += -laudit
-    $(call detected,CONFIG_AUDIT)
+ifeq ($(NO_SYSCALL_TABLE),0)
+  $(call detected,CONFIG_TRACE)
+else
+  ifndef NO_LIBAUDIT
+    ifneq ($(feature-libaudit), 1)
+      msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
+      NO_LIBAUDIT := 1
+    else
+      CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
+      EXTLIBS += -laudit
+      $(call detected,CONFIG_TRACE)
+    endif
   endif
 endif
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index a0f7ed2b869b..4aca13f23b9d 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -439,7 +439,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#ifdef HAVE_LIBAUDIT_SUPPORT
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
 		"trace",
 #endif
 	NULL };
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 62b13518bc6e..1b3fc8ec0fa2 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -73,7 +73,7 @@ static struct cmd_struct commands[] = {
 	{ "lock",	cmd_lock,	0 },
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#ifdef HAVE_LIBAUDIT_SUPPORT
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -485,7 +485,7 @@ int main(int argc, const char **argv)
 		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
-#ifdef HAVE_LIBAUDIT_SUPPORT
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
 		setup_path();
 		argv[0] = "trace";
 		return cmd_trace(argc, argv);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7c6a8b461e24..4eef0c243306 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -44,7 +44,7 @@ libperf-y += machine.o
 libperf-y += map.o
 libperf-y += pstack.o
 libperf-y += session.o
-libperf-$(CONFIG_AUDIT) += syscalltbl.o
+libperf-$(CONFIG_TRACE) += syscalltbl.o
 libperf-y += ordered-events.o
 libperf-y += namespaces.o
 libperf-y += comm.o
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index 9bbcec4e3365..ff17920a5ebc 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#ifdef HAVE_LIBAUDIT_SUPPORT"
+echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
-- 
2.14.3
