Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18E3FE646;
	Fri, 29 May 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070199; cv=none; b=LhzSod373i9v0gEjmQqluNM+GfhXBUL+R4iu5MSy6kUgk/bLGC2wa6CtaA/uHCradtKQLq2NuIiUqdf9a6aOPiI1r6pNh+TiswmAzuNP1juXqXsVXQ3yi+7pYZ27Ft94JumvaSV8Ny28HmxlUA0SGCaarIf8blrF4mWXEekwkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070199; c=relaxed/simple;
	bh=k6jpwAJD+GpMgdTOpupivcl9kr5vuQkQIUNZMLe2ItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BywSlO6PrMiDQUmGoMIHYXpbn7Mz2fufpe8WfR5M3q8go5PdN+K7orAsdIANqgSZ+c/VhqdY9ciz+qg468F2Rvuv3gZw58kJd7ko6U4dvFXJMTYA+rqrYpLo19VlSGLIv7nv5yyghvrdyS8GL4bmGHpejhP5vbZUifJH6PELGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K27KKNdr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K27KKNdr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFDGnm1684869;
	Fri, 29 May 2026 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3Vy2znU6BE4rmaBvm
	7MA/uVOlXjosiNrrWucqsFdf9c=; b=K27KKNdreoIEGHSTowUgvDrVoDEGlaaIk
	KKFeC2moTvrOwELxIq/fCLEUTqNwIR16vBd9KFN/EzVI7jFCQaSKMAY5ltCsQ8AW
	TupsHjs5vd3uBLKmMLAgnQe4AW+vRx7ArNUNcJImG8/Z3u3FMxMUpt2Sf/gx/tB0
	slS9HntHuPN4IiRdzo+7gzKVAidoszJZ0LPI/uVRQHnvLlsZ839eauE6/DlbIIOp
	dbQtQziRMKjIvsFg/Q+U0Fdmzv88/ubR4+eWJBqAfQ4n7d/vaOJIeAMfXBCbvoM+
	8VJPdG3bJlp48Tf4d4FK5SSc7CMwhbrBwpyzR3NRtg5Ivn9Q6BDww==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5Ej016940;
	Fri, 29 May 2026 15:56:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgjr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu9ss47120700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C734620040;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A7352004E;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 20/26] KVM: arm64: Share ID reg handling
Date: Fri, 29 May 2026 17:55:53 +0200
Message-ID: <20260529155601.2927240-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b722 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=zX106nZOjTGFKEJQ2UEA:9
X-Proofpoint-ORIG-GUID: ZzHTE0AERXso7IIrM-FN81R4I5MxuTO1
X-Proofpoint-GUID: ZzHTE0AERXso7IIrM-FN81R4I5MxuTO1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX2vj6YkRj7S/C
 /fxSSkbOGVA5zBBSZdvjrlGMcnXyGE4kTca+RTxJLMmJsXkDHQFXBNywofBFuGNuvi3ZISjzWco
 1HUwkMl1+js7fUQItP6Kp7bfj9rm84EQgt4+imjAEFLqtMfPgRnDtFdqq7yHFvUzZVzqAdAtSN0
 aaCiARNmGFqHoFqzaiZBVQ4O2DFXi0XBCKg4ffzO3IRJr1yz8sYlIjaYcdBJ6RBPj+QyeV8iVZ3
 SuhMcQLOkESCjOntKD5rZfHaZ9Wru02+ElmA7bGNb1ff2fwoIQzJR5NFE2mC1WPLroKkU00BJZg
 sB3vf8JpvAi8ZopBrJW1QQ9QEURxjgAlUvkNESpoiXGBGrVHwCejNHCEaOAXQuW6HA/Fq2yEa2I
 lmwlAq3XYm6a3CGhR9ZWSZ+r4TdSyRtZp4Nk/wVNja0D8sQCXf44s4CuqtHpmgaZr6Z8j9e/gFh
 EiE/w34gfmchWc+mn7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Move ID register definitions from arch/arm64/include to a shared
location (include/kvm/arm64) to enable reuse by e.g. s390 for KVM/arm64
on s390 support.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h | 41 ------------------------------
 include/kvm/arm64/kvm_host.h      | 42 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5734e93cad57..a5fca468cc4a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1385,47 +1385,6 @@ static inline void kvm_hyp_reserve(void) { }
 void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-struct kvm_vm_id_regs {
-	/*
-	 * Emulated CPU ID registers per VM
-	 * (Op0, Op1, CRn, CRm, Op2) of the ID registers to be saved in it
-	 * is (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8.
-	 *
-	 * These emulated idregs are VM-wide, but accessed from the context of a vCPU.
-	 * Atomic access to multiple idregs are guarded by kvm_arch.config_lock.
-	 */
-#define IDREG_IDX(id)		(((sys_reg_CRm(id) - 1) << 3) | sys_reg_Op2(id))
-#define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
-	u64 normal[KVM_ARM_ID_REG_NUM];
-
-	u64 midr_el1;
-	u64 revidr_el1;
-	u64 aidr_el1;
-	u64 ctr_el0;
-};
-
-static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
-{
-	switch (reg) {
-	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
-		return &id_regs->normal[IDREG_IDX(reg)];
-	case SYS_CTR_EL0:
-		return &id_regs->ctr_el0;
-	case SYS_MIDR_EL1:
-		return &id_regs->midr_el1;
-	case SYS_REVIDR_EL1:
-		return &id_regs->revidr_el1;
-	case SYS_AIDR_EL1:
-		return &id_regs->aidr_el1;
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-}
-
-#define kvm_read_vm_id_reg(kvm, reg)					\
-	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
-
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
 static inline bool kvm_arch_has_irq_bypass(void)
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index 8bf399508757..379942225d5f 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -4,6 +4,7 @@
 #define __KVM_ARM64_KVM_HOST_H
 
 #include <linux/types.h>
+#include <asm/sysreg-defs.h>
 
 #define KVM_VCPU_MAX_FEATURES 9
 
@@ -21,6 +22,47 @@
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
 
+struct kvm_vm_id_regs {
+	/*
+	 * Emulated CPU ID registers per VM
+	 * (Op0, Op1, CRn, CRm, Op2) of the ID registers to be saved in it
+	 * is (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8.
+	 *
+	 * These emulated idregs are VM-wide, but accessed from the context of a vCPU.
+	 * Atomic access to multiple idregs are guarded by kvm_arch.config_lock.
+	 */
+#define IDREG_IDX(id)		(((sys_reg_CRm(id) - 1) << 3) | sys_reg_Op2(id))
+#define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
+	u64 normal[KVM_ARM_ID_REG_NUM];
+
+	u64 midr_el1;
+	u64 revidr_el1;
+	u64 aidr_el1;
+	u64 ctr_el0;
+};
+
+static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
+{
+	switch (reg) {
+	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
+		return &id_regs->normal[IDREG_IDX(reg)];
+	case SYS_CTR_EL0:
+		return &id_regs->ctr_el0;
+	case SYS_MIDR_EL1:
+		return &id_regs->midr_el1;
+	case SYS_REVIDR_EL1:
+		return &id_regs->revidr_el1;
+	case SYS_AIDR_EL1:
+		return &id_regs->aidr_el1;
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+}
+
+#define kvm_read_vm_id_reg(kvm, reg)					\
+	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
+
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
-- 
2.53.0

