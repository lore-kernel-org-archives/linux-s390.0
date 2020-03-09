Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgCIPEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 11:04:23 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/4] selftests: KVM: s390: fix early guest crash
Date: Mon,  9 Mar 2020 11:00:23 -0400
Message-Id: <20200309150026.4329-2-borntraeger@de.ibm.com>
In-Reply-To: <20200309150026.4329-1-borntraeger@de.ibm.com>
References: <20200309150026.4329-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

The guest crashes very early due to changes in the control registers
used by dynamic address translation. Let us use different registers
that will not crash the guest.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index 1485bc6c8999..cbb343ad5d42 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -23,25 +23,24 @@ struct kvm_run *run;
 struct kvm_sync_regs *regs;
 static uint64_t regs_null[16];
 
-static uint64_t crs[16] = { 0x40000ULL,
-			    0x42000ULL,
-			    0, 0, 0, 0, 0,
-			    0x43000ULL,
-			    0, 0, 0, 0, 0,
-			    0x44000ULL,
-			    0, 0
-};
-
 static void guest_code_initial(void)
 {
-	/* Round toward 0 */
-	uint32_t fpc = 0x11;
+	/* set several CRs to "safe" value */
+	unsigned long cr2_59 = 0x10;	/* enable guarded storage */
+	unsigned long cr8_63 = 0x1;	/* monitor mask = 1 */
+	unsigned long cr10 = 1;		/* PER START */
+	unsigned long cr11 = -1;	/* PER END */
+
 
 	/* Dirty registers */
 	asm volatile (
-		"	lctlg	0,15,%0\n"
-		"	sfpc	%1\n"
-		: : "Q" (crs), "d" (fpc));
+		"	lghi	2,0x11\n"	/* Round toward 0 */
+		"	sfpc	2\n"		/* set fpc to !=0 */
+		"	lctlg	2,2,%0\n"
+		"	lctlg	8,8,%1\n"
+		"	lctlg	10,10,%2\n"
+		"	lctlg	11,11,%3\n"
+		: : "m" (cr2_59), "m" (cr8_63), "m" (cr10), "m" (cr11) : "2");
 	GUEST_SYNC(0);
 }
 
-- 
2.25.0
