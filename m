Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411534749F3;
	Wed, 12 Aug 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549072; cv=none; b=BRMJwCOFUbRNZYkmFogGsAtwpnrgA1TES447IJs7CqySohBwESd1aig8LkbY8paOqITg7AiOUBDP4fE8uNt2fpPEka62YnZiaO7Kym+jEW4ySSviPNJCTGOheUxWF2NHlWzTpgWz5UEwvJaF8P4q/eU7xyOst4312NtXIaHxHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549072; c=relaxed/simple;
	bh=+ZFvEZKeSCu0sZHY43uIeV6Y9EyewU+Qda5p0vvySSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhV9ZOpTRQZGdd34dUwgeJwYGT9sn6Qm09GiOzK2jZuDxmc0mR79q23gQvk6OEa7dxqkvymr6f62xX+gUJTVgpfLTgAzMtY6tB5finwd0iEHxK+6QyCkQFC1mLluUC3ExXHklbvA+AnJr38EUmdKVYNuN6jBIyBbSAreaF+yioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HblgiD6N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HblgiD6N"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1U1R1816401;
	Wed, 12 Aug 2026 15:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ybf6ef7YiwCLG4K6
	TTJ1lMv4MLFbJ+OtG+JrhZ4gg0=; b=HblgiD6NDTLEeR7ea7XZ2ckvxUg1awYck
	hYF0X1+7PD3jPmsQw2MdjCzh2Q8xaWu1CMNX7nTrvyO65WNT53mjrA+sXjR8lzGN
	oN23WrD7nFDe0UwCENytxW3l8/rYNQmRcJ0HROA8ujEBGaZZVt9nVtpqfIg+IfK0
	3GzBONqvGIT057uVtQ/9GlLMAZB0DJklpoTeOP089je2CMaI8VPv1qUs21nM9fK8
	hk7Zvfc5DFHp0Mc6uEy8IE+wviVdjI1bNcATvA6Ahx3qt6JZvJtxf2q8j/1LMWkt
	V00345PLOZ8pKg4CoVDez2u+y7rxRI/e5cvYSeBVwKBAOTAPVsS0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0380u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQOWp021753;
	Wed, 12 Aug 2026 15:36:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaajx38797598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7979E2004D;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28EFF2004E;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 11/33] KVM: arm64: Share arm64 code with s390
Date: Wed, 12 Aug 2026 17:36:07 +0200
Message-ID: <20260812153631.3376090-12-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1BhaPEZos6ct
 RO0pbWeTlCzCEUWhgrp9NQxCDaZE9fKXxOZJMX+uzKXnit0Icwob0ca1lCbjr/MPWuTx7ao58P8
 thVDmSKJT1ApuShVVAFFUm3TJDVQt5EWoIUFjipW1eJoaWEK0WOAaczYrt9Pk2hn2MQ8zG+fYLA
 eQaO3nmbzMQJi3DoNVMFJOydU/el8ySSy583jBr+lzoWI+2auyeqZbcxxgKLCA0E7Cxdsbc0lDe
 VDI4Tr2h/FSnKOrZMY3d248JJGMyWmlzhaXvpQNP8eQMJZ7abr18N9kWq7PcgiczlPh6wNMkMVW
 sU1SpaNobT7YQzsrEDVEgXSqgvLQOrGHEswjqShFLBi+qE4HrzJDqG4Icjh+ZF0CgBS/F+NtD/O
 GghaK/wCReYMvhri0l6HYtCelBxg4wR8GbWvvQAdvk+BJy67l1hlTwvZZvXli2QGbDpJKok5XFn
 VGAma8qh3OR8fn2xnCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1yPf6ykDrKjC
 UKMEtLbIinV58ppVQwtWAkSY/nGJIDQJQprxVjfGfbxLJo49ht+P6uUiOan7b0tbpO4PumbCtZG
 BNeghFTrZ3LY0rO9V6ju02Panb8mGIs=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c9309 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DWVxlzv4wnVo_M8M_fcA:9
X-Proofpoint-GUID: RzOi_joBKYaBt7eikWmH33uUyADdeH-G
X-Proofpoint-ORIG-GUID: CqTfyBBWehjnw3w_OEzzq3sCLHnrxF-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Mark functions that s390 can use to implement arm on s390 as shared
functions.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c         | 3 +++
 arch/arm64/kvm/guest.c       | 6 ++++++
 arch/arm64/kvm/handle_exit.c | 6 ++++++
 arch/arm64/kvm/mmio.c        | 2 ++
 4 files changed, 17 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8b080804bc90..6b92a3c1d490 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1603,6 +1603,7 @@ static unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
+#ifdef ARM64_S390_COMMON
 static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 					const struct kvm_vcpu_init *init)
 {
@@ -1656,6 +1657,8 @@ static bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
 			     KVM_VCPU_MAX_FEATURES);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 773f6c8e5026..6ca5a9f357cd 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -62,6 +62,7 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
+#ifdef ARM64_S390_COMMON
 static bool core_reg_offset_is_vreg(u64 off)
 {
 	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
@@ -306,6 +307,8 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
@@ -543,6 +546,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef ARM64_S390_COMMON
 static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
 				 u64 __user *uindices)
 {
@@ -591,6 +595,8 @@ static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
 	return copy_core_reg_indices(vcpu, NULL);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
 {
 	const unsigned int slices = vcpu_sve_slices(vcpu);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 29108e5c0206..6a6ef2c074f4 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -213,6 +213,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+#ifdef ARM64_S390_COMMON
 static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);
@@ -224,6 +225,8 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Guest access to SVE registers should be routed to this handler only
  * when the system doesn't support SVE.
@@ -404,6 +407,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_GCS]	= kvm_handle_gcs,
 };
 
+#ifdef ARM64_S390_COMMON
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);
@@ -439,6 +443,8 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
 	return handled;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index d1c3a352d5a2..5161102da507 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -10,6 +10,7 @@
 
 #include "trace.h"
 
+#ifdef ARM64_S390_COMMON
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
 {
 	void *datap = NULL;
@@ -258,3 +259,4 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	run->exit_reason	= KVM_EXIT_MMIO;
 	return 0;
 }
+#endif /* ARM64_S390_COMMON */
-- 
2.53.0

