Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725650B8AA;
	Fri, 18 Sep 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738338; cv=none; b=OYmVdz4rWgBPjlnBHJblGOTV9vpkqJKpRUfUV0T0cmSYp56/cGhTX4jI710s4IfiFA922SvV+qar6UDtj+JZ8HgJvyZ9Oh4fdV6LTjQxjCbI6xudNc/ls01ykFtaopkiNHXafvQ4EvQrQhm8a9gzxxqnVKcvBs4NNkQtimsjxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738338; c=relaxed/simple;
	bh=osxPNSHcQUO0nk+XKlToV/RimPTNmaFDOasczQeqmPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TubNRruvKwxm6J517y66calCM6EbdSU6a4HPmvZ9ltx4DFeKG3e5gYW524pm2e3MM+lz9fBD6GdeHLiI8ryIGti0UZ411WvVlWIB43mkmI5O0UVxoRlFTgUV0ct0O/xzbzH7XR7tLfQt/IYETy59Kdu9OaiTPqxhR06x2LXg6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ko8fDgQ4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ko8fDgQ4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1VXo960914;
	Fri, 18 Sep 2026 13:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C5SCNP8saHi3O3B1k
	Nvg87I+cyuIzf7H9GcjrjizG3o=; b=Ko8fDgQ4pLot/CcAAYQGooiN4YjvVU1QK
	jB6gjcmUricbP39QTj2QoRkRZs0xJ150QY3lUVzkQGbU/U4yAgl5E3AbFMo98dlp
	4Qnra5FwZ0DawM3dfQh9k0sM+5R77SS1lU8YsH3h8Auz5R8DSe2JgSrdH9Vno7xb
	kJd+HWe9BPZkYeeLCaimYiiiJ1mSkNviSR7smoOQiXPE+3DUOWRh0ca+cihA1Sbw
	z/pBn0+E5xP8c4iGvsRqfYwg+2ZEC7jJfTeZyg9PdPP530O4yZTMCiZe0QpTBJfa
	N497h2gUSwBKIhggJjJBp3GJxPS32rR7uSw1hf9IqChvm5uIQEDFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5gb75-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNufH771797;
	Fri, 18 Sep 2026 13:31:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffhcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVEWv20841000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 536782004B;
	Fri, 18 Sep 2026 13:31:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 045D520049;
	Fri, 18 Sep 2026 13:31:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:13 +0000 (GMT)
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
Subject: [PATCH v8 17/29] KVM: arm64: Share arm64 code with s390
Date: Fri, 18 Sep 2026 15:30:54 +0200
Message-ID: <20260918133107.1042730-18-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Gd5dYhDmS8id6aAs38q-IeAloOoIi_tv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX384FMWKEv2aj
 QvUqUYOdWfojFvSd4aUPC8ThKjbYvjuwNodZTRunetGk4xZqQcDpd6sOyG8Pg3jly9KFfhozTJT
 9GLSI7QMqFC84u3CyZg7sXU2Ap84ZHs=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad3d2b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3a0hE5hcTyqzKRjSqTQA:9
X-Proofpoint-ORIG-GUID: RxgjPLRIDeiqnHJfQ4CCB1Yd2NanKony
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX5B0YoHVfggDR
 ycvbVN32uWWkZYYDaGkzET0g11OuYLetTBpKvfBVtCBMUbLUCcRcVZyc49ajtFNWyJ8IIfl+eAo
 Ho7pmjjWwVOaylJX0YMHLjl3G2FksTx1W14U/knkWnKaCi3i1v8SFaqka7LVC4DSIs+mveJQzLI
 CF89nSz6tjn1PFax+8ojBwHYun1c1GJWkTNB5JzFBTQPiq41G/cuQmniirBLK2fN1BH4Z3dTW1v
 oJ6rJPYzwwpz9wg3Sr8LXi+f1Xyfbp2Y4Vpit4VjIB90mwNN/0BF52JpvfzgUtEa+08yS9VOrKP
 nwIVlBqc1y3tS8bq/+merr94S6NR+VHi+wsr6SRh2QMsxyOHy88pw6Cxhx0oU7hnMxwvWU5dqTt
 oe1rITDoZ6vKUsT/Ta8LHLSqDKfMyQEuvnTGn+PFMzE1QZE0QTKdz11QW7BwjrLiEjhkjpRA42P
 RkzhCkcgeLTwHL7DMjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Mark functions that s390 can use to implement arm on s390 as shared
functions.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c   | 3 +++
 arch/arm64/kvm/guest.c | 6 ++++++
 arch/arm64/kvm/mmio.c  | 2 ++
 3 files changed, 11 insertions(+)

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

