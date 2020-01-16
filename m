Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgAPMFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:05:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBvT0b107429
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 07:05:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbvhe03s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 07:05:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 12:05:30 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 3/7] s390x: Add cpu id to interrupt error prints
Date: Thu, 16 Jan 2020 07:05:09 -0500
In-Reply-To: <20200116120513.2244-1-frankja@linux.ibm.com>
References: <20200116120513.2244-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200116120513.2244-4-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

It's good to know which cpu broke the test.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/interrupt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 05f30be..773752a 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -107,8 +107,8 @@ static void fixup_pgm_int(void)
 void handle_pgm_int(void)
 {
 	if (!pgm_int_expected)
-		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
-			     lc->pgm_int_code, lc->pgm_old_psw.addr,
+		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
+			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
 			     lc->pgm_int_id);
 
 	pgm_int_expected = false;
@@ -119,8 +119,8 @@ void handle_ext_int(void)
 {
 	if (!ext_int_expected &&
 	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
-		report_abort("Unexpected external call interrupt (code %#x): at %#lx",
-			     lc->ext_int_code, lc->ext_old_psw.addr);
+		report_abort("Unexpected external call interrupt (code %#x): on cpu %d at %#lx",
+			     stap(), lc->ext_int_code, lc->ext_old_psw.addr);
 		return;
 	}
 
@@ -137,18 +137,18 @@ void handle_ext_int(void)
 
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
