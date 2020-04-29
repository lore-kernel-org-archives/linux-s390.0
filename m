Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52646 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgD2OgK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 10:36:10 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v3 02/10] s390x: smp: Dirty fpc before initial reset test
Date: Wed, 29 Apr 2020 10:35:10 -0400
Message-Id: <20200429143518.1360468-3-frankja@linux.ibm.com>
In-Reply-To: <20200429143518.1360468-1-frankja@linux.ibm.com>
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Let's dirty the fpc, before we test if the initial reset sets it to 0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/s390x/smp.c b/s390x/smp.c
index 7144c9b..b07cb66 100644
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
