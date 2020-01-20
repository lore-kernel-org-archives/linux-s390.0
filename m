Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgATSnG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 13:43:06 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KIcrGq090490
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 13:43:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdk8qq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 13:43:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 20 Jan 2020 18:43:03 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v8 5/6] s390x: lib: fix program interrupt handler if sclp_busy was set
Date: Mon, 20 Jan 2020 19:42:55 +0100
In-Reply-To: <20200120184256.188698-1-imbrenda@linux.ibm.com>
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200120184256.188698-6-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Fix the program interrupt handler for the case where sclp_busy is set.

The interrupt handler will attempt to write an error message on the
console using the SCLP, and will wait for sclp_busy to become false
before doing so. If an exception happenes between setting the flag and
the SCLP call, or if the call itself raises an exception, we need to
clear the flag so we can successfully print the error message.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/interrupt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 05f30be..ccb376a 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -106,10 +106,13 @@ static void fixup_pgm_int(void)
 
 void handle_pgm_int(void)
 {
-	if (!pgm_int_expected)
+	if (!pgm_int_expected) {
+		/* Force sclp_busy to false, otherwise we will loop forever */
+		sclp_handle_ext();
 		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
 			     lc->pgm_int_code, lc->pgm_old_psw.addr,
 			     lc->pgm_int_id);
+	}
 
 	pgm_int_expected = false;
 	fixup_pgm_int();
-- 
2.24.1
