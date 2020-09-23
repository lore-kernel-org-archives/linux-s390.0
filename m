Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgIWNsO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 09:48:14 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH kvm-unit-tests v2 1/4] common.bash: run `cmd` only if a test case was found
Date: Wed, 23 Sep 2020 15:47:55 +0200
Message-Id: <20200923134758.19354-2-mhartmay@linux.ibm.com>
In-Reply-To: <20200923134758.19354-1-mhartmay@linux.ibm.com>
References: <20200923134758.19354-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

It's only useful to run `cmd` in `for_each_unittest` if a test case
was found. This change allows us to remove the guards from the
functions `run_task` and `mkstandalone`.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 run_tests.sh            | 3 ---
 scripts/common.bash     | 8 ++++++--
 scripts/mkstandalone.sh | 4 ----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index fc4b3c23d886..12b63954721d 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -133,9 +133,6 @@ RUNTIME_log_stdout () {
 function run_task()
 {
 	local testname="$1"
-	if [ -z "$testname" ]; then
-		return
-	fi
 
 	while (( $(jobs | wc -l) == $unittest_run_queues )); do
 		# wait for any background test to finish
diff --git a/scripts/common.bash b/scripts/common.bash
index 9a6ebbd7f287..96655c9ffd1f 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -17,7 +17,9 @@ function for_each_unittest()
 
 	while read -r -u $fd line; do
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
-			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+			if [ -n "${testname}" ]; then
+				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+			fi
 			testname=${BASH_REMATCH[1]}
 			smp=1
 			kernel=""
@@ -45,6 +47,8 @@ function for_each_unittest()
 			timeout=${BASH_REMATCH[1]}
 		fi
 	done
-	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+	if [ -n "${testname}" ]; then
+		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+	fi
 	exec {fd}<&-
 }
diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index 9d506cc95072..cefdec30cb33 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -83,10 +83,6 @@ function mkstandalone()
 {
 	local testname="$1"
 
-	if [ -z "$testname" ]; then
-		return
-	fi
-
 	if [ -n "$one_testname" ] && [ "$testname" != "$one_testname" ]; then
 		return
 	fi
-- 
2.25.4
