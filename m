Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE13463B6D;
	Mon, 31 Aug 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188471; cv=none; b=QIDxhOUrmWxSB2qbWpYG23oVN0SMPRuw0uMH7mW0vjW5d/onnviD1NOuXbmYE5Q9KxYLpou6l3lUdZBPcmEyF4xfVeNBQb+dZlr3YHqtHc2NnMud1MOcwFRGVq6FTuDAmR5eQvQ54pfncoYDIty0FCfrcKJja9PayW0iwArqseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188471; c=relaxed/simple;
	bh=9wfYmcMLiY3XrO1XIWerZba4FDE2476kRIwsoeop3ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d30Mzp6+MKThdsfpCM1sziuIs6AtwoQ1BDUAc4MyWKwbmJqNAtxnEZM/BfTbthGb+trYkaw6q+HlaN7MwuSljRGN2Atdza67SRNsPmKoV1adGkjzqOMxzjPUAbclJjNmpSo5SIkVWV5Nf/FXq/REeA8uvSJaGi1531uHg+wB1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fq+1UynD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fq+1UynD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9EV652844;
	Mon, 31 Aug 2026 14:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ejJUX+hlnx8Z0T2Mp
	/03Cnp35wBOJqAQDWt4j6mc6Lg=; b=fq+1UynDK9vlq3szYdgSPwiT+Yjf644SK
	12FjHkYoHCJmITr7H/DTbDgn0NA5cG+f3U37xI9DJZkh4HRqQJqztKdbF/6foypa
	hs+lm5t4cbleMK9NaaPByeI/N3MNsDIYGmVWVmmW9TaXHKI3OBkkPo2rNVpOgon1
	TTuxQSwgeQvQH66bZE5WM0ggmluvHdpLldflP53/AC8sMlq0mrai5W/gNSOLymDh
	HU7rdSKtk+Yu7iAucy/onOiJxDmJXKWVzp4+EA6jhtmEe2y5G8B/DgijcNo6cv0G
	WMA9HuWM9vJv+A30xTbk0BM1f/i9kJN4Rq7GF+RivJ4OariNWgKfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r209j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfdFE029538;
	Mon, 31 Aug 2026 14:55:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx8uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtcJX47382792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54A520040;
	Mon, 31 Aug 2026 14:55:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A48B2004B;
	Mon, 31 Aug 2026 14:55:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:37 +0000 (GMT)
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
Subject: [PATCH v2 01/20] KVM: arm64: Refactor idreg caching into dedicated structure
Date: Mon, 31 Aug 2026 16:55:16 +0200
Message-ID: <20260831145536.913567-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9595f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LNVzOGTwHolIvdFCj68A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX76Rl1Fez0CBI
 CDVSHnkKXXTV20Rx9x/gSP2iyLYL8mR0bCML80XrmsSleLjEio0yNZCUkecppfTQg6VNjNsmEil
 qNX2QNhCGxokI3DFB2bROchl01MpwQoPry8ysyfU1G0DUSwswpXh09FP27lymJhmblzWfQXpZ24
 YqMODEUwzROHrFETDBIe8ya1WrtYpJCLMAEvYMbva9A+3iOhpgDSXdiD/koT5iuxBpCmp8ZPqmA
 FcrY13WFRoan9cTKj0RugUji3N8XZtlVL4aWF+kmPmikhBgiTff/XEsYECV0KArG/QEpxAPAa3y
 THG4li5sLG5ZQzWGddyjDpZLMbh0n9qG0z4wzcZHgu6gj5IPNOHHcOcMBOCVD1/o61Zye+6BPnQ
 V32qF904xee5Tb0ZHbhXTZjfbm6+wEu9xs7f4uboH2Vg6LuD0fU3OemnUKjb7utBub6KS9kjU5t
 NGQhoUyRFOHy4HDQgpg==
X-Proofpoint-GUID: LaLHm07Mg0oo9fmbHz6s4rnhmqkuMq1v
X-Proofpoint-ORIG-GUID: 7doDAoFkK5nGYWMUFtE8aDQa7R2gRfXp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXyIev3iT2igoJ
 IZ+qUhWL8l5bQvrsIFim2nkGhEJSfcN5W/mevPKitr88Mye/wWEwAkeB3dYlUor2B15PlrQHEHA
 P8GXZvCQ6ILpLI76mu/J++JFgT0hQXs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

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
index a8ddce3921b8..f9e90ef9ee4b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -349,6 +349,25 @@ enum fgt_group_id {
 	__NR_FGT_GROUP_IDS__
 };
 
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
+	u64 ftr_reg[KVM_ARM_ID_REG_NUM];
+
+	u64 midr_el1;
+	u64 revidr_el1;
+	u64 aidr_el1;
+	u64 ctr_el0;
+};
+
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
 
@@ -408,22 +427,7 @@ struct kvm_arch {
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
@@ -1563,19 +1567,19 @@ static inline void kvm_hyp_reserve(void) { }
 void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
+static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
 {
 	switch (reg) {
 	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
-		return &ka->id_regs[IDREG_IDX(reg)];
+		return &id_regs->ftr_reg[IDREG_IDX(reg)];
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
@@ -1583,7 +1587,7 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 }
 
 #define kvm_read_vm_id_reg(kvm, reg)					\
-	({ u64 __val = *__vm_id_reg(&(kvm)->arch, reg); __val; })
+	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 1053676551af..de56656237f4 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1410,7 +1410,7 @@ void __init check_feature_map(void)
 
 static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
 {
-	u64 regval = kvm->arch.id_regs[map->regidx];
+	u64 regval = kvm->arch.id_regs.ftr_reg[map->regidx];
 	u64 regfld = (regval >> map->shift) & GENMASK(map->width - 1, 0);
 
 	if (map->sign) {
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 459bd9eb7e4b..bb11561de05e 100644
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
@@ -492,7 +492,8 @@ static int vm_copy_id_regs(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (test_and_set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
 		return 0;
 
-	memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
+	memcpy(kvm->arch.id_regs.ftr_reg, host_kvm->arch.id_regs.ftr_reg,
+	       sizeof(kvm->arch.id_regs.ftr_reg));
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 8758c6801776..3e70b71d8f4f 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -293,7 +293,7 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		return 0;
 
 	if (reg >= sys_reg(3, 0, 0, 1, 0) && reg <= sys_reg(3, 0, 0, 7, 7))
-		return kvm->arch.id_regs[IDREG_IDX(reg)];
+		return kvm->arch.id_regs.ftr_reg[IDREG_IDX(reg)];
 
 	return 0;
 }
@@ -544,7 +544,7 @@ void kvm_init_pvm_id_regs(struct kvm_vcpu *vcpu)
 	 * for protected VMs.
 	 */
 	for (r = sys_reg(3, 0, 0, 4, 0); r <= sys_reg(3, 0, 0, 7, 7); r += sys_reg(0, 0, 0, 0, 1))
-		ka->id_regs[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
+		ka->id_regs.ftr_reg[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 44aae52c473d..06dc8ec7a883 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2543,7 +2543,7 @@ static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
 {
-	u64 *p = __vm_id_reg(&kvm->arch, reg);
+	u64 *p = __vm_id_reg(&kvm->arch.id_regs, reg);
 
 	lockdep_assert_held(&kvm->arch.config_lock);
 
-- 
2.53.0

