From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/52] perf tests: Let 'perf test list' display subtests
Date: Wed,  2 May 2018 12:19:03 -0300
Message-ID: <20180502151942.20542-14-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.ibm.com>

The output of perf test and perf test list differ because perf test list
does not display subtests.  Correct this behavior and also let perf test
list report subtests.

For example:

	$ ./perf test 2>&1 |wc -l
	65

Without this commit:
	$ ./perf test list 2>&1 |wc -l
	57

With this commit:
	$ ./perf test list 2>&1 |wc -l
	65

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1523605343-11970-1-git-send-email-brueckner@linux.ibm.com
Link: https://lkml.kernel.org/n/tip-efb74jw7x2xs2bucp5hf4ilu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cac8f8889bc3..2bde505e2e7e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -654,6 +654,15 @@ static int perf_test__list(int argc, const char **argv)
 			continue;
 
 		pr_info("%2d: %s\n", i, t->desc);
+
+		if (t->subtest.get_nr) {
+			int subn = t->subtest.get_nr();
+			int subi;
+
+			for (subi = 0; subi < subn; subi++)
+				pr_info("%2d:%1d: %s\n", i, subi + 1,
+					t->subtest.get_desc(subi));
+		}
 	}
 
 	perf_test__list_shell(argc, argv, i);
-- 
2.14.3
