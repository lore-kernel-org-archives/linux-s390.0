Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7624F93D8;
	Fri, 18 Sep 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738327; cv=none; b=citoiTar9jJe5vlElBR4n4936ksWv80e8uO5tAMkQZnZ+NkubhkvAVuqc7XtElZ5cuwnrs6u3ivnc8/f6RJIlaZ7bQ1P8pqR6enr5F1zOEEizUo12+k71EvCIZdfdfM1onSbhG1sH0n9JMntaxZwbiP6FGmtu9F9amVjw9UF2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738327; c=relaxed/simple;
	bh=7Cd/fFREaMB8379rYlVP3WMtKJL+r2XoUjKHJBkVZ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slvb/BHSmtOrs/Fnoagfo7ygAJ4v+GHnJTOXipxbxm5JLOkN/A9zvblE0TBci5Vb9Fj8jJPWm4VKK3nHFI7ywdTSlXj1/2HK8xtdnYdHnYZiBBeRoVxsevCjJi4kh2cbAz9YxOlA+e8ivpw6WgpDcPhDgIz8zxPueiBUUxqh988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pdQXN12d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pdQXN12d"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1eGB3979474;
	Fri, 18 Sep 2026 13:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Kq4FY8QEDk1BLA1w
	cKf1js43+qFWt5S2y+8get5iaY=; b=pdQXN12dx8LQJWGWwVofN+K+fRKSW7a/R
	Jjox1sUdvFoug4dhe9k1Ow8p2RYjr368VfDxRyEbBI1mMqpdPtXGHM+/W6s+uUj3
	91hWkukaQPLIxzTNS9LIqQH+pBN6nU0HW0PRk3Wx1JWyDrXxIHkDxpoVvaUxSWyI
	8c5h7YEXe852aa/HiCAjSHZ+DTVSdWMhJVnbgahO5hX3Ao+bbRfvto2nJOxK4YsV
	OOEiyC1gpV5ftA4LM7d3rCDHFjlZkdAE7dLdQ/ONpQSWLKTtiD0+hUB44HbkjV/Q
	BiStOr/11ZaG5CVfepb+TfKJcMnc/5F32fY1Rp+7sOrjsU+x6vJEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eftsr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNxAe695613;
	Fri, 18 Sep 2026 13:31:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fek7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVDO543123018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C7E20040;
	Fri, 18 Sep 2026 13:31:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0BFE2004B;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
Subject: [PATCH v8 14/29] KVM: arm64: Use accessor functions for core regs
Date: Fri, 18 Sep 2026 15:30:51 +0200
Message-ID: <20260918133107.1042730-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfXxnSVzOquEoRT
 Ge43JShlD0pjtnWWebUghNqP9gI3ITcEhuekJvArIv5S1ZwuRgbTnctrJLA2olnTVViNt6aGVaW
 32tSWtdnChEvMi4sXJh+cbHrs2XfhWEYyx/J+2gs2jYE71dtbvrE5QFCpa/+gS+kgkzjXcQ10a0
 Mi64ROvd+RR/XnpMkmu15Iu+bl8aZRoJBZxARvyEjhznjZMC8RLmfNFwgx2hqjFTLsNFS26I0kF
 kcRwreLQ3pdUKmfFeBf6Kt2pxm9/MG0e08iYn988Unqp0AgCNGCtmLAJn+6VCHrpC5VtGLu5kNu
 E6i470YV3qAPueFAfHbpIwb7aFETtqdkWA/WH37LLAgVfrGsoBKaay8rvGjCQTXqvLSq6rCe5wT
 FzoVhXl3kPxl4PmMnqC+GHdrDx7nahAdqORBcKj3OP+JEADf6jPZrZcXJ8N9KdF0sEZLM1C2c/i
 pmdT6lt0S0dyEIZ4Dgw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad3d2a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=5d8JqmD_1xC0DvqtPZgA:9
X-Proofpoint-ORIG-GUID: qcCBgPh0KK7EETcpVsndmPWRjc1yAd5c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX5Vtcu3rwuL/T
 56miinYwUq6J9X1g/b7W7JPeFyVgJmrBwdRvjeK9uPvC6B7FBsj2zPqNyvcijZepL9SlUuVBx9U
 /Jee2B1JI1rV8yhGbOtaNSNApC8DFfs=
X-Proofpoint-GUID: 1seeCj-Vufx83P-PhTYJVU21v1hkxc78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Instead of accessing the value directly use assessor function that
abstract the actual location of the register values. Add a helper
function to reset fpsimd registers. Enables other KVM implementations to
reuse this code.

No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 34 ++++++++++++++++++++++++++--
 arch/arm64/kvm/guest.c               | 14 ++++++------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 8603766c1b4d..b31d50bdf59e 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -141,6 +141,31 @@ static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
 	return (unsigned long *)&vcpu->arch.ctxt.regs.pstate;
 }
 
+static __always_inline unsigned long *vcpu_sp_el0(struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.ctxt.regs.sp;
+}
+
+static __always_inline u64 *vcpu_sp_el1(struct kvm_vcpu *vcpu)
+{
+	return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+}
+
+static __always_inline __u128 *vcpu_vreg(struct kvm_vcpu *vcpu, int n)
+{
+	return &vcpu->arch.ctxt.fp_regs.vregs[n];
+}
+
+static __always_inline __u32 *vcpu_fpsr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.ctxt.fp_regs.fpsr;
+}
+
+static __always_inline __u32 *vcpu_fpcr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.ctxt.fp_regs.fpcr;
+}
+
 static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 {
 	return !!(*vcpu_cpsr(vcpu) & PSR_MODE32_BIT);
@@ -737,6 +762,11 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline void kvm_reset_fpsimd(struct kvm_vcpu *vcpu)
+{
+	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
+}
+
 /* Reset a vcpu's core registers. */
 static inline void kvm_reset_vcpu_core(struct kvm_vcpu *vcpu)
 {
@@ -752,8 +782,8 @@ static inline void kvm_reset_vcpu_core(struct kvm_vcpu *vcpu)
 	/* Reset core registers */
 	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
 	*vcpu_pc(vcpu) = 0;
-	vcpu->arch.ctxt.regs.sp = 0;
-	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
+	*vcpu_sp_el0(vcpu) = 0;
+	kvm_reset_fpsimd(vcpu);
 	vcpu->arch.ctxt.spsr_abt = 0;
 	vcpu->arch.ctxt.spsr_und = 0;
 	vcpu->arch.ctxt.spsr_irq = 0;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 81d850d5a328..773f6c8e5026 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -137,16 +137,16 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return &vcpu_gp_regs(vcpu)[off];
 
 	case KVM_REG_ARM_CORE_REG(regs.sp):
-		return &vcpu->arch.ctxt.regs.sp;
+		return vcpu_sp_el0(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(regs.pc):
-		return &vcpu->arch.ctxt.regs.pc;
+		return vcpu_pc(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(regs.pstate):
-		return &vcpu->arch.ctxt.regs.pstate;
+		return vcpu_cpsr(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(sp_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+		return vcpu_sp_el1(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(elr_el1):
 		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
@@ -170,13 +170,13 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
 		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
 		off /= 4;
-		return &vcpu->arch.ctxt.fp_regs.vregs[off];
+		return vcpu_vreg(vcpu, off);
 
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-		return &vcpu->arch.ctxt.fp_regs.fpsr;
+		return vcpu_fpsr(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		return &vcpu->arch.ctxt.fp_regs.fpcr;
+		return vcpu_fpcr(vcpu);
 
 	default:
 		return NULL;
-- 
2.53.0

