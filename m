Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404834AbfITHue (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 03:50:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8K7ch4d057199
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 03:50:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4r31w17e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 03:50:31 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 20 Sep 2019 08:50:30 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add selector tests
Date: Fri, 20 Sep 2019 09:50:20 +0200
Message-Id: <20190920075020.1698-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Alignment and selectors test order is not specified and so, if you
have an unaligned address and invalid selectors it's up to the
hypervisor to decide which error is presented.

Let's add valid selectors to the unalignmnet test and add selector
tests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/stsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index 7232cb0..c5bd0a2 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -35,7 +35,7 @@ static void test_specs(void)
 
 	report_prefix_push("unaligned");
 	expect_pgm_int();
-	stsi(pagebuf + 42, 1, 0, 0);
+	stsi(pagebuf + 42, 1, 1, 1);
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 	report_prefix_pop();
 
@@ -71,6 +71,8 @@ static inline unsigned long stsi_get_fc(void *addr)
 static void test_fc(void)
 {
 	report("invalid fc",  stsi(pagebuf, 7, 0, 0) == 3);
+	report("invalid selector 1", stsi(pagebuf, 1, 0, 1) == 3);
+	report("invalid selector 2", stsi(pagebuf, 1, 1, 0) == 3);
 	report("query fc >= 2",  stsi_get_fc(pagebuf) >= 2);
 }
 
-- 
2.17.2
