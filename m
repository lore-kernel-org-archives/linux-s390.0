Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F042A177;
	Fri, 31 Jul 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503679; cv=none; b=pAAh2/Uhi0eyKTgHsD2I5x6uFtmM81vv9NqzkOJI3+yHv2wkxN5SMFZVVnbbN9zCVFaNtzJpwDJ1O18HTbkc8q/hlN/6a13BxMV4dsuvCDSUbjOxROM6PJXa2NvJ60QFGwotWcNeikyrPdripq1srny7bYTOMpM6+m3wf+lFZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503679; c=relaxed/simple;
	bh=vdXyTqv4qXpLDME2RJzZVuyGraK2dpbvqxVBzH4pu9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbZLHY/Lk4ttIgvrGv0zZabFdqO8WfXUclYN46gWo5tGruuLIkvp9t6806Ys488xnkfHWxmkkgW2Q3ozHRyiKzHfs3dFlyCnt9+QVAM48mU+SkkAJzDcavM2jm9nf7XyyAEu0L/chVkLwwnbFp5QN0S+YkKNTOG0KzGnvR9L/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zfes3yUW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zfes3yUW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBla644072612;
	Fri, 31 Jul 2026 13:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1/xOCkp5iDdXe5GGs
	BNc+oEhFgymoyW2Cj8PXaz0Di0=; b=Zfes3yUWdwaeYR8sAF4bvsVo7n5aCovdU
	qRhR31nlXJRxAyN+3I3Nb1EusiTnyIk+q9Dcg+ETnPqy2MBp5JBxNU2DPVi82Qw4
	0nwUCyXuaYlxQbHzNqb/Xmtu5aVSpg/R8iznA/nhVY/KmTJZH6tVE33CaJjpNxfF
	BmdarVuatHsA0rCH2/ALRZ61gxki3d2lephMbrG8pveGbL60CUuk4yiPy6Pz2m5N
	o6wEM53FUVTtjx1vg1UnAVo1sF9hNVKOMQX8PJOOSeMjwdQDBacF8i++Bsp6TcDH
	/BFafDI+I6IyAo2pTf1W7BVX7Qc2l08rYSFYro26RTGbnFq8E+CWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuQRH021067;
	Fri, 31 Jul 2026 13:09:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqr55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD98FA13697516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B5020040;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135AF2004D;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
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
Subject: [PATCH v5 12/31] KVM: arm64: Share arm64 code with s390
Date: Fri, 31 Jul 2026 15:08:40 +0200
Message-ID: <20260731130902.654679-13-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GxRtDljKq8W5UUiA-eAH7IuRcTBNEvOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxqRw+0fp+R2P
 HSWZBk0vdjhN9SkZAV8kyt6HkqxuNzHb7A35aBy3WJofjWFC9GKAAS4rXIBrSITs6L/pO0lbc4m
 qSpbKOzZ1xkc04qFgFpj/t3f0BBbfrm7cfxQJmyR+0WFQlt2dUePhHOCLhHq8J9+Us4hEgVdW0H
 JzZ3bZtzR1AblEIfXYrryT8m8lMB/UAyBVQGd2FbjaidfY00k5sr67uNLjt0WtVhc6i2SYDMGXO
 DCrhzy0xeN+vJqWViz5WLcY28Ow6L57YB+BIr85DxlVmf4oqFLQQqfmG9vMHe3OPDpQZDIj3ohH
 Im42q2eW6CuOEEZ8lQhPiIlVd1em2tKnDMkzy1HKqHWeLzjgb94304fztjZGxI/VK3z1cQ4RuLl
 5OC37cPv1jVCS3WsJmCY/1VdTTgl54TbVXQU1G6aLs5iGbW+0LdBHVP0/iGyHsAx+YUp9bed8/U
 0ZofTpc8P+4sqTs2YLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1LtABwy1h6Ur
 pAeqp1OGnSZF2yw0GfQX7u5DjYhjignzpazyGlxbW8rvGdh2dvedQH1GRSh4tiXJzfjzMtKVUGD
 DbUOTed+u5biQ5qMnRjXEzKpS9lccUk=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e7c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UDcn1B_FrKOTVnIrxN8A:9
X-Proofpoint-GUID: Sierdj-3VJiQGB9DfCYGxN405rhWcDxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Mark functions that s390 can use to implement arm on s390 as shared
functions.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c         | 3 +++
 arch/arm64/kvm/guest.c       | 6 ++++++
 arch/arm64/kvm/handle_exit.c | 6 ++++++
 arch/arm64/kvm/mmio.c        | 2 ++
 arch/arm64/kvm/reset.c       | 6 ++++++
 5 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9a6c72a18672..2d2e7498be88 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1593,6 +1593,7 @@ static unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
+#ifdef ARM64_S390_COMMON
 static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 					const struct kvm_vcpu_init *init)
 {
@@ -1641,6 +1642,8 @@ static bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
 			     KVM_VCPU_MAX_FEATURES);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 02eca05ef572..df1f78ff1044 100644
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
index 54aedf93c78b..d511af145ee6 100644
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
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 727abbff2b6a..81d9f0faede2 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -34,6 +34,7 @@
 static u32 __ro_after_init kvm_ipa_limit;
 unsigned int __ro_after_init kvm_host_sve_max_vl;
 
+#ifdef ARM64_S390_COMMON
 /*
  * ARMv8 Reset Values
  */
@@ -46,6 +47,8 @@ unsigned int __ro_after_init kvm_host_sve_max_vl;
 #define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
+#endif /* ARM64_S390_COMMON */
+
 unsigned int __ro_after_init kvm_sve_max_vl;
 
 int __init kvm_arm_init_sve(void)
@@ -169,6 +172,7 @@ static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
 		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
 }
 
+#ifdef ARM64_S390_COMMON
 static void kvm_reset_vcpu_core_regs(struct kvm_vcpu *vcpu)
 {
 	u32 pstate;
@@ -193,6 +197,8 @@ static void kvm_reset_vcpu_core_regs(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) = pstate;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /**
  * kvm_reset_vcpu - sets core registers and sys_regs to reset value
  * @vcpu: The VCPU pointer
-- 
2.53.0

