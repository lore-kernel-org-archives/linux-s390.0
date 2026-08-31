Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6150AC16;
	Mon, 31 Aug 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188479; cv=none; b=ZiTpXtADHysolh946scylnaMqgvdjGXjcdeVwNSFYfoizmRrFUQzAmz9oIvb7PScM/K9wBOBcgNFPGQ/1E5wZI7iibyoEH5brHo6Wqj1jE9P+Sy1cQI9NlpH1IKv083sNh8iK4xrA61Dcg2ZyUOCqKeiKoCvcd7asPfMDevvNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188479; c=relaxed/simple;
	bh=QmuqQsWPCXbu7YL9lXmIsvSwD4DaDRRx1A6Xx4l9YDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/Po9LWQAPS+gnbh34b6U8qpLUqfRRSbf/fhRn2YdR0r+h2qyV2uaiJPF420hR4PxMxRGr7c2kK2TZS+yfwZJ5NKcENiLGzHEmu8GA6jGVg+9Qd9xJ/3rY7MDb/Uz9Tqz/hHvAuK7CHugP+O1scxW5HvXSrOaTi6sV0wyReiucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d/XKd8hK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d/XKd8hK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZUTI2583573;
	Mon, 31 Aug 2026 14:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tI1QU5bib97AuL2yY
	VpDLoyzhg9SnD4PC3koRAUEWyE=; b=d/XKd8hKgY4za9tNbL8bKJZWrbw+SvnE7
	EQHSZJJGHMSj1kd/u7bigEk3yOwjzQEpBaS0YqfxaOWrO+RLIkRi7DL/E5PqTsUV
	cXOMdTpN1LBSee7lp0G0JVmusbexnDDC6E4KUXR6lg16HQR/+vULIzvzwQ1mxpKP
	2qrOtwN8bG3TrFUBZ3PjWdbCusDXLBZHep6aMZ/nVSI9JqEs2dRwHuqrj0Vx7YYv
	lPUXChbk1jiPa6CcurbD3ycy0wtqznMtafeH/LRwoq6IgGb/s55mJv90nJ05O3F/
	2N0PXE/aLD2kCONy7qontjPBjHlQx9by/PCd8S27Yk8TtQOpaOH/g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1u9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgXL003411;
	Mon, 31 Aug 2026 14:55:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxgcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtfdS39190922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F194E20040;
	Mon, 31 Aug 2026 14:55:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76CC12004B;
	Mon, 31 Aug 2026 14:55:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:40 +0000 (GMT)
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
Subject: [PATCH v2 07/20] KVM: arm64: Share more arm64 code with s390
Date: Mon, 31 Aug 2026 16:55:22 +0200
Message-ID: <20260831145536.913567-8-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9595f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DGrxBuOW4VxBNXMv79cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXyuNh26ymLXGF
 FS5nyANwtHCmN4LtLjhu71kKIraOaYt03kyda9wQXhxupuWwSGDxFHvYZPcNf96OrmknlFEt6ix
 0aI84KtRCr/1TE1LTrTGTSV3QWSsUe8=
X-Proofpoint-ORIG-GUID: kpBibWaTCGTcfrntdZ795KBzW2Gsz0eo
X-Proofpoint-GUID: sBuuWfzlxarD2b9vH300xAnW5O2Nov50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXzrLnksKpTNFy
 zKkfrhZH3h4nDicSYsCl8cGekXfKaqAA+3jc4cui6hk5z0k0NQG2v5nHpwv33I+dphoUxcbWQc1
 fJZWDsnicAc7aN2wYZ7UKYF9xpDBDHbHEH6gd0PSBdONVDoCbs1vyRvubt4UU7O5wSdXCopKV4A
 8tO8eK41SJ/w1j8aOY3Bo0rYaZolhHQJLmYRij3Vv0VCD/HBAbiasp9tGxL4PhxeAP/OpkcbVzk
 XHab2lICzwXIP6ss5cLpZuTZMF4v3tMSpX7ncdiTh+ydkUBo/VdQbx79wQt+Fsw8XPIIt16fmcK
 KDrBXjp06xP8Mn/kjxf7VWGbZHJuVdjrl4gCCUaMua8qwTCCuW32b4Vyz2ubLr6qjr/G0u82xT+
 4ks0p0zyDlJM0PbH4tB1cqgLHw99VGG46HEKKEPU7DjnPNP0ySne0YFCX8LzYPzpuA4NoJQSBRn
 x/Iwp8pjoijIBJhfDOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Mark functions that s390 can use to implement arm on s390 as shared
functions.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c      |  3 +++
 arch/arm64/kvm/guest.c    | 11 +++++++----
 arch/arm64/kvm/sys_regs.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6b92a3c1d490..62e8b32ee74e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -340,6 +340,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_arm_teardown_hypercalls(kvm);
 }
 
+#ifdef ARM64_S390_COMMON
 static bool kvm_has_full_ptr_auth(void)
 {
 	bool apa, gpa, api, gpi, apa3, gpa3;
@@ -374,6 +375,8 @@ static bool kvm_has_full_ptr_auth(void)
 		(apa + api + apa3) == 1);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 6ca5a9f357cd..e978b2fbeb76 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -307,12 +307,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
-#endif /* ARM64_S390_COMMON */
-
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
 
+#endif /* ARM64_S390_COMMON */
+
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	unsigned int max_vq, vq;
@@ -383,6 +383,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
+#ifdef ARM64_S390_COMMON
 #define SVE_REG_SLICE_SHIFT	0
 #define SVE_REG_SLICE_BITS	5
 #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
@@ -399,6 +400,8 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 #define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
 #define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Number of register slices required to cover each whole SVE register.
  * NOTE: Only the first slice every exists, for now.
@@ -595,8 +598,6 @@ static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 	return copy_core_reg_indices(vcpu, NULL);
 }
 
-#endif /* ARM64_S390_COMMON */
-
 static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
 {
 	const unsigned int slices = vcpu_sve_slices(vcpu);
@@ -658,6 +659,8 @@ static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu,
 	return num_regs;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /**
  * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
  * @vcpu: the vCPU pointer
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 53d096803d9d..b167f9d06fd4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -45,6 +45,7 @@
  * 64bit interface.
  */
 
+#ifdef ARM64_S390_COMMON
 static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
 static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val);
@@ -82,6 +83,8 @@ static bool write_to_read_only(struct kvm_vcpu *vcpu,
 			"sys_reg write to read-only register");
 }
 
+#endif /* ARM64_S390_COMMON */
+
 enum sr_loc_attr {
 	SR_LOC_MEMORY	= 0,	  /* Register definitely in memory */
 	SR_LOC_LOADED	= BIT(0), /* Register on CPU, unless it cannot */
@@ -428,6 +431,7 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
 	__vcpu_assign_sys_reg(vcpu, reg, val);
 }
 
+#ifdef ARM64_S390_COMMON
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
@@ -533,6 +537,8 @@ static bool access_rw(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
  */
@@ -800,6 +806,7 @@ static bool access_gicv5_ppi_enabler(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#ifdef ARM64_S390_COMMON
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -853,6 +860,8 @@ static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			 u64 val)
 {
@@ -1011,6 +1020,7 @@ static u64 reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return actlr;
 }
 
+#ifdef ARM64_S390_COMMON
 static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	u64 mpidr = kvm_calculate_mpidr(vcpu);
@@ -1019,6 +1029,8 @@ static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return mpidr;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
 				      const struct sys_reg_desc *r)
 {
@@ -1922,6 +1934,7 @@ static u8 pmuver_to_perfmon(u8 pmuver)
 	}
 }
 
+#ifdef ARM64_S390_COMMON
 static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
 static u64 sanitise_id_aa64pfr1_el1(const struct kvm_vcpu *vcpu, u64 val);
 static u64 sanitise_id_aa64pfr2_el1(const struct kvm_vcpu *vcpu, u64 val);
@@ -2078,6 +2091,8 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
 				       const struct sys_reg_desc *r)
 {
@@ -2127,6 +2142,7 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
+#ifdef ARM64_S390_COMMON
 static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
 {
 	if (!vcpu_has_sve(vcpu))
@@ -2288,6 +2304,8 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, val);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static u64 read_sanitised_id_dfr0_el1(struct kvm_vcpu *vcpu,
 				      const struct sys_reg_desc *rd)
 {
@@ -2332,6 +2350,7 @@ static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, val);
 }
 
+#ifdef ARM64_S390_COMMON
 static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 			       const struct sys_reg_desc *rd, u64 user_val)
 {
@@ -2661,6 +2680,8 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		       u64 *val)
 {
@@ -2764,6 +2785,7 @@ static bool bad_redir_trap(struct kvm_vcpu *vcpu,
 	SYS_REG_USER_FILTER(name, access_arch_timer, reset_val, 0, \
 			    arch_timer_get_user, arch_timer_set_user, vis)
 
+#ifdef ARM64_S390_COMMON
 /*
  * Since reset() callback and field val are not used for idregs, they will be
  * used for specific purposes for idregs.
@@ -2840,6 +2862,8 @@ static bool bad_redir_trap(struct kvm_vcpu *vcpu,
 	.val = 0,				\
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static bool access_sp_el1(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
@@ -3212,6 +3236,7 @@ static void init_imp_id_regs(void)
 	boot_cpu_aidr_val = read_sysreg(aidr_el1);
 }
 
+#ifdef ARM64_S390_COMMON
 static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	switch (reg_to_encoding(r)) {
@@ -3269,6 +3294,8 @@ static int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	.val = mask,					\
 	}
 
+#endif /* ARM64_S390_COMMON */
+
 static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	__vcpu_assign_sys_reg(vcpu, r->reg, vcpu->kvm->arch.nr_pmu_counters);
@@ -4833,6 +4860,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ SYS_DESC(SYS_AARCH32_CNTVCTSS),     access_arch_timer },
 };
 
+#ifdef ARM64_S390_COMMON
 static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
 			       bool reset_check)
 {
@@ -4882,6 +4910,8 @@ static void perform_access(struct kvm_vcpu *vcpu,
 		kvm_incr_pc(vcpu);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * emulate_cp --  tries to match a sys_reg access in a handling table, and
  *                call the corresponding trap handler.
@@ -5340,6 +5370,7 @@ void kvm_sys_regs_create_debugfs(struct kvm *kvm)
 			    &sr_resx_fops);
 }
 
+#ifdef ARM64_S390_COMMON
 static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
 {
 	u32 id = reg_to_encoding(reg);
@@ -5360,6 +5391,8 @@ static void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
 	reg->reset(vcpu, reg);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /**
  * kvm_reset_sys_regs - sets system registers to reset value
  * @vcpu: The VCPU pointer
@@ -5432,6 +5465,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+#ifdef ARM64_S390_COMMON
 /******************************************************************************
  * Userspace API
  *****************************************************************************/
@@ -5753,6 +5787,8 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 #define KVM_ARM_FEATURE_ID_RANGE_INDEX(r)			\
 	KVM_ARM_FEATURE_ID_RANGE_IDX(sys_reg_Op0(r),		\
 		sys_reg_Op1(r),					\
-- 
2.53.0

