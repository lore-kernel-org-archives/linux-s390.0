Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566625524C;
	Mon, 28 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599016; cv=none; b=figSMuN+7/jSc9Sss/s3hFrX7oUomw55K0vnx2B/cJdGDg0337RoK+ePtrLBagbY/J/2OJlwb07y1MgTcflqFE+o7XOZa96jpfhiltJjajzHUKqVCZlMKqF39L+3JtucP9oYdcYnwyrjihBc2X5TAWMCYiltnyMfX+Mv3PWSUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599016; c=relaxed/simple;
	bh=cJD1JjVkwh76c+a74MNrHkqYzmQHcyVXCtL+lW6ioO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5OuPMJcejtblIz0FDO017V8JgLF8IUDwAv7ye5+bq+IboHnCJSomaAg6ShXJ5QocTIEXI55YGTgC0MN0Rn1DP3yQpj+ziE7HEhetxr0IwE0wf0f4oEFZr4xdp6AZoUk1jBtbDTyganSBHJCeeQLXjtKQmJ52/RXmCtfxrl4C10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K7VFAzn8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K7VFAzn8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZNfE1046884;
	Mon, 28 Sep 2026 12:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/WPBKKsHMVkaT68PH
	pPCT34I36LgsqbMSZNLVADJ+5I=; b=K7VFAzn8pAS4O865ctPy+OTu0t7x/0TYr
	c55nNdeKhq7ptFeycsv9WHR+Y3yFujF7YeBB9yLo6IvxgugHdsnoffBDcQftCx9i
	dXQv6zfs2pH2Wt1mLyLQUzB0D5K7QylynMOOFxL4PHYzzVpHKdYpzv3cKPgneaDW
	1hScD9HdgmzDgV32Y15BjArhF8/HZXATToq4FVCPBy5LX8kHypKd3Sp4LHMxW7Xw
	OwyMJQvv9mKtQswPUV5x8yRBgqVjrVV+rAN+mWXx4VQMFEobLgY4aZQRhJLFuVs3
	bDjooTQDUqNE1Lcpf0Mi5gPi0Hp65WdO3Zl8oUUUvBSk7iecRFtFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j51b4x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHXVQ027121;
	Mon, 28 Sep 2026 12:36:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw598f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCameI26476900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:36:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF63220043;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE9982004D;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v5 1/3] KVM: s390: Improve floating IRQ injection behavior
Date: Mon, 28 Sep 2026 12:30:55 +0000
Message-ID: <20260928123639.34226-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928123639.34226-1-frankja@linux.ibm.com>
References: <20260928123639.34226-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfX9UzSGI9imE7t
 Z1xtsGx2bLRfqZHK3p7q3jdBBIX/KHGLGnAsXMefu/KTlQfL0VaraiYSTQDRI4spqkzQNkF6zNb
 0mwX77QABeGRFk/uM0O62gfdfxzmXyo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfXyfv1cfBTdhNj
 MT3bVgay9Xl3yB3KEcjmEnoXowclxMXW4tYgcTRfkE4SJpyo3FlYiAJPX0NytXaeuojbnXi+HsJ
 nVC1ij/IRekROhzUbZzzO13wTgoQMUyhp78xdSZNIrGfsZhAOd78kps1erH5WyoT4h6N5VeAfaf
 c7PCGUXitqC3j+jEEpxgWDaAbrDPDNzCRbjXZpKywx8i91luhICp/per2kh25fgb4Mmy5S8NLsH
 noclvs76RYAdHubNN+D67vgDjZPuvRib6SdaLuQtNqqRKf818IXpWErfCQnudv/Orz/XZWOxbOA
 ZLD4KXp5UctypCp66AEsEWKrTCKSYhTaX5GEGkdC4KXtuS/hKZN/kdJ4KYDa1AFo9bb8W3Qgfrh
 E6uRmlsQSg0AxzH3u/hoA9I4Rkp+6Fhub9LjwLaBDDv1A3dxuFvn62MLOdpXweiwe0BaFv6DefV
 JrHIqIKIvhefM9Q6wiA==
X-Proofpoint-GUID: 8m4f8o0XjS4z7sO13eWwOLMS6TYQZU0r
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba5f66 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mNrvo4Ka_OWIiVjgUZwA:9
X-Proofpoint-ORIG-GUID: 8m4f8o0XjS4z7sO13eWwOLMS6TYQZU0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280050

Floating IRQs can be handled by any VCPU that opened its masks. The
current design does not check if the mask is open when a floating IRQ
is injected via the FLIC. It will wakeup the last VCPU that went
sleeping hoping it's the correct one.

Improve this by checking if the VCPU can deliver that partiqular IRQ
and if not try to find another VCPU which can take the IRQ.

This is not the final fix around this topic but we'll eventually
inject a pending IRQ. The current code can easily deadlock a VM and
with this fix we work around that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/s390/interrupt.c | 86 ++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index f892f4307883..1e013058f558 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -1918,49 +1918,93 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	return 0;
 }
 
+static u64 inti_to_irq_pend_mask(u64 type, int isc)
+{
+	switch (type) {
+	case KVM_S390_MCHK:
+		/* Only repressible machine checks are floating */
+		return BIT(IRQ_PEND_MCHK_REP);
+	case KVM_S390_INT_VIRTIO:
+		return BIT(IRQ_PEND_VIRTIO);
+	case KVM_S390_INT_SERVICE:
+		return BIT(IRQ_PEND_EXT_SERVICE) |
+		       BIT(IRQ_PEND_EXT_SERVICE_EV);
+	case KVM_S390_INT_PFAULT_DONE:
+		return BIT(IRQ_PEND_PFAULT_DONE);
+	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		return BIT(isc_to_irq_type(isc));
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Setup intervention masks to catch running vcpus that hopefully open
+ * their masks soonish and kick sleeping vcpus to motivate them to
+ * take IRQs.
+ */
+static void vcpu_intervention_kick(struct kvm_vcpu *vcpu, u64 type)
+{
+	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
+	switch (type) {
+	case KVM_S390_MCHK:
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
+		break;
+	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		if (!(type & KVM_S390_INT_IO_AI_MASK &&
+		      vcpu->kvm->arch.gisa_int.origin) ||
+		      kvm_s390_pv_cpu_get_handle(vcpu))
+			kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
+		break;
+	default:
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
+		break;
+	}
+	kvm_s390_vcpu_wakeup(vcpu);
+}
+
 /*
  * Find a destination VCPU for a floating irq and kick it.
  */
-static void __floating_irq_kick(struct kvm *kvm, u64 type)
+static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 {
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
+	u64 irq_pend_mask;
+	unsigned long i;
 
 	online_vcpus = atomic_read(&kvm->online_vcpus);
 	if (!online_vcpus)
 		return;
 
+	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
 	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
 		sigcpu %= online_vcpus;
 		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
-		if (!is_vcpu_stopped(dst_vcpu))
+		if (!is_vcpu_stopped(dst_vcpu) &&
+		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
 			break;
 		/* avoid endless loops if all vcpus are stopped */
-		if (nr_tries++ >= online_vcpus)
-			return;
+		if (nr_tries++ >= online_vcpus) {
+			dst_vcpu = NULL;
+			break;
+		}
 	}
 
-	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
-	switch (type) {
-	case KVM_S390_MCHK:
-		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
-		break;
-	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (!(type & KVM_S390_INT_IO_AI_MASK &&
-		      kvm->arch.gisa_int.origin) ||
-		      kvm_s390_pv_cpu_get_handle(dst_vcpu))
-			kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
-		break;
-	default:
-		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_EXT_INT);
-		break;
+	/* Nobody was enabled, time to wake all of them */
+	if (!dst_vcpu) {
+		kvm_for_each_vcpu(i, dst_vcpu, kvm)
+			vcpu_intervention_kick(dst_vcpu, type);
+		return;
 	}
-	kvm_s390_vcpu_wakeup(dst_vcpu);
+
+	vcpu_intervention_kick(dst_vcpu, type);
 }
 
 static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	u64 type = READ_ONCE(inti->type);
+	int isc = -1;
 	int rc;
 
 	switch (type) {
@@ -1977,6 +2021,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		rc = __inject_pfault_done(kvm, inti);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		/* Grab isc here since __inject_io() might free inti */
+		isc = int_word_to_isc(inti->io.io_int_word);
 		rc = __inject_io(kvm, inti);
 		break;
 	default:
@@ -1985,7 +2031,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	__floating_irq_kick(kvm, type);
+	__floating_irq_kick(kvm, type, isc);
 	return 0;
 }
 
-- 
2.53.0

