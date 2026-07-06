Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCF477E39;
	Mon,  6 Jul 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327994; cv=none; b=L8bHNeewe/MJMpRDBWi/1RrLAK14TxwDjQFJadml3zwnc7+3lkCxy1z2JOXIMtShrFSkI3pDNHF/drMNa+LHWwe+ANeb5ZMVAuEr56tcaTgf3zh7yvW/voZNSrLztYTYwoO0aDWdDt+r0kINnCSU0a3fcdrNhwDHUbScaeBdAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327994; c=relaxed/simple;
	bh=6d8P2ZA3gm8IFh/mrXmC7uW6i/gEp+wNwOvVGvLS+sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5u0Tuqe837M3N2VST2yI/XS2Em0LUJDE/5B5iZm19JXHpdVrvV5K3Fjb8J8ZgONjcaQRfYqmHGVt3b5ZJPe4gl3WFwXGajfhq7PpQcBN/GVE5DR/Tqnp+l+vR2jwZzYW3VSGnwDqryrAwJc7pOns4cDWZEmhEgz/Lp4XVawDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B8uk7BOY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B8uk7BOY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6668GnfR1497483;
	Mon, 6 Jul 2026 08:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c3/qjjDz4zlmCsho1
	amB9lAEk/KIAn/DS3/7/VNsd/o=; b=B8uk7BOYeVw89AlXJdfCuZoDbhqihtmFk
	oiUgcyG8gwwa1faws2/NitamX8VHMvm203jGAZ+4efueb2hZM+/3dreaVlh7rkPp
	BD50ppzt3QV2ilW54HgSw4Rl0QsK1EE3Im4h+B9TuHfV6pIzU3kLnf9vcwZ3qa7G
	Ya0/6RleU96VYxx+kvZGIGf5RBUnQsCLiqktEKoahWmbnE2oEZdjpL17Fi5dE8E0
	hVdeodabLokehZoqJ/hMMIKeDeZSDI0hfSzytKSLxD71AtiBDxVSt5eeEn/iOMpu
	DMcivIg6KjU85cC2NLp8yOFIybATDH3Dgrokfus6PGXgkSIqkFJ9g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh2kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ngoZ009807;
	Mon, 6 Jul 2026 08:52:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpw1bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qXw630409086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4162B20040;
	Mon,  6 Jul 2026 08:52:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB41B2004F;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
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
Subject: [PATCH v4 08/27] KVM: arm64: Prepare sharing arm64 code with s390
Date: Mon,  6 Jul 2026 10:52:08 +0200
Message-ID: <20260706085229.979525-9-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C18re4_GJCBnJs9OMEVcKoICqLBXgsqj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX2PJ09Y62bWwE
 n9J93lZ/kFBOaXJC5M25CBIJuAyS24GcgMvc0En8teKHISSNfRFLkgYAygfomInXWEnD/Xj+hqq
 6U7JPfHR7coGovXB/XBIwTnFe6pcRNE=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b6cd8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SEEEUPhAIGzw0_SdnhEA:9
X-Proofpoint-GUID: C18re4_GJCBnJs9OMEVcKoICqLBXgsqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX/TEjmpMq/duG
 JPrXvf2NR+UDq3AMLSe604Rlzl5kmd5R0LznDHoFQi8AaEAZ1lIJoa3Sxa6tyVyNYOZ4F3QsdC+
 RxoydgCJpBBsaVVEPxhY8+/Rj5PJVxVBqtg2F3PnPlSfBfP4734nRTLJ+gSEy5BGutrITlZkrxk
 xBU69tu0e2F3sO0/M4ZJGLz8sd/4rXwOCJTR4oC2SFppIDnDJIIbRiUekUwPJLHvmntykZjPzeP
 RCSgqCwgJZvUdcUbOj1rEGkpsWhB4pQMU/kFxvy5HSnBYCsWv5mm+R9qF7sTDxYbqjk8eFHXr04
 Oju1KS1bIyhxxStzW2Ec4EFbEbKqTD5xE2Eep9+CMBjbB6XDrzR+Axf7YbW0cxvRsvYqeoJLvCx
 stBDcNGA5HsPo/VxKcoRpIVxVitOvmPcKEx27Gxy/On1dngMOCG9l74lCnBM3iGgXhyUVhy9Obp
 tBLzYw9ssGD5bqJFVfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060088

Mark functions that s390 can use to implement arm on s390 as shared
functions.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/arm.c         |  3 +++
 arch/arm64/kvm/guest.c       |  3 +++
 arch/arm64/kvm/handle_exit.c |  6 ++++++
 arch/arm64/kvm/mmio.c        | 14 ++++++++++++++
 arch/arm64/kvm/reset.c       |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 50adfff75be8..c992308b2dce 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1580,6 +1580,7 @@ static unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
+#ifdef ARM64_S390_COMMON
 static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 					const struct kvm_vcpu_init *init)
 {
@@ -1628,6 +1629,8 @@ static bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
 			     KVM_VCPU_MAX_FEATURES);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b01d6622b872..5a202cfd27bc 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -543,6 +543,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef ARM64_S390_COMMON
 static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
 				 u64 __user *uindices)
 {
@@ -591,6 +592,8 @@ static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
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
index e2285ed8c91d..876d56dd5b64 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -10,6 +10,7 @@
 
 #include "trace.h"
 
+#ifdef ARM64_S390_COMMON
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
 {
 	void *datap = NULL;
@@ -135,8 +136,11 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
 		if (!kvm_vcpu_dabt_issf(vcpu))
 			data = data & 0xffffffff;
 
+#endif /* ARM64_S390_COMMON */
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
 			       &data);
+		//TODO  tracing
+#ifdef ARM64_S390_COMMON
 		data = vcpu_data_host_to_guest(vcpu, data, len);
 		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
 	}
@@ -171,8 +175,11 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	 * though, so directly deliver an exception to the guest.
 	 */
 	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
+#endif /* ARM64_S390_COMMON */
 		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), esr,
 				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
+		//TODO tracing
+#ifdef ARM64_S390_COMMON
 
 		if (vcpu_is_protected(vcpu))
 			return kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
@@ -223,14 +230,20 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 		data = vcpu_data_guest_to_host(vcpu, vcpu_get_reg(vcpu, rt),
 					       len);
 
+#endif /* ARM64_S390_COMMON */
 		trace_kvm_mmio(KVM_TRACE_MMIO_WRITE, len, fault_ipa, &data);
+	//TODO tracing
+#ifdef ARM64_S390_COMMON
 		kvm_mmio_write_buf(data_buf, len, data);
 
 		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, fault_ipa, len,
 				       data_buf);
 	} else {
+#endif /* ARM64_S390_COMMON */
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ_UNSATISFIED, len,
 			       fault_ipa, NULL);
+	//TODO tracing
+#ifdef ARM64_S390_COMMON
 
 		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, fault_ipa, len,
 				      data_buf);
@@ -257,3 +270,4 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	run->exit_reason	= KVM_EXIT_MMIO;
 	return 0;
 }
+#endif /* ARM64_S390_COMMON */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b963fd975aac..faab6f03f365 100644
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
-- 
2.53.0

