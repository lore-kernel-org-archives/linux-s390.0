Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfKRIgL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8WXZp014248
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2way8kuqp2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:10 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 18 Nov 2019 08:36:08 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/5] selftests: kvm: make syncregs more reliable on s390
Date: Mon, 18 Nov 2019 09:36:00 +0100
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191118083602.15835-4-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

similar to commit 2c57da356800 ("selftests: kvm: fix sync_regs_test with
newer gccs") and commit 204c91eff798a ("KVM: selftests: do not blindly
clobber registers in guest asm") we better do not rely on gcc leaving
r11 untouched.  We can write the simple ucall inline and have the guest
code completely as small assembler function.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .../testing/selftests/kvm/s390x/sync_regs_test.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index d5290b4ad636..b705637ca14b 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -25,12 +25,15 @@
 
 static void guest_code(void)
 {
-	register u64 stage asm("11") = 0;
-
-	for (;;) {
-		GUEST_SYNC(0);
-		asm volatile ("ahi %0,1" : : "r"(stage));
-	}
+	/*
+	 * We embed diag 501 here instead of doing a ucall to avoid that
+	 * the compiler has messed with r11 at the time of the ucall.
+	 */
+	asm volatile (
+		"0:	diag 0,0,0x501\n"
+		"	ahi 11,1\n"
+		"	j 0b\n"
+	);
 }
 
 #define REG_COMPARE(reg) \
-- 
2.21.0
