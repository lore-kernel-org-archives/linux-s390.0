Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981342;
	b=JnwooavgJRigY1hL3+OdVOW5hm/mUWFzAU9eX9zI0upuPI+Jf02l5LkfdQd5hmyNgBRz
	 7JMIZLXCvZf8LHv1hom421AYMDd0UJhpgoVgWwplNt+a6dcCDzpunMF2lIAgrozkImGHa
	 hp8LOVr8Q/0KKymEhMxbWOso4gQ+/ie5uVT7TfV6h/6w1sflicqSuLmG1HCF6wJGTW4xe
	 dNl7cBDNc3tAUWi5Eg1A+HQs20sWaxWpZdfD5nj0PdCNA1mJQrkta8MiUm2Nrsmq+hB7J
	 xEvKIvUDJh8hPgCuwhhEixreey6G7DE5SPiyis1R+K5TfPDkxxv2CUS+yoDVTxsEwaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nIe4y/wURdvfPyF6YlgB6Bfl6OuYdf/Ts/d09vFJTRw=;
	b=Mhg7b45lPtip1xjIg2fNobV4YUVddeIUhN2/FO93S03foyGsnTkH77K6kTGm0T3TAayf
	 pzredppw+9/5Q/vjxjlkAQzVJFxrgR9aDvq0t51YCv3uq5nhyCJra7U5d+bitjzmOefk2
	 HQbspGCi1yUmWaU4K+u0plg1mkq1LEves6BJ2GNRJWstws0EoygExkd0ZyAqEVQnVqbuQ
	 7sIPFgtWTLas9pRM09V23M5iCsd4nfzINT+d/Zv6lC6rvxs8mHs5e7A+vvqOID0vy0uhI
	 PKKcpvcW8V0pI6Kxsd1VUdDxrHHd1w6zNSwuMntFxLb+DgudH/6FSLQFqIfyajJWzSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UmJNanGv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE560A3838;
	Fri,  6 Nov 2026 16:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFE560A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UmJNanGv
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE5Cx1094480;
	Fri, 6 Nov 2026 16:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nIe4y/
	wURdvfPyF6YlgB6Bfl6OuYdf/Ts/d09vFJTRw=; b=UmJNanGvq6JJEg59BwKncw
	K572xAiMLc4gqLpXV2zvfJ3KlrlsffzAB/xp/+i5HLC0XIR/JZw0Uqgu5CoBCSsc
	yNOau1kG7sSG7KZI8AakNkFs/dUWHuX2V/xyC/AkledZa8VLqAVH9SXX6TubwyrJ
	IacN59FF9XYUYlc/06yZNmSaK+AS5vi7OK6jd8sOhXOcSZlDjm+XH+cFbFyB/TMr
	/8A7DsKINVRWszF6heEjGQbJGOdSe9MykHj2v2HO0ZTSwE2Y51R345+8AzfPzWkE
	biaAHnyUf/TSs4FDLQwHZA40983+isIKE6LahU6evYB6m6HNYrTIAHW1Ct74/icA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rawj03-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4trY3584936;
	Fri, 6 Nov 2026 16:08:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka724bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8EfQ44302756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538B020040;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB4AC2005A;
	Fri,  6 Nov 2026 16:08:13 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:13 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:34 +0100
Subject: [PATCH v3 01/23] KVM: arm64: Refactor idreg caching into dedicated
 structure
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedfb78 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=cTjP7GSaQDJverrz-6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nsgYLN8scBgX_s1iGg-Hn7XLfXEblE64
X-Proofpoint-ORIG-GUID: nsgYLN8scBgX_s1iGg-Hn7XLfXEblE64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX3aU7/6OFEayu
 8pM5dvcPBLBGfKNmr3S32IZjlUi7nTvzn0T2E0UsPRqDGJPzZMjB1u/towpIC83ON7h2sL4w2Fm
 +kbzl5j5YhesTgrgQphFjyGCVAgg+No=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX3nYfpu16sFND
 c1URAxu2FsufUINzl5vdVwLzSdOHX1SlacIAcSIvc3aN8UWNySBuXr9+3vB1eF7Y/foVd7E8UPv
 Pzk126/5WSpcbGralpUgV2+wD9gI+pcbF7fpy8Fey1HV+OeRGQtqz+9bfacjCv3IEdlQtXfKWkO
 uYpYxIRGoIE2QtUmVJUfzTHoz24gM39pinnip+ketfJOXmToaRRFQf7qhQyO5IsbLPR5yLKDFb6
 p5ed6LLL7WuKI2KO0C9lmpXO9NCYR9uuGmnfPdgZueBIr3uguAyzrynymiYXS3TrobQid+bZvzJ
 pUgWS95qTMfk4RdoAObcwG9Esbiq7OC0aQVszjBRshRZTOw3wzuihQ3sCH8CCtNHIhTmUvWBKpx
 KWDL0phye1DJ+vSFpxUo2Nld9isA+K9xTXGSozW31T2loMbQ9uw9kCq6+j6lEkYohJQe1y5edBH
 ACibgWcCDyWoappIuHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Move VM-wide ID register emulation fields from struct kvm_arch into a
new struct kvm_vm_id_regs. The new struct is placed in a shared region.
Update all users to use the new structure.

No functional changes.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h  | 50 ++++++++++++++++++++------------------
 arch/arm64/kvm/config.c            | 10 ++++----
 arch/arm64/kvm/hyp/nvhe/pkvm.c     |  7 +++---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |  4 +--
 arch/arm64/kvm/sys_regs.c          |  2 +-
 5 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 97332ffcb130..7f051dad79c7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -105,6 +105,25 @@ struct vcpu_reset_state {
 	bool		reset;
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
 #endif /* ARM64_S390_COMMON == 1 */
 
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
@@ -478,22 +497,7 @@ struct kvm_arch {
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
@@ -1634,19 +1638,19 @@ void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 bool kvm_pkvm_vcpu_is_powered_off(struct kvm_vcpu *vcpu);
 
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
@@ -1654,7 +1658,7 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 }
 
 #define kvm_read_vm_id_reg(kvm, reg)					\
-	({ u64 __val = *__vm_id_reg(&(kvm)->arch, reg); __val; })
+	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index adaf26ab93b8..49bbe68c0b9e 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1467,11 +1467,11 @@ static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
 			resx.res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
 	}
 
-	val = kvm->arch.id_regs[r->idreg_idx];
-	kvm->arch.id_regs[r->idreg_idx] &= ~resx.res0;
-	kvm->arch.id_regs[r->idreg_idx] |= resx.res1;
+	val = kvm->arch.id_regs.ftr_reg[r->idreg_idx];
+	kvm->arch.id_regs.ftr_reg[r->idreg_idx] &= ~resx.res0;
+	kvm->arch.id_regs.ftr_reg[r->idreg_idx] |= resx.res1;
 
-	return val != kvm->arch.id_regs[r->idreg_idx];
+	return val != kvm->arch.id_regs.ftr_reg[r->idreg_idx];
 }
 
 void kvm_idregs_enforce_dependencies(struct kvm *kvm)
@@ -1488,7 +1488,7 @@ void kvm_idregs_enforce_dependencies(struct kvm *kvm)
 
 static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
 {
-	u64 regval = kvm->arch.id_regs[map->regidx];
+	u64 regval = kvm->arch.id_regs.ftr_reg[map->regidx];
 	u64 regfld = (regval >> map->shift) & GENMASK(map->width - 1, 0);
 
 	if (map->sign) {
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index fc0475f0877d..41ee83290697 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -399,7 +399,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 	DECLARE_BITMAP(allowed_features, KVM_VCPU_MAX_FEATURES);
 
 	/* CTR_EL0 is always under host control, even for protected VMs. */
-	hyp_vm->kvm.arch.ctr_el0 = host_kvm->arch.ctr_el0;
+	hyp_vm->kvm.arch.id_regs.ctr_el0 = host_kvm->arch.id_regs.ctr_el0;
 
 	/*
 	 * pKVM runs only GICv3. Anything else becomes 0, the model of a VM
@@ -419,7 +419,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 			    KVM_VCPU_MAX_FEATURES);
 
 		if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags))
-			hyp_vm->kvm.arch.midr_el1 = host_kvm->arch.midr_el1;
+			hyp_vm->kvm.arch.id_regs.midr_el1 = host_kvm->arch.id_regs.midr_el1;
 
 		goto out;
 	}
@@ -574,7 +574,8 @@ static int vm_copy_id_regs(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (test_and_set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
 		return 0;
 
-	memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
+	memcpy(kvm->arch.id_regs.ftr_reg, host_kvm->arch.id_regs.ftr_reg,
+	       sizeof(kvm->arch.id_regs.ftr_reg));
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 32e82653ebf7..10b144e50feb 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -296,7 +296,7 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		return 0;
 
 	if (reg >= sys_reg(3, 0, 0, 1, 0) && reg <= sys_reg(3, 0, 0, 7, 7))
-		return kvm->arch.id_regs[IDREG_IDX(reg)];
+		return kvm->arch.id_regs.ftr_reg[IDREG_IDX(reg)];
 
 	return 0;
 }
@@ -607,7 +607,7 @@ void kvm_init_pvm_id_regs(struct kvm_vcpu *vcpu)
 	 * for protected VMs.
 	 */
 	for (r = sys_reg(3, 0, 0, 4, 0); r <= sys_reg(3, 0, 0, 7, 7); r += sys_reg(0, 0, 0, 0, 1))
-		ka->id_regs[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
+		ka->id_regs.ftr_reg[IDREG_IDX(r)] = pvm_calc_id_reg(vcpu, r);
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 850eba167aad..0f0b0495b710 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2543,7 +2543,7 @@ static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
 {
-	u64 *p = __vm_id_reg(&kvm->arch, reg);
+	u64 *p = __vm_id_reg(&kvm->arch.id_regs, reg);
 
 	lockdep_assert_held(&kvm->arch.config_lock);
 

-- 
2.56.0

