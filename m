Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgHRNE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Aug 2020 09:04:56 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 3/4] run_tests/mkstandalone: add arch_cmd hook
Date: Tue, 18 Aug 2020 15:04:23 +0200
Message-Id: <20200818130424.20522-4-mhartmay@linux.ibm.com>
In-Reply-To: <20200818130424.20522-1-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
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
 scripts/common.bash | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/common.bash b/scripts/common.bash
index c7acdf14a835..a6044b7c6c35 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -19,7 +19,7 @@ function for_each_unittest()
 	while read -r -u $fd line; do
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
 			if [ -n "${testname}" ]; then
-				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 			fi
 			testname=${BASH_REMATCH[1]}
 			smp=1
@@ -49,11 +49,16 @@ function for_each_unittest()
 		fi
 	done
 	if [ -n "${testname}" ]; then
-		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 	fi
 	exec {fd}<&-
 }
 
+function arch_cmd()
+{
+	[ "${ARCH_CMD}" ] && echo "${ARCH_CMD}"
+}
+
 # The current file has to be the only file sourcing the arch helper
 # file
 ARCH_FUNC=scripts/${ARCH}/func.bash
-- 
2.25.4
