Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfK1MqR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCgwRx060827
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whmt0nma2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:14 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 3/9] s390x: irq: make IRQ handler weak
Date: Thu, 28 Nov 2019 13:46:01 +0100
In-Reply-To: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1574945167-29677-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

Having a weak function allows the tests programm to declare its own
IRQ handler.
This is helpfull for I/O tests to have the I/O IRQ handler having
its special work to do.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 3e07867..d70fde3 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -140,7 +140,7 @@ void handle_mcck_int(void)
 		     lc->mcck_old_psw.addr);
 }
 
-void handle_io_int(void)
+__attribute__((weak)) void handle_io_int(void)
 {
 	report_abort("Unexpected io interrupt: at %#lx",
 		     lc->io_old_psw.addr);
-- 
2.17.0
