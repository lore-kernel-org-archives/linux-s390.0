Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278C372EEC;
	Mon, 31 Aug 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187711; cv=none; b=Cb25XhFuaDvfn6TTIIlWw4wqgETWc0Mxmnl51K8xF//0a2uzwCbahzpVKYlX9uJaAuNOqYK4e7TiuU+URwKa6kLuRRkt2PN/g40p8+VsYpw3rkjMP5WAzLwdtdsFpcWpk3EpFz+IIAA9hez4Hw3C6yhKKhXGBcDb2Iqy+p/zRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187711; c=relaxed/simple;
	bh=fYxVuEPp2zoMzRtiZky5z8P9uLwUlo4R6fWMNGygexA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATEFM0zn99QcFYQPHB6ZDODoWniYQ+ehFieICZi5ckezZzadepzQ7K/Zi5flTxdLnkv1Ag95yQwIqnAV23GgbmGcpv1MxFwvNd6WvDWwi6BfH0NPfpP9gTPlr/bwrxj3wMuv6HJptQge7xHIZCIOOwizdnnl8j5ZivThTNWhqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FcPdOCgI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FcPdOCgI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZSS62415322;
	Mon, 31 Aug 2026 14:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pue/hbxchQPNeEsdd
	XL86T3H83khYsyD2h/Nv3W6fyY=; b=FcPdOCgIqIN10eF863oa8StEXgm1d+sRW
	lXG8EfQyadiLrWpSFO1pqACAuDvKBghfq4Y6GguxG3YSl4yOovGlJVOoJhi91FQm
	mJhqRQLg73xHyfeoEOoha8jLReMpkrctk4mMLopcQasK2M/ynwxYIFxPMWyFNlD6
	HCRTodl9YXmDP6pdMLFaHJHS0xqRWO/stJLmqzxM5ulnaj3TyBJ+3EpD8ywxGXj6
	/AuSpwYa11RiDk6x09fAKUIGH5Og5Kc9qwkedpyRPdBPLsO5Dlt+SNnkKuk3zZqI
	E/C9qLJq+5P6DOc90WbW9Zyn8ONyeuvwUpSOqGGiDPM6G36Qbg9VA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj4r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfe7R000458;
	Mon, 31 Aug 2026 14:48:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg694w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm6hQ37683632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC95620043;
	Mon, 31 Aug 2026 14:48:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A30E2004F;
	Mon, 31 Aug 2026 14:48:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:06 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 08/23] KVM: arm64: Use accessor functions for core regs
Date: Mon, 31 Aug 2026 16:47:45 +0200
Message-ID: <20260831144802.834315-9-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1zK3oBXbNNxGR2EXxhhHdmdbRgRuFZS2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX+vcTo7yy7HS4
 Wto4QJsDhSX8OAUN9EIgsJxu/MujafoBnkDLA0uBZI40f/hXpLlIHrxIRWjgv5tCt2egyIMFHzd
 Vm54yGGwlVTV4Q0pQqFUD4vsvG7R3dv57MwFNMESDPPhyYMF5Xa9XegLfMgCtY1r3q7YhqzF8ea
 ZRdEvL/EBGQvcMZEYkoMe/Ec9A9byei2dT3M6BfPqNMFZJqItNLmHHF/OxRyi0w3ZMewDeaa5g7
 pmcYiGoYlJYMQO0jHCVZ/1QeOapzApT7bmPyg4oNS3yUAjo/dFt6yRCTPW0QXyq5jxoVeBLhz88
 G0mSdYstMTfZ5jrPhAOWJtRITBntL/XfOZpO0uc8LyqxGy3wApW4uF0Uy9uNNUt5vPdjP3X0V6Q
 xG4Pa7JSuGttISXjbikmYwEtAKkIaXNFW054VwFt12Ci75ejm8q+pfM7/lr6eJiBZKkMzG12B6L
 npeckVOv6Lo8cRXigkw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a95942c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=5d8JqmD_1xC0DvqtPZgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX89usLFrmOumW
 jYc4JbERmuLag87vfTdIljrGOUbuzOdmuS517AM7aEKj1RxUC67lRfqP5M2lStJyoXZCw/4vcGC
 JO9hKU7dsljG6ri1DxLFjetMjrrgE0k=
X-Proofpoint-ORIG-GUID: O6xM98xvsvzV9BNaSI3gyssBojBLKXcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Instead of accessing the value directly use assessor function that
abstract the actual location of the register values. Add a helper
function to reset fpsimd registers. Enable other KVM implementations to
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

