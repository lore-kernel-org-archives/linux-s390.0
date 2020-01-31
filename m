Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729242AbgAaPEF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:04:05 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF1CIL114656
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:04:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvf34ny0j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:04:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:03:55 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/7] selftests: KVM: testing the local IRQs resets
Date: Fri, 31 Jan 2020 16:03:48 +0100
In-Reply-To: <20200131150348.73360-1-borntraeger@de.ibm.com>
References: <20200131150348.73360-1-borntraeger@de.ibm.com>
Message-Id: <20200131150348.73360-8-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Pierre Morel <pmorel@linux.ibm.com>

Local IRQs are reset by a normal cpu reset.  The initial cpu reset and
the clear cpu reset, as superset of the normal reset, both clear the
IRQs too.

Let's inject an interrupt to a vCPU before calling a reset and see if
it is gone after the reset.

We choose to inject only an emergency interrupt at this point and can
extend the test to other types of IRQs later.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[minor fixups]
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20200131100205.74720-7-frankja@linux.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index fb8e976943a9..1485bc6c8999 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -14,6 +14,9 @@
 #include "kvm_util.h"
 
 #define VCPU_ID 3
+#define LOCAL_IRQS 32
+
+struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
 
 struct kvm_vm *vm;
 struct kvm_run *run;
@@ -53,6 +56,23 @@ static void test_one_reg(uint64_t id, uint64_t value)
 	TEST_ASSERT(eval_reg == value, "value == %s", value);
 }
 
+static void assert_noirq(void)
+{
+	struct kvm_s390_irq_state irq_state;
+	int irqs;
+
+	irq_state.len = sizeof(buf);
+	irq_state.buf = (unsigned long)buf;
+	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
+	/*
+	 * irqs contains the number of retrieved interrupts. Any interrupt
+	 * (notably, the emergency call interrupt we have injected) should
+	 * be cleared by the resets, so this should be 0.
+	 */
+	TEST_ASSERT(irqs >= 0, "Could not fetch IRQs: errno %d\n", errno);
+	TEST_ASSERT(!irqs, "IRQ pending");
+}
+
 static void assert_clear(void)
 {
 	struct kvm_sregs sregs;
@@ -94,6 +114,22 @@ static void assert_initial(void)
 static void assert_normal(void)
 {
 	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
+	assert_noirq();
+}
+
+static void inject_irq(int cpu_id)
+{
+	struct kvm_s390_irq_state irq_state;
+	struct kvm_s390_irq *irq = &buf[0];
+	int irqs;
+
+	/* Inject IRQ */
+	irq_state.len = sizeof(struct kvm_s390_irq);
+	irq_state.buf = (unsigned long)buf;
+	irq->type = KVM_S390_INT_EMERGENCY;
+	irq->u.emerg.code = cpu_id;
+	irqs = _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
+	TEST_ASSERT(irqs >= 0, "Error injecting EMERGENCY IRQ errno %d\n", errno);
 }
 
 static void test_normal(void)
@@ -106,6 +142,8 @@ static void test_normal(void)
 
 	vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
 	assert_normal();
 	kvm_vm_free(vm);
@@ -120,6 +158,8 @@ static void test_initial(void)
 
 	vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
 	assert_normal();
 	assert_initial();
@@ -135,6 +175,8 @@ static void test_clear(void)
 
 	vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
 	assert_normal();
 	assert_initial();
-- 
2.21.0
