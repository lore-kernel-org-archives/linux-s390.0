Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388367AbgEYInx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 04:43:53 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: stsi: Make output tap13 compatible
Date: Mon, 25 May 2020 10:43:40 +0200
Message-Id: <20200525084340.1454-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, stzi@linux.ibm.com, mhartmay@linux.ibm.com, david@redhat.com, cohuck@redhat.com

In tap13 output # is a special character and only "skip" and "todo"
are allowed to come after it. Let's appease our CI environment and
replace # with "count".

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/stsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index 66b4257..b81cea7 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -129,11 +129,11 @@ static void test_3_2_2(void)
 	}
 
 	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
-	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
+	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu count configured");
 	report(data->vm[0].total_cpus ==
 	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
-	       "cpu # total == conf + reserved");
-	report(data->vm[0].standby_cpus == 0, "cpu # standby");
+	       "cpu count total == conf + reserved");
+	report(data->vm[0].standby_cpus == 0, "cpu count standby");
 	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
 	       "VM name == kvm-unit-test");
 
-- 
2.25.1
