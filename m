From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf: fix exit code check in test case execution
Date: Tue,  6 Jun 2017 16:31:55 +0200
Message-ID: <20170606143156.10471-3-tmricht@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Jiri Olsa's
Commit c9666c26ead0 ("perf tests attr: Make compare_data global")
introduced a wrong check on the command's return code exit status test:

  -        if ret != int(self.ret):
  +        if compare_data(str(ret), str(self.ret)):
             raise Unsup(self)

This check succeeds when the expected return code matches
the actual return code and raises the Unsup exceptions.
This is not correct.

Revert to the orignal check to raise the exception on
mismatch.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 5787879..d0242d8 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -174,7 +174,7 @@ class Test(object):
 
         log.info("  '%s' ret %d, expected %s" % (cmd, ret, str(self.ret)))
 
-        if compare_data(str(ret), str(self.ret)):
+        if ret != int(self.ret):
             raise Unsup(self)
 
     def compare(self, expect, result):
-- 
2.9.3
