Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730319AbgCJNBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:50 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/5] selftests: KVM: s390: test more register variants for the reset ioctl
Date: Tue, 10 Mar 2020 09:01:41 -0400
Message-Id: <20200310130144.9921-3-borntraeger@de.ibm.com>
In-Reply-To: <20200310130144.9921-1-borntraeger@de.ibm.com>
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

We should not only test the oneregs or the get_(x)regs interfaces but
also the sync_regs. Those are usually the canonical place for register
content.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 50 ++++++++++++++++++----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index cbb343ad5d42..c385842792b7 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -20,8 +20,8 @@ struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
 
 struct kvm_vm *vm;
 struct kvm_run *run;
-struct kvm_sync_regs *regs;
-static uint64_t regs_null[16];
+struct kvm_sync_regs *sync_regs;
+static uint8_t regs_null[512];
 
 static void guest_code_initial(void)
 {
@@ -86,6 +86,16 @@ static void assert_clear(void)
 
 	vcpu_fpu_get(vm, VCPU_ID, &fpu);
 	TEST_ASSERT(!memcmp(&fpu.fprs, regs_null, sizeof(fpu.fprs)), "fprs == 0");
+
+	/* sync regs */
+	TEST_ASSERT(!memcmp(sync_regs->gprs, regs_null, sizeof(sync_regs->gprs)),
+		    "gprs0-15 == 0 (sync_regs)");
+
+	TEST_ASSERT(!memcmp(sync_regs->acrs, regs_null, sizeof(sync_regs->acrs)),
+		    "acrs0-15 == 0 (sync_regs)");
+
+	TEST_ASSERT(!memcmp(sync_regs->vrs, regs_null, sizeof(sync_regs->vrs)),
+		    "vrs0-15 == 0 (sync_regs)");
 }
 
 static void assert_initial(void)
@@ -93,12 +103,32 @@ static void assert_initial(void)
 	struct kvm_sregs sregs;
 	struct kvm_fpu fpu;
 
+	/* KVM_GET_SREGS */
 	vcpu_sregs_get(vm, VCPU_ID, &sregs);
-	TEST_ASSERT(sregs.crs[0] == 0xE0UL, "cr0 == 0xE0");
-	TEST_ASSERT(sregs.crs[14] == 0xC2000000UL, "cr14 == 0xC2000000");
+	TEST_ASSERT(sregs.crs[0] == 0xE0UL, "cr0 == 0xE0 (KVM_GET_SREGS)");
+	TEST_ASSERT(sregs.crs[14] == 0xC2000000UL,
+		    "cr14 == 0xC2000000 (KVM_GET_SREGS)");
 	TEST_ASSERT(!memcmp(&sregs.crs[1], regs_null, sizeof(sregs.crs[1]) * 12),
-		    "cr1-13 == 0");
-	TEST_ASSERT(sregs.crs[15] == 0, "cr15 == 0");
+		    "cr1-13 == 0 (KVM_GET_SREGS)");
+	TEST_ASSERT(sregs.crs[15] == 0, "cr15 == 0 (KVM_GET_SREGS)");
+
+	/* sync regs */
+	TEST_ASSERT(sync_regs->crs[0] == 0xE0UL, "cr0 == 0xE0 (sync_regs)");
+	TEST_ASSERT(sync_regs->crs[14] == 0xC2000000UL,
+		    "cr14 == 0xC2000000 (sync_regs)");
+	TEST_ASSERT(!memcmp(&sync_regs->crs[1], regs_null, 8 * 12),
+		    "cr1-13 == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->crs[15] == 0, "cr15 == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->fpc == 0, "fpc == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->todpr == 0, "todpr == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->cputm == 0, "cputm == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->ckc == 0, "ckc == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->pp == 0, "pp == 0 (sync_regs)");
+	TEST_ASSERT(sync_regs->gbea == 1, "gbea == 1 (sync_regs)");
+
+	/* kvm_run */
+	TEST_ASSERT(run->psw_addr == 0, "psw_addr == 0 (kvm_run)");
+	TEST_ASSERT(run->psw_mask == 0, "psw_mask == 0 (kvm_run)");
 
 	vcpu_fpu_get(vm, VCPU_ID, &fpu);
 	TEST_ASSERT(!fpu.fpc, "fpc == 0");
@@ -113,6 +143,8 @@ static void assert_initial(void)
 static void assert_normal(void)
 {
 	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
+	TEST_ASSERT(sync_regs->pft == KVM_S390_PFAULT_TOKEN_INVALID,
+			"pft == 0xff.....  (sync_regs)");
 	assert_noirq();
 }
 
@@ -137,7 +169,7 @@ static void test_normal(void)
 	/* Create VM */
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
-	regs = &run->s.regs;
+	sync_regs = &run->s.regs;
 
 	vcpu_run(vm, VCPU_ID);
 
@@ -153,7 +185,7 @@ static void test_initial(void)
 	printf("Testing initial reset\n");
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
-	regs = &run->s.regs;
+	sync_regs = &run->s.regs;
 
 	vcpu_run(vm, VCPU_ID);
 
@@ -170,7 +202,7 @@ static void test_clear(void)
 	printf("Testing clear reset\n");
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
-	regs = &run->s.regs;
+	sync_regs = &run->s.regs;
 
 	vcpu_run(vm, VCPU_ID);
 
-- 
2.25.0
