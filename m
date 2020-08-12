Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26044 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbgHLJ1V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Aug 2020 05:27:21 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [kvm-unit-tests RFC v2 3/4] run_tests/mkstandalone: add arch dependent function to `for_each_unittest`
Date: Wed, 12 Aug 2020 11:27:04 +0200
Message-Id: <20200812092705.17774-4-mhartmay@linux.ibm.com>
In-Reply-To: <20200812092705.17774-1-mhartmay@linux.ibm.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

This allows us, for example, to auto generate a new test case based on
an existing test case.

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 run_tests.sh            |  2 +-
 scripts/common.bash     | 13 +++++++++++++
 scripts/mkstandalone.sh |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index 24aba9cc3a98..23658392c488 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -160,7 +160,7 @@ trap "wait; exit 130" SIGINT
    # preserve stdout so that process_test_output output can write TAP to it
    exec 3>&1
    test "$tap_output" == "yes" && exec > /dev/null
-   for_each_unittest $config run_task
+   for_each_unittest $config run_task arch_cmd
 ) | postprocess_suite_output
 
 # wait until all tasks finish
diff --git a/scripts/common.bash b/scripts/common.bash
index f9c15fd304bd..62931a40b79a 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -1,8 +1,15 @@
+function arch_cmd()
+{
+	# Dummy function, can be overwritten by architecture dependent
+	# code
+	return
+}
 
 function for_each_unittest()
 {
 	local unittests="$1"
 	local cmd="$2"
+	local arch_cmd="${3-}"
 	local testname
 	local smp
 	local kernel
@@ -19,6 +26,9 @@ function for_each_unittest()
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
 			if [ -n "${testname}" ]; then
 				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+				if [ "${arch_cmd}" ]; then
+					"${arch_cmd}" "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+				fi
 			fi
 			testname=${BASH_REMATCH[1]}
 			smp=1
@@ -49,6 +59,9 @@ function for_each_unittest()
 	done
 	if [ -n "${testname}" ]; then
 		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+		if [ "${arch_cmd}" ]; then
+			"${arch_cmd}" "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+		fi
 	fi
 	exec {fd}<&-
 }
diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index cefdec30cb33..3b18c0cf090b 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -128,4 +128,4 @@ fi
 
 mkdir -p tests
 
-for_each_unittest $cfg mkstandalone
+for_each_unittest $cfg mkstandalone arch_cmd
-- 
2.25.4
