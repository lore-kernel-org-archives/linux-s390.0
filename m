Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309396;
	b=R3uP9bYL34SRj+jvsD3lbVzZIUCpc3f3p2+XLz4rhY8IvF3zPwlfaT0AkwmEvbFKdpnv
	 yO/3Bf5zKXGM2R0rwuUHBLWiQNkw5jRV8V9SMDVGdJnlOGIxLSe/iTL5Z0apl4ScQKisz
	 M5zbWLf6zaSyqkI8IpRGzhNznQWs/wHa/JY9/cGPiqfjfDVK+K5g+3wghhmz7bM2QxI4K
	 3cWdaJnLUHp/JQtwOZoVCncplrkUZi6gNP3tDxUbW5Ld4MClizIcDGKaLu3YMmjJyXhR3
	 bc7B1FaikXjAG0SuTcgxIagzRbnAcZaIbhimQBQ3q9JzSCbluIQ+tg+RKEHGMPzLOSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GeX2x+r3TY/Ghcw+2XqzP5GHtndUkNHMp/Q8fqa/sHY=;
	b=RnBQbyajJBPjPRjGcV2MnOBafEnOzE/rx8gU84R678xhXZZchayIUPSP2Cl4F0DqxqP3
	 KwE8g0eQ4DgWkFi4p1hVjU2K35/BvB4v3VGOuzKYjllr6hAiiABVmio9/aSNhVqZVnjPR
	 yeC/FH1lTIks+qVA0ushwqU9iS7fXxemKAIyHZjhrYHN5612ANrAhz/rFLGTo1fd0W1rs
	 uM4+vhsnACRKrwisSbpudez9g4VD9Spd3O45V0lZ26If9c+wjbrX+qAS0OECRjALBbCl6
	 Fm8kC6sqnkwSagvg+lfy2jvQdrqgul1KA1GnTmtKvd27RBKLyxj3g2E4+oolG6lX9vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gM2KrP1P;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB7606A326;
	Tue, 10 Nov 2026 11:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gM2KrP1P
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABELnj2376922;
	Tue, 10 Nov 2026 11:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GeX2x+r3TY/Ghcw+2
	XqzP5GHtndUkNHMp/Q8fqa/sHY=; b=gM2KrP1PPrgpnlquOCm0Jq8uTCXFFD6u4
	/P8KSga9x7kmXyTdHGG+i321w9VswrIUMY2ROWmjLC5zfFJgRWu6nIhwpj1IrCDG
	aP4jnGzBdEuelhIRJ1Fz5yg3ybHddvbaUJASIzyb3TIv8iUbzPoG3XAvbV0xaHGG
	TZCqNlIF/zXsyvWBIMJhbmoStv9dUTkmNXY2aEQ+2JSTYMav5cX8FuZ9qWtf9UqY
	BPIzGC/C5mE3r8Q77UM7Wdz1mBtqt9IVTYOxfDoYQSguZhDfJfDz6979cf7gSPax
	Tx8sidSqfI8Qmy0KBwx46Rat1dQoZd+TMXqdobWfgqnqL/sA+LoEg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug64jsh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7nw27331807;
	Tue, 10 Nov 2026 11:16:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg6179-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABFf9i3539604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:15:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4859458051;
	Tue, 10 Nov 2026 11:16:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B60505805C;
	Tue, 10 Nov 2026 11:16:30 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:30 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 1/6] KVM: s390: selftests: Add kvm_exit test for instruction intercepts
Date: Tue, 10 Nov 2026 06:16:14 -0500
Message-ID: <20261110111619.61760-2-aaronmbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UDQQd7iVEEfhc6upnxg4UmFh1y3U_uP2
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af2fd12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pU_1Nm1CSTO1vtOqAocA:9
X-Proofpoint-GUID: UDQQd7iVEEfhc6upnxg4UmFh1y3U_uP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX08gEf/pq/Ooq
 8Z15Sv06ddZ0CMwCVwN7qRGcxl5sjg6/SvwD2hRGX6EY/Pw694J6idqmOGhbjAAPthlZ/s1sG4w
 RhAYQ+vTCOgSQcUwIcjY8WBv1DopoUOXsf2xnuur5YOvUy9e3RExIn4a5D4nBnRx4d7286c96dx
 lD+4STNbFj8ZKNZA6dpfxnkN12WHrdGU/q/NlNLHjDf54K/Zk8xo8Tq8xGhAn9VtFDFpet8SHRg
 UbZlE5VTezbS2NM49IWObvSvpEbCAB3gnY0h1JQp/sz8ykuXLn7jxRsjGvtu4DAtVUxgpVp5n8v
 GLp+0vNbizcoftlMWW9QzIpAAwfNU2zM+p1mxEybt/SUjpiqisTgzezEOVBJ6c49nQtpAZ4pEWK
 oS9bFH2iDguShbXGSGdCopKjxn7ERFnH31zgijo6RSs20oaVAjXUcTUAju+Nr/FFAiKMpeY5jah
 uEslqDGGUZ4d/4HWU7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfXwzruwl26fCEf
 fQhltErsee8XXqlIh+R7Oag1Abr28X8vq3MJFwjViYJKbwrX/hHaS4vd9eRtNCN5NJfBHoqw6Sn
 HZEVBt1p+kvyqZWb6RZIzG7rnCmDYGE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add a selftest for the exits KVM reports to userspace on s390x, mainly
KVM_EXIT_S390_SIEIC. This patch adds the harness and the instruction
intercept tests:

- DIAG 0x500: inject an external call, check it is pending, resume, and
  compare the registers with those synced in kvm_run.
- DIAG 0x501: check the opcode and diagnose code in ipa and ipb.
- DIAG 0x501 with registers set beforehand: check they are intact.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/include/s390/kvm_lifecycle.h          |  35 +++
 tools/testing/selftests/kvm/s390/kvm_exit.c   | 212 ++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
 create mode 100644 tools/testing/selftests/kvm/s390/kvm_exit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..a46a75c90e66 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -232,6 +232,7 @@ TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
 TEST_GEN_PROGS_s390 += pre_fault_memory_test
 TEST_GEN_PROGS_s390 += s390/irq_injection
+TEST_GEN_PROGS_s390 += s390/kvm_exit
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
diff --git a/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
new file mode 100644
index 000000000000..7dec11a6e214
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definition of structs for KVM lifecycle tests.
+ *
+ * Copyright IBM Corp. 2026
+ *
+ * Authors:
+ *  Nitya Khamar (nkhamar@linux.ibm.com)
+ *  Aaron Malik Brown (aaronmbr@linux.ibm.com)
+ */
+#ifndef SELFTEST_KVM_LIFECYCLE_H
+#define SELFTEST_KVM_LIFECYCLE_H
+
+#include "kvm_util.h"
+#include <stdbool.h>
+
+struct kvm_lifecycle_testdef {
+	const char *name;
+	bool (*test)(void);
+};
+
+struct kvm_parameters {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	void *guest_code;
+	struct kvm_run *run;
+	unsigned int interrupt_type;
+	struct kvm_s390_irq *irq;
+	struct kvm_s390_irq_state *irq_state;
+	struct {
+		bool immediate_exit_condition;
+	} manual_parameters;
+};
+
+#endif /* SELFTEST_KVM_LIFECYCLE_H */
diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
new file mode 100644
index 000000000000..140358357c67
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for KVM Exits to userspace on s390x
+ *
+ * Copyright IBM Corp. 2026
+ *
+ * Authors:
+ *  Nitya Khamar <nkhamar@linux.ibm.com>
+ *  Aaron Malik Brown <aaronmbr@linux.ibm.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include <errno.h>
+#include "processor.h"
+#include "ucall_common.h"
+#include "sie.h"
+#include "kvm_lifecycle.h"
+
+#define NUM_GPRS 16
+#define DIAG_ASSEMBLY_CODE 0x501
+#define IPA_DIAG 0x83
+
+static struct kvm_parameters create_vm_kvm_exit(struct kvm_parameters parameters)
+{
+	parameters.vm = vm_create_with_one_vcpu(&parameters.vcpu,
+						parameters.guest_code);
+	return parameters;
+}
+
+static void cleanup_kvm(struct kvm_parameters *parameters)
+{
+	kvm_vm_free(parameters->vm);
+}
+
+static void compare_regs(struct kvm_regs *regs, struct kvm_sync_regs *sregs)
+{
+	int register_number;
+
+	for (register_number = 0; register_number < NUM_GPRS; register_number++)
+		TEST_ASSERT_EQ(regs->gprs[register_number], sregs->gprs[register_number]);
+}
+
+static void guestcode_instruction_intercept(void)
+{
+	asm volatile("diag 0,0, 0x500\n" :::);
+	GUEST_DONE();
+}
+
+static bool test_instruction_intercept(void)
+{
+	struct kvm_parameters param = {
+		.guest_code = guestcode_instruction_intercept,
+		.interrupt_type = KVM_S390_INT_EXTERNAL_CALL,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+	struct kvm_s390_irq_state irq_state = {};
+	struct kvm_s390_irq irq = {};
+	struct kvm_regs regs;
+	int interrupts;
+
+	ksft_print_msg("Testing Instruction Intercept Exit\n");
+	param = create_vm_kvm_exit(param);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	irq.type = param.interrupt_type;
+	irq.u.extcall.code = param.vcpu->id;
+	irq_state.len = sizeof(irq);
+	irq_state.buf = (unsigned long)&irq;
+	param.irq = &irq;
+	param.irq_state = &irq_state;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
+		    "Failed with Unexpected icptcode of 0x%x\n",
+		    param.run->s390_sieic.icptcode);
+	interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_SET_IRQ_STATE,
+				  param.irq_state);
+	TEST_ASSERT(interrupts >= 0, "Cannot Inject Interrupt (%d)", errno);
+	irq_state.buf = (unsigned long)&irq;
+	irq_state.len = sizeof(irq);
+	interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_GET_IRQ_STATE,
+				  &irq_state);
+	TEST_ASSERT(interrupts > 0,
+		    "Expected pending interrupt after injection, got %d", interrupts);
+	TEST_ASSERT_EQ(irq.type, KVM_S390_INT_EXTERNAL_CALL);
+	TEST_ASSERT_EQ(irq.u.extcall.code, param.vcpu->id);
+	vcpu_run(param.vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
+		    "Expected ICPT_INST from GUEST_DONE after inject, got 0x%x\n",
+		    param.run->s390_sieic.icptcode);
+	vcpu_regs_get(param.vcpu, &regs);
+	compare_regs(&regs, &param.run->s.regs);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void guestcode_diagnose_hypercall(void)
+{
+	asm volatile("diag 0,0, 0x501\n" :::);
+}
+
+static bool test_diagnose_code(void)
+{
+	struct kvm_parameters param = {
+		.guest_code = guestcode_diagnose_hypercall,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+	ksft_print_msg("Testing Diagnosis Hypercall Exit\n");
+	param = create_vm_kvm_exit(param);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
+		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
+		    param.run->exit_reason, param.run->s390_sieic.icptcode);
+	TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
+		    "Failed with Unexpected Opcode of %u\n",
+		    param.run->s390_sieic.ipa >> 8);
+	TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,
+		    "Failed with Unexpected Diagnose Code of %u\n",
+		    param.run->s390_sieic.ipb >> 16);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void guestcode_diagnose_conditional(void)
+{
+	asm volatile("lghi %%r3,0x3333\n"
+		"lghi %%r5, 0x555\n"
+		"lghi %%r6, 0x3333\n"
+		"cgrjne %%r6, %%r3, 1f\n"
+		"diag 0,0, 0x501\n"
+		"1:\n"
+		:
+		:
+		: "r3", "r5", "r6"
+	);
+	GUEST_DONE();
+}
+
+static bool test_diagnose_conditional_code(void)
+{
+	struct kvm_parameters param = {
+		.guest_code = guestcode_diagnose_conditional,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+	struct kvm_regs regs;
+
+	ksft_print_msg("Testing Diagnosis Hypercall for Conditional Code Exit\n");
+	param = create_vm_kvm_exit(param);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
+		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
+		    param.run->exit_reason, param.run->s390_sieic.icptcode);
+	TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
+		    "Failed with Unexpected Opcode of %u\n",
+		    param.run->s390_sieic.ipa >> 8);
+	TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,
+		    "Failed with Unexpected Diagnose Code of %u\n",
+		    param.run->s390_sieic.ipb >> 16);
+	vcpu_regs_get(param.vcpu, &regs);
+	TEST_ASSERT_EQ(regs.gprs[3], 0x3333);
+	TEST_ASSERT_EQ(regs.gprs[5], 0x555);
+	TEST_ASSERT_EQ(regs.gprs[6], 0x3333);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void test(void)
+{
+	int i;
+	struct kvm_lifecycle_testdef testlist[] = {
+		{
+			.name = "Testing Instruction Intercepts",
+			.test = test_instruction_intercept,
+		},
+		{
+			.name = "Testing DIAG Code",
+			.test = test_diagnose_code,
+		},
+		{
+			.name = "Testing Conditional DIAG Code",
+			.test = test_diagnose_conditional_code,
+		},
+	};
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	for (i = 0; i < ARRAY_SIZE(testlist); i++) {
+		if (testlist[i].test())
+			ksft_test_result_pass("%s\n", testlist[i].name);
+		else
+			ksft_test_result_skip("%s\n", testlist[i].name);
+	}
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
+	test();
+	ksft_finished();
+}
-- 
2.50.1 (Apple Git-155)

