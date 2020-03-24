Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgCXINI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 04:13:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O83w3U009040
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 04:13:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewtr7p0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 04:13:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 24 Mar 2020 08:13:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 02/10] s390x: smp: Dirty fpc before initial reset test
Date: Tue, 24 Mar 2020 04:12:43 -0400
In-Reply-To: <20200324081251.28810-1-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200324081251.28810-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

Let's dirty the fpc, before we test if the initial reset sets it to 0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 8c9b98aabd9e8222..95df8c49d2495391 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -185,6 +185,7 @@ static void test_emcall(void)
 /* Used to dirty registers of cpu #1 before it is reset */
 static void test_func_initial(void)
 {
+	asm volatile("sfpc %0" :: "d" (0x11));
 	lctlg(1, 0x42000UL);
 	lctlg(7, 0x43000UL);
 	lctlg(13, 0x44000UL);
-- 
2.25.1
