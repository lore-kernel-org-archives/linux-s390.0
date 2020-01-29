Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgA2UDg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Jan 2020 15:03:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TJrkxU132335
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xuagn5g2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 29 Jan 2020 20:03:32 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
Date: Wed, 29 Jan 2020 15:03:12 -0500
In-Reply-To: <20200129200312.3200-1-frankja@linux.ibm.com>
References: <20200129200312.3200-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200129200312.3200-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

Local IRQs are reset by a normal cpu reset.  The initial cpu reset and
the clear cpu reset, as superset of the normal reset, both clear the
IRQs too.

Let's inject an interrupt to a vCPU before calling a reset and see if
it is gone after the reset.

We choose to inject only an emergency interrupt at this point and can
extend the test to other types of IRQs later.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index 2b2378cc9e80..299c1686f98c 100644
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
@@ -52,6 +55,29 @@ static void test_one_reg(uint64_t id, uint64_t value)
 	TEST_ASSERT(eval_reg == value, "value == %s", value);
 }
 
+static void assert_noirq(void)
+{
+	struct kvm_s390_irq_state irq_state;
+	int irqs;
+
+	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
+	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
+		return;
+
+	irq_state.len = sizeof(buf);
+	irq_state.buf = (unsigned long)buf;
+	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
+	/*
+	 * irqs contains the number of retrieved interrupts, apart from the
+	 * emergency call that should be cleared by the resets, there should be
+	 * none.
+	 */
+	if (irqs < 0)
+		printf("Error by getting IRQ: errno %d\n", errno);
+
+	TEST_ASSERT(!irqs, "IRQ pending");
+}
+
 static void assert_clear(void)
 {
 	struct kvm_sregs sregs;
@@ -93,6 +119,31 @@ static void assert_initial(void)
 static void assert_normal(void)
 {
 	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
+	assert_noirq();
+}
+
+static int inject_irq(int cpu_id)
+{
+	struct kvm_s390_irq_state irq_state;
+	struct kvm_s390_irq *irq = &buf[0];
+	int irqs;
+
+	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
+	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
+		return 0;
+
+	/* Inject IRQ */
+	irq_state.len = sizeof(struct kvm_s390_irq);
+	irq_state.buf = (unsigned long)buf;
+	irq->type = KVM_S390_INT_EMERGENCY;
+	irq->u.emerg.code = cpu_id;
+	irqs = _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
+	if (irqs < 0) {
+		printf("Error by injecting INT_EMERGENCY: errno %d\n", errno);
+		return errno;
+	}
+
+	return 0;
 }
 
 static void test_normal(void)
@@ -105,6 +156,8 @@ static void test_normal(void)
 
 	_vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
 	assert_normal();
 	kvm_vm_free(vm);
@@ -122,6 +175,8 @@ static int test_initial(void)
 
 	rv = _vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
 	assert_normal();
 	assert_initial();
@@ -141,6 +196,8 @@ static int test_clear(void)
 
 	rv = _vcpu_run(vm, VCPU_ID);
 
+	inject_irq(VCPU_ID);
+
 	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
 	assert_normal();
 	assert_initial();
-- 
2.20.1
