Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21108 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbfKMMXj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:23:39 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADCJLC1182944
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:23:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7qdcv74f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:23:36 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Nov 2019 12:23:23 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 3/4] s390x:irq: make IRQ handler weak
Date: Wed, 13 Nov 2019 13:23:18 +0100
In-Reply-To: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

Having a weak function allows the tests programm to declare its own IRQ
handler.
This is helpfull when developping I/O tests.
---
 lib/s390x/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 7aecfc5..0049194 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -140,7 +140,7 @@ void handle_mcck_int(sregs_t *regs)
 		     lc->mcck_old_psw.addr);
 }
 
-void handle_io_int(sregs_t *regs)
+__attribute__((weak)) void handle_io_int(sregs_t *regs)
 {
 	report_abort("Unexpected io interrupt: at %#lx",
 		     lc->io_old_psw.addr);
-- 
2.7.4
