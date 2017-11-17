From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] perf: correct segfault in nsinfo__copy()
Date: Fri, 17 Nov 2017 16:13:52 +0100
Message-ID: <1510931632-28355-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When running perf in a namespace, workload from other namespaces
are accounted to PID 0.  During thread initialization for PID 0,
nsinfo__new(PID 0) returns NULL.
Later, a missing NULL pointer check in nsinfo__copy() that is
called from map__new() to handle vdso maps might cause a
segmentation fault.

For example, the segmentation fault can be seen when running
perf top in a namespace created with:
	unshare --fork --pid --mount-proc /bin/bash
while running some workload, e.g., find /, in a different
namespace.  The resulting stack trace might look like:

  (gdb)
  #0  nsinfo__copy (nsi=0x0) at util/namespaces.c:143
  #1  0x000000010010fe3a in map__new (machine=<optimized out>, start=132816, len=<optimized out>, pgoff=<optimized out>, d_maj=<optimized out>, d_min=0, ino=0,
      ino_gen=0, prot=5, flags=4098, filename=0x3fffcb01180 "[vdso]", type=MAP__FUNCTION, thread=0x101c3c050) at util/map.c:192
  #2  0x000000010010e1a4 in machine__process_mmap2_event (machine=0x101c3bab8, event=0x3fffcb01138, sample=<optimized out>) at util/machine.c:1397
  #3  0x00000001000659d8 in perf_top__mmap_read_idx (top=top@entry=0x3ffffff91d0, idx=idx@entry=0) at builtin-top.c:863
  #4  0x00000001000680ae in perf_top__mmap_read (top=0x3ffffff91d0) at builtin-top.c:876
  #5  __cmd_top (top=0x3ffffff91d0) at builtin-top.c:1021
  #6  cmd_top (argc=<optimized out>, argv=<optimized out>) at builtin-top.c:1352
  #7  0x00000001000b643c in run_builtin (p=0x100277b08 <commands+336>, argc=<optimized out>, argv=0x3ffffffede0) at perf.c:297
  #8  0x00000001000419e0 in handle_internal_command (argv=<optimized out>, argc=1) at perf.c:349
  #9  run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:393
  #10 main (argc=<optimized out>, argv=0x3ffffffede0) at perf.c:537

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/namespaces.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 5be0217..cf8bd12 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
+	if (nsi == NULL)
+		return NULL;
+
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
 		nnsi->pid = nsi->pid;
-- 
1.8.3.1
