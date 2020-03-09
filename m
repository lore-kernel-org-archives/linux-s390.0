Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgCIPEB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 11:04:01 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] selftests: KVM: s390: check for registers to NOT change on reset
Date: Mon,  9 Mar 2020 11:00:26 -0400
Message-Id: <20200309150026.4329-5-borntraeger@de.ibm.com>
In-Reply-To: <20200309150026.4329-1-borntraeger@de.ibm.com>
References: <20200309150026.4329-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

Normal reset and initial CPU reset do not clear all registers. Add a
test that those registers are NOT changed.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 55 +++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index c385842792b7..b567705f0d41 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -40,8 +40,22 @@ static void guest_code_initial(void)
 		"	lctlg	8,8,%1\n"
 		"	lctlg	10,10,%2\n"
 		"	lctlg	11,11,%3\n"
-		: : "m" (cr2_59), "m" (cr8_63), "m" (cr10), "m" (cr11) : "2");
-	GUEST_SYNC(0);
+		/* now clobber some general purpose regs */
+		"	llihh	0,0xffff\n"
+		"	llihl	1,0x5555\n"
+		"	llilh	2,0xaaaa\n"
+		"	llill	3,0x0000\n"
+		/* now clobber a floating point reg */
+		"	lghi	4,0x1\n"
+		"	cdgbr	0,4\n"
+		/* now clobber an access reg */
+		"	sar	9,4\n"
+		/* We embed diag 501 here to control register content */
+		"	diag 0,0,0x501\n"
+		:
+		: "m" (cr2_59), "m" (cr8_63), "m" (cr10), "m" (cr11)
+		/* no clobber list as this should not return */
+		);
 }
 
 static void test_one_reg(uint64_t id, uint64_t value)
@@ -98,6 +112,21 @@ static void assert_clear(void)
 		    "vrs0-15 == 0 (sync_regs)");
 }
 
+static void assert_initial_noclear(void)
+{
+	TEST_ASSERT(sync_regs->gprs[0] == 0xffff000000000000UL,
+		    "gpr0 == 0xffff000000000000 (sync_regs)");
+	TEST_ASSERT(sync_regs->gprs[1] == 0x0000555500000000UL,
+		    "gpr1 == 0x0000555500000000 (sync_regs)");
+	TEST_ASSERT(sync_regs->gprs[2] == 0x00000000aaaa0000UL,
+		    "gpr2 == 0x00000000aaaa0000 (sync_regs)");
+	TEST_ASSERT(sync_regs->gprs[3] == 0x0000000000000000UL,
+		    "gpr3 == 0x0000000000000000 (sync_regs)");
+	TEST_ASSERT(sync_regs->fprs[0] == 0x3ff0000000000000UL,
+		    "fpr0 == 0f1 (sync_regs)");
+	TEST_ASSERT(sync_regs->acrs[9] == 1, "ar9 == 1 (sync_regs)");
+}
+
 static void assert_initial(void)
 {
 	struct kvm_sregs sregs;
@@ -140,6 +169,14 @@ static void assert_initial(void)
 	test_one_reg(KVM_REG_S390_CLOCK_COMP, 0);
 }
 
+static void assert_normal_noclear(void)
+{
+	TEST_ASSERT(sync_regs->crs[2] == 0x10, "cr2 == 10 (sync_regs)");
+	TEST_ASSERT(sync_regs->crs[8] == 1, "cr10 == 1 (sync_regs)");
+	TEST_ASSERT(sync_regs->crs[10] == 1, "cr10 == 1 (sync_regs)");
+	TEST_ASSERT(sync_regs->crs[11] == -1, "cr11 == -1 (sync_regs)");
+}
+
 static void assert_normal(void)
 {
 	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
@@ -176,7 +213,13 @@ static void test_normal(void)
 	inject_irq(VCPU_ID);
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
+
+	/* must clears */
 	assert_normal();
+	/* must not clears */
+	assert_normal_noclear();
+	assert_initial_noclear();
+
 	kvm_vm_free(vm);
 }
 
@@ -192,8 +235,13 @@ static void test_initial(void)
 	inject_irq(VCPU_ID);
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
+
+	/* must clears */
 	assert_normal();
 	assert_initial();
+	/* must not clears */
+	assert_initial_noclear();
+
 	kvm_vm_free(vm);
 }
 
@@ -209,9 +257,12 @@ static void test_clear(void)
 	inject_irq(VCPU_ID);
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
+
+	/* must clears */
 	assert_normal();
 	assert_initial();
 	assert_clear();
+
 	kvm_vm_free(vm);
 }
 
-- 
2.25.0
