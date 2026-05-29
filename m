Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B333F1ABF;
	Fri, 29 May 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070499; cv=none; b=C6FaDSHGTUBjdeYffk0vLAF7dInB/8olVwZIjLURNnWEbqiZsQzwqVxICLWCRuWk0SemhQrLd1M/g0517DSZ+Q9vWLFTsKdWH69+pVRBthi+Oxogui8xDY4Xhd4887RMWhj/JdalLjW1URkBOj8aI1N5TPq1GegSLK33cRrY9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070499; c=relaxed/simple;
	bh=1qFcgdzfKutuRCefdcv49mhnpDe49vhaVF+lPt6wIPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkWlTos5o+uy3veESrXuVNcWrPDwj0de6te9FzwwyTH24bn/r9eGnIOQCdrHrOMsc0MRvY5oiySFO/UtE2px/EjlZyPoLuFm9ximqSzZNUC/HJ0Lq76EuABNtHI1Z5PgXbllimwpPReboerMaLNoaTQ6jS1UBW9QCAUASs+1q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E0S/ccSw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E0S/ccSw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF8fI81468200;
	Fri, 29 May 2026 15:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GoxrwaGtqkwb0bP+i
	25cRQ407cUzDdO4u3IWehcOzxc=; b=E0S/ccSwzZvm/dz4zxDQm/0DzhLlSaKos
	mO8V8FwVVRwtXJcgrZR6dgsmU6/Ief2eZkuly0Oad2ftcVP28eTwlu5TLpenucrx
	i9icXRcSKuHuCg188nX54NAspxSMbNhDQy1Atz24JsFyneaQMOUMAMuIxGNj8eG5
	Td9g/m9Nl6s6GbfPTb2mI0N+KOS09+WO/5sGL7fC3Alk9ER2dRIeUBwnpApre152
	i+CWb3gKuKS+9o/K8P3rHqmwmHV6QmxKLmbrfGWzEUk8eV+YrTzQOkcYwOW+cpDi
	N0BY08f8wv276zKL1iUxrfMVBH2ucPbpYsUqeY+8ftBaKt0jwJsSA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mgk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5Ek016940;
	Fri, 29 May 2026 15:56:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgjrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFuBmF20906536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19DE22004B;
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B95E420043;
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v1 23/26] KVM: s390: arm64: Implement feature sanitisation
Date: Fri, 29 May 2026 17:55:56 +0200
Message-ID: <20260529155601.2927240-24-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9SvAY8Wj9EaNZfGFFir4G7VlwKfL-0t3
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b723 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IwyvTvM2pio66WvHkYAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXy2KWNEm7t3zb
 uHtFibnIxTTygD1dhn7bMJXOoUpZ/bLBlXCmJm+UK3zTVjjnY17J5kCD3Di4ls73ntAJ7arai1p
 bFgpBKXkX8ObbQ8BVBgSCpac6DZGQYxtF9q97EhqYsp9bf9qa6VKrofLkKV2Z2Lx6/U50mbZbn3
 Y6BhgKh0+psWAL/Q4fUnlb6wDijqKmSr0N/+StREPnIr/fnoZvJPRc2V8LXDyCX3nkbzwdJTdA/
 /X6j8nZKVoAuYXc+aDOjtQspIC9rgkovVDiY/q1SpsupZV7mHJACIbAGxpKvomnpkee/aHuT3db
 MQAog5FDKSNcxSh3E7UckNFuqCrY1W2OpTO8GWSXoHWhKRdE9CIY19Bplq0bTHizDeBw2mUcuev
 42Wy5eCbFbS5WNsjownIFOHn8GrT38pHywtaoEe7nElkPsYahPMmyLFzfa0UQQr6BKag3pO0aRL
 QXeaqFrkezwO3xf/GQA==
X-Proofpoint-ORIG-GUID: 9SvAY8Wj9EaNZfGFFir4G7VlwKfL-0t3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Implement feature detection and sanitization for arm64 KVM guests on
s390.

Query hardware capabilities using QAAF instruction and sanitize arm64 ID
registers. Provide accessor functions for queried capabilities and
integrate feature detection into module initialization sequence.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_feature.h          | 111 ++++++++++++
 arch/s390/include/asm/kvm_host_arm64.h       |   2 +-
 arch/s390/include/asm/kvm_host_arm64_types.h |   3 +-
 arch/s390/include/asm/kvm_nested.h           |   5 +
 arch/s390/kvm/arm64/Makefile                 |   1 +
 arch/s390/kvm/arm64/arm.c                    |   6 +
 arch/s390/kvm/arm64/feature.c                | 170 +++++++++++++++++++
 7 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm_feature.h
 create mode 100644 arch/s390/kvm/arm64/feature.c

diff --git a/arch/s390/include/asm/kvm_feature.h b/arch/s390/include/asm/kvm_feature.h
new file mode 100644
index 000000000000..dda99c3b09af
--- /dev/null
+++ b/arch/s390/include/asm/kvm_feature.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __S390_KVM_ARM64_FEATURE_H__
+#define __S390_KVM_ARM64_FEATURE_H__
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/kvm_host_arm64_types.h>
+
+#include <kvm/arm64/kvm_feature.h>
+
+int __init kvm_arm_host_detect_features(void);
+
+/**
+ * kvm_sae_supported_sd_formats() - Retrieve supported SAE SD formats
+ *
+ * Return: Bitmap of supported SAE state description formats.
+ */
+static inline u32 kvm_sae_supported_sd_formats(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.ssdf;
+}
+
+/**
+ * kvm_sae_supported_sa_formats() - Retrieve supported SAE SA formats
+ *
+ * Return: Bitmap of supported SAE save area formats.
+ */
+static inline u32 kvm_sae_supported_sa_formats(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.ssaf;
+}
+
+/**
+ * kvm_sae_max_vcpus() - Retrieve maximum supported vcpus
+ *
+ * Return: Max number of vCPUs supported by the SAE instruction/the machine
+ *	as indicated by QAAF, not necessarily that supported by the host software.
+ */
+static inline u16 kvm_sae_max_vcpus(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	/* QAAF QMP reports the max id not the max num */
+	return __qaaf_qmp.maxncpu + 1;
+}
+
+/**
+ * kvm_sae_irptc() - Retrieve supported SAE IRPTCs
+ *
+ * Return: Bitmap of supported SAE IRPTCs.
+ */
+static inline u64 kvm_sae_irptc(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.regs[QAAF_IRPTC];
+}
+
+/** 
+ * kvm_arm_host_sys_reg_by_name() - Get the value of a sys register
+ *
+ * @id - ARM (ID-)register name
+ *
+ * Get the value of a sys register describing the host configuration.
+ * The returned value indicates support by the machine (HW/FW)
+ * after some sanitisation. Equivalent to arm64's read_sanitised_ftr_reg,
+ * See `enum qaaf_regs` for supported registers. Use the ARM register name
+ * without the QAAF_REG_ prefix as defined in the qaaf_regs enum.
+ *
+ * Example:
+ *	kvm_arm_host_sys_reg_by_name(ID_AA64PFR0_EL1)
+ *
+ * Return: Sanitised HW value of the specified register
+ */
+#define kvm_arm_host_sys_reg_by_name(id) kvm_arm_host_sys_reg_by_id(SYS_##id)
+
+/** 
+ * kvm_arm_host_sys_reg_by_id() - Get the value of a sys register
+ *
+ * @id - ARM sysreg id
+ *
+ * Get the value of a sys register describing the host configuration.
+ * The returned value indicates support by the machine (HW/FW)
+ * after some sanitisation. Equivalent to arm64's read_sanitised_ftr_reg,
+ * See `enum qaaf_regs` for supported registers.
+ *
+ * Example:
+ *	kvm_arm_host_sys_reg_by_id(SYS_ID_AA64PFR0_EL1)
+ *
+ * Return: Sanitised HW value of the specified register
+ */
+u64 kvm_arm_host_sys_reg_by_id(u32 id);
+
+#define kvm_arm_host_has_feat(id, fld, limit)				\
+	id_has_feat(kvm_arm_host_sys_reg_by_name(id), id, fld, limit)
+
+#define kvm_has_fpmr(k)					\
+	(kvm_has_feat((k), ID_AA64PFR2_EL1, FPMR, IMP))
+
+#define kvm_has_s1poe(k)				\
+	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
+
+#define kvm_vcpu_has_pmu(_v) false
+#define kvm_has_mte(_k) false
+
+#endif /* __S390_KVM_ARM64_FEATURE_H__*/
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index fcbe510cb868..f62daff3303b 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -6,6 +6,7 @@
 
 #include <asm/kvm_host_arm64_types.h>
 #include <asm/debug.h>
+#include <asm/kvm_feature.h>
 
 #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
 
@@ -123,7 +124,6 @@ struct kvm_vcpu_stat {
 #define _vcpu_test_and_clear_flag(v, flagset, ...)	\
 	__vcpu_test_and_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
 
-#define kvm_has_mte(_kvm) false
 #define vcpu_has_sve(_vcpu) false
 #define vcpu_has_ptrauth(_vcpu) false
 
diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/include/asm/kvm_host_arm64_types.h
index 16f7018a1714..45fa360601fb 100644
--- a/arch/s390/include/asm/kvm_host_arm64_types.h
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -206,7 +206,8 @@ enum {
 	/* 0x3f-0x41 reserved */
 	QAAF_REG_CNTFRQ_EL0		= 0x42,
 	QAAF_REG_CTR_EL0		= 0x43,
-	/* 0x44-0x49 reserved */
+	QAAF_REG_AIDR_EL1		= 0x44,
+	/* 0x43-0x49 reserved */
 	QAAF_IRPTC			= 0x4a,
 	/* 0x4b reserved */
 	QAAF_REG_ICH_VTR_EL2		= 0x4c,
diff --git a/arch/s390/include/asm/kvm_nested.h b/arch/s390/include/asm/kvm_nested.h
index 7158932e718b..f075df33277f 100644
--- a/arch/s390/include/asm/kvm_nested.h
+++ b/arch/s390/include/asm/kvm_nested.h
@@ -10,4 +10,9 @@ static inline bool vcpu_has_nv(const struct kvm_vcpu *vcpu)
 	return false;
 }
 
+static inline u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
+{
+	BUILD_BUG();
+}
+
 #endif /* ASM_KVM_NESTED_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index d0aac34b8d2f..28deeb90efa9 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -9,6 +9,7 @@ ccflags-y += -I $(src) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_ARM64
 
 kvm-arm64-obj := \
 	arm.o \
+	feature.o \
 	guest.o \
 	handle_exit.o \
 	inject_fault.o \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 48418c46e451..dc0e070f8a62 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -701,6 +701,8 @@ u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
 
 static int __init kvm_s390_arm64_init(void)
 {
+	int err = 0;
+
 	if (!sclp.has_aef) {
 		pr_info("SAE is not available\n");
 		return -ENXIO;
@@ -711,6 +713,10 @@ static int __init kvm_s390_arm64_init(void)
 		return -ENXIO;
 	}
 
+	err = kvm_arm_host_detect_features();
+	if (err)
+		return err;
+
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
 				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
 }
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
new file mode 100644
index 000000000000..9a34c0866a2b
--- /dev/null
+++ b/arch/s390/kvm/arm64/feature.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+#include <asm/kvm_host_arm64_types.h>
+#include <asm/kvm_feature.h>
+
+struct qaaf_qmc_block __qaaf_qmc;
+
+#define MASK_RESERVED(_qaafp, _id)				\
+	({							\
+		u64 *_reg = &((_qaafp)->regs[QAAF_REG_##_id]);	\
+		*_reg = (*_reg & ~_id##_RES0) | _id##_RES1;	\
+	})
+
+#define QAAF_FIELD_MODIFY(_idp, _id_field, _val) \
+	FIELD_MODIFY(_id_field##_MASK, _idp, _id_field##_##_val)
+
+#define MODIFY(_qaafp, _id, _field, _val) \
+	QAAF_FIELD_MODIFY(&((_qaafp)->regs[QAAF_REG_##_id]), _id##_##_field, _val)
+
+int __init kvm_arm_host_detect_features(void)
+{
+	qaaf_qmc(&__qaaf_qmc);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64ISAR0_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64ISAR1_EL1, LS64, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64ISAR1_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64ISAR2_EL1, SYSINSTR_128, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64ISAR2_EL1, SYSREG_128, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64ISAR2_EL1, PAC_frac, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64ISAR2_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64ISAR3_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64MMFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64MMFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64MMFR2_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, Spec_FPACC, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, ADERR, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, SDERR, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, ANERR, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, SNERR, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR3_EL1, MEC, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64MMFR3_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR4_EL1, SRMASK, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR4_EL1, E3DSE, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR4_EL1, RMEGDI, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR4_EL1, FGWTE3, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64MMFR4_EL1, ASID2, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64MMFR4_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64PFR0_EL1, SEL2, NI);
+	MODIFY(&__qaaf_qmc, ID_AA64PFR0_EL1, SVE, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64PFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64PFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64PFR2_EL1);
+
+	MODIFY(&__qaaf_qmc, ID_AA64DFR0_EL1, PMUVer, NI);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64DFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64DFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64DFR2_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64AFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64AFR1_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64ZFR0_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64SMFR0_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_AA64FPFR0_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_PFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_PFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_PFR2_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_DFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_DFR1_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR2_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR3_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR4_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_MMFR5_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR2_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR3_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR4_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR5_EL1);
+	MASK_RESERVED(&__qaaf_qmc, ID_ISAR6_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, MVFR0_EL1);
+	MASK_RESERVED(&__qaaf_qmc, MVFR1_EL1);
+	MASK_RESERVED(&__qaaf_qmc, MVFR2_EL1);
+
+	MASK_RESERVED(&__qaaf_qmc, CTR_EL0);
+
+	MASK_RESERVED(&__qaaf_qmc, ICH_VTR_EL2);
+
+	return 0;
+}
+
+#define _qaaf_reg_case(id) case SYS_##id: return __qaaf_qmc.regs[QAAF_REG_##id]
+
+u64 kvm_arm_host_sys_reg_by_id(u32 id)
+{
+	switch (id) {
+	_qaaf_reg_case(MIDR_EL1);
+	_qaaf_reg_case(MPIDR_EL1);
+	_qaaf_reg_case(REVIDR_EL1);
+	_qaaf_reg_case(ID_PFR0_EL1);
+	_qaaf_reg_case(ID_PFR1_EL1);
+	_qaaf_reg_case(ID_DFR0_EL1);
+	_qaaf_reg_case(ID_AFR0_EL1);
+	_qaaf_reg_case(ID_MMFR0_EL1);
+	_qaaf_reg_case(ID_MMFR1_EL1);
+	_qaaf_reg_case(ID_MMFR2_EL1);
+	_qaaf_reg_case(ID_MMFR3_EL1);
+	_qaaf_reg_case(ID_ISAR0_EL1);
+	_qaaf_reg_case(ID_ISAR1_EL1);
+	_qaaf_reg_case(ID_ISAR2_EL1);
+	_qaaf_reg_case(ID_ISAR3_EL1);
+	_qaaf_reg_case(ID_ISAR4_EL1);
+	_qaaf_reg_case(ID_ISAR5_EL1);
+	_qaaf_reg_case(ID_MMFR4_EL1);
+	_qaaf_reg_case(ID_ISAR6_EL1);
+	_qaaf_reg_case(MVFR0_EL1);
+	_qaaf_reg_case(MVFR1_EL1);
+	_qaaf_reg_case(MVFR2_EL1);
+	_qaaf_reg_case(ID_PFR2_EL1);
+	_qaaf_reg_case(ID_DFR1_EL1);
+	_qaaf_reg_case(ID_MMFR5_EL1);
+	_qaaf_reg_case(ID_AA64PFR0_EL1);
+	_qaaf_reg_case(ID_AA64PFR1_EL1);
+	_qaaf_reg_case(ID_AA64PFR2_EL1);
+	_qaaf_reg_case(ID_AA64ZFR0_EL1);
+	_qaaf_reg_case(ID_AA64SMFR0_EL1);
+	_qaaf_reg_case(ID_AA64FPFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR1_EL1);
+	_qaaf_reg_case(ID_AA64DFR2_EL1);
+	_qaaf_reg_case(ID_AA64AFR0_EL1);
+	_qaaf_reg_case(ID_AA64AFR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR0_EL1);
+	_qaaf_reg_case(ID_AA64ISAR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR2_EL1);
+	_qaaf_reg_case(ID_AA64ISAR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR0_EL1);
+	_qaaf_reg_case(ID_AA64MMFR1_EL1);
+	_qaaf_reg_case(ID_AA64MMFR2_EL1);
+	_qaaf_reg_case(ID_AA64MMFR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR4_EL1);
+	_qaaf_reg_case(CNTFRQ_EL0);
+	_qaaf_reg_case(CTR_EL0);
+	_qaaf_reg_case(AIDR_EL1);
+	_qaaf_reg_case(ICH_VTR_EL2);
+	_qaaf_reg_case(PMMIR_EL1);
+	_qaaf_reg_case(PMCR_EL0);
+	_qaaf_reg_case(PMCEID0_EL0);
+	_qaaf_reg_case(PMCEID1_EL0);
+	default:
+		WARN(true, "Unknown system register 0x%x\n", id);
+		return 0xbad1234bad;
+	}
+}
-- 
2.53.0

