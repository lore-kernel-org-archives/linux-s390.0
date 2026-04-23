Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692723537D0;
	Thu, 23 Apr 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947973; cv=none; b=P+952fAY87Qxd5ys59jJoaSEs4E8Hy2nwrttBnGQb9XsPNMPUQZ056Vo/UsWOxo24cPWYWuJA7S3/r8XT5YhcMlM9bO5BLNhG/0y+gjoW0tLmyCEQv9c0wqEWpxJIXUCQw81fowE+GaNaaOQG4WTsKXeOHlE1F8Yay1oS/zWiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947973; c=relaxed/simple;
	bh=zMaDvx9re5DyUPeNz6AzLKND7DHngkH5iHJ10hgUKOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZTMNi1gQcb+tAiRi4/5G9R01fhL+N34eZ1u7cq/ID7fh1HS9YaTciX+h2xKOtrcs9y80cZ7aNpmWazkgsM62443gNz2NeZ6BDEg7FcPFGWxTG6mZw9YLXPiMSwlsLu/mGqk99UbpKFdJit4o6/d2Arm/8XJOxRVwNhgzNjxfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DphtqLZQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DphtqLZQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7gm4s3228999;
	Thu, 23 Apr 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dnA9BqDM6C9y/sJJO
	/8uZ4IBN5ybvNEnu6pCIipvgwM=; b=DphtqLZQeLabXESPklEK20dXDctfV+C3e
	vyyqATyGh/F8Fke8T6y5Hdf6wvItz7aQm11agZCuQatzpz2nM47cK9uwC3A8lE0t
	zCKkh42FEStd4e9lmfWG/4C61eykCPOPTOk3yXAKSXQszZ21AQ6Yt95cPGw/yiW8
	gawu3F9gQIBn5huvaGv0EL4WUCstmyEo4YWv9pECP0O2+NmXQjXQiw5hgsSo/xOW
	niSbadN//2QeHKrUnT9HjOYyLWyiUt0cEoPRRLIzwE6ee7QhlelfpZjqTgpW3pz1
	NCumjXUUPaoS0GFJ9GLVTkKii2piGQt6tPf0elZZ+4v4EAhLIudkw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28m8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCZWEH019946;
	Thu, 23 Apr 2026 12:39:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6k5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCdKj745351302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:39:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D8952004E;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77BDA2004F;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH 1/3] KVM: s390: selftests: Add load psw bear test
Date: Thu, 23 Apr 2026 12:36:02 +0000
Message-ID: <20260423123902.14663-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423123902.14663-1-frankja@linux.ibm.com>
References: <20260423123902.14663-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: imo1G3qJLpoucFDa5tDbQoR1wzWKN2ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX7BMm1u3botEz
 DFFsbKRRMqYXEk/d6Q+Ue3RsbtFxrucSDnxs8hUZrnaKI+1RIiScX5LDEwR49bDla7QFJV7rLss
 u5jb9PU3VKXSsYYp6UQWrFab05YpyznEIcMUnzQHOo7sia7h6NyWhOu4kWFJNhiCq2ghAlyy/FX
 fcw3JROSlgdhKF4kUaLUe1jPKg25kn1Uw4Ktw7CKxk16xgrgfnacHC4L1hcoIlEEjz7W+e/JovW
 Q/AVr2LmL80RczSA4fdc05Z/YOICCrRhexeZ7BNDE5SUnauYmE+XrzSqMTaxfhW/8SgJWxALKb/
 qPjoXJj0YIpDmPBR+r7aDgs/RUVWeaz5oq3mzNlHBDvAdjRJLqrQGwgJfoHqtN8y/WYObXHAPHb
 l2Sv8eDNRoxpIRH/6npksovkTouboMwijpRhsOPcsnWPsGhXHG/q9PiUHaGTIljql7iXFDsXP1Y
 S1KLHrVmeCKu2CiWNMg==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea12fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=G4_ZmC8i095dR4b8HbIA:9
X-Proofpoint-ORIG-GUID: imo1G3qJLpoucFDa5tDbQoR1wzWKN2ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230122

The bear is set for lpsw and lpswe, so let's check that also happens
when kvm emulates these instructions.

Load PSW and all of its variants are only emulated by KVM if there's a
pending machine check. Therefore the tests inject those but never open
the masks to receive them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/s390/bear.c  | 250 +++++++++++++++++++++++
 2 files changed, 251 insertions(+)
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
index 000000000000..63032a789c8d
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/bear.c
@@ -0,0 +1,250 @@
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
+u64 psw_mask = 0x0400000180000000ULL;
+
+static void guest_lpswe_inv(void)
+{
+	extern void lpswe_dest_addr_inv(void);
+	u64 psw_inv[2] = {psw_mask | BIT(63), (uintptr_t)lpswe_dest_addr_inv};
+	u64 psw_pgm[2] = {psw_mask,  (uintptr_t)lpswe_dest_addr_inv};
+	u64 bear;
+
+	/*
+	 * Advanced shenanigans:
+	 * - Use real stores (sturg) to lowcore PGM new PSW since the
+	 *   lowcore isn't mapped in DAT
+	 * - After the exception store invalid address to PGM new so
+	 *   the test exits
+	 */
+	asm volatile (
+		"	larl	%%r3,lpswe_addr_inv\n"
+		"	lghi	%%r6, 464\n"
+		"	lg	%%r5, %[psw_pgm_m]\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r6, 472\n"
+		"	lg      %%r5, %[psw_pgm_a]\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r5, 0x80\n"
+		"	xgr	%%r6, %%r6\n"
+		"	sturg	%%r5, %%r6\n"
+		"lpswe_addr_inv:\n"
+		"       lpswe    %[psw_inv]\n"
+		"       nop\n"
+		"       nop\n"
+		".globl lpswe_dest_addr_inv\n"
+		"lpswe_dest_addr_inv:\n"
+		"       .insn   s,0xb2010000,%[bear]\n"
+		"	lg	%%r4, %[bear]\n"
+		"       lghi    %%r6, 472\n"
+		"	lghi	%%r5, 1\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r6, 0x8c\n"
+		"	lura	%%r5, %%r6\n"
+		: [bear] "=Q" (bear)
+		: [psw_inv] "Q" (psw_inv),
+		  [psw_pgm_m] "Q" (psw_pgm), [psw_pgm_a] "Q" (psw_pgm[1])
+		: "cc", "r3", "r4", "r5", "r6"
+		);
+}
+
+static void guest_lpswe(void)
+{
+	extern void lpswe_dest_addr(void);
+	u64 psw[2] = {psw_mask, (uintptr_t)lpswe_dest_addr};
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
+	u64 psw_short = (psw_mask | BIT(63 - 12) | (uintptr_t)lpsw_dest_addr);
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
+static void guest_lpsw_inv(void)
+{
+	extern void lpsw_dest_addr_inv(void);
+	u64 psw_short_inv = (psw_mask | BIT(63 - 12) | BIT(63) | (uintptr_t)lpsw_dest_addr_inv);
+	u64 psw_pgm[2] = {psw_mask,  (uintptr_t)lpsw_dest_addr_inv};
+	u64 bear;
+
+	/*
+	 * Advanced shenanigans:
+	 * - Use real stores (sturg) to lowcore PGM new PSW since the
+	 *   lowcore isn't mapped in DAT
+	 * - After the exception store invalid address to PGM new so
+	 *   the test exits
+	 */
+	asm volatile (
+		"	larl	%%r3,lpsw_addr_inv\n"
+		"	lghi	%%r6, 464\n"
+		"	lg	%%r5, %[psw_pgm_m]\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r6, 472\n"
+		"	lg      %%r5, %[psw_pgm_a]\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r5, 0x80\n"
+		"	xgr	%%r6, %%r6\n"
+		"	sturg	%%r5, %%r6\n"
+		"lpsw_addr_inv:\n"
+		"       lpsw    %[psw_inv]\n"
+		"       nop\n"
+		"       nop\n"
+		".globl lpsw_dest_addr_inv\n"
+		"lpsw_dest_addr_inv:\n"
+		"       .insn   s,0xb2010000,%[bear]\n"
+		"	lg	%%r4, %[bear]\n"
+		"       lghi    %%r6, 472\n"
+		"	lghi	%%r5, 1\n"
+		"	sturg	%%r5, %%r6\n"
+		"	lghi	%%r6, 0x8c\n"
+		"	lura	%%r5, %%r6\n"
+		: [bear] "=Q" (bear)
+		: [psw_inv] "Q" (psw_short_inv),
+		  [psw_pgm_m] "Q" (psw_pgm), [psw_pgm_a] "Q" (psw_pgm[1])
+		: "cc", "r3", "r4", "r5", "r6"
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
+	void *lc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpswe);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpswe: emulation: bear matches\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpswe_inv);
+	lc = addr_gpa2hva(vm, 0);
+	memset(lc, 0, PAGE_SIZE);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpswe: emulation: pgm: lpsw bear matches\n");
+	ksft_test_result(run->s.regs.gprs[5] == 6,
+			 "lpswe: emulation: pgm: ILC is 0\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] &&
+			 run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpswe: interpretation: lpswe bear matches\n");
+	kvm_vm_free(vm);
+}
+
+static void test_lpsw(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	void *lc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpsw: emulation: bear matches\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw_inv);
+	lc = addr_gpa2hva(vm, 0);
+	memset(lc, 0, PAGE_SIZE);
+	inject_mcheck(vcpu);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpsw: emulation: pgm: invalid: bear matches\n");
+	ksft_test_result(run->s.regs.gprs[5] == 6,
+			 "lpsw: emulation: pgm: ILC is 0\n");
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_lpsw);
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	ksft_test_result(run->s.regs.gprs[3] &&
+			 run->s.regs.gprs[3] == run->s.regs.gprs[4],
+			 "lpsw: interpretation: bear matches\n");
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(test_facility(193));
+
+	ksft_print_header();
+	ksft_set_plan(8);
+	test_lpsw();
+	test_lpswe();
+	ksft_finished();
+}
-- 
2.51.0

