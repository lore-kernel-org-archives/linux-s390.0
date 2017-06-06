From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf: fix incorrect sample_type value for perf stat tests
Date: Tue,  6 Jun 2017 16:31:54 +0200
Message-ID: <20170606143156.10471-2-tmricht@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Test case 14 runs 'perf stat' command to execute all
tests/attr/test-stat* test cases. They all fail with
a mismatch in sample_type attribute, for example:

running './tests/attr//test-stat-basic'
...
compare
  matchng [event:base-stat]
      to [event-0-0-4]
      ...
      [sample_type] 0 65536
  ->FAIL

The reason for the failure is in create_perf_stat_counter()
in file builtin-stat.c. When command 'perf stat record -o -'
is used the value of perf_event_stat.sample_type is not changed.
All other invocations of 'perf stat' change this
member to PERF_SAMPLE_IDENTIFIER (2^16).

None of the test-stat-* tests are invoked with
'perf stat record -o -' and the sample_type comparion fails.

Fix this by changing the expected value for attribute sample_type
in the base_stat file.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/base-stat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index f4cf148..4a48d16 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -8,7 +8,7 @@ type=0
 size=112
 config=0
 sample_period=0
-sample_type=0
+sample_type=65536
 read_format=3
 disabled=1
 inherit=1
-- 
2.9.3
