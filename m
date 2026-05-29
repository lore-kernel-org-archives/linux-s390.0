Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F39400E16;
	Fri, 29 May 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070203; cv=none; b=nGY30a7eZVJIN7WcSp6gxFCYqTvppk1JNxSbzG5rS8nzR5yUcVji3xAjeKxgcV/xedefvaWQSGWknM3xl1wJFxP5M53SDEfc3V8VJ6Qk9vCFzY9dfjVq7pwp7/q1A40DQs6eyx6iRepYwlmp26gzCAgPlRAp87M+rlGVd6DKpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070203; c=relaxed/simple;
	bh=GrNLXw87enQ8YyFIlPyIRnw07HBNMRfIhPiPbWEOzLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7MgaEQXz+FZf6QPq8qJokmc1Y6MvHOf5fakKwXFueTKl1qDhThG0ABdPYW2ngulHIP3NW/99BbNYphsMfCxk7ijjxwPRsRlrdcwx4c3FuVfZdia6gx9XyMl8DeSvXpoqHo0Aolk5zSPoVv2jQ2YBfMzXRKnOPqgiqerXXCEf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Evhp8Xjg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Evhp8Xjg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFFon92418293;
	Fri, 29 May 2026 15:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dqKCCofcz0Zv74DPH
	irPfzI3TpUJzfAENQhUkMK1kvo=; b=Evhp8XjgdpMwTUdSePXiqx8k31I/ekiRG
	7mdbZwIjQAoQozZjlWvK4P7mSpYl8pBBUOmE5vDlUnpokXCPhghZV9M9H42BZldV
	3VVS/qa19kj7EgEIUWExZCx4G+X1IAyp6i76u791S0qx6F0SJTwEPwUDui3a04Xw
	/sNxOhUiu/CoIyny3AV7RV6Rv1UtJ+E0+OiYpZ1ZZVsi9IdK1rmm0PDayN5sVT5s
	R16Qq4+XS1YCBl5KkKt//dgKnX5R0PkIjnN0IMV8SAKqXIo6J9a44c5ucaXu0Gj+
	dSS+zaC9KAw37LHv9O56GImmqTAtFQ/cw5VlsgcAUTUD8cbAe2MrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884vkpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs8Dx027824;
	Fri, 29 May 2026 15:56:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8jmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu5VT42205508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A1920040;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AC132004D;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
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
Subject: [PATCH v1 09/26] KVM: arm64: Refactor idreg caching into dedicated structure
Date: Fri, 29 May 2026 17:55:42 +0200
Message-ID: <20260529155601.2927240-10-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b71e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ltnAkj20NlQT-AaSmW0A:9
X-Proofpoint-ORIG-GUID: v-ZUWhFCxXBMvxuhjxXM0qLXz25xPYX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX0iwO/qKPo8HI
 EsmFXXeoaO6BoC57iqvezPM1uhFuhPoC+50C6SIL4NgZnyFHBltBqcd3fhpS5L/vp5Rp+8CxlHE
 1zlUXAj6rb6gc7zmzaw/x9WSNNizz5GosWm7rGpKYxy1lywT5myMVBcE1JBOFsZKllYcy1GDa+y
 zAbl65QxnoAU/l1Ch/Pg8G6/5xm9yp8IxksBt/+dE1mRiIRytX0SYuZ3TPzsptyFGqOmjIkVlfE
 Bv8IIGogt2Vm7i0wBJAlcfCPPA8f0gjlbKPwM9KVdU08SgJDuqiXbdwrfLen06qI59A/6Eu82nD
 i6w/D6Vl8XzCAds5Yo316fqM4P1aw3J9/4Am5/u1jVRKcazRmVg0ZwNKkADg8rxeJsplFX5lY6h
 uoghT3iFZbj5PqYZtSDvtS9J0saERKDsw76IeE2N8VL3FRr5XRsQVmpdTspo/CZ/QpYmBt/tP6w
 ftoVeK6dxi6SWAMnUVA==
X-Proofpoint-GUID: v-ZUWhFCxXBMvxuhjxXM0qLXz25xPYX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Move VM-wide ID register emulation fields from struct kvm_arch into a
new struct kvm_vm_id_regs to prepare future sharing of these fields and
functions using them. Update all users to use the new structure. No
functional changes.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h  | 50 ++++++++++++++++--------------
 arch/arm64/kvm/config.c            |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c     |  7 +++--
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |  4 +--
 arch/arm64/kvm/sys_regs.c          |  2 +-
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4c2c62b8b506..a8efff6ea01d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -352,22 +352,7 @@ struct kvm_arch {
 	struct kvm_smccc_features smccc_feat;
 	struct maple_tree smccc_filter;
 
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
-	u64 id_regs[KVM_ARM_ID_REG_NUM];
-
-	u64 midr_el1;
-	u64 revidr_el1;
-	u64 aidr_el1;
-	u64 ctr_el0;
+	struct kvm_vm_id_regs id_regs;
 
 	/* Masks for VNCR-backed and general EL2 sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
@@ -1399,19 +1384,38 @@ static inline void kvm_hyp_reserve(void) { }
 void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
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
 {
 	switch (reg) {
 	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
-		return &ka->id_regs[IDREG_IDX(reg)];
+		return &id_regs->normal[IDREG_IDX(reg)];
 	case SYS_CTR_EL0:
-		return &ka->ctr_el0;
+		return &id_regs->ctr_el0;
 	case SYS_MIDR_EL1:
-		return &ka->midr_el1;
+		return &id_regs->midr_el1;
 	case SYS_REVIDR_EL1:
-		return &ka->revidr_el1;
+		return &id_regs->revidr_el1;
 	case SYS_AIDR_EL1:
-		return &ka->aidr_el1;
+		return &id_regs->aidr_el1;
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
@@ -1419,7 +1423,7 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 }
 
 #define kvm_read_vm_id_reg(kvm, reg)					\
-	({ u64 __val = *__vm_id_reg(&(kvm)->arch, reg); __val; })
+	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 014fe04daabf..58a439c3ab9c 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1398,7 +1398,7 @@ void __init check_feature_map(void)
 
 static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
 {
-	u64 regval = kvm->arch.id_regs[map->regidx];
+	u64 regval = kvm->arch.id_regs.normal[map->regidx];
 	u64 regfld = (regval >> map->shift) & GENMASK(map->width - 1, 0);
 
 	if (map->sign) {
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index eb1c10120f9f..94620f142f42 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -343,7 +343,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 	DECLARE_BITMAP(allowed_features, KVM_VCPU_MAX_FEATURES);
 
 	/* CTR_EL0 is always under host control, even for protected VMs. */
-	hyp_vm->kvm.arch.ctr_el0 = host_kvm->arch.ctr_el0;
+	hyp_vm->kvm.arch.id_regs.ctr_el0 = host_kvm->arch.id_regs.ctr_el0;
 
 	/* Preserve the vgic model so that GICv3 emulation works */
 	hyp_vm->kvm.arch.vgic.vgic_model = host_kvm->arch.vgic.vgic_model;
@@ -358,7 +358,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 			    KVM_VCPU_MAX_FEATURES);
 
 		if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags))
-			hyp_vm->kvm.arch.midr_el1 = host_kvm->arch.midr_el1;
+			hyp_vm->kvm.arch.id_regs.midr_el1 = host_kvm->arch.id_regs.midr_el1;
 
 		return;
 	}
@@ -493,7 +493,8 @@ static int vm_copy_id_regs(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (test_and_set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
 		return 0;
 
-	memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
+	memcpy(kvm->arch.id_regs.normal, host_kvm->arch.id_regs.normal,
+	       sizeof(kvm->arch.id_regs.normal));
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index b5a0de84ce01..e8d773d38905 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -292,7 +292,7 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		return 0;
 
 	if (reg >= sys_reg(3, 0, 0, 1, 0) && reg <= sys_reg(3, 0, 0, 7, 7))
-		return kvm->arch.id_regs[IDREG_IDX(reg)];
+		return kvm->arch.id_regs.normal[IDREG_IDX(reg)];
 
 	return 0;
 }
@@ -543,7 +543,7 @@ void kvm_init_pvm_id_regs(struct kvm_vcpu *vcpu)
 	 * for protected VMs.
 	 */
 	for (r = sys_reg(3, 0, 0, 4, 0); r <= sys_reg(3, 0, 0, 7, 7); r += sys_reg(0, 0, 0, 0, 1))
-		ka->id_regs[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
+		ka->id_regs.normal[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b9aa892616ab..195ecdac7bd6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2477,7 +2477,7 @@ static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
 {
-	u64 *p = __vm_id_reg(&kvm->arch, reg);
+	u64 *p = __vm_id_reg(&kvm->arch.id_regs, reg);
 
 	lockdep_assert_held(&kvm->arch.config_lock);
 
-- 
2.53.0

