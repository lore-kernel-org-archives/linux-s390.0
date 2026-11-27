Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789463;
	b=Iz/QlY+Y1wORHIaTITdYUq8jXbCoZD8c6o80JJy53DQYGmzGyFVH8cNyK9+SUvamq+jJ
	 lNkt1V75FhDL02ATuRlwFiwQU2OXJ0EWKAmxv3pDXOev3dC7OvCKdmCrb6qocjhJnsiZt
	 3vI0Zlk1uKva+5qWj9yriToxRDAQ9L3ExV+lbUqQsMI23oHea6CSYK85gIVDIcUnrsbLz
	 cqfAin8OOcazCMEcpaqylRrjEJi5TD5Q5/nOb5vjhTI1gpQy6AjgOboBQGK48Xv+6MueK
	 SynDjgX01q+xMBAYmBffEGq/k0X3QdhjekSGWayyw0xB1AhBQ5/yQHhVT/8HCSyfSkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789463;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Zz4xWtI9vVSUQVx48zTuDenwYcnh+LkrBlA+b384qak=;
	b=BUhXfH6bbiLAJEMPI37qJcVMRG8IP/yOpzMAS1AOkTVV9Nc0xsENArmR8R/pgQjAqamB
	 x3qwDfhQbYHlLy18ks+pbgdXDI2lyyGsebDlhz/7HlK8Yonr1bj46SU1qqwQlHe1/jmQM
	 Ppe+ZLbHevOzp11VsY7Re98NoPmjFNs8AuHHqjZgd9YURfFWmyoGmjeaiWIAe0NAEVJkg
	 8pNExus6+teZnGUHohwtrHPNg70pyywfldrp7HWuaWdaCLz3inU1jqTl146S85MfAz7UU
	 9EqY4VxcyeB3s3+Pg8z5YRV8cWDAUXKCkxiIRoEeZBFtvcxOg9IEh60pOB/RIUATLjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rmvSJeNC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC66070F54;
	Fri, 27 Nov 2026 14:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EC66070F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rmvSJeNC
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4wVr3419817;
	Fri, 27 Nov 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zz4xWt
	I9vVSUQVx48zTuDenwYcnh+LkrBlA+b384qak=; b=rmvSJeNC+Cn8vQo60l73w5
	BjtIagbd9Je+6j7SII4C5sCl31jsOLpK7gVNbk+AV8Cpn+RdbuTUIAMDrvPq2Kjg
	+6MWqhDsLY39jakGwqn2LGNQ/6dL80NSZFSu5HdbX98GLePJMiHkRvZPYCb4mAbz
	qCNdt1+AoVv3iqTangtRZpp3IbqBNMks/O1F03RpF5yDSI62dlimQjeaEHCqH132
	djJoxFpGOdZwmTB1Aihs9/cNs6wvqETsb63/E1mSBRT9TAlBUZkbWkNt6alKAl25
	LlLwlatAY89bvBdUBPeAd4mNLN0GXbztNNUu1oTzI0czWYeP0M8gBoiUj4s0jDpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fap8ma-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4IUs2819277;
	Fri, 27 Nov 2026 14:23:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaahku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENPPo37880106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77DC82004E;
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3F822006C;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:26 +0100
Subject: [PATCH v4 23/25] KVM: s390: arm64: Implement SVE for arm guests
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
Message-Id: <20261127-sysreg-v4-23-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX8IaBewKar55V
 9Fhaws3ojIaTBvMVHi2L3ZjNeyf647J5Fe/GvoYjC+oiipB3rJ/cthzNnNuQ+PtFdCZlMZBhCgE
 oLSrLtqAMQ3azvEYBzVE7k7puufPZCx71Sy0wtkiB7w/mI77sDRwZh64yWqPSG57OFFdArlj75/
 kBPhHioLU0Fe+izKX9TFuFI4fd6qt10xqG0hU0ldLuJee7ia40UEnvTQYTlDg7NSI4duDBdnRT6
 vuLgAQxDh32EUL1kfvnet+pEKk4j5caGd04QKvoHqTZmhI3wUq0by9svvyTfE/Z0Jax5cAME+mb
 CClwcEYdPOAzCKykW0H3IuPEiaLwlW93xQDffxZh78yLlTgtBBNuW3Tawxk+sxtvWpWpk9Y1xbD
 Of0vFbIIWe43savnmz8Vnpsjax3VPQi4EG6Y2qxTD/52dz9pUQcEIO2AKX7lHLqcxw2a1bHuLHU
 +92KNS4OGrt5nyXSIHQ==
X-Proofpoint-ORIG-GUID: QoMiXpm52ieS_1F44DlO7m_zmBm8zuyr
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b099262 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=E2f1HnvsrPvGzuHPg88A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QoMiXpm52ieS_1F44DlO7m_zmBm8zuyr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX2kJdilavIQ8/
 u0+BreUV4zHKsRWdNWL7/YUq+c6IhOZohDgiWpPCiY8nwzx4bRNv+kbFR6DSzrN/va6czaAFjT9
 zgwrMq7LFDnsnxL3PPAWQLtMCQ/RS+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270056

From: Friedrich Welter <fritz@linux.ibm.com>

Add support for Scalable Vector Extension (SVE) in ARM64 guests running
on s390 hardware, providing 128-bit vector operations backed by s390's
Vector Extension (VX).

The implementation is limited to 128-bit vectors (VQ=1) matching s390 VX
register width. Z registers reuse existing FP/SIMD register space (vregs),
while P registers and FFR are stored in the SAE block.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Friedrich Welter <fritz@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |   5 +-
 arch/s390/kvm/arm64/arm.c              |   6 +
 arch/s390/kvm/arm64/feature.c          |   9 +-
 arch/s390/kvm/arm64/feature.h          |   6 +
 arch/s390/kvm/arm64/guest.c            | 250 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/reset.c            |  24 ++++
 6 files changed, 297 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index a3874288a151..d09ed3a211f3 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -34,7 +34,9 @@ bool cpus_have_final_cap(unsigned int num);
 #define KVM_MAX_VCPUS 1
 #define __KVM_HAVE_VCPU_RUN_PID_CHANGE
 
-#define KVM_S390_ARM64_IMPL_FEATURES 0
+#define KVM_S390_ARM64_IMPL_FEATURES (		\
+	 BIT(KVM_ARM_VCPU_SVE)			\
+)
 #define KVM_HALT_POLL_NS_DEFAULT 50000
 
 #define KVM_S390_MANAGES_S390_GUEST 0
@@ -130,7 +132,6 @@ struct kvm_vcpu_stat {
 };
 
 #define kvm_has_mte(_kvm) false
-#define vcpu_has_sve(_vcpu) false
 #define vcpu_has_ptrauth(_vcpu) false
 
 #define kvm_has_fpmr(kvm) \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 899a897c5486..b06c101ef6a9 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -54,6 +54,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ONE_REG:
 		ret = 1;
 		break;
+	case KVM_CAP_ARM_SVE:
+		ret = system_supports_sve();
+		break;
 	default:
 		ret = 0;
 	}
@@ -264,6 +267,9 @@ static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu)
 {
 	unsigned long features = KVM_S390_ARM64_IMPL_FEATURES;
 
+	if (!system_supports_sve())
+		clear_bit(KVM_ARM_VCPU_SVE, &features);
+
 	return features;
 }
 
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
index 8fd278ace942..fc5b159a94b3 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -56,7 +56,6 @@ void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc)
 	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR4_EL1);
 
 	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SEL2, NI);
-	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SVE, NI);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR0_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR1_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR2_EL1);
@@ -151,3 +150,11 @@ bool cpus_have_final_cap(unsigned int num)
 		return false;
 	}
 }
+
+bool system_supports_sve(void)
+{
+	return cpu_has_vx() &&
+	       SYS_FIELD_GET(ID_AA64PFR0_EL1, SVE,
+			     read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) ==
+		       ID_AA64PFR0_EL1_SVE_IMP;
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
index 7b0698cc5563..e6916d8064c3 100644
--- a/arch/s390/kvm/arm64/feature.h
+++ b/arch/s390/kvm/arm64/feature.h
@@ -83,4 +83,10 @@ static inline u64 kvm_sae_irptc(void)
 
 #define kvm_vcpu_has_pmu(_v) false
 
+#define vcpu_has_sve(_vcpu)							\
+	(system_supports_sve() &&						\
+	 test_bit(KVM_ARCH_FLAG_GUEST_HAS_SVE, &((_vcpu)->kvm)->arch.flags))
+
+bool system_supports_sve(void);
+
 #endif /* ARCH_S390_KVM_FEATURE_H */
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 047460975936..bdc489a7c7e9 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -5,6 +5,9 @@
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 #include <arm64/sys_regs.h>
+#include <arm64/sve_context.h>
+
+#include "feature.h"
 
 #define SVE_VQ_MIN	__SVE_VQ_MIN
 #define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
@@ -52,6 +55,243 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
+static int sve_zreg_index(__u64 id, unsigned int *regnum)
+{
+	/* Currently only one slice is supported on arm, and our zreg is only 128 bit */
+	const u64 zreg_id_max = KVM_REG_ARM64_SVE_ZREG(KVM_ARM64_SVE_NUM_ZREGS - 1,
+						       KVM_ARM64_SVE_MAX_SLICES - 1);
+	const u64 zreg_id_min = KVM_REG_ARM64_SVE_ZREG(0, 0);
+
+	if (id < zreg_id_min || id > zreg_id_max)
+		return -ENOENT;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static int sve_preg_index(u64 id, unsigned int *regnum)
+{
+	const u64 preg_id_max = KVM_REG_ARM64_SVE_FFR(KVM_ARM64_SVE_MAX_SLICES - 1);
+	const u64 preg_id_min = KVM_REG_ARM64_SVE_PREG(0, 0);
+
+	if (id < preg_id_min || id > preg_id_max)
+		return -ENOENT;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static int sve_ffr_index(u64 id, unsigned int *regnum)
+{
+	if (id != KVM_REG_ARM64_SVE_FFR(0))
+		return -ENOENT;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static inline int get_sve_ffr_reg(struct kvm_vcpu *vcpu, unsigned int regnum,
+				  u16 __user *uptr)
+{
+	/* ffr is pregmax + 1 */
+	if (regnum != KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (put_user(vcpu->arch.sae_block.sve_ffr, uptr))
+		return -EFAULT;
+	return sizeof(vcpu->arch.sae_block.sve_ffr);
+}
+
+static inline int get_sve_preg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       u16 __user *uptr)
+{
+	if (regnum >= KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (put_user(vcpu->arch.sae_block.sve_pregs[regnum], uptr))
+		return -EFAULT;
+	return sizeof(vcpu->arch.sae_block.sve_pregs[regnum]);
+}
+
+static inline int get_sve_zreg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       __vector128 __user *uptr)
+{
+	if (regnum >= KVM_ARM64_SVE_NUM_ZREGS)
+		return -EINVAL;
+
+	/* vreg and svreg overlap and zreg is also just 128 bit so we reuse the vreg space */
+	if (copy_to_user(uptr, &vcpu->arch.ctxt.vregs[regnum],
+			 sizeof(vcpu->arch.ctxt.vregs[regnum])))
+		return -EFAULT;
+	return sizeof(vcpu->arch.ctxt.vregs[regnum]);
+}
+
+static inline int set_sve_ffr_reg(struct kvm_vcpu *vcpu, unsigned int regnum,
+				  const u16 __user *uptr)
+{
+	/* ffr is pregmax + 1*/
+	if (regnum != KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (get_user(vcpu->arch.sae_block.sve_ffr, uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_sve_preg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       const u16 __user *uptr)
+{
+	if (regnum >= KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (get_user(vcpu->arch.sae_block.sve_pregs[regnum], uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_sve_zreg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       const __vector128 __user *uptr)
+{
+	if (regnum >= KVM_ARM64_SVE_NUM_ZREGS)
+		return -EINVAL;
+
+	/*vreg and svreg overlap and zreg is also just 128 bit so we reuse the vreg space*/
+	if (copy_from_user(&vcpu->arch.ctxt.vregs[regnum], uptr,
+			   sizeof(vcpu->arch.ctxt.vregs[regnum])))
+		return -EFAULT;
+	return 0;
+}
+
+static int set_sve_vls(struct kvm_vcpu *vcpu, const void __user *uptr)
+{
+	u64 vqs[KVM_ARM64_SVE_VLS_WORDS] = { 0 };
+	unsigned int vq;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	if (kvm_arm_vcpu_sve_finalized(vcpu))
+		return -EPERM;
+
+	if (copy_from_user(vqs, uptr, sizeof(vqs)))
+		return -EFAULT;
+
+	/* only 128 bit and 1 VQ are supported , nothing saved just check validity */
+	for (vq = KVM_ARM64_SVE_VQ_MIN + 1; vq <= KVM_ARM64_SVE_VQ_MAX; ++vq)
+		if (vq_present(vqs, vq))
+			return -EINVAL;
+
+	/* run with a vl of 0 not valid */
+	if (!vq_present(vqs, KVM_ARM64_SVE_VQ_MIN))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int get_sve_vls(struct kvm_vcpu *vcpu, void __user *uptr)
+{
+	u64 vqs[KVM_ARM64_SVE_VLS_WORDS] = { 0 };
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	/* currently only 128 bit are supported so we only set bit 0  hardcoded */
+	vqs[0] |= vq_mask(KVM_ARM64_SVE_VQ_MIN);
+
+	if (copy_to_user(uptr, vqs, sizeof(vqs)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sve_reg_index(u64 id, unsigned int *regnum)
+{
+	int ret;
+
+	ret = sve_ffr_index(id, regnum);
+	if (ret == -ENOENT)
+		ret = sve_preg_index(id, regnum);
+	if (ret == -ENOENT)
+		ret = sve_zreg_index(id, regnum);
+
+	return ret;
+}
+
+static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	void __user *uptr = (void __user *)reg->addr;
+	unsigned int regnum;
+	int size;
+	int ret;
+
+	if (reg->id == KVM_REG_ARM64_SVE_VLS)
+		return get_sve_vls(vcpu, uptr);
+
+	ret = sve_reg_index(reg->id, &regnum);
+	if (ret)
+		return ret;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	if (!kvm_arm_vcpu_sve_finalized(vcpu))
+		return -EPERM;
+
+	if (sve_ffr_index(reg->id, &regnum) == 0)
+		size = get_sve_ffr_reg(vcpu, regnum, uptr);
+	else if (sve_preg_index(reg->id, &regnum) == 0)
+		size = get_sve_preg(vcpu, regnum, uptr);
+	else
+		size = get_sve_zreg(vcpu, regnum, uptr);
+
+	if (size < 0)
+		return size;
+
+	/*
+	 * Only the low 128 bits of a Z register and the low 16 bits of a
+	 * P register or the FFR are live: zero-pad the rest.
+	 */
+	if (clear_user((u8 __user *)uptr + size, KVM_REG_SIZE(reg->id) - size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const void __user *uptr = (const void __user *)reg->addr;
+	unsigned int regnum;
+	int ret;
+
+	if (reg->id == KVM_REG_ARM64_SVE_VLS)
+		return set_sve_vls(vcpu, uptr);
+
+	ret = sve_reg_index(reg->id, &regnum);
+	if (ret)
+		return ret;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	if (!kvm_arm_vcpu_sve_finalized(vcpu))
+		return -EPERM;
+
+	if (sve_ffr_index(reg->id, &regnum) == 0)
+		return set_sve_ffr_reg(vcpu, regnum, uptr);
+	if (sve_preg_index(reg->id, &regnum) == 0)
+		return set_sve_preg(vcpu, regnum, uptr);
+	return set_sve_zreg(vcpu, regnum, uptr);
+}
+
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
 	int ret;
@@ -61,6 +301,11 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		return ret;
 	uindices += ret;
 
+	ret = copy_sve_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
 	return kvm_arm_copy_sys_reg_indices(vcpu, uindices);
 }
 
@@ -68,6 +313,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long num = num_core_regs(vcpu);
 
+	num += num_sve_regs(vcpu);
 	num += kvm_arm_num_sys_reg_descs(vcpu);
 	return num;
 }
@@ -81,6 +327,8 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:
 		return get_core_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:
+		return get_sve_reg(vcpu, reg);
 	default:
 		return kvm_arm_sys_reg_get_reg(vcpu, reg);
 	}
@@ -95,6 +343,8 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:
 		return set_core_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:
+		return set_sve_reg(vcpu, reg);
 	default:
 		return kvm_arm_sys_reg_set_reg(vcpu, reg);
 	}
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index b36f45f30b9b..2ae363f6821a 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -2,6 +2,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/fpu.h>
+#include <linux/cpufeature.h>
 
 #include <asm/aef.h>
 
@@ -12,8 +13,13 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#include "feature.h"
+
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
+	if (vcpu_has_sve(vcpu) && !kvm_arm_vcpu_sve_finalized(vcpu))
+		return false;
+
 	return true;
 }
 
@@ -77,6 +83,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	 */
 	preempt_disable();
 
+	if (!vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED)) {
+		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
+			set_bit(KVM_ARCH_FLAG_GUEST_HAS_SVE, &vcpu->kvm->arch.flags);
+	} else if (vcpu_has_sve(vcpu)) {
+		memset(vcpu->arch.sae_block.sve_pregs, 0, sizeof(vcpu->arch.sae_block.sve_pregs));
+		vcpu->arch.sae_block.sve_ffr = 0;
+	}
+
 	/* The reset must run with an unloaded save area */
 	loaded = vcpu_is_loaded(vcpu);
 	if (loaded)
@@ -115,5 +129,15 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
 {
+	switch (feature) {
+	case KVM_ARM_VCPU_SVE:
+		if (!vcpu_has_sve(vcpu))
+			return -EINVAL;
+		if (vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED))
+			return -EPERM;
+		vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
+		return 0;
+	}
+
 	return -EINVAL;
 }

-- 
2.56.1

