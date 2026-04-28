Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C33F2117;
	Tue, 28 Apr 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391825; cv=none; b=QwzWQsaqje2lU6bC5xUWy4HtfU0660qwZJxasO3exO5zqlvaMQe+63dMLD4X4ky28kPdzAVtCYARwPbYDiv0L0mWi8hOZUshEHqrZwJLhiO8xG/SwKUJyr3asjkSJlrqklEOc0Kp43FegxZeB0sZ2lubWdzRe2iRyWSCCa8cf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391825; c=relaxed/simple;
	bh=k4qrFjAb3Euu7Na+K737xBB3Ph8bk+GHcmCeNUP4GxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By3rpIny9h2/d6MteLX9LQYmvxLUKBX3BpiQTRnFalMmoKzL+Wz4ak5nDLCl5r73TQaUwTLWxI8NRwcI6JeC4xE7wZ8qXv0WbxKLE0ryW8j/SCQvv9XwZu7GJbK9ffVy68fDf7za1eWgDHDDGX67IgAp11YirWeDFGZP3WuzSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oKC8S1+2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oKC8S1+2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S42EnJ2819432;
	Tue, 28 Apr 2026 15:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hUFiRfjOeIzSdUBN3
	6ih9mE/1om4IWgb3WYfSKb+sBw=; b=oKC8S1+2taEDrBwQ6Mxk60/rd1Zs7w1gr
	PbZZMSI3G136g/6pwjSlTX7hMvU/s2B7uPTij+wbP2+YhmoXjIhyOGWEI16Dg5cc
	Y3/o7hQzka177YykQcW7iokYV8bDx7HO/I5dTPNLvB9D7eKV0B+aUifLiVUduLD5
	lzXHOwKDFlo1kI4pE5EeCtfPj5mVIUrDCC81xH6H9UbqaB5tPJF/0t2+Ez6P1hiI
	aZj6XeVKNC5hrtT+ykN26efLPFhzKp1H4Bkxv8X7JdH34syQ17c6GY5iF+EhWsMz
	cbk1kzv62+uaXceFI5kmkwZgShy9GR6kPDK4M0JMdcFYkhBlzdipg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6c99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrq4S001945;
	Tue, 28 Apr 2026 15:56:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga83u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuRcJ16712106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B296520040;
	Tue, 28 Apr 2026 15:56:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60AD620043;
	Tue, 28 Apr 2026 15:56:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:27 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v2 12/28] KVM: arm64: Share reset general register code
Date: Tue, 28 Apr 2026 17:56:04 +0200
Message-ID: <20260428155622.1361364-13-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6wNOxgP5a7ZGCE_iq3Zl6rVP-pTTi3CC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX27tiLUZy2aJP
 zoyczIIC+7skkFxTQTIHvPDb4LxL8NhuemQE5WoRoImz8W5J/RBCqFBRQrs4a2RYPa9FY9adyOE
 mkZRGRAmcMAVWtCe4dnQ0C61PbF/EzL7OIPT/rcao7Hkjv5tLJIylep1NVcOPC6go74NAmZKm0j
 DP7Cm3tYbjfTM6WNoHWxEAGtm4Mw/7YaCtbZWpLD1STB0MvXw8XFXT9jS+h9INKbDDWConelqLZ
 wOoNgj/nDAjE1wwIZTmSJR3cO+Q/VJbBp4lo9JrAoptUAT1G45S5+RxJW3V04N0PTXLA7pHxyLY
 eau4/9OViaEV89jw/n+fFjsQgWghOXJ9Nv7j8SyAd7jeA5eepV5DVbkNtRcMg+ONTf2PX61gRMP
 RdRTaz8V6aQPmL6Cl59DB17JiUBvPTDCMcJKuRfdSskrVdtMjMO8TqaxHWr1jURnYOc9qGCiHXL
 wSrOnHT8KQ8Mdeh/GwA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0d8b0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lpgxcksCC1xG6NCAB4wA:9
X-Proofpoint-ORIG-GUID: 6wNOxgP5a7ZGCE_iq3Zl6rVP-pTTi3CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Move code and required definitions to reset general registers into the
shared location. Additionally, add defines to arch/arm64 such that
accessing general registers becomes architecture agnostic.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h | 97 +++++--------------------------
 arch/arm64/kvm/reset.c            | 34 +----------
 include/kvm/arm64/kvm_host.h      | 82 ++++++++++++++++++++++++++
 include/kvm/arm64/reset.h         |  8 +++
 virt/kvm/arm64/Makefile.kvm       |  1 +
 virt/kvm/arm64/guest.c            |  8 +--
 virt/kvm/arm64/reset.c            | 43 ++++++++++++++
 7 files changed, 155 insertions(+), 118 deletions(-)
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
index e952dec01d74..b4f579df0beb 100644
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
@@ -210,23 +198,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
-	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
-	*vcpu_pc(vcpu) = 0;
-	*vcpu_sp_el0(vcpu) = 0;
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
index d1eccbe44c50..d36ebea4d60f 100644
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
 #define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
 
 /*
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
index 000000000000..257f28373566
--- /dev/null
+++ b/virt/kvm/arm64/reset.c
@@ -0,0 +1,43 @@
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
+	*vcpu_sp_el0(vcpu) = 0;
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

