Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128D4582CC;
	Mon, 31 Aug 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188218; cv=none; b=Db6m+EhxLbKltaXX0grFJrPcNumaHCqumqqwT5P694hDRBG/puCxnf7Suir0T250GmSJP5Hoazcn7S04uof2kvqIjut2ITAoWiwdL+XQtJ1AA4hsQ/BCfJ6eLO0+SOy4LwBca956ByBRkOVwkMDhwbVGH5st382WXktowYydtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188218; c=relaxed/simple;
	bh=XahmHxH0Gd3lj5ehi9NUQWJAAODcuOY5ppqaWC/GHdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcRQ3vzjzO/fM0ZTOuU6AkdtETH2hMDz/VblcYvkr6iYUlcS5WvrUI8i3WafCrlFBmsvJc60H0P+GLGzVFBgC8CQ3PtCDNE91YyXkbBcqo+Jg0F0FggxhYWC85qEO8/lQQgy8B2qE5KtkCWZVdGS8E2Qb3iofUTcizBegbdzPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmhrmU9Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmhrmU9Q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ2N92530185;
	Mon, 31 Aug 2026 14:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2z3sWLPpK2eDFdOqs
	5emIQ2Y32dheJUIVq6RAjdHB/w=; b=FmhrmU9QCAA6qlzw/bTCVodXBHEs7nQss
	/WGCPp+Nvzh/RNExAwknHK/FS+fu1bVW0GvqjmV9eMNOo9hknj9S4s+8ScbofUsG
	h825t8nvhkzqgInaLmQhuaqOrZYDv6q0RkGkwLkf8UhivRsp2TOnxalTaNCs2GlA
	z06PsQHdDp0WKAwTiKofjCPru6RoMS24J1gb5/Jrk1mcfF8ZMjkIguubBgV0T1FX
	nav4Y+vYYFqgXbgP4sXRqco0mAj4UyIi9gkCy/Kldv7ga4m03k8q/69xPDpEu368
	zE2gdx3H7S7S/I6XqrAX3tGX8E7RWb5g/LZyFNcVDE2z20/uGn6HQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a1u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfiRm000511;
	Mon, 31 Aug 2026 14:55:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6a9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEte2i48759128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F81620040;
	Mon, 31 Aug 2026 14:55:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAC820043;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
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
Subject: [PATCH v2 06/20] KVM: arm64: Prepare sys_regs.c for sharing with s390
Date: Mon, 31 Aug 2026 16:55:21 +0200
Message-ID: <20260831145536.913567-7-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9595f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ij1lYihUeJT8dvZHXdMA:9
X-Proofpoint-GUID: l8CeX09BAcs-5KdSLesq6XqQMWOQcj1r
X-Proofpoint-ORIG-GUID: 572vbWJLKU_EE3ExR3nIQY2XukXZic_6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX51eO/bYuMVOJ
 QhApnQqsz9Uya79UwctrOWx4Ob1nDdJI0PK6KmyX3A6u/ycdM5BhwQPd3XZtiNK7J3w5CgqJ726
 GyrIu7nPkfZac6VfDyipXLnhzxgjN6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX2VMQon3K1S9s
 9cHp1gqRzXtiTaeEVdrNgLElUmnPoGddrjZj6HfaoCqZiNaD57r/wyfmKCkmKZYMpYX7jlLG1Av
 /SWj17tGtBPs4QLlqLb7xsJE6EdG6cHATWkYUA6cHIIqYUALqhyXaMiA2y9R42Aoblo/YjnYTbi
 AAJw4hlmB9ssHWSvg7SAyzRqXd0FbvJT1+1j1e9WWVcNyRaz8kj9TwuaCW6bFUxelQBmZJIpf8+
 hDzbwoGUhDTkkbHami2mZ9JiYa1E5zW/MMTdk3V0GiqPufPwufkd80NdZIhnlWpy/38eDgyBuag
 JPPfFX5HyYoaBasD7YqLaHgK6FEZZgjAe8g17VluWvA3aIxVN8HnK4lVOS2voTKcB1HTo3GpvE+
 2b30pJedslmbmH6FALpiI/gQzxb4JW/ciWPBMPDCrjKSJIm1QOoPQsJ2yOALA2E8e5sgpm40Roh
 FBHlDYXcyD6UhE32mBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Prepare sharing of sys_regs.c with s390 by moving functions to another
location inside sys_regs.c. This reduces the number of shared regions.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 100 +++++++++++++++++++-------------------
 arch/s390/kvm/arm64/arm.c |   2 +
 2 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7d0047b542f4..53d096803d9d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2043,13 +2043,6 @@ static inline bool is_vcpu_ftr_id_reg(u32 id)
 	return is_feature_id_reg(id) && !is_vm_ftr_id_reg(id);
 }
 
-static inline bool is_aa32_id_reg(u32 id)
-{
-	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
-		sys_reg_CRn(id) == 0 && sys_reg_CRm(id) >= 1 &&
-		sys_reg_CRm(id) <= 3);
-}
-
 static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 				  const struct sys_reg_desc *r)
 {
@@ -2065,20 +2058,6 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
-				       const struct sys_reg_desc *r)
-{
-	/*
-	 * AArch32 ID registers are UNKNOWN if AArch32 isn't implemented at any
-	 * EL. Promote to RAZ/WI in order to guarantee consistency between
-	 * systems.
-	 */
-	if (!kvm_supports_32bit_el0())
-		return REG_RAZ | REG_USER_WI;
-
-	return id_visibility(vcpu, r);
-}
-
 static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *r)
 {
@@ -2099,6 +2078,27 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *r)
+{
+	/*
+	 * AArch32 ID registers are UNKNOWN if AArch32 isn't implemented at any
+	 * EL. Promote to RAZ/WI in order to guarantee consistency between
+	 * systems.
+	 */
+	if (!kvm_supports_32bit_el0())
+		return REG_RAZ | REG_USER_WI;
+
+	return id_visibility(vcpu, r);
+}
+
+static inline bool is_aa32_id_reg(u32 id)
+{
+	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
+		sys_reg_CRn(id) == 0 && sys_reg_CRm(id) >= 1 &&
+		sys_reg_CRm(id) <= 3);
+}
+
 /* Visibility overrides for SVE-specific control registers */
 static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
@@ -2553,29 +2553,6 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
 	*p = val;
 }
 
-static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		       u64 *val)
-{
-	*val = 0;
-	return 0;
-}
-
-static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 val)
-{
-	return 0;
-}
-
-static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-		       const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = kvm_read_vm_id_reg(vcpu->kvm, SYS_CTR_EL0);
-	return true;
-}
-
 static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -2684,6 +2661,29 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		       u64 *val)
+{
+	*val = 0;
+	return 0;
+}
+
+static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		      u64 val)
+{
+	return 0;
+}
+
+static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		       const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = kvm_read_vm_id_reg(vcpu->kvm, SYS_CTR_EL0);
+	return true;
+}
+
 static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
@@ -4855,12 +4855,6 @@ static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
 	return true;
 }
 
-int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
-{
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
 static void perform_access(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params,
 			   const struct sys_reg_desc *r)
@@ -4944,6 +4938,12 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 	kvm_inject_undefined(vcpu);
 }
 
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
 /**
  * kvm_handle_cp_64 -- handles a mrrc/mcrr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 3caa72f780a5..2740ee3b703e 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -9,6 +9,7 @@
 #include <linux/kvm_host.h>
 #include <linux/cleanup.h>
 #include <linux/fpu.h>
+#include <linux/bitfield.h>
 
 #include <asm/access-regs.h>
 
@@ -25,6 +26,7 @@
 #include "trace.h"
 
 static unsigned long system_supported_vcpu_features(void);
+#define read_sanitised_ftr_reg(_id) 0
 
 #define __INCL_GEN_ARM_FILE
 #include "generated/arm.inc"
-- 
2.53.0

