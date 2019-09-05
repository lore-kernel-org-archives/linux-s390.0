Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731660AbfIEIkm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858bZf1088761
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utxpyruwm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:40 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:39 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 6/8] KVM: selftests: Add a test for the KVM_S390_MEM_OP ioctl
Date: Thu,  5 Sep 2019 10:40:07 +0200
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
References: <20190905084009.26106-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-7-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

Check that we can write and read the guest memory with this s390x
ioctl, and that some error cases are handled correctly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lkml.kernel.org/r/20190829130732.580-1-thuth@redhat.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/Makefile      |   1 +
 tools/testing/selftests/kvm/s390x/memop.c | 166 ++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/memop.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1b48a94b4350..62c591f87dab 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,6 +32,7 @@ TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
+TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
new file mode 100644
index 000000000000..9edaa9a134ce
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test for s390x KVM_S390_MEM_OP
+ *
+ * Copyright (C) 2019, Red Hat, Inc.
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
+#define VCPU_ID 1
+
+static uint8_t mem1[65536];
+static uint8_t mem2[65536];
+
+static void guest_code(void)
+{
+	int i;
+
+	for (;;) {
+		for (i = 0; i < sizeof(mem2); i++)
+			mem2[i] = mem1[i];
+		GUEST_SYNC(0);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_s390_mem_op ksmo;
+	int rv, i, maxsize;
+
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+
+	maxsize = kvm_check_cap(KVM_CAP_S390_MEM_OP);
+	if (!maxsize) {
+		fprintf(stderr, "CAP_S390_MEM_OP not supported -> skip test\n");
+		exit(KSFT_SKIP);
+	}
+	if (maxsize > sizeof(mem1))
+		maxsize = sizeof(mem1);
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	run = vcpu_state(vm, VCPU_ID);
+
+	for (i = 0; i < sizeof(mem1); i++)
+		mem1[i] = i * i + i;
+
+	/* Set the first array */
+	ksmo.gaddr = addr_gva2gpa(vm, (uintptr_t)mem1);
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+
+	/* Let the guest code copy the first array to the second */
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Unexpected exit reason: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	memset(mem2, 0xaa, sizeof(mem2));
+
+	/* Get the second array */
+	ksmo.gaddr = (uintptr_t)mem2;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
+	ksmo.buf = (uintptr_t)mem2;
+	ksmo.ar = 0;
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+
+	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
+		    "Memory contents do not match!");
+
+	/* Check error conditions - first bad size: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = -1;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
+
+	/* Zero size: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = 0;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
+		    "ioctl allows 0 as size");
+
+	/* Bad flags: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = -1;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
+
+	/* Bad operation: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = -1;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
+
+	/* Bad guest address: */
+	ksmo.gaddr = ~0xfffUL;
+	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
+
+	/* Bad host address: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = 0;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EFAULT,
+		    "ioctl does not report bad host memory address");
+
+	/* Bad access register: */
+	run->psw_mask &= ~(3UL << (63 - 17));
+	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 17;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
+	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.20.1
