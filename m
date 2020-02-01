Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgBAP3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FGPNg014068
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xw6qcf81f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 4/7] s390x: Add cpu id to interrupt error prints
Date: Sat,  1 Feb 2020 10:28:48 -0500
In-Reply-To: <20200201152851.82867-1-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200201152851.82867-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

It's good to know which cpu broke the test.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/interrupt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index ccb376a..3a40cac 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -109,8 +109,8 @@ void handle_pgm_int(void)
 	if (!pgm_int_expected) {
 		/* Force sclp_busy to false, otherwise we will loop forever */
 		sclp_handle_ext();
-		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
-			     lc->pgm_int_code, lc->pgm_old_psw.addr,
+		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
+			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
 			     lc->pgm_int_id);
 	}
 
@@ -122,8 +122,8 @@ void handle_ext_int(void)
 {
 	if (!ext_int_expected &&
 	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
-		report_abort("Unexpected external call interrupt (code %#x): at %#lx",
-			     lc->ext_int_code, lc->ext_old_psw.addr);
+		report_abort("Unexpected external call interrupt (code %#x): on cpu %d at %#lx",
+			     lc->ext_int_code, stap(), lc->ext_old_psw.addr);
 		return;
 	}
 
@@ -140,18 +140,18 @@ void handle_ext_int(void)
 
 void handle_mcck_int(void)
 {
-	report_abort("Unexpected machine check interrupt: at %#lx",
-		     lc->mcck_old_psw.addr);
+	report_abort("Unexpected machine check interrupt: on cpu %d at %#lx",
+		     stap(), lc->mcck_old_psw.addr);
 }
 
 void handle_io_int(void)
 {
-	report_abort("Unexpected io interrupt: at %#lx",
-		     lc->io_old_psw.addr);
+	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
+		     stap(), lc->io_old_psw.addr);
 }
 
 void handle_svc_int(void)
 {
-	report_abort("Unexpected supervisor call interrupt: at %#lx",
-		     lc->svc_old_psw.addr);
+	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx",
+		     stap(), lc->svc_old_psw.addr);
 }
-- 
2.20.1
