Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DC35959;
	Mon, 23 Mar 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280215; cv=none; b=l9RLTD098o9d6vBSRWYtO0tHldN1qR2wpbzh00Q0f2XdBRrRUTRq0FhasTlQFvZnjTzjOvmhcaTT+g6kDna0xN94njjXT1vCP+DAUWFDgLcw99VjL2VwSdFg8F+BZr0NRF9bSRV1lw3t2sgfgtG9CyxlbAjdJT8ZcFMF7lNJGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280215; c=relaxed/simple;
	bh=u7+tnHGkFd0+tlV8MNrFPXszGKSSflEuxqCCAiiS6hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhUaPo6ew2r0OnY4M2KRar+TBDDYkAurxgipoBvkaD4kI2Lp82ko5BipPrgbwVnJLmFFPufFZU2sTP+/V0abwBHiExDaUZKdTDQaYk8q621ouh59EEdrupjf7fZOdOaZJaSg6RCsUpK/GSVkn7/ta5+qEmRx1g71aULJg5Oe6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mH8a4IyC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mH8a4IyC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NDOA0m044132;
	Mon, 23 Mar 2026 15:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5I7oq70nKWU6boSTI
	C+8NO1jEJj91n4vOHPyLT/koUY=; b=mH8a4IyCrcJ5oKMKWJceg5qQwmbyyNR1+
	rvpRFCpNg+nkNeHx5bdhslwa6gZABr2oCMTD+Gdm5tYiovGpn86YTQDIciD3Kegs
	XsNKJ8tWf5RWxpganyDiLXN4Z6ieNEMwS4OnRU/Sx+hnwWtI4rBt5ClM4r0UF2/5
	PFi3EfL0BFGgUHqzrtss5OI8i7hUwgWeV3YKAH9d/Sk70aQsvLypoFbwbN39Gxyj
	+VK/2W8Z+8rVcQtG+EyED30YkB8GmAFnN3sgrMQ/vzqkYwnnljx7KB8xZpRtCrYW
	R1GCb40GqKjONS07Q56e3QLYwtlaXoRhv+YuW57QOIbL154f+OV5g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9qhqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBwhdP005991;
	Mon, 23 Mar 2026 15:36:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ye184-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NFalGn47251874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:36:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB3342004B;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1CE920043;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: [PATCH 2/2] KVM: s390: selftests: Add load psw bear test
Date: Mon, 23 Mar 2026 15:35:23 +0000
Message-ID: <20260323153637.3683-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323153637.3683-1-frankja@linux.ibm.com>
References: <20260323153637.3683-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mO5ygo8Bwq2t_IWbkwoJK3hRkjrd2t0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfXxjzNaT3dL06O
 AS1mzr2bL4WKaJMsS/gnVTr9ItFBTnmdi/rW9D8dhI3d1lID1RTerqFHTCtFjtd+iPHW0nQshPB
 0z72/5AD0FNqRkc4DGkKjQ5zG6pchpeBpTp7lgEQTcZMPoHEdXrXeXw3ktnmqVW+bcZK9eP2btc
 VdJq9zRpBCXY7CLb/+Smx771H06rc/QK5K+IgPFKIyE8Eu/x0cJXYfPfHJfbAJ/uAvmBtthTYTe
 3imEq+ZYmXwd5Kc16AmgE6PPBt9XvsIEA9xXEl0nNlTu1gHnm2Ji45VNw/Ni+AtiGR32wYd8hm1
 gRgaLHnhlil0OYK2nWQNFdaSX6Ig5hNdvSMVYIEQ7ffnGD8A2rf1vtbJ7sIdLsfHl2wVuvmM2/T
 mL+kxIfCKXulDISRyuvfQs7mCkOmXinH+a57BZePBh7nBHPl44UeSEqjoqiaXy27TLo0btneAvy
 xB9z/1OcbG5AQ9jwJ5w==
X-Proofpoint-GUID: mO5ygo8Bwq2t_IWbkwoJK3hRkjrd2t0A
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c15e15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=bbBV95juPFatarpXuWAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118

The bear is set for lpsw and lpswe but not for lpswey.

Load PSW and all of its variants are only emulated by KVM if there's a
pending machine check. Therefore the tests inject those but never open
the masks to receive them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/s390/bear.c  | 184 +++++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/bear.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6471fa214a9f..9afb6479dbee 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -207,6 +207,7 @@ TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
+TEST_GEN_PROGS_s390 += s390/bear
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
diff --git a/tools/testing/selftests/kvm/s390/bear.c b/tools/testing/selftests/kvm/s390/bear.c
new file mode 100644
index 000000000000..fee4999532ae
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/bear.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LPSW(E|Y) bear tests.
+ * LPSW and LPSWE do set the bear but LPSWEY doesn't.
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include "ucall_common.h"
+#include "facility.h"
+
+static void guest_lpswey(void)
+{
+	extern void lpswey_dest_addr(void);
+	u64 psw[2] = {0x0400000180000000ULL, (uintptr_t)lpswey_dest_addr};
+	u64 bear;
+
+	asm volatile (
+		"	larl	%%r3,lpswey_addr\n"
+		"lpswey_addr:\n"
+		"	.insn	siy,0xeb0000000071,%[psw],0\n"
+		"       nop\n"
+		"       nop\n"
+		".globl lpswey_dest_addr \n"
+		"lpswey_dest_addr:\n"
+		"       .insn   s,0xb2010000,%[bear]\n"
+		"	lg	%%r4, %[bear]\n"
+		"       nop\n"
+		"       nop\n"
+		: [bear] "=Q" (bear)
+		: [psw] "T" (psw)
+		: "cc", "r3", "r4"
+		);
+}
+
+static void guest_lpswe(void)
+{
+	extern void lpswe_dest_addr(void);
+	u64 psw[2] = {0x0400000180000000ULL, (uintptr_t)lpswe_dest_addr};
+	u64 bear;
+
+	asm volatile (
+		"	larl	%%r3,lpswe_addr\n"
+		"lpswe_addr:\n"
+		"       lpswe    %[psw]\n"
+		"       nop\n"
+		"       nop\n"
+		".globl lpswe_dest_addr\n"
+		"lpswe_dest_addr:\n"
+		"       .insn   s,0xb2010000,%[bear]\n"
+		"	lg	%%r4, %[bear]\n"
+		"       nop\n"
+		"       nop\n"
+		: [bear] "=Q" (bear)
+		: [psw] "Q" (psw)
+		: "cc", "r3", "r4"
+		);
+}
+
+static void guest_lpsw(void)
+{
+	extern void lpsw_dest_addr(void);
+	u64 psw_short = (0x0400000180000000ULL | BIT(63 - 12) |
+			 (uintptr_t)lpsw_dest_addr);
+	u64 bear;
+
+	asm volatile (
+		"	larl	%%r3,lpsw_addr\n"
+		"lpsw_addr:\n"
+		"       lpsw    %[psw]\n"
+		"       nop\n"
+		"       nop\n"
+		".globl lpsw_dest_addr\n"
+		"lpsw_dest_addr:\n"
+		"       .insn   s,0xb2010000,%[bear]\n"
+		"	lg	%%r4, %[bear]\n"
+		"       nop\n"
+		"       nop\n"
+		: [bear] "=Q" (bear)
+		: [psw] "Q" (psw_short)
+		: "cc", "r3", "r4"
+		);
+}
+
+/* A machine check forces KVM to emulate PSW loading */
+static void inject_mcheck(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_irq irq = {};
+	int irqs;
+
+	irq.type = KVM_S390_MCHK;
+	/* External damage mcheck */
+	irq.u.mchk.cr14 = BIT(63 - 38);
+	irq.u.mchk.mcic = BIT(58);
+	irqs = __vcpu_ioctl(vcpu, KVM_S390_IRQ, &irq);
+	TEST_ASSERT(irqs >= 0, "Error injecting MCHECK errno %d", errno);
+}
+
+static void test_lpswey(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] != run->s.regs.gprs[4],
+			 "emulation: lpswey bear does not match\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] &&
+			 run->s.regs.gprs[3] != run->s.regs.gprs[4],
+			 "interpretation: lpswey bear does not match\n");
+	kvm_vm_free(vm);
+}
+
+static void test_lpswe(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpswe);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "emulation: lpswe bear matches\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] &&
+			 run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "interpretation: lpswe bear matches\n");
+	kvm_vm_free(vm);
+}
+
+static void test_lpsw(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "emulation: lpsw bear matches\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] &&
+			 run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "interpretation: lpsw bear matches\n");
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(test_facility(193));
+
+	ksft_print_header();
+	ksft_set_plan(6);
+	test_lpsw();
+	test_lpswe();
+	test_lpswey();
+	ksft_finished();
+}
-- 
2.51.0

