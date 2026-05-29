Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E442189A;
	Fri, 29 May 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070208; cv=none; b=oza2isq34YbJjaHAaJULgLB3T1anSS6489hKnNX+41QpeS7Wxe6fqDlUq2c7K6YM7TCBpFnvGo0qasabJJysWEPYE1lQauCwj1WrUEPj+M2vf3yCZewxo1mdZWiNvrD1C75QH+1XWAjU3z73U2CVuyC77cQVVk9vugBiX5KqqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070208; c=relaxed/simple;
	bh=7UbxpkEnieP8qmC8SH0fNHWVwIA7YnI3HCzNjXbo/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+WEfErGgCIPw6skcauCndeI99TE/jhw0fbXnQnVW5YtB2Oz+zKUeHAF/BPQwXUNvc/YEGhFm3oM6fHhDTK6nyfB9/gwpP72bq1CtA+wC6Wh2KEOe1jUWUiWIrC0mkgwa+FiigEEkTmDJxIdpK++gkED6qjAuUMpEKMp2NJreEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Br07LJqV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Br07LJqV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFAYU72776975;
	Fri, 29 May 2026 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HvS5ygHypbJ75jCe1
	4OYm4t9n4F8Jw6nQDIGnTnTBbo=; b=Br07LJqVccDj11BHABnbfpAinPDJhDQyz
	//ajbUVn59mmqveBwbisoas67DHY4xyZ0+9DKfKcrRqP8ViC/0s9d/OByh6PkPHM
	JQgIahsuwnBMgwNoU1ndbbmROOlgu+5sWBwa2DPUddABnkXPKSK1rGL3S9U5w7da
	FgZ6g3yWFT095uoeTUauo7zszH7AW2noaEwFlaDRSoTgdwUrmJfb9YfzkTPcKVG2
	7LTbuDFfByuN/4lJ3yCFT6/rWxsWuz9PGA6o4It/XIoaA/9kK7+UV0MvYQwAcGha
	AmBKsnb28U/x20o9IuZ36dj/OxPQxj2vT8kZi+9fOjvUQum5ryrsg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889m2d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7d9009674;
	Fri, 29 May 2026 15:56:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgkw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu9tX47120694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72F0020040;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 217952004B;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
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
Subject: [PATCH v1 19/26] KVM: arm64: Share KVM feature detection macros
Date: Fri, 29 May 2026 17:55:52 +0200
Message-ID: <20260529155601.2927240-20-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: g14Y61h8uAxZVsdbu3T7k6nMLecUnH8y
X-Proofpoint-GUID: g14Y61h8uAxZVsdbu3T7k6nMLecUnH8y
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19b721 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jOJeQztrt6vKKCgc4XMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX/jwSK6rRsyho
 2nIBltCjJMUMeEh8dKZ2tjLZobHXN+jrO55sYqE797bQ4oESaB0Hgb5ZVPXr/a1bBgpyDmSYFom
 PDhcdBMBn+dMREelMLs8A/8oG+1Mymfx2l5JhZ6re8aISrUtFYQTiacebKWG8DUY/2UbmP+97yW
 LSsj6YH9rDl9eggcv55CXKj0fyGwUTV9iTaLUH7GQB4PbRWH8TPDQc9dUuYIrD52r3K//LV7Cty
 DMQJU3MxDCShags7TJTCwzhjfs6DF5Uj4gMJROus5Q9gyvN5GLId2fnG13SS4t/Y4FtyF1wKGFk
 rqM69GF/9KwW23ZqDvd0FdNAASLREImVIryp0AamhgyMg0ffZKEB7hx6pezvjI9IWPGc0nAlQw+
 iSC7lgubovmbAEVBcWZVmT7BL3akZPwwjgDQcNebahUVJHYBkf+/yxI93r21MVz/VGZa0YrKEzY
 tKHg5MAz8vUjKO1ZEvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Move kvm feature definitions from arch/arm64/include to a shared location
(include/kvm/arm64) to enable reuse by e.g. s390 for KVM/arm64 on s390
support.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_feature.h          | 60 +------------------
 .../asm => include/kvm/arm64}/kvm_feature.h   | 28 ++-------
 2 files changed, 5 insertions(+), 83 deletions(-)
 copy {arch/arm64/include/asm => include/kvm/arm64}/kvm_feature.h (76%)

diff --git a/arch/arm64/include/asm/kvm_feature.h b/arch/arm64/include/asm/kvm_feature.h
index 27a472d2343e..e1fb8b9f5ce2 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/arch/arm64/include/asm/kvm_feature.h
@@ -2,65 +2,7 @@
 #ifndef __ARM64_KVM_FEATURE_H__
 #define __ARM64_KVM_FEATURE_H__
 
-#include <linux/types.h>
-#include <linux/bitfield.h>
-#include <asm/sysreg-defs.h>
-
-#define extract_id_field_unsigned(val, id, fld)				\
-	(FIELD_GET(id##_##fld##_MASK, (val)))
-
-#define extract_id_field_signed(val, id, fld)				\
-	({								\
-		u64 __val = extract_id_field_unsigned((val), id, fld);	\
-		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
-	})
-
-#define cmp_id_feat_signed(val, id, fld, op, limit)			\
-	(extract_id_field_signed((val), id, fld) op S64_SYS_FIELD_VALUE(id, fld, limit))
-
-#define cmp_id_feat_unsigned(val, id, fld, op, limit)			\
-	(extract_id_field_unsigned((val), id, fld) op (u64)SYS_FIELD_VALUE(id, fld, limit))
-
-#define cmp_id_feat(val, id, fld, op, limit)				\
-	(id##_##fld##_SIGNED ?						\
-	 cmp_id_feat_signed(val, id, fld, op, limit) :			\
-	 cmp_id_feat_unsigned(val, id, fld, op, limit))
-
-#define id_has_feat(val, id, fld, limit)				\
-	cmp_id_feat(val, id, fld, >=, limit)
-
-#define id_has_feat_enum(val, id, fld, variant)				\
-	cmp_id_feat_unsigned(val, id, fld, ==, variant)
-
-#define id_has_feat_range(val, id, fld, min, max)			\
-	(cmp_id_feat(val, id, fld, >=, min) &&				\
-	cmp_id_feat(val, id, fld, <=, max))
-
-#define __kvm_has_feat(kvm, id, fld, limit)				\
-	id_has_feat(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, limit)
-
-#define kvm_has_feat(kvm, ...) __kvm_has_feat(kvm, __VA_ARGS__)
-
-#define __kvm_has_feat_enum(kvm, id, fld, val)				\
-	id_has_feat_enum(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, val)
-
-#define kvm_has_feat_enum(kvm, ...) __kvm_has_feat_enum(kvm, __VA_ARGS__)
-
-
-/* Check for a given level of PAuth support */
-#define kvm_has_pauth(k, l)						\
-	({								\
-		bool pa, pi, pa3;					\
-									\
-		pa  = kvm_has_feat((k), ID_AA64ISAR1_EL1, APA, l);	\
-		pa &= kvm_has_feat((k), ID_AA64ISAR1_EL1, GPA, IMP);	\
-		pi  = kvm_has_feat((k), ID_AA64ISAR1_EL1, API, l);	\
-		pi &= kvm_has_feat((k), ID_AA64ISAR1_EL1, GPI, IMP);	\
-		pa3  = kvm_has_feat((k), ID_AA64ISAR2_EL1, APA3, l);	\
-		pa3 &= kvm_has_feat((k), ID_AA64ISAR2_EL1, GPA3, IMP);	\
-									\
-		(pa + pi + pa3) == 1;					\
-	})
+#include <kvm/arm64/kvm_feature.h>
 
 #define kvm_has_fpmr(k)					\
 	(system_supports_fpmr() &&			\
diff --git a/arch/arm64/include/asm/kvm_feature.h b/include/kvm/arm64/kvm_feature.h
similarity index 76%
copy from arch/arm64/include/asm/kvm_feature.h
copy to include/kvm/arm64/kvm_feature.h
index 27a472d2343e..945abbbf1aa8 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/include/kvm/arm64/kvm_feature.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef __ARM64_KVM_FEATURE_H__
-#define __ARM64_KVM_FEATURE_H__
+
+#ifndef __KVM_ARM64_FEATURE_H__
+#define __KVM_ARM64_FEATURE_H__
 
 #include <linux/types.h>
 #include <linux/bitfield.h>
@@ -46,7 +47,6 @@
 
 #define kvm_has_feat_enum(kvm, ...) __kvm_has_feat_enum(kvm, __VA_ARGS__)
 
-
 /* Check for a given level of PAuth support */
 #define kvm_has_pauth(k, l)						\
 	({								\
@@ -62,24 +62,4 @@
 		(pa + pi + pa3) == 1;					\
 	})
 
-#define kvm_has_fpmr(k)					\
-	(system_supports_fpmr() &&			\
-	 kvm_has_feat((k), ID_AA64PFR2_EL1, FPMR, IMP))
-
-#define kvm_has_tcr2(k)				\
-	(kvm_has_feat((k), ID_AA64MMFR3_EL1, TCRX, IMP))
-
-#define kvm_has_s1pie(k)				\
-	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1PIE, IMP))
-
-#define kvm_has_s1poe(k)				\
-	(system_supports_poe() &&			\
-	 kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
-
-#define kvm_has_ras(k)					\
-	(kvm_has_feat((k), ID_AA64PFR0_EL1, RAS, IMP))
-
-#define kvm_has_sctlr2(k)				\
-	(kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
-
-#endif /* __ARM64_KVM_FEATURE_H__*/
+#endif /* __KVM_ARM64_FEATURE_H__*/
-- 
2.53.0

