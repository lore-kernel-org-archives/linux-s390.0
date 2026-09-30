Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9028531B10;
	Wed, 30 Sep 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789724; cv=none; b=EFzUoLp/104+KqQt0Fg5ONSIOyMY0tLfTFQU3g1SZ1eXBfpallmWdtFTrXWQTyJ4srdL2TCvDabgfNwifPRyNg8KctTsfzLXEjkriSCStQU1f7rK2zuMVRQFFQM7EGfl/JHhIQSu0p8WsREnPrLKLG9+tx4ZBfmEGRd/8IrGRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789724; c=relaxed/simple;
	bh=GMefMnByx9nFpNvuZT0RFDs+7oXdNOAh95Vi/KcfXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zd7FfpZGAVNJuddGpUvug3bZvhbZ/+LP93bQ+H5VsyDis8fxAM6E5FTZdzesr0n4vhYkmue8Itca+v1aiGeYIG6PYpBkcdKRObDYHEeC/S/SDQMN2wckmyiJIQ0Gs9vIpzPv/uckbPbblxLHu8Ophsan+oyISI7wwpvmmua68HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mFAYAg4U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mFAYAg4U"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5Lt43203100;
	Wed, 30 Sep 2026 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CJ2U0gZFHFWadhLeJ
	bd0jOfRIRm6eyPZnK7swjCoSck=; b=mFAYAg4UJVadG+v4EBLGLMh0Hh+s0s/VC
	ylJ3UhYPOAeQpjRXACoZNRa0w+AXCcEmy9nh8wLYbcTHyc+YrSIfReOWQk6twG9K
	V1yyFX0XhnW/2XwkQeFU5DcMul2ikk2grE686bRm99jiNqLEeyPfzCz3kyqAF06a
	jBWrSzk/bmHtDGLc3NIkjBZngBQkWQ1y6KTL6boAY9uA/3Zp6vdXpXetaJ+aKhZ2
	Um+NF5vPsnGTgnjEFVKvgu3vGNkNCZCy7ItQgz32LeUC6j8XInp0ClegIwhpTGxv
	zLDmJ+8gM/zNEkFRMyHxCDqwrZ1LRK/yKVSbBkUr3zBn2PWREhiwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5ep82-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEI17j3569533;
	Wed, 30 Sep 2026 17:34:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa66g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYjVq44892428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E911B20049;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99EB12005A;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
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
Subject: [PATCH v9 08/24] KVM: arm64: Use accessor functions for core regs
Date: Wed, 30 Sep 2026 19:34:23 +0200
Message-ID: <20260930173441.66762-9-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX1vWxX+pAwyg1
 VEATprJ6r7IVphkiVuaxm48FLUCXWUH5DBRuSzGuymeTdWtkZycwjV7m552L/wZNDZLo8F5IFKa
 Ce3hgQscAeRHBSwwWD+t3h3prbgeivI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX/51H7x7CQalI
 UO5XQZ+JYUCSpnuDW0UWMNQ93B6yhcJBnijxZTEJ3jCOnbxsXsxdSdId/4vUk3G/od8I9rO5hZh
 CAzTiIfGStgx6HKnCBctlTo2Jc0AvEdbx9YRoFXCTgH5YC5kGK6JSgQIGPCSgsHl0K2tWlZbd3I
 l7BToiCXvLlRtIL98YuX+jAZrpTJKlPQZIKMNk7Pd6QyHiON8sUDnsY6phP/4sKe1LRVies9GHv
 X+G8u6/7iprp4c2wftQS5nheQaFUsljVLGnD7x0X9yqyuqhX1b1KL2PNkh0yMdG3mqWuEoAORZ9
 UjmXp61XR4vjBlUjssRb0XgHMSceM2RwYIKkLqE1X70W2LoMBtZOxLY8zHeeaR9YD64DLbraqi2
 I68aGwRA/DqlJsERCyDviskUl+KmoRrvzRbEGEmdMZ6yRHED1LrUcQZypmasBGilW639zL8XBVR
 OBvvI0+NGjH6wnaV+7A==
X-Proofpoint-GUID: oTALerHSjy3Aw4tEN9aSS6TZR7xXK1Vc
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd483b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=5d8JqmD_1xC0DvqtPZgA:9
X-Proofpoint-ORIG-GUID: MtU3tSDvYx34DYwdDBPveoDC-tx-grUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

Instead of accessing the value directly use accessor functions that
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

