From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 5/5] perf trace: Remove audit-libs dependency if syscall tables are present
Date: Fri, 19 Jan 2018 09:56:17 +0100
Message-ID: <1516352177-11106-6-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Change the Makefile and build process to no longer require audit-libs
interfaces when the architecture provides system call tables.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/Makefile.config          | 10 ++++++++--
 tools/perf/builtin-help.c           |  2 +-
 tools/perf/perf.c                   |  4 ++--
 tools/perf/util/generate-cmdlist.sh |  2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 12dec6e..f02f370 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -533,8 +533,14 @@ endif
 
 ifndef NO_LIBAUDIT
   ifneq ($(feature-libaudit), 1)
-    msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
-    NO_LIBAUDIT := 1
+    ifeq ($(NO_SYSCALL_TABLE), 1)
+      msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
+      NO_LIBAUDIT := 1
+    else
+      # With syscall table support, auditlibs are no longer required to build
+      # the trace tool.
+      $(call detected,CONFIG_AUDIT)
+    endif
   else
     CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
     EXTLIBS += -laudit
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index a0f7ed2..4aca13f 100644
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
index 62b1351..1b3fc8e 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -73,7 +73,7 @@ struct cmd_struct {
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
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index 9bbcec4..ff17920 100755
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
1.8.3.1
