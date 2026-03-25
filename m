Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7C3D9DB9;
	Wed, 25 Mar 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444803; cv=none; b=lpfoVnrc0tD+t0x2ceq4gT578Iv8oR/DzM0Fi+tbdq2KiNX0Lbs6CKBVqWbUZGHH+BVAQX48BdCphOWHFgQEziCXxQmWSgrjEAuJmVXzGrBs6/xILQatXdBccnP9XG5neuR5nJim2E2eLwBO0S88BMLRGGshz9tdYsDQYENTrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444803; c=relaxed/simple;
	bh=BWF4VwA4IjDF6Zw3KsLD+Rst9sNOwYuO8UTEGumvBOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqsRphNMw8Imqw6doiS7tidcKQsuysYneRILp87hRnzOi6qAYrHoWXZ0A11U3lZ3DFGG9eJFeDJIDQIubDUHIXkgnaIQlk+r9m69kvCOn5lO5lvAodtm0qZgb/C1EbyXAKuti06+VLU+GDhE3N6B/09PuLPdGArfcTaf7Tr4F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZskmQxE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZskmQxE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P6nBVC3681168;
	Wed, 25 Mar 2026 13:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J9TeZvWt2dmeGxqBM
	cmFfNrJGOtYj+YiLrs1gBwKg/0=; b=DZskmQxEaUH/czApxED7V0NNpq/t1EcH+
	NGwARbCc76NzHr7L7mSp85X7hLDiRoO6McnBkyBVTm7RzPngppr9ijMsA38O0SMo
	Mt7QzvFsHWsUdRX7jYprQJIgie3OOrdNse2RJYhgEWlXgki502BivV4i0O2Xoc1O
	y2TxK7eWxcD65hKeK+ooETkO+B4Uow7sQCOQId0ThcmF/0nBgdzX/YtujjWd84+4
	bhqujNP0n2gF9IH3ktqlSeYBEZmbUkm4y3OtYI+VKTyLir8ppEhVKqP6kNCnMtes
	uRtze2EqBnlCJkDjry1AG9NMGq6A9T916FhgbNTeA27TX2h5LDpyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa0jhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:19:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PA5CqQ031598;
	Wed, 25 Mar 2026 13:19:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsxshn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:19:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PDJr6250201074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 13:19:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9801E2004D;
	Wed, 25 Mar 2026 13:19:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D7422004B;
	Wed, 25 Mar 2026 13:19:53 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 13:19:53 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: [PATCH v2] KVM: s390: selftests: Add load psw bear test
Date: Wed, 25 Mar 2026 13:19:09 +0000
Message-ID: <20260325131945.29038-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323153637.3683-3-frankja@linux.ibm.com>
References: <20260323153637.3683-3-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YHGmGDWXvG55PY97aBzrzhbA49j8t1Jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5NSBTYWx0ZWRfXxwNoiRqBMBS6
 wDYGfItkv6MSV7qExznoT6160QqJqLW/PXJPY1pZ91xoGZMk/bv/eyzvMhFyOthAcuaeFiSxE60
 gu9oUZ0cYJ9VQI15lvd6dpmtgeoEoNdCt2S/dpUA2Cb6sYhE1agr1axt3P2T2TD+nYsJXSihC8/
 y/uuDtQEmIPKBTT9O1PBo4qARwQhhg7z2rxFNxWQLu0zbpeOAX4MtVfEyVWD/7t8lKdckedubLP
 nctqFaqop9vXJlivmax4BrvdZScuj2qj1f8n1tw0y5w+Fkel+4DTKx0FAGLy3kOJmeoH/JcnjRU
 fyQw/2azWHL4Hr3NTlakaDj02bjWhcazrlYygiiVeaM4d9AOZwSeMoQZ7swCsJTUMpPcrucBNXK
 iKUvrAGi+oteWugP527rgMEPHuKEWdjYdyveDzMiPc2kQ1GU6xFeZXjUsaVKvmQggsXeezf1DZf
 xIJvAOz8Vl4GR33Xemg==
X-Proofpoint-GUID: YHGmGDWXvG55PY97aBzrzhbA49j8t1Jd
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3e0fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CKcPlAwmQQKpteUkSnwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250095

The bear is set for lpsw and lpswe, so let's check that also happens
when kvm emulates these instructions.

Load PSW and all of its variants are only emulated by KVM if there's a
pending machine check. Therefore the tests inject those but never open
the masks to receive them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/s390/bear.c  | 133 +++++++++++++++++++++++
 2 files changed, 134 insertions(+)
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
index 000000000000..c7604176cf65
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/bear.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* LPSW/E bear tests. */
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
+#include "processor.h"
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
+	ksft_set_plan(4);
+	test_lpsw();
+	test_lpswe();
+	ksft_finished();
+}
-- 
2.51.0

