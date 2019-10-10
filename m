Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726923AbfJJHxo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 03:53:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A7rdSW004793
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 03:53:41 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhx4dcedr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 03:53:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 10 Oct 2019 08:52:42 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] selftests: kvm: make syncregs more reliable on s390
Date: Thu, 10 Oct 2019 09:52:36 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191010075236.100247-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

similar to commit 2c57da356800 ("selftests: kvm: fix sync_regs_test with
newer gccs") and commit 204c91eff798a ("KVM: selftests: do not blindly
clobber registers in guest asm") we better do not rely on gcc leaving
r11 untouched.  We can write the simple ucall inline and have the guest
code completely as small assembler function.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/s390x/sync_regs_test.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index d5290b4ad636..04d6abe68961 100644
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
+	 * we embed diag 501 here instead of a ucall as the called function
+	 * could mess with the content of r11 when doing the hypercall
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
