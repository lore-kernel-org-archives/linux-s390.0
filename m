Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981326;
	b=Vwj8j4J3cZJbDBdWjH+Bi4RiYY13BqJkxB39l66GUIXy9vVLvHeCeJmkRSkzSpKdTX0U
	 kjMP2wpaSXbVXTthEb+MZWFR7guqi4qrdiGd5mxYdQ+IT6Y6qJYVsI/UstkpmxJc+zVbQ
	 riQbrYOCjJRDp9qPrj2102FwupY2VQVDuXquVO1dl/2cUlRckc9RHeSdH/hEOE9a8+MIa
	 A1C7kqUlqeauH9NfPnFs3ZTfguF1k8CiBd8uIzhxO18K7d7ibbyqZH/qZFYqJrKHGA5PK
	 0HE6kQaEORk4WXg5HQZbZBs9mSH7n83ynQ3M9JfczssEg0qTTYLh3LQtZSNaTfbc69Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981326;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NwHGzADZz4Ks+lxsWJ5hHz46CrfiXovsx7AeNkAjrgA=;
	b=Sf0b7bGl6O7uAIp0f0ThQl4zqZgxx27xaxtTjRGjxXcd7i+fJ568uIIQg/eqNQM1vTvA
	 TO4DmW+oPiRfT3idivGn/NCXTKkl4d75D+9+c4I1ad5WBSC3c2T0q9h0XopTqFHVkMM+M
	 c3AlcZUmfnHr4X6Slji2Gn2ox3LZ2mkOq+GmuO3Q+HahDAPuEv/lYGyk0n46nO5dhKhwz
	 anzZ0SYSc81aJ/fAzchJ7fh8fGjMttnzDBKrjxKU3Y2OKkj9oXS+rfaCZisCZNQGGaC56
	 +fGw5HIH9R2hmiAhhKHGEpK0yMOggLcYUFiFAt/1n6ZvJ+xuSUDC7x0xG1ipT70EyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dHqSZ+J7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B304606A329;
	Fri,  6 Nov 2026 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B304606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dHqSZ+J7
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FECm52656392;
	Fri, 6 Nov 2026 16:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NwHGzA
	DZz4Ks+lxsWJ5hHz46CrfiXovsx7AeNkAjrgA=; b=dHqSZ+J7zThTnLR03HSsvi
	jHmvQgQlsmrpYmmQVLTmCajeavDhYiLPVHl/inDSa3EUejob+osUMR9SI0VBNYQm
	MFecLN1UaXCMCxMJ34SY6CxfD1k4arAWTJ2//vmaoGZ06C8wc+0z9Motnebw+otF
	ZFYSPsMH4OknGXV88gOst7SaXf/G3zhzbzZvHoCyfJrKeST4vX74dw37oqufkh/u
	2bOTyTNKV6sv6Kt+qMOuvgulw14wlViShbGKv7zascln3PHpFqKeBJjCMhV14gos
	ZKtXliP2pKNJof/xvwG2MXe86vXye3Nex43FC+ckVh4GgOqRNs2B/a9qHco9G4EA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5eu0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK7023577902;
	Fri, 6 Nov 2026 16:08:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v871q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Lil32833872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD2672004F;
	Fri,  6 Nov 2026 16:08:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 770E92005A;
	Fri,  6 Nov 2026 16:08:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:52 +0100
Subject: [PATCH v3 19/23] KVM: s390: arm64: Implement exception injection
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
Message-Id: <20261106-sysreg-v3-19-75e95980fb10@linux.ibm.com>
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
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX28k5cGYA9Ixu
 aQPCW1WFqvS75I39U2aDjZrF6/BnHcfhSg5kofro9ifOzz5P80F2YHq3rvY0FXz9QeEtE47xSpO
 oej9lSF14S+V1dYmFkxpH7Aa0zlyh0w=
X-Proofpoint-GUID: lfHOuCZAuMKuaHIBsR28JGIvc97ziHj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXzywuR5bIro98
 LokhN+OfGkj1mNjPZMjH+GkbsKPLJ4QVsjDtRPFHSfZ6nKtYvV4nmaGPsdgpLg2+46zzjounRYR
 NLksSeAUPr42Uu+4bRJqeJlq1DQzUCnKTxucpbjON0wUY7I9loemTdb2YlcxkRBn5eGTctsdhM7
 3UkRujx1jN0CB4OrTYujQWoL8xdEt9jcwAtii+XkQVVfehWQ0MNmVrMDRpd+0RfckL6TMzx/UrL
 Bz70XSn51dwhroQUxUSIs9k7CF/3Im8px2Jd0Bes1emmRKzk0GZrqliqgUbVJZjTves0DYnCRwC
 h/9fnmCynwnrV9xlbDChVnzWC3tbiYizsrquXeHK2zaiv8ph9/YW1A+Jh/JvjQ4khrhmNA8yCk0
 yOI7pQ2zDSlY/2JivV0ZSUqolzGNtZSlhXKN+qtpp1r1GgdDrdyH5rj3wJblYM/lfR+3caZOy7S
 dzD9tVCswDyDo8W/Clw==
X-Proofpoint-ORIG-GUID: lfHOuCZAuMKuaHIBsR28JGIvc97ziHj5
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=W5TDu8ZgCn-YWPwT9wYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Add exception injection support for s390 KVM arm64 architecture. This
implements the core exception entry mechanism and fault injection
functions needed for proper guest exception handling.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |   2 +
 arch/s390/kvm/arm64/Makefile           |   1 +
 arch/s390/kvm/arm64/arm.c              |  15 ++---
 arch/s390/kvm/arm64/exception.c        | 109 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/inject_fault.c     |  65 +++++++++++++++++++-
 5 files changed, 179 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 44deae423ace..79549434a1d6 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -425,4 +425,6 @@ static inline bool vgic_host_has_gicv5(void)
 	return false;
 }
 
+void kvm_adjust_pc(struct kvm_vcpu *vcpu);
+
 #endif /* ASM_KVM_HOST_ARM64_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 24ac6f6f6278..b0f2da6ac482 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -11,6 +11,7 @@ ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/$(SRCARCH)/kvm/gma
 
 kvm-arm64-local := \
 	arm.o \
+	exception.o \
 	feature.o \
 	guest.o \
 	handle_exit.o \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 4de0f17052cb..91e9f4a75ce7 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -390,14 +390,6 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
-static void adjust_pc(struct kvm_vcpu *vcpu)
-{
-	if (vcpu_get_flag(vcpu, INCREMENT_PC)) {
-		kvm_skip_instr(vcpu);
-		vcpu_clear_flag(vcpu, INCREMENT_PC);
-	}
-}
-
 static noinstr void arm_vcpu_enter_exit(phys_addr_t sae_block)
 {
 	guest_timing_enter_irqoff();
@@ -488,7 +480,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		trace_kvm_entry(*vcpu_pc(vcpu));
 
-		adjust_pc(vcpu);
+		kvm_adjust_pc(vcpu);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_el2, SYS_HCR_EL2);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_el2, SYS_HCRX_EL2);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2);
@@ -511,8 +503,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_sigset_deactivate(vcpu);
 out:
-	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
-		adjust_pc(vcpu);
+	if (unlikely(vcpu_get_flag(vcpu, PENDING_EXCEPTION) ||
+		     vcpu_get_flag(vcpu, INCREMENT_PC)))
+		kvm_adjust_pc(vcpu);
 
 	save_vx_regs(vcpu->arch.ctxt.vregs);
 	kernel_fpu_end(&fpu_save, KERNEL_FPC | KERNEL_VXR);
diff --git a/arch/s390/kvm/arm64/exception.c b/arch/s390/kvm/arm64/exception.c
new file mode 100644
index 000000000000..93a2a2a8bcc8
--- /dev/null
+++ b/arch/s390/kvm/arm64/exception.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <arm64/kvm_emulate.h>
+#include <arm64/sysreg-defs.h>
+
+#include <arm64/ptrace.h>
+
+/*
+ * This performs the exception entry at a given EL (@target_mode), stashing PC
+ * and PSTATE into ELR and SPSR respectively, and compute the new PC/PSTATE.
+ * The EL passed to this function *must* be a non-secure, privileged mode with
+ * bit 0 being set (PSTATE.SP == 1).
+ *
+ * When an exception is taken, most PSTATE fields are left unchanged in the
+ * handler. However, some are explicitly overridden (e.g. M[4:0]). Luckily all
+ * of the inherited bits have the same position in the AArch64/AArch32 SPSR_ELx
+ * layouts, so we don't need to shuffle these for exceptions from AArch32 EL0.
+ *
+ * For the SPSR_ELx layout for AArch64, see ARM DDI 0487E.a page C5-429.
+ * For the SPSR_ELx layout for AArch32, see ARM DDI 0487E.a page C5-426.
+ *
+ * Here we manipulate the fields in order of the AArch64 SPSR_ELx layout, from
+ * MSB to LSB.
+ */
+static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
+			      enum exception_type type)
+{
+	unsigned long sctlr, vbar, old_pstate, new, mode;
+	u64 exc_offset;
+
+	old_pstate = *vcpu_cpsr(vcpu);
+	mode = old_pstate & (PSR_MODE_MASK | PSR_MODE32_BIT);
+
+	if      (mode == target_mode)
+		exc_offset = CURRENT_EL_SP_ELx_VECTOR;
+	else if ((mode | PSR_MODE_THREAD_BIT) == target_mode)
+		exc_offset = CURRENT_EL_SP_EL0_VECTOR;
+	else if (!(mode & PSR_MODE32_BIT))
+		exc_offset = LOWER_EL_AArch64_VECTOR;
+	else
+		exc_offset = LOWER_EL_AArch32_VECTOR;
+
+	switch (target_mode) {
+	case PSR_MODE_EL1h:
+		vbar = vcpu_read_sys_reg(vcpu, VBAR_EL1);
+		sctlr = vcpu_read_sys_reg(vcpu, SCTLR_EL1);
+		vcpu_write_sys_reg(vcpu, *vcpu_pc(vcpu), ELR_EL1);
+		vcpu_write_sys_reg(vcpu, old_pstate, SPSR_EL1);
+		break;
+	default:
+		panic("Unknown PSR Mode: 0x%lx.", target_mode);
+	}
+
+	*vcpu_pc(vcpu) = vbar + exc_offset + type;
+
+	new = 0;
+
+	new |= (old_pstate & PSR_N_BIT);
+	new |= (old_pstate & PSR_Z_BIT);
+	new |= (old_pstate & PSR_C_BIT);
+	new |= (old_pstate & PSR_V_BIT);
+	new |= (old_pstate & PSR_DIT_BIT);
+	new |= (old_pstate & PSR_PAN_BIT);
+
+	if (!(sctlr & SCTLR_EL1_SPAN))
+		new |= PSR_PAN_BIT;
+
+	if (sctlr & SCTLR_ELx_DSSBS)
+		new |= PSR_SSBS_BIT;
+
+	new |= PSR_D_BIT;
+	new |= PSR_A_BIT;
+	new |= PSR_I_BIT;
+	new |= PSR_F_BIT;
+
+	new |= target_mode;
+
+	*vcpu_cpsr(vcpu) = new;
+}
+
+static void kvm_inject_exception(struct kvm_vcpu *vcpu)
+{
+	switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
+	case unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC):
+		enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
+		break;
+	default:
+		WARN_ONCE(1, "Unsupported pending exception type: 0x%lx\n",
+			  vcpu_get_flag(vcpu, EXCEPT_MASK));
+		break;
+	}
+}
+
+/*
+ * Adjust the guest PC (and potentially exception state) depending on
+ * flags provided by the emulation code.
+ */
+void kvm_adjust_pc(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_get_flag(vcpu, PENDING_EXCEPTION)) {
+		kvm_inject_exception(vcpu);
+		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
+		vcpu_clear_flag(vcpu, EXCEPT_MASK);
+	} else if (vcpu_get_flag(vcpu, INCREMENT_PC)) {
+		kvm_skip_instr(vcpu);
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
+	}
+}
diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inject_fault.c
index 425dbeaa421c..33f40c5188c9 100644
--- a/arch/s390/kvm/arm64/inject_fault.c
+++ b/arch/s390/kvm/arm64/inject_fault.c
@@ -2,6 +2,38 @@
 
 #include <arm64/kvm_emulate.h>
 
+static void pend_sync_exception(struct kvm_vcpu *vcpu)
+{
+	kvm_pend_exception(vcpu, EXCEPT_AA64_EL1_SYNC);
+}
+
+static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
+{
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
+	u64 esr = 0;
+
+	if (kvm_vcpu_abt_iss1tw(vcpu))
+		esr |= ESR_ELx_FSC_SEA_TTW(kvm_vcpu_abt_gltl(vcpu));
+	else
+		esr |= ESR_ELx_FSC_EXTABT;
+
+	pend_sync_exception(vcpu);
+
+	esr |= ESR_ELx_IL;
+
+	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
+		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
+	else
+		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
+
+	if (!is_iabt)
+		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
+
+	vcpu_write_sys_reg(vcpu, addr, FAR_EL1);
+	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
+}
+
 /**
  * kvm_inject_undefined - inject an undefined instruction into the guest
  * @vcpu: The vCPU in which to inject the exception
@@ -11,11 +43,40 @@
  */
 void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 {
-	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+	u64 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT) | ESR_ELx_IL;
+
+	kvm_inject_sync(vcpu, esr);
+}
+
+static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+{
+	inject_abt64(vcpu, iabt, addr);
 }
 
 int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
 {
-	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+	lockdep_assert_held(&vcpu->mutex);
+
+	__kvm_inject_sea(vcpu, iabt, addr);
 	return 1;
 }
+
+void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
+{
+	unsigned long addr, esr;
+
+	addr  = kvm_vcpu_get_fault_ipa(vcpu);
+	addr |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
+
+	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr);
+
+	esr = vcpu_read_sys_reg(vcpu, ESR_EL1);
+	esr &= ~GENMASK_ULL(5, 0);
+	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
+}
+
+void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr)
+{
+	pend_sync_exception(vcpu);
+	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
+}

-- 
2.56.0

