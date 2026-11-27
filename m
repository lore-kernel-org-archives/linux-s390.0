Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789449;
	b=RbnD+CidEKsa1gEZlJPAhp5wcraZoT9DWHk+spDcplzWzJs70HE8CQMtzzW2AoWFTCvI
	 fQRJu8ibpn/pIuBTwWKyOAyKFxRD743IbYoBophW16+MpTWII8JCIywV8ZvoghN1pOedT
	 YrvAdX5wNeti7KDYekACIgNMUopNDOeKTKfg0ZPU6dMqCsNsBkdXU4xfg6vJIQYeyC3zn
	 r2s4dGGRLTmdT8T+1sxyYXeYgzP7+/q0PVf7C9Ofp1jhTyvw51JgmYLRG5zhon0dqpPUA
	 rb6pq5B9CwOFjA7TpQq/sP5WwMAkU+VaZ+z73tMiMvyQH5ifWCIsxI6yiU1afSvCodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789449;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DFaOsy9QYnymomkKV/m7NOnqcV+r25MPwpui3EHYmfI=;
	b=IcC7fCE0HPymtWKx1ChUyLua7l/b9/xPticNTV4aaYNtd4shQNQBfDjNnX/tAQbqK6+b
	 phtQDdZtOhtvL/mRrDJ65aSxV0NTAkrSXKQZADFcJ0C0u1Is4nRyZpSPdzJJ/pRhTKN+K
	 vFgGOU3VJPqgiTlgeb+4VBMzaZPmHkyqbBEaiM4rkBZ2stFSxdVdRI1+Js5H7WJVZD11a
	 Ya18lHMhon9uxW7jxCveki9bwzdiIKYamUijske5CNrNL9mdv8xd9/h/98Wq7ZcyA1ZSZ
	 3CyYc5mEyVVdnjp5g6VHuDwclAEXSZPFaCyr13WPe2rXOGFVdwTnSkpeewGQRkmEyIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTxO4pKO;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD660A2612;
	Fri, 27 Nov 2026 14:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ADD660A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTxO4pKO
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4ssg3266868;
	Fri, 27 Nov 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DFaOsy
	9QYnymomkKV/m7NOnqcV+r25MPwpui3EHYmfI=; b=TTxO4pKO2m7gxyFlzs4Q7n
	wJZvkKz47KJqzhNgiqreS7c8VmEGnFA1WTZXkifxdVeJ6F8jpuUZkiPiz1aM17z2
	LLd3sIxArzlApIVuMo5QhxKwYq7n5ym2nX9g6Hbm4OgdwkWxdzOTLo48grrcHOa8
	IcinFQzMJb9DKQzHKGqXWuDzzlutSiVMf76TV2GrO7sA9/r4sFX5XBFhL/yZYpua
	I+sF1JNE3Z/Uk6RmWnYSS2NXCKvX47HqlBZmY2luVcXWV/zKgWaA1Q3gWyi/dMDW
	/oczr9ZFgeWWRWyyyGh/cHuNmJUPk4FVCfuitxH8t7RYeNzWQew4zu8VOOpyJSsw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkx6tc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4H6h3245407;
	Fri, 27 Nov 2026 14:23:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx9516-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENOsZ25232006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D9520043;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A5582006A;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:24 +0100
Subject: [PATCH v4 21/25] KVM: s390: arm64: Implement exception injection
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
Message-Id: <20261127-sysreg-v4-21-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX9vCZNNNe2QeO
 fjDOhAVxhT3nFPL5E95XZyckvF+ZbwTmtMk50lnBrQd5yIAgw5Jg5gvEh8vMTgsKcmjNS+hQ04Y
 VOhljmbSap0hFEjtsiwQfTOy/JAMliGI3MbHtN9sPAKC10ZFodSB7ADcNw9n57AnfBL4zZb6HuT
 sCWm6ZZWyWm+UJPAh/8kw9G1nlls1IbkgJ6mos1KoRAPTG/aq8SaxFi6SZ5d9SChwDTnYq596ej
 j5Xyt3tIHykI64o2mg2Ci8eQJzHwkO1H9dldohk/58pgMXm7Yj7BZcXkTQWNhkBgiMebkuDQZdF
 YEDe7kKDUqSFSADztht57sMfsYqsaYk18PpirGnotPa12ZlvHte4+KnurDDzCRDAdT+shYkdiVD
 S4d3qrC5rfuowe6fwybG6JM9nAKySz0w1v+6uNimeQ/ajjCZjKWB5JQMZKvU7igW2Gld7T4B0gS
 XEuP/EG8Ll2sUsjt4xg==
X-Proofpoint-ORIG-GUID: R5khA13BXlDDbI5zkJ1Y7UEXSeYlMT0F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfXxFewFMefFoyX
 ZbnlEQ8qUU8KMiac7DTtYvMaHsM0KasCUltXlON1ES3EXk0YelEuGH2/phooIjheXLpL3kbKpzw
 zuLYOwevvTAa3cufatvex8gU4j5hXpc=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b099261 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=W5TDu8ZgCn-YWPwT9wYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R5khA13BXlDDbI5zkJ1Y7UEXSeYlMT0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Add exception injection support for s390 KVM arm64 architecture. This
implements the core exception entry mechanism and fault injection
functions needed for proper guest exception handling.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |   1 +
 arch/s390/kvm/arm64/Makefile           |   1 +
 arch/s390/kvm/arm64/arm.c              |  15 ++---
 arch/s390/kvm/arm64/exception.c        | 109 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/inject_fault.c     |  65 +++++++++++++++++++-
 5 files changed, 178 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index a06472f4f3fb..a3874288a151 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -427,5 +427,6 @@ static inline bool vgic_host_has_gicv5(void)
 }
 
 size_t kvm_parange_to_address_sanitized(u32 id_parange);
+void kvm_adjust_pc(struct kvm_vcpu *vcpu);
 
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
index 8d3006837af5..d6bfb29c8186 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -396,14 +396,6 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
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
@@ -494,7 +486,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		trace_kvm_entry(*vcpu_pc(vcpu));
 
-		adjust_pc(vcpu);
+		kvm_adjust_pc(vcpu);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_el2, SYS_HCR_EL2);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_el2, SYS_HCRX_EL2);
 		vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2);
@@ -517,8 +509,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
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
2.56.1

