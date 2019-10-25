Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409654AbfJYRGm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 13:06:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PH4TUW123007
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv3ck42cx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:41 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 25 Oct 2019 18:06:40 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 2/5] s390x: improve error reporting for interrupts
Date: Fri, 25 Oct 2019 19:06:31 +0200
In-Reply-To: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1572023194-14370-3-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Improve error reporting for unexpected external interrupts to also
print the received external interrupt code.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/s390x/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 5cade23..1636207 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -118,8 +118,8 @@ void handle_ext_int(void)
 {
 	if (!ext_int_expected &&
 	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
-		report_abort("Unexpected external call interrupt: at %#lx",
-			     lc->ext_old_psw.addr);
+		report_abort("Unexpected external call interrupt (code %#x): at %#lx",
+			     lc->ext_int_code, lc->ext_old_psw.addr);
 		return;
 	}
 
-- 
2.7.4
