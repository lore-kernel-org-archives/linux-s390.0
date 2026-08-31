Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100250AC3C;
	Mon, 31 Aug 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188481; cv=none; b=b9kthFUEUFdybjr596V/ITkZLf9KOCQP0M0IXQICg2yO0k0Y+s/nEVO+zSJHLNwaG9tHkKVos6lK5T0hhEvkNcZU+I9Y3zLojMCEnAGyvmoh5lKLMdevXYlhhU0/Uf44ZnJjEAwz6BOTkqrYuU4tQS17EkcQPJsgNoFlvmuw1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188481; c=relaxed/simple;
	bh=t2oiGYvNQ2OtECzDa/blNMCQi4T3GWj2w/gv79lsjUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT6yiTTUO0XXT7BwZRfnkln0m5QdEAruBb1IE05P5IRhDf7KDq5cpANr0w29vs9eNOC4PspILNubIzUxDg9oiAaSRxSxDlEimR7o2mzmzKfrB9Mk07n6GUx4mEL3yD4+VL13WsdwaTnb4RpDM2YS2nZUYDC/grPlcPIOnz45beE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZDfCyvT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZDfCyvT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZAbK652855;
	Mon, 31 Aug 2026 14:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dqj03JsN3v899/54D
	h3trYStuun5wJJ47MvvFZy/JSI=; b=dZDfCyvT1RLiZC8yfai/MOv2ZbTxtrgZ1
	2cxi21O6+jk9xr+Vdf+EYwd/Vibl86QoCFn3gmPqpxX6KtA18DdKRjEoR10IF89L
	LkrkMc3HgW6kTCzM2wM6rB2ls2haOvLLQO6eq3Gwuv3crhTd16Po6QzWpthsaMb9
	eHl/f2LhCbUwu+pp0p+LC/4y5ypAc8T/B68nBkCSAluVLBT6a4eMDNZQ9ExEdoxw
	bATelAbzTqfzbl0Xry/r6UJcnTgkYyfw5O+T+uSec4Xbo227WLYFnklgw3mT1md+
	TqmIr/ZRZIhbaOnruTCgYlSuhYcZ6QMqqzZg+S55zqthnnxI8W9HQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r20ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfdR9000453;
	Mon, 31 Aug 2026 14:55:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6aay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtlBB45416922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B29A20040;
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F8A22004E;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 19/20] KVM: s390: arm64: Promote PTRAUTH capability
Date: Mon, 31 Aug 2026 16:55:34 +0200
Message-ID: <20260831145536.913567-20-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a959600 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vEByiMwdv1DjAl9ZBwYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX89mEG6gB4mi1
 0zFvS+kBp+QYZjqN2NlMoZOV/JwuypnbzG14jquiwXCGtzoRbK/zXrII4DysF2Pd2uTuHhMftal
 Bkclhb/8BdhAfJ7Phk5HscAdyLhokrdoZee8P8JvAUekXvZuxw0LknR1jIWxWvwR+rn31WAl1R0
 +14/zNoUZQ6rRbLa7OAakoV2N6rF65sh/Br6+lwdjIUBXx0f/T3lng8TnX6bA9k8OLrKUMQK0Ko
 gzJRd73yVwyJcTDiPgqoifSrxtr6N8wTSastwfl7GbYWgkukaTcZE/ZDtaM74R45LgjY4gjYTVk
 3aTueWaV4jFiTyf0KAMLPuJbaxvIwXMF8zGSn7GmR+852+nzWIQ7zuva9ahOeSy/ewP6Y3B4HyG
 T7F5Vky70haW54BVsuAa0ALSAbXfUFK1RcNJfNY4d734l+LLpLxnSw5FQnOk+biKw80sZ5J3+AG
 3+nULljOfOPs9fQSZsg==
X-Proofpoint-GUID: GK1FQndob2zSCbl_CpxOFT0-dMCgjCeG
X-Proofpoint-ORIG-GUID: hkSLRam3Q_eVqdMtZKr1q4fZgnInHJZU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwQMFUiqMRqDF
 QHZpzjQDOIL5QXbxXmIuM7uH/lIPaxDnRbwSmocRRAm3wvnmdB7vl9eRcJlMLogqh6QQKPfSkwp
 cXEY903Wx9kaQmLI6rdzLkJPxgoTgyQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Promote the pointer authentication capability if supported by hardware.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  8 ++------
 arch/s390/kvm/arm64/arm.c              |  9 +++++++++
 arch/s390/kvm/arm64/feature.c          | 18 ++++++++++++++++++
 arch/s390/kvm/arm64/feature.h          |  5 +++++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 73eb09e98848..32facf045704 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -32,6 +32,8 @@ bool cpus_have_final_cap(unsigned int num);
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 1
 #define KVM_S390_ARM64_IMPL_FEATURES (		\
+	 BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS) |	\
+	 BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC) |	\
 	 BIT(KVM_ARM_VCPU_SVE)			\
 )
 
@@ -133,7 +135,6 @@ struct kvm_vcpu_stat {
 };
 
 #define kvm_has_mte(_kvm) false
-#define vcpu_has_ptrauth(_vcpu) false
 
 struct kvm_arch_memory_slot {
 };
@@ -170,11 +171,6 @@ struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 };
 
-static inline bool system_has_full_ptr_auth(void)
-{
-	return true;
-}
-
 #define kvm_vm_is_protected(_kvm) false
 #define vcpu_is_protected(_vcpu) false
 
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index a46c9c62a5f9..ebd8045c0900 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -57,6 +57,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		ret = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
+	case KVM_CAP_ARM_PTRAUTH_GENERIC:
+		ret = kvm_has_full_ptr_auth();
+		break;
 	default:
 		ret = 0;
 	}
@@ -265,6 +269,11 @@ static unsigned long system_supported_vcpu_features(void)
 	if (!system_supports_sve())
 		clear_bit(KVM_ARM_VCPU_SVE, &features);
 
+	if (!kvm_has_full_ptr_auth()) {
+		clear_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features);
+		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
+	}
+
 	return features;
 }
 
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
index 3847cdd2f92b..a2848e4b3e62 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -170,3 +170,21 @@ bool system_supports_sve(void)
 			     read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) ==
 		       ID_AA64PFR0_EL1_SVE_IMP;
 }
+
+bool system_has_full_ptr_auth(void)
+{
+	u64 isar1 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
+	u64 isar2 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+	bool address_auth;
+	bool generic_auth;
+
+	address_auth = SYS_FIELD_GET(ID_AA64ISAR1_EL1, APA, isar1) >= ID_AA64ISAR1_EL1_APA_PAuth ||
+		       SYS_FIELD_GET(ID_AA64ISAR1_EL1, API, isar1) >= ID_AA64ISAR1_EL1_API_PAuth ||
+		       SYS_FIELD_GET(ID_AA64ISAR2_EL1, APA3, isar2) >= ID_AA64ISAR2_EL1_APA3_PAuth;
+
+	generic_auth = SYS_FIELD_GET(ID_AA64ISAR1_EL1, GPA, isar1) >= ID_AA64ISAR1_EL1_GPA_IMP ||
+		       SYS_FIELD_GET(ID_AA64ISAR1_EL1, GPI, isar1) >= ID_AA64ISAR1_EL1_GPI_IMP ||
+		       SYS_FIELD_GET(ID_AA64ISAR2_EL1, GPA3, isar2) >= ID_AA64ISAR2_EL1_GPA3_IMP;
+
+	return address_auth && generic_auth;
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
index 892cf8bcf3a1..c11ac0daa428 100644
--- a/arch/s390/kvm/arm64/feature.h
+++ b/arch/s390/kvm/arm64/feature.h
@@ -94,4 +94,9 @@ static inline u64 kvm_sae_irptc(void)
 
 bool system_supports_sve(void);
 
+#define vcpu_has_ptrauth(vcpu)						\
+	 (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_ADDRESS) ||       \
+	  vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_GENERIC))
+bool system_has_full_ptr_auth(void);
+
 #endif /* ARCH_S390_KVM_FEATURE_H */
-- 
2.53.0

