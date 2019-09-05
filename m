Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732454AbfIEIkl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858bbku083148
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utwrv3jca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:37 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 2/8] KVM: selftests: Implement ucall() for s390x
Date: Thu,  5 Sep 2019 10:40:03 +0200
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
References: <20190905084009.26106-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

On s390x, we can neither exit via PIO nor MMIO, but have to use an
instruction like DIAGNOSE. Now that ucall() is implemented, we can
use it in the sync_reg_test on s390x, too.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20190731151525.17156-3-thuth@redhat.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c | 56 +++++++++++++++++++
 .../selftests/kvm/s390x/sync_regs_test.c      |  6 +-
 3 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a51e3b83df40..75ea1ecbf85a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -10,7 +10,7 @@ UNAME_M := $(shell uname -m)
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/ucall.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
-LIBKVM_s390x = lib/s390x/processor.c
+LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
new file mode 100644
index 000000000000..fd589dc9bfab
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to userspace".
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ */
+#include "kvm_util.h"
+
+void ucall_init(struct kvm_vm *vm, void *arg)
+{
+}
+
+void ucall_uninit(struct kvm_vm *vm)
+{
+}
+
+void ucall(uint64_t cmd, int nargs, ...)
+{
+	struct ucall uc = {
+		.cmd = cmd,
+	};
+	va_list va;
+	int i;
+
+	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+
+	va_start(va, nargs);
+	for (i = 0; i < nargs; ++i)
+		uc.args[i] = va_arg(va, uint64_t);
+	va_end(va);
+
+	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
+	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
+}
+
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+{
+	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct ucall ucall = {};
+
+	if (run->exit_reason == KVM_EXIT_S390_SIEIC &&
+	    run->s390_sieic.icptcode == 4 &&
+	    (run->s390_sieic.ipa >> 8) == 0x83 &&    /* 0x83 means DIAGNOSE */
+	    (run->s390_sieic.ipb >> 16) == 0x501) {
+		int reg = run->s390_sieic.ipa & 0xf;
+
+		memcpy(&ucall, addr_gva2hva(vm, run->s.regs.gprs[reg]),
+		       sizeof(ucall));
+
+		vcpu_run_complete_io(vm, vcpu_id);
+		if (uc)
+			memcpy(uc, &ucall, sizeof(ucall));
+	}
+
+	return ucall.cmd;
+}
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index e85ff0d69548..bbc93094519b 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -25,9 +25,11 @@
 
 static void guest_code(void)
 {
+	register u64 stage asm("11") = 0;
+
 	for (;;) {
-		asm volatile ("diag 0,0,0x501");
-		asm volatile ("ahi 11,1");
+		GUEST_SYNC(0);
+		asm volatile ("ahi %0,1" : : "r"(stage));
 	}
 }
 
-- 
2.20.1
