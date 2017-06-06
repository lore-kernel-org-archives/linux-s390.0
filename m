From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 3/3] perf: fix perf test case 14
Date: Tue,  6 Jun 2017 16:31:56 +0200
Message-ID: <20170606143156.10471-4-tmricht@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Command perf test -v 14 (Setup struct perf_event_attr test)
always reports success even if the test case fails.
It works correctly if you also specify -F (for don't fork).

   root@s35lp76 perf]# ./perf test -v 14
   14: Setup struct perf_event_attr               :
   --- start ---
   running './tests/attr/test-record-no-delay'
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.002 MB /tmp/tmp4E1h7R/perf.data
     (1 samples) ]
   expected task=0, got 1
   expected precise_ip=0, got 3
   expected wakeup_events=1, got 0
   FAILED './tests/attr/test-record-no-delay' - match failure
   test child finished with 0
   ---- end ----
   Setup struct perf_event_attr: Ok

The reason for the wrong error reporting is the return value of the
system() library call. It is called in run_dir() file tests/attr.c
and returns the exit status, in above case 0xff00.
This value is given as parameter to the exit() function which
can only handle values 0-0xff.
The child process terminates with exit value of 0 and the parent
does not detect any error.

This patch corrects the error reporting and prints the
correct test result.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 88dc51f..131b510 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -150,7 +150,7 @@ static int run_dir(const char *d, const char *perf)
 	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
 		 d, d, perf, vcnt, v);
 
-	return system(cmd);
+	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
 
 int test__attr(int subtest __maybe_unused)
-- 
2.9.3
