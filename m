Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728362AbgAaKC0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 05:02:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00V9rwaa100654
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:25 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv7e2k2ss-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:25 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 31 Jan 2020 10:02:23 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v10 5/6] selftests: KVM: s390x: Add reset tests
Date: Fri, 31 Jan 2020 05:02:04 -0500
In-Reply-To: <20200131100205.74720-1-frankja@linux.ibm.com>
References: <20200131100205.74720-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131100205.74720-6-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Test if the registers end up having the correct values after a normal,
initial and clear reset.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 tools/testing/selftests/kvm/Makefile       |   1 +
 tools/testing/selftests/kvm/s390x/resets.c | 155 +++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/resets.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3138a916574a..fe1ea294730c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -36,6 +36,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
+TEST_GEN_PROGS_s390x += s390x/resets
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 
diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
new file mode 100644
index 000000000000..fb8e976943a9
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test for s390x CPU resets
+ *
+ * Copyright (C) 2020, IBM
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+#define VCPU_ID 3
+
+struct kvm_vm *vm;
+struct kvm_run *run;
+struct kvm_sync_regs *regs;
+static uint64_t regs_null[16];
+
+static uint64_t crs[16] = { 0x40000ULL,
+			    0x42000ULL,
+			    0, 0, 0, 0, 0,
+			    0x43000ULL,
+			    0, 0, 0, 0, 0,
+			    0x44000ULL,
+			    0, 0
+};
+
+static void guest_code_initial(void)
+{
+	/* Round toward 0 */
+	uint32_t fpc = 0x11;
+
+	/* Dirty registers */
+	asm volatile (
+		"	lctlg	0,15,%0\n"
+		"	sfpc	%1\n"
+		: : "Q" (crs), "d" (fpc));
+	GUEST_SYNC(0);
+}
+
+static void test_one_reg(uint64_t id, uint64_t value)
+{
+	struct kvm_one_reg reg;
+	uint64_t eval_reg;
+
+	reg.addr = (uintptr_t)&eval_reg;
+	reg.id = id;
+	vcpu_get_reg(vm, VCPU_ID, &reg);
+	TEST_ASSERT(eval_reg == value, "value == %s", value);
+}
+
+static void assert_clear(void)
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_fpu fpu;
+
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	TEST_ASSERT(!memcmp(&regs.gprs, regs_null, sizeof(regs.gprs)), "grs == 0");
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	TEST_ASSERT(!memcmp(&sregs.acrs, regs_null, sizeof(sregs.acrs)), "acrs == 0");
+
+	vcpu_fpu_get(vm, VCPU_ID, &fpu);
+	TEST_ASSERT(!memcmp(&fpu.fprs, regs_null, sizeof(fpu.fprs)), "fprs == 0");
+}
+
+static void assert_initial(void)
+{
+	struct kvm_sregs sregs;
+	struct kvm_fpu fpu;
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	TEST_ASSERT(sregs.crs[0] == 0xE0UL, "cr0 == 0xE0");
+	TEST_ASSERT(sregs.crs[14] == 0xC2000000UL, "cr14 == 0xC2000000");
+	TEST_ASSERT(!memcmp(&sregs.crs[1], regs_null, sizeof(sregs.crs[1]) * 12),
+		    "cr1-13 == 0");
+	TEST_ASSERT(sregs.crs[15] == 0, "cr15 == 0");
+
+	vcpu_fpu_get(vm, VCPU_ID, &fpu);
+	TEST_ASSERT(!fpu.fpc, "fpc == 0");
+
+	test_one_reg(KVM_REG_S390_GBEA, 1);
+	test_one_reg(KVM_REG_S390_PP, 0);
+	test_one_reg(KVM_REG_S390_TODPR, 0);
+	test_one_reg(KVM_REG_S390_CPU_TIMER, 0);
+	test_one_reg(KVM_REG_S390_CLOCK_COMP, 0);
+}
+
+static void assert_normal(void)
+{
+	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
+}
+
+static void test_normal(void)
+{
+	printf("Testing normal reset\n");
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
+	run = vcpu_state(vm, VCPU_ID);
+	regs = &run->s.regs;
+
+	vcpu_run(vm, VCPU_ID);
+
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
+	assert_normal();
+	kvm_vm_free(vm);
+}
+
+static void test_initial(void)
+{
+	printf("Testing initial reset\n");
+	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
+	run = vcpu_state(vm, VCPU_ID);
+	regs = &run->s.regs;
+
+	vcpu_run(vm, VCPU_ID);
+
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
+	assert_normal();
+	assert_initial();
+	kvm_vm_free(vm);
+}
+
+static void test_clear(void)
+{
+	printf("Testing clear reset\n");
+	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
+	run = vcpu_state(vm, VCPU_ID);
+	regs = &run->s.regs;
+
+	vcpu_run(vm, VCPU_ID);
+
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
+	assert_normal();
+	assert_initial();
+	assert_clear();
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+
+	test_initial();
+	if (kvm_check_cap(KVM_CAP_S390_VCPU_RESETS)) {
+		test_normal();
+		test_clear();
+	}
+	return 0;
+}
-- 
2.20.1
