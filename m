Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F030E0FD;
	Thu,  2 Apr 2026 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103722; cv=none; b=kukOFyyAv9lxL9eZAyvShwOsKvBRFoFMZ+nfdBmJ+r5qzOi5cTqcFFfWvYrhJPZK2/Gk8d6kZeTT9RHj1NMLW1ZAdMMcX5kUowMtk0JY2+dPzF85mO7MKfSq7ixuqiDFpFShXN/s0ifMniAMxBwNCS4ysGbNCrLVDv/ZdmJEZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103722; c=relaxed/simple;
	bh=IBvtlN0qyiCljte1NILbypJ4Exyz9YJJDId4fkpibXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIiIZrNRdXP9ltsn01FcGWMgAt0ZLJjXgbXRBhYgOA5CeemWy7vk4qlyRyaAoUvAlm4QAJHqw1ANQQPgWC9/76/HUVs0TLpXjpAvHb4zQ4wr9s9Fp7Vj1SlEIh6+wV6DMgg+OU/CNQX6ItvSkrGYTuKq6sLvfE/81OslfYJPWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rcge2bv4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rcge2bv4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631HOhXE3104683;
	Thu, 2 Apr 2026 04:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KvR1duYgwzCYShjPY
	6nLudPK9qJc9NfwU5yBxRM7qFo=; b=Rcge2bv4xD6UObBgoMWeKMRt+AwFJxIE0
	hQlFWbO/ZCr6zyaK4HpwTCJiou/99AASNm6V/7nYgeEzowochUrZk+bSi/6CanPc
	weNs2z7h7ZQQVMVjnYLrakW77QpyaqhPLf54t/N+o08qezw9BwhgVcX2Ug1VFLBc
	QJ6kk2y3eRyGQ6LS/ERPidvcbkFTlzkcJp7SPt7wOoSZDeoGYBEHRgBjUBd4Vxcv
	vwC3/UFtyoALLxQMgtS2W7qBP3O+ZucXRuzuJgdl3SEhspci7DBQ7/tJvt9ghpYN
	8z2OwcpfCOXyqQQjPAUrDUbe+kuwOiHs0iNJzcOrHn8wcUp2zh8ww==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcjecw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63211nx0013898;
	Thu, 2 Apr 2026 04:21:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkrhet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LUtB30933456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5FAF20043;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 643E02004E;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 12/27] KVM: arm64: Share reset general register code
Date: Thu,  2 Apr 2026 06:21:08 +0200
Message-ID: <20260402042125.3948963-13-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cdeecf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lpgxcksCC1xG6NCAB4wA:9
X-Proofpoint-GUID: RgA0Z6hmtnB9HZt9hl3JiMJWbrEk8gmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX+iGHqyHUSmfs
 vMLEr39H1yxd49jlFzbgVUC5jFamDN1TLGaCMl7lEB0rImHznChR3NJtcLTPN/d5dYjStjjCyyv
 cRNjsNmewmRwGfJQ6uaq+uOURzHKGCXxkiIvw6IRhMeSsB7VgQJQNd487Ad4QdUiXmvUdNg7IOG
 24XWZYONsVdB4Nbl9jpH8WYu6EBGY9CPeDFVTbAbf+ZgSnqJY4dV8BfTuMnepl4xjg8Mw1LPhwh
 GzoYrvz7wYxm7Cu9bZ8jmfU5/SEeLjoRzVtkAZd3Cfo7n+BprQVVUJmW8yBuJCe3Ix1C/+mqyNj
 Bb3+6mb9p7xwOd7cjNFAcqoNBOq+BzBhqV0gr00J1UWF2jfow5Lowd5uJx1vf/IV00Nb7QmVZJd
 5bjmwcMw2rGjrlBQLArEZvIRCxdg4CGUkEWWNkrESCnkzQNlEOti8pwWyibL22ipv+7p+gXKxGy
 sKxCnor5KsYV/a+DnVw==
X-Proofpoint-ORIG-GUID: RgA0Z6hmtnB9HZt9hl3JiMJWbrEk8gmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Move code and required definitions to reset general registers into the
shared location. Additionally, add defines to arch/arm64 such that
accessing general registers becomes architecture agnostic.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h | 97 +++++--------------------------
 arch/arm64/kvm/reset.c            | 33 +----------
 include/kvm/arm64/kvm_host.h      | 82 ++++++++++++++++++++++++++
 include/kvm/arm64/reset.h         |  8 +++
 virt/kvm/arm64/Makefile.kvm       |  1 +
 virt/kvm/arm64/guest.c            |  8 +--
 virt/kvm/arm64/reset.c            | 42 +++++++++++++
 7 files changed, 154 insertions(+), 117 deletions(-)
 create mode 100644 include/kvm/arm64/reset.h
 create mode 100644 virt/kvm/arm64/reset.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7e473b895740..e3a2ac3979ac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -877,39 +877,6 @@ struct kvm_vcpu_arch {
 	struct vncr_tlb	*vncr_tlb;
 };
 
-/*
- * Each 'flag' is composed of a comma-separated triplet:
- *
- * - the flag-set it belongs to in the vcpu->arch structure
- * - the value for that flag
- * - the mask for that flag
- *
- *  __vcpu_single_flag() builds such a triplet for a single-bit flag.
- * unpack_vcpu_flag() extract the flag value from the triplet for
- * direct use outside of the flag accessors.
- */
-#define __vcpu_single_flag(_set, _f)	_set, (_f), (_f)
-
-#define __unpack_flag(_set, _f, _m)	_f
-#define unpack_vcpu_flag(...)		__unpack_flag(__VA_ARGS__)
-
-#define __build_check_flag(v, flagset, f, m)			\
-	do {							\
-		typeof(v->arch.flagset) *_fset;			\
-								\
-		/* Check that the flags fit in the mask */	\
-		BUILD_BUG_ON(HWEIGHT(m) != HWEIGHT((f) | (m)));	\
-		/* Check that the flags fit in the type */	\
-		BUILD_BUG_ON((sizeof(*_fset) * 8) <= __fls(m));	\
-	} while (0)
-
-#define __vcpu_get_flag(v, flagset, f, m)			\
-	({							\
-		__build_check_flag(v, flagset, f, m);		\
-								\
-		READ_ONCE(v->arch.flagset) & (m);		\
-	})
-
 /*
  * Note that the set/clear accessors must be preempt-safe in order to
  * avoid nesting them with load/put which also manipulate flags...
@@ -923,54 +890,14 @@ struct kvm_vcpu_arch {
 #define __vcpu_flags_preempt_enable()	preempt_enable()
 #endif
 
-#define __vcpu_set_flag(v, flagset, f, m)			\
-	do {							\
-		typeof(v->arch.flagset) *fset;			\
-								\
-		__build_check_flag(v, flagset, f, m);		\
-								\
-		fset = &v->arch.flagset;			\
-		__vcpu_flags_preempt_disable();			\
-		if (HWEIGHT(m) > 1)				\
-			*fset &= ~(m);				\
-		*fset |= (f);					\
-		__vcpu_flags_preempt_enable();			\
-	} while (0)
-
-#define __vcpu_clear_flag(v, flagset, f, m)			\
-	do {							\
-		typeof(v->arch.flagset) *fset;			\
-								\
-		__build_check_flag(v, flagset, f, m);		\
-								\
-		fset = &v->arch.flagset;			\
-		__vcpu_flags_preempt_disable();			\
-		*fset &= ~(m);					\
-		__vcpu_flags_preempt_enable();			\
-	} while (0)
-
-#define __vcpu_test_and_clear_flag(v, flagset, f, m)		\
-	({							\
-		typeof(v->arch.flagset) set;			\
-								\
-		set = __vcpu_get_flag(v, flagset, f, m);	\
-		__vcpu_clear_flag(v, flagset, f, m);		\
-								\
-		set;						\
-	})
-
-#define vcpu_get_flag(v, ...)	__vcpu_get_flag((v), __VA_ARGS__)
-#define vcpu_set_flag(v, ...)	__vcpu_set_flag((v), __VA_ARGS__)
-#define vcpu_clear_flag(v, ...)	__vcpu_clear_flag((v), __VA_ARGS__)
-#define vcpu_test_and_clear_flag(v, ...)			\
-	__vcpu_test_and_clear_flag((v), __VA_ARGS__)
-
-/* KVM_ARM_VCPU_INIT completed */
-#define VCPU_INITIALIZED	__vcpu_single_flag(cflags, BIT(0))
-/* SVE config completed */
-#define VCPU_SVE_FINALIZED	__vcpu_single_flag(cflags, BIT(1))
-/* pKVM VCPU setup completed */
-#define VCPU_PKVM_FINALIZED	__vcpu_single_flag(cflags, BIT(2))
+#define _vcpu_get_flag(v, flagset, ...)	\
+	__vcpu_get_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_set_flag(v, flagset, ...)	\
+	__vcpu_set_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_clear_flag(v, flagset, ...)	\
+	__vcpu_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_test_and_clear_flag(v, flagset, ...)	\
+	__vcpu_test_and_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
 
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(0))
@@ -1081,6 +1008,12 @@ static inline u64 *___ctxt_sys_reg(const struct kvm_cpu_context *ctxt, int r)
 
 #define ctxt_sys_reg(c,r)	(*__ctxt_sys_reg(c,r))
 
+#define kvm_vcpu_get_sp_el1(__vcpu) (__ctxt_sys_reg(&(__vcpu)->arch.ctxt, SP_EL1))
+#define kvm_vcpu_get_vreg(__vcpu, _n) (&(__vcpu)->arch.ctxt.fp_regs.vregs[_n])
+#define kvm_vcpu_get_vregs(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.vregs)
+#define kvm_vcpu_get_fpsr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpsr)
+#define kvm_vcpu_get_fpcr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpcr)
+
 u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
 
 #define __vcpu_assign_sys_reg(v, r, val)				\
@@ -1413,8 +1346,6 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 #define kvm_vcpu_has_feature(k, f)	__vcpu_has_feature(&(k)->arch, (f))
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
-#define kvm_vcpu_initialized(v) vcpu_get_flag(vcpu, VCPU_INITIALIZED)
-
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index d039f1d7116a..b4f579df0beb 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -30,22 +30,11 @@
 #include <asm/kvm_nested.h>
 #include <asm/virt.h>
 
+#include <kvm/arm64/reset.h>
+
 /* Maximum phys_shift supported for any VM on this host */
 static u32 __ro_after_init kvm_ipa_limit;
 unsigned int __ro_after_init kvm_host_sve_max_vl;
-
-/*
- * ARMv8 Reset Values
- */
-#define VCPU_RESET_PSTATE_EL1	(PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | \
-				 PSR_F_BIT | PSR_D_BIT)
-
-#define VCPU_RESET_PSTATE_EL2	(PSR_MODE_EL2h | PSR_A_BIT | PSR_I_BIT | \
-				 PSR_F_BIT | PSR_D_BIT)
-
-#define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
-				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
-
 unsigned int __ro_after_init kvm_sve_max_vl;
 
 int __init kvm_arm_init_sve(void)
@@ -191,7 +180,6 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_reset_state reset_state;
 	bool loaded;
-	u32 pstate;
 
 	spin_lock(&vcpu->arch.mp_state_lock);
 	reset_state = vcpu->arch.reset_state;
@@ -210,22 +198,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		kvm_vcpu_reset_sve(vcpu);
 	}
 
-	if (vcpu_el1_is_32bit(vcpu))
-		pstate = VCPU_RESET_PSTATE_SVC;
-	else if (vcpu_has_nv(vcpu))
-		pstate = VCPU_RESET_PSTATE_EL2;
-	else
-		pstate = VCPU_RESET_PSTATE_EL1;
-
-	/* Reset core registers */
-	memset(vcpu_gp_regs(vcpu), 0, sizeof(*vcpu_gp_regs(vcpu)));
-	*vcpu_pc(vcpu) = 0;
-	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
-	vcpu->arch.ctxt.spsr_abt = 0;
-	vcpu->arch.ctxt.spsr_und = 0;
-	vcpu->arch.ctxt.spsr_irq = 0;
-	vcpu->arch.ctxt.spsr_fiq = 0;
-	*vcpu_cpsr(vcpu) = pstate;
+	kvm_reset_vcpu_core_regs(vcpu);
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index 21117e4fd546..20b824ecf16e 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -41,6 +41,86 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
+/*
+ * Each 'flag' is composed of a comma-separated triplet:
+ *
+ * - the flag-set it belongs to in the vcpu->arch structure
+ * - the value for that flag
+ * - the mask for that flag
+ *
+ *  __vcpu_single_flag() builds such a triplet for a single-bit flag.
+ * unpack_vcpu_flag() extract the flag value from the triplet for
+ * direct use outside of the flag accessors.
+ */
+#define __vcpu_single_flag(_set, _f)	_set, (_f), (_f)
+
+#define __unpack_flag(_set, _f, _m)	_f
+#define unpack_vcpu_flag(...)		__unpack_flag(__VA_ARGS__)
+
+#define __build_check_flag(flagset, f, m)				\
+	do {								\
+		/* Check that the flags fit in the mask */		\
+		BUILD_BUG_ON(HWEIGHT(m) != HWEIGHT((f) | (m)));		\
+		/* Check that the flags fit in the type */		\
+		BUILD_BUG_ON((sizeof(*(flagset)) * 8) <= __fls(m));	\
+	} while (0)
+
+#define __vcpu_get_flag(flagset, f, m)				\
+	({							\
+		__build_check_flag((flagset), f, m);		\
+								\
+		READ_ONCE(*(flagset)) & (m);			\
+	})
+
+#define __vcpu_set_flag(flagset, f, m)				\
+	do {							\
+		typeof(*flagset) *fset;				\
+								\
+		__build_check_flag((flagset), f, m);		\
+								\
+		fset = (flagset);				\
+		__vcpu_flags_preempt_disable();			\
+		if (HWEIGHT(m) > 1)				\
+			*fset &= ~(m);				\
+		*fset |= (f);					\
+		__vcpu_flags_preempt_enable();			\
+	} while (0)
+
+#define __vcpu_clear_flag(flagset, f, m)			\
+	do {							\
+		typeof(*flagset) *fset;				\
+								\
+		__build_check_flag(flagset, f, m);		\
+								\
+		fset = (flagset);				\
+		__vcpu_flags_preempt_disable();			\
+		*fset &= ~(m);					\
+		__vcpu_flags_preempt_enable();			\
+	} while (0)
+
+#define __vcpu_test_and_clear_flag(flagset, f, m)		\
+	({							\
+		typeof(*flagset) set;				\
+								\
+		set = __vcpu_get_flag((flagset), f, m);		\
+		__vcpu_clear_flag((flagset), f, m);		\
+								\
+		set;						\
+	})
+
+#define vcpu_get_flag(v,  ...)	_vcpu_get_flag((v), __VA_ARGS__)
+#define vcpu_set_flag(v, ...)	_vcpu_set_flag((v), __VA_ARGS__)
+#define vcpu_clear_flag(v, ...)	_vcpu_clear_flag((v), __VA_ARGS__)
+#define vcpu_test_and_clear_flag(v, ...)	\
+	_vcpu_test_and_clear_flag((v), __VA_ARGS__)
+
+/* KVM_ARM_VCPU_INIT completed */
+#define VCPU_INITIALIZED	__vcpu_single_flag(cflags, BIT(0))
+/* SVE config completed */
+#define VCPU_SVE_FINALIZED	__vcpu_single_flag(cflags, BIT(1))
+/* pKVM VCPU setup completed */
+#define VCPU_PKVM_FINALIZED	__vcpu_single_flag(cflags, BIT(2))
+
 /* Exception pending */
 #define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
 /*
@@ -76,6 +156,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 #define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
 #define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 
+#define kvm_vcpu_initialized(v) vcpu_get_flag(v, VCPU_INITIALIZED)
+
 static inline bool kvm_supports_32bit_el0(void)
 {
 	return false;
diff --git a/include/kvm/arm64/reset.h b/include/kvm/arm64/reset.h
new file mode 100644
index 000000000000..a0bca4769b13
--- /dev/null
+++ b/include/kvm/arm64/reset.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_ARM64_RESET_H__
+#define __KVM_ARM64_RESET_H__
+
+void kvm_reset_vcpu_core_regs(struct kvm_vcpu *vcpu);
+
+#endif /* __KVM_ARM64_RESET_H__ */
diff --git a/virt/kvm/arm64/Makefile.kvm b/virt/kvm/arm64/Makefile.kvm
index ac969bf1c016..c5e1db570a09 100644
--- a/virt/kvm/arm64/Makefile.kvm
+++ b/virt/kvm/arm64/Makefile.kvm
@@ -9,4 +9,5 @@ shared-arm64-obj := \
 	$(KVM_ARM64)/guest.o \
 	$(KVM_ARM64)/handle_exit.o \
 	$(KVM_ARM64)/mmio.o \
+	$(KVM_ARM64)/reset.o \
 
diff --git a/virt/kvm/arm64/guest.c b/virt/kvm/arm64/guest.c
index e283a4456df8..35ba03033b4c 100644
--- a/virt/kvm/arm64/guest.c
+++ b/virt/kvm/arm64/guest.c
@@ -93,7 +93,7 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return vcpu_cpsr(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(sp_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+		return kvm_vcpu_get_sp_el1(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(elr_el1):
 		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
@@ -117,13 +117,13 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
 		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
 		off /= 4;
-		return &vcpu->arch.ctxt.fp_regs.vregs[off];
+		return kvm_vcpu_get_vreg(vcpu, off);
 
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-		return &vcpu->arch.ctxt.fp_regs.fpsr;
+		return  kvm_vcpu_get_fpsr(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		return &vcpu->arch.ctxt.fp_regs.fpcr;
+		return  kvm_vcpu_get_fpcr(vcpu);
 
 	default:
 		return NULL;
diff --git a/virt/kvm/arm64/reset.c b/virt/kvm/arm64/reset.c
new file mode 100644
index 000000000000..5a8be5233f76
--- /dev/null
+++ b/virt/kvm/arm64/reset.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm_host.h>
+#include <asm/pstate.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_nested.h>
+#include <kvm/arm64/reset.h>
+
+/*
+ * ARMv8 Reset Values
+ */
+#define VCPU_RESET_PSTATE_EL1	(PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | \
+				 PSR_F_BIT | PSR_D_BIT)
+
+#define VCPU_RESET_PSTATE_EL2	(PSR_MODE_EL2h | PSR_A_BIT | PSR_I_BIT | \
+				 PSR_F_BIT | PSR_D_BIT)
+
+#define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
+				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
+
+void kvm_reset_vcpu_core_regs(struct kvm_vcpu *vcpu)
+{
+	u64 pstate;
+
+	if (vcpu_el1_is_32bit(vcpu))
+		pstate = VCPU_RESET_PSTATE_SVC;
+	else if (vcpu_has_nv(vcpu))
+		pstate = VCPU_RESET_PSTATE_EL2;
+	else
+		pstate = VCPU_RESET_PSTATE_EL1;
+
+	/* Reset core registers */
+	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
+	*vcpu_pc(vcpu) = 0;
+	memset(kvm_vcpu_get_vregs(vcpu), 0, sizeof(*kvm_vcpu_get_vregs(vcpu)));
+	memset(kvm_vcpu_get_fpsr(vcpu), 0, sizeof(*kvm_vcpu_get_fpsr(vcpu)));
+	memset(kvm_vcpu_get_fpcr(vcpu), 0, sizeof(*kvm_vcpu_get_fpcr(vcpu)));
+	vcpu->arch.ctxt.spsr_abt = 0;
+	vcpu->arch.ctxt.spsr_und = 0;
+	vcpu->arch.ctxt.spsr_irq = 0;
+	vcpu->arch.ctxt.spsr_fiq = 0;
+	*vcpu_cpsr(vcpu) = pstate;
+}
-- 
2.51.0

