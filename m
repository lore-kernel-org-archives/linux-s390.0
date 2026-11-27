Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789455;
	b=Bc4heDsVSQB3JZmBLgZniQsFeX+2DI3X/d6u+Ac5AnGNJVblbISAzkl1oqhJ89Sjp6iP
	 MbFoONNklWi3Hzq6k0yhRcr9zK+XWRHhrbcFr03ZR9Ac7lutZ4z/OxX7KXUKKzAr+yKPz
	 34yzYbc2ddbnK0OiCDQ/Ut/M7OUnjn6xfBHPdBK20676wkzB6cVaU/7L2KofGUEc4pw05
	 /V5Ke+qSzaBGpMR+2T6j1e47yQwWsZ0gAH2Pr6KoZQTPgyztspmGILV46yuk+dVPE41Hz
	 fVstCEpmnFJRvgFPigTvYRo5b81EZrLFYrF4J6faYHjAcpo0Y0XBrWJBZXOJEPZCPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789455;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ymBLMm+sgP5xbWm+LFLduEPlAjjSbRRsgx7LwhXSMPs=;
	b=Kujd1a0DXlnW0L+yIurilTMoL4G0vFCfxixRIiZYDaEenwA4RYscaeKjDo6kmcNfd6B2
	 dk2e5nSuDHhlBRaTcRqqXTj+r81MwK3rX2eft5U1Qn65VysIYrs2jfmH1liVZJttpvaOY
	 qQhEu4Jt1BW5+vD3I31FgkirZbm0HCWnjW8TEJlAT7MNRtZmXtkFQMhkgmfVbCvtl97Ro
	 ZknEAR+vFHik9VvWBEK+sx4iTWcqhmmBiZjNXprpHPlBtPkJ6C/B3pVJjygVRHCiBuNZY
	 L9iYcy0rV14/GCqniEnP8KZUycCqSAYHOjjLhJITLzBGebStL2+g+EvkBN3DGRtc+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NRBmH9p1;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BC606C710;
	Fri, 27 Nov 2026 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8BC606C710
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NRBmH9p1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4bKc3266065;
	Fri, 27 Nov 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ymBLMm
	+sgP5xbWm+LFLduEPlAjjSbRRsgx7LwhXSMPs=; b=NRBmH9p14sgocgZyyUhyHL
	X46O/ct1uG/gVCstagLCnqsHjbx5WcxOI9dNAN3qt3xrlKkkQfGRWdh7WwRFYJ1V
	M6n6TJmLNy6H8O8YhZsrpps+3APkMZb7Y1Nv+ixk0tst0FTP72RE9yII+BOaHkB2
	01ep6vE6HD7BRk9r7PdWzi2NXxLeKEWEWr5P0zOAConpOAAxWOO9Kx92SvkzekdK
	PbvcYYgj2/JFpKg3CSEREhzPI8qtDiEXRwcvVWEZoZfvmRQE9JvlfAjn+FGqjumU
	s+ICHLuMg/8skkc1sHmGtm+SGdgm9cM4IaCTIT8FEnMXW/wRJz2R5kR0f1Ux/2Fg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkx6sv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4EAd1180971;
	Fri, 27 Nov 2026 14:23:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckj8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENIHQ51118546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5F512004E;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E092006C;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:13 +0100
Subject: [PATCH v4 10/25] KVM: arm64: Share system register code with s390
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
Message-Id: <20261127-sysreg-v4-10-a6318d18aab5@linux.ibm.com>
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
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX9NzDjRYjvAfa
 WYziU+rM+NOorlNYkAn1a16JdmWilRLuq9XzkvWbEj4bODjbOU0YZh66GGHektKpmA9KGQDBIqY
 feJ+AqkJE37vQdr1goz9Fes86FkgUsi+DEBTbzlkb/2d2oEg9F0i+Vs7zY0dX8RjL3l4gMD5KPt
 Iv+3nxfrJZDIqg4Wq/8r8KUbSGi7FPc2HmCwNVpmatsj6ced2bYeXyBQPpdESd17NjAB6e5a9dE
 w851nBiMaFKeYCZoVLToPs8pbpaBeNqqooLc7KRh3/6Lr13JF2q6/WjuevECaYwKsf8z8OUVR/A
 oMERKlRbKeMIDns4cqH1uw2bZqQqtN9cLrUGmHKCv6FHSIBvi7spShM8aHUuNplo0jjhMMLeCWo
 9bI3liAFf5ANtFxKYIDNU0TCly1Td/GaQRSevt8MC8366bdzeBtCoTz0B/JZElQLUKJFLYDOEVS
 Q+fZ3bBzWO3oBQbM5ng==
X-Proofpoint-ORIG-GUID: gGZLCulJ7WFFJuEA2cQty0aPjTLTJRw1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX/FlB/psUXiGX
 kpnog2Ew4bOER5S53PGRP9Nig6wI8ItUHvrAwDtVdPbE+HJZlGYoLgxkKUjAGqHmftgycjTtWew
 6lpZc6NeOObspngqNKi68t+6+lWdL50=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b09925e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Ta4cUnT-blxcx9JQKIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gGZLCulJ7WFFJuEA2cQty0aPjTLTJRw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Mark functions that s390 can use to implement system registers for arm
on s390 guests as shared functions. The new shared functionality covers
system register infrastructure for KVM, Pointer auth checks and
shareable parts of the SVE register API. In order to reduce the number
of shared sections more code than s390 requires is shared. This is no
problem as for the shared code unused function checking is disabled.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c      |  3 +++
 arch/arm64/kvm/guest.c    | 11 +++++++----
 arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a148e80d0aef..4d44b638b7d3 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -361,6 +361,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_arm_teardown_hypercalls(kvm);
 }
 
+#if ARM64_S390_COMMON == 1
 static bool kvm_has_full_ptr_auth(void)
 {
 	bool apa, gpa, api, gpi, apa3, gpa3;
@@ -395,6 +396,8 @@ static bool kvm_has_full_ptr_auth(void)
 		(apa + api + apa3) == 1);
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index ba4570c52a91..c9780845ef17 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -307,12 +307,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
-#endif /* ARM64_S390_COMMON == 1 */
-
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	unsigned int max_vq, vq;
@@ -383,6 +383,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
+#if ARM64_S390_COMMON == 1
 #define SVE_REG_SLICE_SHIFT	0
 #define SVE_REG_SLICE_BITS	5
 #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
@@ -399,6 +400,8 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 #define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
 #define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 /*
  * Number of register slices required to cover each whole SVE register.
  * NOTE: Only the first slice every exists, for now.
@@ -595,8 +598,6 @@ static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 	return copy_core_reg_indices(vcpu, NULL);
 }
 
-#endif /* ARM64_S390_COMMON == 1 */
-
 static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
 {
 	const unsigned int slices = vcpu_sve_slices(vcpu);
@@ -658,6 +659,8 @@ static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu,
 	return num_regs;
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 /**
  * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
  * @vcpu: the vCPU pointer
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index abc49d4968f6..6bd200694b14 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -45,6 +45,7 @@
  * 64bit interface.
  */
 
+#if ARM64_S390_COMMON == 1
 static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
 static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val);
@@ -82,6 +83,8 @@ static bool write_to_read_only(struct kvm_vcpu *vcpu,
 			"sys_reg write to read-only register");
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 enum sr_loc_attr {
 	SR_LOC_MEMORY	= 0,	  /* Register definitely in memory */
 	SR_LOC_LOADED	= BIT(0), /* Register on CPU, unless it cannot */
@@ -428,6 +431,7 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
 	__vcpu_assign_sys_reg(vcpu, reg, val);
 }
 
+#if ARM64_S390_COMMON == 1
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
@@ -533,6 +537,8 @@ static bool access_rw(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 /*
  * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
  */
@@ -800,6 +806,7 @@ static bool access_gicv5_ppi_enabler(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#if ARM64_S390_COMMON == 1
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -853,6 +860,8 @@ static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			 u64 val)
 {
@@ -1012,6 +1021,7 @@ static u64 reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return actlr;
 }
 
+#if ARM64_S390_COMMON == 1
 static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	u64 mpidr = kvm_calculate_mpidr(vcpu);
@@ -1020,6 +1030,8 @@ static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return mpidr;
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
 				      const struct sys_reg_desc *r)
 {
@@ -1589,6 +1601,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 #define AMU_AMEVCNTR1_EL0(n) { SYS_DESC(SYS_AMEVCNTR1_EL0(n)), undef_access }
 #define AMU_AMEVTYPER1_EL0(n) { SYS_DESC(SYS_AMEVTYPER1_EL0(n)), undef_access }
 
+#if ARM64_S390_COMMON == 1
 static unsigned int ptrauth_visibility(const struct kvm_vcpu *vcpu,
 			const struct sys_reg_desc *rd)
 {
@@ -1609,6 +1622,8 @@ static unsigned int ptrauth_visibility(const struct kvm_vcpu *vcpu,
 	__PTRAUTH_KEY(k ## KEYLO_EL1),					\
 	__PTRAUTH_KEY(k ## KEYHI_EL1)
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static bool access_arch_timer(struct kvm_vcpu *vcpu,
 			      struct sys_reg_params *p,
 			      const struct sys_reg_desc *r)
@@ -1906,6 +1921,7 @@ static int arm64_check_features(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+#if ARM64_S390_COMMON == 1
 static u8 pmuver_to_perfmon(u8 pmuver)
 {
 	switch (pmuver) {
@@ -2838,6 +2854,8 @@ static bool bad_redir_trap(struct kvm_vcpu *vcpu,
 	.val = 0,				\
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static bool access_sp_el1(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
@@ -3219,6 +3237,7 @@ static void init_imp_id_regs(void)
 	boot_cpu_aidr_val = read_sysreg(aidr_el1);
 }
 
+#if ARM64_S390_COMMON == 1
 static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	switch (reg_to_encoding(r)) {
@@ -3276,6 +3295,8 @@ static int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	.val = mask,					\
 	}
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	__vcpu_assign_sys_reg(vcpu, r->reg, vcpu->kvm->arch.nr_pmu_counters);
@@ -4863,6 +4884,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ SYS_DESC(SYS_AARCH32_CNTVCTSS),     access_arch_timer },
 };
 
+#if ARM64_S390_COMMON == 1
 static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
 			       bool reset_check)
 {
@@ -4912,6 +4934,8 @@ static void perform_access(struct kvm_vcpu *vcpu,
 		kvm_incr_pc(vcpu);
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
 {
 	kvm_inject_undefined(vcpu);
@@ -5446,6 +5470,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+#if ARM64_S390_COMMON == 1
 static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
 {
 	u32 id = reg_to_encoding(reg);
@@ -5787,6 +5812,8 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
+#endif /* ARM64_S390_COMMON == 1 */
+
 #define KVM_ARM_FEATURE_ID_RANGE_INDEX(r)			\
 	KVM_ARM_FEATURE_ID_RANGE_IDX(sys_reg_Op0(r),		\
 		sys_reg_Op1(r),					\

-- 
2.56.1

