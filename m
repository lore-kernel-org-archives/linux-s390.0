From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/43] perf trace: Obtain errno strings by using arch_syscalls__strerrno()
Date: Tue, 23 Jan 2018 10:12:21 -0300
Message-ID: <20180123131251.28197-14-acme@kernel.org>
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

Replace the errno_to_name() from the audit-libs with the newly
introduced arch_syscalls__strerrno() function.

With this change:

1.  With replacing errno_to_name() from audit-libs, perf trace
    does no longer require audit-lib interfaces.

2. In addition to 1, the audit-libs dependency can be removed
   for architectures that support syscall tables in perf.
   This is achieved in a follow-up commit.

3. With the architecture specific errno number/name mapping,
   perf trace reports can work across architectures.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1516352177-11106-5-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-xjvoqzhwmu4wn4kl9ng11rvs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 531d43bf57e1..7dece5e0cdbb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "util/color.h"
 #include "util/debug.h"
+#include "util/env.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include <subcmd/exec-cmd.h>
@@ -45,14 +46,12 @@
 
 #include <errno.h>
 #include <inttypes.h>
-#include <libaudit.h> /* FIXME: Still needed for audit_errno_to_name */
 #include <poll.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/err.h>
 #include <linux/filter.h>
-#include <linux/audit.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
 #include <linux/stringify.h>
@@ -545,6 +544,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .parm	= &strarray__##array, }
 
+#include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/flock.c"
 #include "trace/beauty/futex_op.c"
@@ -1660,6 +1660,14 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
 }
 
+static const char *errno_to_name(struct perf_evsel *evsel, int err)
+{
+	struct perf_env *env = perf_evsel__env(evsel);
+	const char *arch_name = perf_env__arch(env);
+
+	return arch_syscalls__strerrno(arch_name, err);
+}
+
 static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
@@ -1730,7 +1738,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 errno_print: {
 		char bf[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
-			   *e = audit_errno_to_name(-ret);
+			   *e = errno_to_name(evsel, -ret);
 
 		fprintf(trace->output, ") = -1 %s %s", e, emsg);
 	}
-- 
2.14.3
