Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981341;
	b=iQLK2RsbZQELW3MHCCObx0BI6s94/dV/98WfAqye6jHpQ7+u7aAOgCNd9RBTKd4b4Ofd
	 /nY1hy6iXMK91HctaMdoG/mjbDOQMJUrbBlHnvUnXHxaDvLWqiTiAaqyhEMnXrcJNMQTT
	 rswPLKD99yqjVjy3+72n1v+pjRJmiicAo+Y9YeBE9z3hvw2pA599fqi/TGmQFIh1aBT0t
	 cnXt49RGtWlSnWZsMyELvqjuUAY61AGnocyKQV/A4kzF/AyCC/AoXdP8dh9vsJcKw7QsI
	 RwMv3o/ehliJDrcJRWsnuNED+KQZBMbZtCsxEyLnaVqBkDPZoTKo2p06v8FiNsGr+4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kTCJ1pl4K7AfmN5sQmqn+aYf6quhJxctXq36l2tFrKQ=;
	b=pU8r824MHn+REHsrRz86p/rxsjdNDZ9++QBBr6LWeTgpRcl+HEHusZ2DVZ3yBX6ZAkMB
	 yZ7YvkgERIUm1c+JxLKax+LrFRuuSJV9sPk6R7n4+Xtkdcz4UU6dEU8CVuhyT1zUl46Ky
	 MGgXfDQ2/CNDvgJZ/s30TyiioKgTt0XRowI+5CcZn4WqoaucLZqhGGAoGn9/Z+B0b4jnj
	 dA9G0hYqRw+JH83FbTMWiNVQsSEJtVjaG9VL57IHjp4lx6d8rCuAl4Qcaf+sKxYBMuVQo
	 UUEeWDJP5Z+Maa490yHZEdcDNM4TKneD1zkwgIfEmVuey+k8wuSctRmaB499Jl8Wy4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eQJe2Sb4;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32760A381A;
	Fri,  6 Nov 2026 16:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C32760A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eQJe2Sb4
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE7Yb2711256;
	Fri, 6 Nov 2026 16:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kTCJ1p
	l4K7AfmN5sQmqn+aYf6quhJxctXq36l2tFrKQ=; b=eQJe2Sb4MFXtsfmNr5bdD8
	PVR63j7NELKBfZYyPej7+gQBY/OI5f2zS4zLNLXvw73f4CWF5kylQNe7M9tc1xJc
	r3rI04CbLP0aw0OHaTzKNpKeeg6FWSvAHR9Cyca/Ghu3SC0LTO2H+6Qjp2FWoLW2
	Gj7djHOD5bxOmiRpPbzbq27Fdv7fRkvYsOpDRaYj4UdLqQPaQdIbs7P/AHJ8EzNr
	V66wbIrpI42+kfxKUO6wYED6iwyj2bGhGdzbCHv1hINccDiHxD345XX575k05W/0
	bVCVcZVRohTQI7qMRlBgDfml/mX6U/63y9nHF/mJy1NGjUe4IUBBjkbOMdHgTDbg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95gxn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4sSJ3476002;
	Fri, 6 Nov 2026 16:08:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmress11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8N2c50463050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF1F020040;
	Fri,  6 Nov 2026 16:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59EC62005A;
	Fri,  6 Nov 2026 16:08:22 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:22 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:54 +0100
Subject: [PATCH v3 21/23] KVM: s390: arm64: Implement SVE for arm guests
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
Message-Id: <20261106-sysreg-v3-21-75e95980fb10@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedfb7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=E2f1HnvsrPvGzuHPg88A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wX9IUGuG9CfU4phpF4q7xE43RNtyuaCi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXyGehQ2oVexGK
 1xNUd2c7Hlem0+eqhNNvEpp0ZX/9ikw7dAeBmUr2Z/ApPT0u/hQncgiLqOt1v1rx4+fiIaH4O+a
 MAtTaW1igy4Mn7OcrK+OhVuW6SN5lU3c6e/O+mD3Qqq6zvImhRcEfjUm5rq15NhML/tA8vs6nMN
 d5ZylamokSNL4uZ4Tmbtj09rO9gjW4vSx5hAM4A82rMnBTcp5c6sv7CQS/Rk1KoHZ8bQhUgbnvW
 ndqhHsLbiL+JsBUrJ9kMjRIOG4AjKi8LKbPBbNiGCqmEdU8hpNeSp87M0xZDWsZ2cUKdYinP6wO
 XTBZqIRAMyVDZPKu9yUI74SzK0kzsEfdm6+HwF0clBHW/PFaa4gQbsnEQ+lYTPpday8SAjf34fI
 9qsw681mpF8F2rtteeBUfFRzOm9d0VA1MLQ1wp84anIDxuYMxtvqet8kG2UtkmhguF/Fwue1DmF
 EDmD0TgxonUcvGaF71g==
X-Proofpoint-GUID: wX9IUGuG9CfU4phpF4q7xE43RNtyuaCi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXzvU6IulHKtTT
 h7w3j5Wcl35D3g69QOWjduCANMoY0zrzIIjdpQM6AlxUqPNtms5a3/6+isTxdkDW9FWp3cU1a+b
 W/Z2hN3/Rq3miaIcCkcyhIlRUr/1OBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060062

Add support for Scalable Vector Extension (SVE) in ARM64 guests running
on s390 hardware, providing 128-bit vector operations backed by s390's
Vector Extension (VX).

The implementation is limited to 128-bit vectors (VQ=1) matching s390 VX
register width. Z registers reuse existing FP/SIMD register space (vregs),
while P registers and FFR are stored in the SAE block.

Co-developed-by: Friedrich Welter <fritz@linux.ibm.com>
Signed-off-by: Friedrich Welter <fritz@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |   5 +-
 arch/s390/kvm/arm64/arm.c              |   6 +
 arch/s390/kvm/arm64/feature.c          |   9 +-
 arch/s390/kvm/arm64/feature.h          |   6 +
 arch/s390/kvm/arm64/guest.c            | 250 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/reset.c            |  24 ++++
 6 files changed, 297 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 20f51cf9ce37..f096faceb19d 100644
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
index b5a0f8c1e9a4..8c2a07a96ee3 100644
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
index f8b23ba85f9e..0979e0cadc66 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -56,7 +56,6 @@ void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc)
 	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR4_EL1);
 
 	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SEL2, NI);
-	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SVE, NI);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR0_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR1_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR2_EL1);
@@ -161,3 +160,11 @@ bool cpus_have_final_cap(unsigned int num)
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
index 0a59047fda6e..9af6173f6b11 100644
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
index 047460975936..9e9d0034ddfc 100644
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
+		return -EINVAL;
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
+		return -EINVAL;
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
+		return -EINVAL;
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
+	if (ret == -EINVAL)
+		ret = sve_preg_index(id, regnum);
+	if (ret == -EINVAL)
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
index dc00bf398b15..1ce05a95689f 100644
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
 
@@ -76,6 +82,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
@@ -114,5 +128,15 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
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
2.56.0

