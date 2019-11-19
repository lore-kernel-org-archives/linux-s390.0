Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbfKSJxu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 04:53:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJ9qcvd063781
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 04:53:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waymaw1af-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 04:53:47 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 19 Nov 2019 09:53:45 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 1/3] s390x: export sclp_setup_int
Date: Tue, 19 Nov 2019 10:53:37 +0100
In-Reply-To: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Export sclp_setup_int() so that it can be used from outside.

Needed for an upocoming unit test.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/sclp.h | 1 +
 lib/s390x/sclp.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 6d40fb7..675f07e 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -265,6 +265,7 @@ typedef struct ReadEventData {
 } __attribute__((packed)) ReadEventData;
 
 extern char _sccb[];
+void sclp_setup_int(void);
 void sclp_handle_ext(void);
 void sclp_wait_busy(void);
 void sclp_mark_busy(void);
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 7798f04..123b639 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -45,7 +45,7 @@ static void mem_init(phys_addr_t mem_end)
 	page_alloc_ops_enable();
 }
 
-static void sclp_setup_int(void)
+void sclp_setup_int(void)
 {
 	uint64_t mask;
 
-- 
2.7.4
