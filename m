Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055D4A2E2D;
	Tue,  5 May 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002661; cv=none; b=CU+9Qz/SPIMB+73A+tEMKGyT0+EHKTYi2CPBAYJ6gEKQE5tv+qmQinNrMt9BkmklO951gJMpTfEc9XSfxNTfsSkjS4E8fU/Z1I6AeZVbW+wdVA8R5C6GuzbvLIBeKr2G4s4Zn2Yx58RhSIN58jqUihzIYzWDKfL1qa68USk6sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002661; c=relaxed/simple;
	bh=bbvBbQLxwvTrULGGkPxnAgfA6qo2puCwqDbEU5CYOtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sghYv/Rl9/3aqdQ6+4/7YDG3YrA9vbJ4HF9pevjuMQr5rlyqMSuKAqgYe+hDU7Zs33SNLLAKeBrYfwLGx00hOlxmdflyT4RUl2mQ3KnBzQB9B5oY0YvxwTJJOvKOk2muQpDb5N66uZWhkxJFkVvbGq5bbMY1JjIJc4Ebd0GV6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UeprHP7i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UeprHP7i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645892Y7068020;
	Tue, 5 May 2026 17:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lZQC62wmVNQuDsipZ
	ryUy4QJPHrqMN70Q3EiEDETvUM=; b=UeprHP7iLT5SSP8Bvb04WCyJPSuwoJS1C
	9H+l+EnFaMGTWitb/Veb41BeukjqbKruIyD+1uLfyay9EkgDRMADWA6xo2EwZIxx
	aWCYHbxmKt3pWNZsumLgCCAi+qGX0DSi1MICfY8myQHUJEIDUBMuhqs4erZUKUCg
	7PHDbg/DLm3FubEU+ugYNBOcpfSw2lyY2BthNXsafdK7xTl1uoIlKjyxQsAVxNnh
	gPq2lEppeAUVsbU/i6JvLlaYCZcK7aMUTza6xCDuh8c41LPkGZO1oWar0owBTxKm
	g6yvdiy/GV133R03rkC6YTikKoZOzhkTW6kNalEzWF8nJV8OtBuSw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1d0jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645H9Y3O027513;
	Tue, 5 May 2026 17:37:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h2ny4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645HbYIJ20316838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 17:37:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21AE5804B;
	Tue,  5 May 2026 17:37:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54C158055;
	Tue,  5 May 2026 17:37:32 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 17:37:32 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock for RT case
Date: Tue,  5 May 2026 19:37:27 +0200
Message-ID: <20260505173728.160562-4-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505173728.160562-1-freimuth@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d81vL-uXm6FIFtWrxc8VGdZ7ytEnBb3y
X-Proofpoint-GUID: d81vL-uXm6FIFtWrxc8VGdZ7ytEnBb3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfX9XpZRezaOFLu
 cSf8A7ZzdVnr8VIpKIKZQzurp1eeszEQzINKKqH9A8neLx6z3ZaW5RjZ4AcmJ6PlK7+tIfo6VNn
 RTqdeSxyteCWD9TeW1R4pIsJddOy/etQQTd8oFNaEkuDse+0P/Dm5GNe1VH/owqU+Qhq2YTElL0
 6vpUS+urlJq26ogg/I7LEc+qbZuVlc0Dc6TMEa/F9RpiOoaszF1+B8gOT/qPvugXyWvrdjWWv4p
 JPwDut17qwc2xMZ+widQzsb3QIthAFIKSJRC12oPin/fOoQmgykwfjljpSPtD064Ppb3pnBU8n7
 7c7In777ftozoxpMUBuiyM4y578HdwC+cObhI6Ga2kwNqzMdT6E1mPMac127IjuGPAsgEu8i1Fy
 ZqL0RETxe0ygQjtbfHln5uxUr4jNQnSq71MAqcBbXzXwbby5uscnTomq2eecXKA9eKWjOW8fOEb
 NhOiRVEx3+erEjCzH4w==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fa2ae0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EHZai7OVpKDGiIimAuEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050171

s390 needs to maintain support for an RT kernel. This requires the
floating interrupt lock, fi->lock to be changed to a raw spin lock 
since the fi->lock maybe called with interrupts disabled in __inject_io.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/intercept.c        |  4 +-
 arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
 arch/s390/kvm/kvm-s390.c         |  2 +-
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index fbb2406b31d2..9dd8a4986592 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
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
index 39aff324203e..6e9ad58c0e90 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
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
index 12d8d38c260d..49ccdeccc70c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -625,7 +625,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 	int deliver = 0;
 	int rc = 0;
 
-	spin_lock(&fi->lock);
+	raw_spin_lock(&fi->lock);
 	spin_lock(&li->lock);
 	if (test_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs) ||
 	    test_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs)) {
@@ -654,7 +654,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 		deliver = 1;
 	}
 	spin_unlock(&li->lock);
-	spin_unlock(&fi->lock);
+	raw_spin_unlock(&fi->lock);
 
 	if (deliver) {
 		VCPU_EVENT(vcpu, 3, "deliver: machine check mcic 0x%llx",
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
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 74f453f039a3..d8011b6d6801 100644
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
-- 
2.52.0

