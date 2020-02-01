Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbgBAP3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FFVUN027263
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xw7b4736n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 2/7] s390x: smp: Fix ecall and emcall report strings
Date: Sat,  1 Feb 2020 10:28:46 -0500
In-Reply-To: <20200201152851.82867-1-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200201152851.82867-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Instead of "smp: ecall: ecall" we now get "smp: ecall: received".

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index e37eb56..93a9594 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -125,7 +125,7 @@ static void ecall(void)
 	load_psw_mask(mask);
 	set_flag(1);
 	while (lc->ext_int_code != 0x1202) { mb(); }
-	report(1, "ecall");
+	report(1, "received");
 	set_flag(1);
 }
 
@@ -160,7 +160,7 @@ static void emcall(void)
 	load_psw_mask(mask);
 	set_flag(1);
 	while (lc->ext_int_code != 0x1201) { mb(); }
-	report(1, "ecall");
+	report(1, "received");
 	set_flag(1);
 }
 
-- 
2.20.1
