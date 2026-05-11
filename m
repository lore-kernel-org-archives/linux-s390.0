Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A742668F;
	Mon, 11 May 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516105; cv=none; b=Bshy5rPTrT+BeJcmb1igKV2Cf+Og26NTvj1YsKg1YfrzUFSJijpCa8nStNy2sJbv2ZvZUvTBw3Z3eqWQ3OPGnyZadjS/Lzavm6kTc/8XF5Q4/qTXXM783C2pohZXxngdwKFcYKUXLEoObrIn4Dn9mGQ0PSYSD1qazwBy8EPSWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516105; c=relaxed/simple;
	bh=9zYRNSVh4OLDnkMa/saIohSRT//DcjtoCkk9MuI6myw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJvIfrbZgPxDCRRkICpQ8ubPzg0gWNLZkCToBPyVghEcvic+oGN8qyj6AFJdebYqcizyIl1cE/ZUk1E1hAM0NpW1KE617H4Pb10RbIGGVHUHtW0KD/ZsowziQA2AlKLPvu5R0AthQMZXGeyl6gvAr7xBIObu+OckhYiKvo+Eb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7LzNaPk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7LzNaPk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BCW4UQ3249645;
	Mon, 11 May 2026 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6/ynIiSkQj1012AdA
	FcFxPJ4QYfi9z6UeZRKQ4JwgEE=; b=N7LzNaPkrAuDEAp8bwSFDTVG9Ufb5qccV
	h7+2cIG5qI0E0KRqMxlFpGhiJD3mEq/goe1u3CUknflaDokHwfAW+uM8ZrlR1Nxs
	WyzVpfFaw2lFhWxIVThnARS8W+mL6a60jiC0r9/0C0xjhbZrJ8qeZjFYZIZyPobF
	i3eEK1XTRzsaERsZ/KcYpvMFeP61/r8RIECUXOw6PnCl9tJgZLZs6biaBT6sRy3X
	J0BHj9qo9pzrtbgu/7rsj/WmTmcwuW4uHUsaWZW6LAmj456m98y8Wl/vRzU5zEJA
	TWpV5YiAiFPKI2pjCHgL8m5KpG8c85h8EdyoaUHPC3H/oeiQwJyRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqs4wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BFsaaM002471;
	Mon, 11 May 2026 16:14:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvx4c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BGEv4R22610548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 16:14:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3535805A;
	Mon, 11 May 2026 16:14:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E88758054;
	Mon, 11 May 2026 16:14:56 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 16:14:56 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v6 3/4] KVM: S390: Change fi->lock, li->lock to raw
Date: Mon, 11 May 2026 18:14:50 +0200
Message-ID: <20260511161451.209464-4-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511161451.209464-1-freimuth@linux.ibm.com>
References: <20260511161451.209464-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfXxPEK7iKD1tpu
 3z0Dra7WVb7EgIbx8s0Lkph1lKsTSVNHM3voeiPYGfw11eyEzywW/pDu0p+aJvq0DaZCJZckV/S
 0GgwAEkMlD78D9fqdkTpg8WvTKj2sF4/fsw1xodIwK5cR+kkP32ZIgIg+0lId4/qn1CHaJe4epc
 DsGv//RrqIjVAjQ+VPqjYd5O1lG/AkQpz2r6nh4sfOem9QJah59iRYpekTbOkFdIU14opEsElQb
 vmSvAx1/oM9KsvBSGZtrrVZK1NvtAOvdM1rRxo/+wJWzY4MoJc+S5T2aNYPBOJ51KWKjG7l0ahZ
 DrMWJtnEBIoleAXyyWi6EMTNbshEIFpSp0DTkrbMOrM3I8102CdxjlR0RUauisPDp/MogYRdMVT
 KNXAmZPMYtUtxzpH+/4WcVFg6GKtMuBuCY1S4LiMECy8f3p9gdDlTQmhZmIKpP7Kb/KM0/a17Y4
 mxWrfnmHH1IDQXslBkw==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a020083 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vmYEZ7anJvjYlnvue9IA:9
X-Proofpoint-ORIG-GUID: MdICb98ap9-lyYuT_bHLk6F-LFWLkrq9
X-Proofpoint-GUID: MdICb98ap9-lyYuT_bHLk6F-LFWLkrq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110174

s390 needs to maintain support for common code. This requires the
floating interrupt lock and local interrupt lock to be changed
to raw_spinlocks. Most or all other platforms use raw_spinlocks in
their inatomic implementations since they will be called with 
interrupts disabled and the locks in that context cannot sleep.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   4 +-
 arch/s390/kvm/intercept.c        |   8 +--
 arch/s390/kvm/interrupt.c        | 112 +++++++++++++++----------------
 arch/s390/kvm/kvm-s390.c         |   4 +-
 arch/s390/kvm/sigp.c             |   4 +-
 5 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index fbb2406b31d2..295f0770bcb1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -321,7 +321,7 @@ struct kvm_s390_irq_payload {
 };
 
 struct kvm_s390_local_interrupt {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
 	unsigned long pending_irqs;
@@ -353,7 +353,7 @@ struct kvm_s390_local_interrupt {
 struct kvm_s390_float_interrupt {
 	unsigned long pending_irqs;
 	unsigned long masked_irqs;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct list_head lists[FIRQ_LIST_COUNT];
 	int counters[FIRQ_MAX_COUNT];
 	struct kvm_s390_mchk_info mchk;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 39aff324203e..fff2baa31651 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -64,10 +64,10 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 		return 0;
 
 	/* avoid races with the injection/SIGP STOP code */
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	flags = li->irq.stop.flags;
 	stop_pending = kvm_s390_is_stop_irq_pending(vcpu);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	trace_kvm_s390_stop_request(stop_pending, flags);
 	if (!stop_pending)
@@ -518,7 +518,7 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	/*
 	 * 2 cases:
 	 * a: an sccb answering interrupt was already pending or in flight.
@@ -534,7 +534,7 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 	fi->srv_signal.ext_params |= 0x43000;
 	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
 	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 12d8d38c260d..4b700813692b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -483,11 +483,11 @@ static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
 	struct kvm_s390_ext_info ext;
 	int rc;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	ext = li->irq.ext;
 	clear_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
 	li->irq.ext.ext_params2 = 0;
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	VCPU_EVENT(vcpu, 4, "deliver: pfault init token 0x%llx",
 		   ext.ext_params2);
@@ -625,8 +625,8 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 	int deliver = 0;
 	int rc = 0;
 
-	spin_lock(&fi->lock);
-	spin_lock(&li->lock);
+	raw_spin_lock(&fi->lock);
+	raw_spin_lock(&li->lock);
 	if (test_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs) ||
 	    test_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs)) {
 		/*
@@ -653,8 +653,8 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 		memset(&fi->mchk, 0, sizeof(mchk));
 		deliver = 1;
 	}
-	spin_unlock(&li->lock);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&li->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (deliver) {
 		VCPU_EVENT(vcpu, 3, "deliver: machine check mcic 0x%llx",
@@ -695,11 +695,11 @@ static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_prefix_info prefix;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	prefix = li->irq.prefix;
 	li->irq.prefix.address = 0;
 	clear_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	vcpu->stat.deliver_prefix_signal++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
@@ -716,12 +716,12 @@ static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu)
 	int rc;
 	int cpu_addr;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	cpu_addr = find_first_bit(li->sigp_emerg_pending, KVM_MAX_VCPUS);
 	clear_bit(cpu_addr, li->sigp_emerg_pending);
 	if (bitmap_empty(li->sigp_emerg_pending, KVM_MAX_VCPUS))
 		clear_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	VCPU_EVENT(vcpu, 4, "%s", "deliver: sigp emerg");
 	vcpu->stat.deliver_emergency_signal++;
@@ -750,11 +750,11 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
 	struct kvm_s390_extcall_info extcall;
 	int rc;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	extcall = li->irq.extcall;
 	li->irq.extcall.code = 0;
 	clear_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	VCPU_EVENT(vcpu, 4, "%s", "deliver: sigp ext call");
 	vcpu->stat.deliver_external_call++;
@@ -800,11 +800,11 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	int rc = 0, nullifying = false;
 	u16 ilen;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	pgm_info = li->irq.pgm;
 	clear_bit(IRQ_PEND_PROG, &li->pending_irqs);
 	memset(&li->irq.pgm, 0, sizeof(pgm_info));
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	ilen = pgm_info.flags & KVM_S390_PGM_FLAGS_ILC_MASK;
 	VCPU_EVENT(vcpu, 3, "deliver: program irq code 0x%x, ilen:%d",
@@ -942,10 +942,10 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_ext_info ext;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs) ||
 	    !(test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs))) {
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return 0;
 	}
 	ext = fi->srv_signal;
@@ -954,7 +954,7 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
 	if (kvm_s390_pv_cpu_is_protected(vcpu))
 		set_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (!ext.ext_params)
 		return 0;
@@ -973,16 +973,16 @@ static int __must_check __deliver_service_ev(struct kvm_vcpu *vcpu)
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_ext_info ext;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	if (!(test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs))) {
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return 0;
 	}
 	ext = fi->srv_signal;
 	/* only clear the event bits */
 	fi->srv_signal.ext_params &= ~SCCB_EVENT_PENDING;
 	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	VCPU_EVENT(vcpu, 4, "%s", "deliver: sclp parameter event");
 	vcpu->stat.deliver_service_signal++;
@@ -998,7 +998,7 @@ static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu)
 	struct kvm_s390_interrupt_info *inti;
 	int rc = 0;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_PFAULT],
 					struct kvm_s390_interrupt_info,
 					list);
@@ -1008,7 +1008,7 @@ static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu)
 	}
 	if (list_empty(&fi->lists[FIRQ_LIST_PFAULT]))
 		clear_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (inti) {
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
@@ -1040,7 +1040,7 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 	struct kvm_s390_interrupt_info *inti;
 	int rc = 0;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_VIRTIO],
 					struct kvm_s390_interrupt_info,
 					list);
@@ -1058,7 +1058,7 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 	}
 	if (list_empty(&fi->lists[FIRQ_LIST_VIRTIO]))
 		clear_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (inti) {
 		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
@@ -1119,7 +1119,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 
 	fi = &vcpu->kvm->arch.float_int;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	isc = irq_type_to_isc(irq_type);
 	isc_list = &fi->lists[isc];
 	inti = list_first_entry_or_null(isc_list,
@@ -1146,7 +1146,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 	if (list_empty(isc_list))
 		clear_bit(irq_type, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (inti) {
 		rc = __do_deliver_io(vcpu, &(inti->io));
@@ -1323,11 +1323,11 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	li->pending_irqs = 0;
 	bitmap_zero(li->sigp_emerg_pending, KVM_MAX_VCPUS);
 	memset(&li->irq, 0, sizeof(li->irq));
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	sca_clear_ext_call(vcpu);
 }
@@ -1663,7 +1663,7 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 	u16 id = (schid & 0xffff0000U) >> 16;
 	u16 nr = schid & 0x0000ffffU;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	list_for_each_entry(iter, isc_list, list) {
 		if (schid && (id != iter->io.subchannel_id ||
 			      nr != iter->io.subchannel_nr))
@@ -1673,10 +1673,10 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 		fi->counters[FIRQ_CNTR_IO] -= 1;
 		if (list_empty(isc_list))
 			clear_bit(isc_to_irq_type(isc), &fi->pending_irqs);
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return iter;
 	}
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	return NULL;
 }
 
@@ -1771,7 +1771,7 @@ static int __inject_service(struct kvm *kvm,
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
 	kvm->stat.inject_service_signal++;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_EVENT_PENDING;
 
 	/* We always allow events, track them separately from the sccb ints */
@@ -1791,7 +1791,7 @@ static int __inject_service(struct kvm *kvm,
 	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_MASK;
 	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
 out:
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	kfree(inti);
 	return 0;
 }
@@ -1802,15 +1802,15 @@ static int __inject_virtio(struct kvm *kvm,
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
 	kvm->stat.inject_virtio++;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_VIRTIO] >= KVM_S390_MAX_VIRTIO_IRQS) {
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_VIRTIO] += 1;
 	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_VIRTIO]);
 	set_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	return 0;
 }
 
@@ -1820,16 +1820,16 @@ static int __inject_pfault_done(struct kvm *kvm,
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
 	kvm->stat.inject_pfault_done++;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_PFAULT] >=
 		(ASYNC_PF_PER_VCPU * KVM_MAX_VCPUS)) {
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_PFAULT] += 1;
 	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_PFAULT]);
 	set_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	return 0;
 }
 
@@ -1840,11 +1840,11 @@ static int __inject_float_mchk(struct kvm *kvm,
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
 	kvm->stat.inject_float_mchk++;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	fi->mchk.cr14 |= inti->mchk.cr14 & (1UL << CR_PENDING_SUBCLASS);
 	fi->mchk.mcic |= inti->mchk.mcic;
 	set_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	kfree(inti);
 	return 0;
 }
@@ -1873,9 +1873,9 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	}
 
 	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
-		spin_unlock(&fi->lock);
+		raw_spin_unlock(&fi->lock);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_IO] += 1;
@@ -1890,7 +1890,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
 	list_add_tail(&inti->list, list);
 	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	return 0;
 }
 
@@ -2082,10 +2082,10 @@ void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	li->irq.stop.flags = 0;
 	clear_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 }
 
 static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
@@ -2138,9 +2138,9 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	rc = do_inject_vcpu(vcpu, irq);
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 	if (!rc)
 		kvm_s390_vcpu_wakeup(vcpu);
 	return rc;
@@ -2181,7 +2181,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	if (!kvm_s390_pv_is_protected(kvm))
 		fi->masked_irqs = 0;
 	mutex_unlock(&kvm->lock);
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	fi->pending_irqs = 0;
 	memset(&fi->srv_signal, 0, sizeof(fi->srv_signal));
 	memset(&fi->mchk, 0, sizeof(fi->mchk));
@@ -2189,7 +2189,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 		clear_irq_list(&fi->lists[i]);
 	for (i = 0; i < FIRQ_MAX_COUNT; i++)
 		fi->counters[i] = 0;
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 	kvm_s390_gisa_clear(kvm);
 };
 
@@ -2235,7 +2235,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 		}
 	}
 	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
 		list_for_each_entry(inti, &fi->lists[i], list) {
 			if (n == max_irqs) {
@@ -2272,7 +2272,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 }
 
 out:
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 out_nolock:
 	if (!ret && n > 0) {
 		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
@@ -3105,7 +3105,7 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 	 * Don't allow setting the interrupt state
 	 * when there are already interrupts pending
 	 */
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	if (li->pending_irqs) {
 		r = -EBUSY;
 		goto out_unlock;
@@ -3118,7 +3118,7 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 	}
 
 out_unlock:
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 out_free:
 	vfree(buf);
 
@@ -3178,11 +3178,11 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 	int cpuaddr;
 	int n = 0;
 
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	pending_irqs = li->pending_irqs;
 	memcpy(&sigp_emerg_pending, &li->sigp_emerg_pending,
 	       sizeof(sigp_emerg_pending));
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	for_each_set_bit(irq_type, &pending_irqs, IRQ_PEND_COUNT) {
 		memset(&irq, 0, sizeof(irq));
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 74f453f039a3..5695038119c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3263,7 +3263,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	}
 
 	mutex_init(&kvm->arch.float_int.ais_lock);
-	spin_lock_init(&kvm->arch.float_int.lock);
+	raw_spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
 	init_waitqueue_head(&kvm->arch.ipte_wq);
@@ -3734,7 +3734,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->msl = sclp.hamax;
 
 	vcpu->arch.sie_block->icpua = vcpu->vcpu_id;
-	spin_lock_init(&vcpu->arch.local_int.lock);
+	raw_spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.sie_block->gd = kvm_s390_get_gisa_desc(vcpu->kvm);
 	seqcount_init(&vcpu->arch.cputm_seqcount);
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 55c34cb35428..911bb8e6ed69 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -245,10 +245,10 @@ static int __prepare_sigp_re_start(struct kvm_vcpu *vcpu,
 	int rc = -EOPNOTSUPP;
 
 	/* make sure we don't race with STOP irq injection */
-	spin_lock(&li->lock);
+	raw_spin_lock(&li->lock);
 	if (kvm_s390_is_stop_irq_pending(dst_vcpu))
 		rc = SIGP_CC_BUSY;
-	spin_unlock(&li->lock);
+	raw_spin_unlock(&li->lock);
 
 	return rc;
 }
-- 
2.52.0

