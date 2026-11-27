Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789459;
	b=OEem+kSv5ddrgJUe+gfSAmiPoawMbn/czMGKLuwcCwUiegNOyxdubUST0chodCCPH447
	 /hpXGloyyG6C9TJDOl84FcaZXp4qvW1FyASFfqrccylQMO+0RlEocMLa+cKm1uMbpzBwD
	 7//iK324KadFsCX4FgaUcDfm2Lkj/wsJoWpP8QidIopnxlIXZjW4CckFICwV5a4a9GvaR
	 60WS29urdZNJftZGbglkBkezYySoZwAx6JDiWeiQwHmkuB6AMd8uVeIrwP8aiGIc3DMoJ
	 533tlpWMgrTZ8De3DNdVlcKdXpdS9oclEnLnbtzx1QjVa2Jg21WWKoG99YCeJ4mLE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dr6anXfFaRUPLtcUaE0xnSp+SE8ftkLjWqinLtQgvsQ=;
	b=gRN662jdfjnLh0jgBi4uFOXsAq11UKUdzkqzVnFtLsDzLtqJniE8cq0JF7+EGQbfRlGB
	 2u4lTFd1nBejnGVOeVxh3TQQwKlu2P3wBfc9TyukVJScDwY6aWNGDalFJcb7cQgbbKhuM
	 H+uMP5YRZkbqQIBwViqpDyBEMF+Xo0a6L/mKi0Xk7kqkK6YfuELzllYyqg6Sz7Yq1UQes
	 TUIWAvlJ6SxETvquV9jQvKUe4VLdvSyXFTSALIOzeFHXpS43wIT5BCwRKFHrD23nT11JG
	 jz+vfv1rVWzD2ARVcxOsYok51gLDfkBAWbByZB/VkyYtWq4cdlGBURr0XwsxMQwjyGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A7DFN17S;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A995606E12D;
	Fri, 27 Nov 2026 14:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A995606E12D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A7DFN17S
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4ovZ3419760;
	Fri, 27 Nov 2026 14:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dr6anX
	fFaRUPLtcUaE0xnSp+SE8ftkLjWqinLtQgvsQ=; b=A7DFN17S2kpOKREMiVsMae
	0dVmKAWZQ7DTqcfyNilh4a4LQDwo3PoexYRiJUr+CrR0Ec7M74i1+YPZHV1DtCnc
	xuIQzR3Wrmyec7IZ2ZMr+bKTVnYKU+vz31jVw8JXAs2KUELU1tCH9kwwGifgX/cT
	Q+wiMXd4E1GG2kWirPpfQNkQ/9bX+p45eUr/b359FEltjGs2FBnongTwiJpGUtQR
	1E76p9zwzyOsDJKJsN34S9gwtHyxWN0gwofCw94X71klGwqxuvxCicoLNkS818d4
	g4tkV0U1Pu42HBalHbYkVz5Wb9K7no/1rF/cGdLxycaI8l9/t9iA0F49rbn6E+OA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fap8kk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4FHg1180993;
	Fri, 27 Nov 2026 14:23:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckj7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENEcf27066722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7715F20040;
	Fri, 27 Nov 2026 14:23:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EF920063;
	Fri, 27 Nov 2026 14:23:14 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:13 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:05 +0100
Subject: [PATCH v4 02/25] KVM: arm64: Refactor idreg caching into dedicated
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
Message-Id: <20261127-sysreg-v4-2-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX+mBVQ9bm35qV
 fq9CgDmRuGSoq3s0RVdYgA29pXLus6csLhzUD/Locxswf7BIJwyRIYMIYOFGeunT9QDavP89fR1
 e9WtBwnhwi84kwoYphYt/xvBA12bx4spDrP9EYxMvd83bd55T49OyF8QoAjQbUZUz8ZpeWOsI6V
 bh78vd3rp2n75wVm0/pAl4Y+mRC6uI8K947yoTp31UTLEW5skVU0Rir/2578LE98V7mPz1CWCWR
 bR4Va205+VI9ySkvnTdicZRrHneccR1xAqBtksNu7zD9KQA0uBtcUWWMPmcm0Ot8kX70yvMTXcw
 Ah3/dnfStzCxJ9hR8hA05a0xZKhyNC9ku1XgAkHT/0e4s+1yyJAyJF8xR+g+0ujafmuHXRWuOMb
 dTbK/EgH41ekFFYSjK4pyGRDKYq+01Q1VuPUm5ofcBxLL3vhq2UAX83a02cPI/sZbMLH1GlAXLv
 GBBxFXAGRB/OoBVarCg==
X-Proofpoint-ORIG-GUID: yj0mw7K8HM2Je7B_AGb9dVexBMwhbkI7
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b09925c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MW4Uhza44UK2E-9FfEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yj0mw7K8HM2Je7B_AGb9dVexBMwhbkI7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX8KNan99mmsHz
 fUBgi4bMLHrTZ+cgsmUupGz3xxnSIC+XMQ/JGDQpYH4/0GCbhXNOCNVvn7vhuhvJLWDAfZg7IB3
 2/68GkVhr8qe406f9G8VrpYAyfuYgBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270056

Move VM-wide ID register emulation fields from struct kvm_arch into a
new struct kvm_vm_id_regs. The new struct is placed in a shared region.
Update the helper function and one memcopy in pkvm to use the new
structure;

No functional changes.

Suggested-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h | 56 +++++++++++++++++++++------------------
 arch/arm64/kvm/hyp/nvhe/pkvm.c    |  3 ++-
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 83a6993e21cf..cfb2721053ed 100644
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
+	u64 ftr_regs[KVM_ARM_ID_REG_NUM];
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
@@ -1637,24 +1641,24 @@ void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 bool kvm_pkvm_vcpu_is_powered_off(struct kvm_vcpu *vcpu);
 
-static inline u64 *__vm_ftr_reg_by_idx(struct kvm_arch *ka, u32 idx)
+static inline u64 *__vm_ftr_reg_by_idx(struct kvm_vm_id_regs *id_regs, u32 idx)
 {
-		return &ka->id_regs[idx];
+		return &id_regs->ftr_regs[idx];
 }
 
-static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
+static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
 {
 	switch (reg) {
 	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
-		return __vm_ftr_reg_by_idx(ka, IDREG_IDX(reg));
+		return __vm_ftr_reg_by_idx(id_regs, IDREG_IDX(reg));
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
@@ -1663,13 +1667,13 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 
 #define kvm_get_vm_ftr_reg_by_idx(kvm, idx)					\
 	({									\
-		u64 *__valp = __vm_ftr_reg_by_idx(&(kvm)->arch, idx);		\
+		u64 *__valp = __vm_ftr_reg_by_idx(&(kvm)->arch.id_regs, idx);	\
 		__valp;								\
 	})
 
 #define kvm_get_vm_id_reg(kvm, reg)					\
 	({								\
-		u64 *__valp = __vm_id_reg(&(kvm)->arch, reg);		\
+		u64 *__valp = __vm_id_reg(&(kvm)->arch.id_regs, reg);	\
 		__valp;							\
 	})
 
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index db51174ffbe0..471f6d82bc3e 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -591,7 +591,8 @@ static int vm_copy_id_regs(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (test_and_set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
 		return 0;
 
-	memcpy(kvm->arch.id_regs, host_kvm->arch.id_regs, sizeof(kvm->arch.id_regs));
+	memcpy(kvm->arch.id_regs.ftr_regs, host_kvm->arch.id_regs.ftr_regs,
+	       sizeof(kvm->arch.id_regs.ftr_regs));
 
 	return 0;
 }

-- 
2.56.1

