Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546333AD8C;
	Sun, 31 May 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780254246; cv=none; b=ZZ94nJZcy+uGr193u88H2WOAzyKZWRryYFgGWF7UjBi08O8cP4eiOUID9wlLX4BT//RAf5u6g3/EqQP9RCkZIKlvsAzKzNFSXZ4gLky7N8v76UMIN2TdodQ1Rev5DroGrMsfFoHiFHzISntlCBcsjfSWN6rQrrPZoCI66E7ifC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780254246; c=relaxed/simple;
	bh=JJHpS7VHQ6uZZpPYCWoOYiZbLXZrnheQoWgT47xb/a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGCQ8AT8dVF1KlD/iUt20RMVXdoZ3NFnV+3gE22JsDF4TxwdRYwuxzUoS+EfdmRKLwFA/eZexnzeIPemocTQgQmj+yW/c2AEMMdSyivtwwRVi5FUk1sDusztcHxbKlA3TOYS3eXaINku6b1NM1znhmaZQ4fAqwLU6AHquF85ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYhtY8df; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYhtY8df"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V46L742666058;
	Sun, 31 May 2026 19:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RL04ADu/ZbmFuN+1D
	fSI+6tovVRON2BbneCZtiTHt4s=; b=dYhtY8dfsa2q4RrRkfCjTQLgR65uBgeeA
	ZhCngdkbeCO5z7aHYZXWyZxG3+3aF22pqMDWfvPf27B1KChB3JQ+Taj3IGilxSO/
	mboZUrH2L1yzglturZb9mrmi5YLLXvdSlsbmDrYrYc295vjPgmNaiAxUOlAzPeNH
	uGpw1GHnscQ98wxxshgItaeX3+egucElHiEZYOzk3XtjEff8SKMPygnn0gp1CTk8
	R7f+xI2gIlm73rpBPvcmv70RfoNOJ/J2uztgTyvjeZyXdbgRF6KYTzJimzEVcWN5
	OWIE1cm58qg4WVOeX7PQbZ75ICXTLZkv5iQI7X0wYN/8OL7985kUQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsw7qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:04:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VIsBeV006155;
	Sun, 31 May 2026 19:03:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegam8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:03:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VJ3vc653805548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 19:03:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D2C58056;
	Sun, 31 May 2026 19:03:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8BB058052;
	Sun, 31 May 2026 19:03:56 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 19:03:56 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v9 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject
Date: Sun, 31 May 2026 21:03:53 +0200
Message-ID: <20260531190353.204317-4-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531190353.204317-1-freimuth@linux.ibm.com>
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_SPKP3TIkvFVwcBg0H7nKNJYzHt8pim
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1c8620 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xDNdzKvPSL2aGnhA7LQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIwMiBTYWx0ZWRfX5zUBNDT/0AlD
 vLE6ied3KuzzQlh2HK2AeY1oFzgsXPkMgWXZAIDjM/WBAhIq0K4Ssb16lCFdJALYmtdLFCNvzB8
 7XJcEQtuc7Q5zq6WOXyLqQ4BuY9kMXgJUP2Y5cFd0i9NZuQHlJNoeBNWDXgY/qUNyMuvui8ZfQE
 vlBMcJuMEwLX40VjG/W+1QrL2nxQayQjY26MBP7t/Nyn15NcdBdT8Uwqlgqg16xg2u/0l8Uhp5O
 O4QsYAJonEWAN9ChAWb0+zKaYKVXGSSli/rFgPiTbjIMAhzinH0szIZ9KsrBZYjM1zyOza7LhtW
 zFKe2/wRnkpz5DGkHZXTFXLJf4jr+FQrbATaBOmLdQpBHr74p/yPFVeleFJC5gmEmjBtDPWPOaa
 MoAMWiNpJK1yrqOaMNXkpVUcAt7xudFueSIZDmYEQo637YBDS6N1pFk6hVHJY2oj8RwUcK57J6d
 Dmf0OIgmxF+VjuH9Q3Q==
X-Proofpoint-ORIG-GUID: o_SPKP3TIkvFVwcBg0H7nKNJYzHt8pim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310202

s390 needs a fast path for irq injection, and along those lines we
introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
the global work queue as it does today, this patch provides a fast path for
irq injection.

The inatomic fast path cannot lose control since it is running with
interrupts disabled. This meant making the following changes that exist on
the slow path today. First, the adapter_indicators page needs to be mapped
since it is accessed with interrupts disabled, so we added map/unmap
functions. Second, access to shared resources between the fast and slow
paths needed to be changed from mutex and semaphores to spin_lock's.
Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
but we had to implement the fast path with GFP_ATOMIC allocation. Each of
these enhancements were required to prevent blocking on the fast inject
path.

Fencing of Fast Inject in Secure Execution environments is enabled in the
patch series by not mapping adapter indicator pages. In Secure Execution
environments the path of execution available before this patch is followed.

Statistical counters have been added to enable analysis of irq injection on
the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
io_set_adapter_int and io_390_inatomic_no_inject. The no inject counter
captures adapter masked, coalesced and suppressed interrupts.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   6 +-
 arch/s390/kvm/intercept.c        |   5 +-
 arch/s390/kvm/interrupt.c        | 265 ++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.c         |  27 +++-
 arch/s390/kvm/kvm-s390.h         |   3 +-
 5 files changed, 241 insertions(+), 65 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0056cc9414a0..7422ded443ba 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -359,7 +359,7 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int last_sleep_cpu;
-	struct mutex ais_lock;
+	spinlock_t ais_lock;
 	u8 simm;
 	u8 nimm;
 };
@@ -450,6 +450,10 @@ struct kvm_vm_stat {
 	u64 inject_io;
 	u64 io_390_adapter_map;
 	u64 io_390_adapter_unmap;
+	u64 io_390_inatomic;
+	u64 io_flic_inject_airq;
+	u64 io_set_adapter_int;
+	u64 io_390_inatomic_no_inject;
 	u64 inject_float_mchk;
 	u64 inject_pfault_done;
 	u64 inject_service_signal;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 39aff324203e..1980df61ef30 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -517,8 +517,9 @@ static int handle_pv_spx(struct kvm_vcpu *vcpu)
 static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	/*
 	 * 2 cases:
 	 * a: an sccb answering interrupt was already pending or in flight.
@@ -534,7 +535,7 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 	fi->srv_signal.ext_params |= 0x43000;
 	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
 	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a7cff4289f4a..5cfa781e349a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -624,8 +624,9 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 	struct kvm_s390_mchk_info mchk = {};
 	int deliver = 0;
 	int rc = 0;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	spin_lock(&li->lock);
 	if (test_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs) ||
 	    test_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs)) {
@@ -654,7 +655,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 		deliver = 1;
 	}
 	spin_unlock(&li->lock);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	if (deliver) {
 		VCPU_EVENT(vcpu, 3, "deliver: machine check mcic 0x%llx",
@@ -941,11 +942,12 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_ext_info ext;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs) ||
 	    !(test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs))) {
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return 0;
 	}
 	ext = fi->srv_signal;
@@ -954,7 +956,7 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
 	if (kvm_s390_pv_cpu_is_protected(vcpu))
 		set_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	if (!ext.ext_params)
 		return 0;
@@ -972,17 +974,18 @@ static int __must_check __deliver_service_ev(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_ext_info ext;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	if (!(test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs))) {
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return 0;
 	}
 	ext = fi->srv_signal;
 	/* only clear the event bits */
 	fi->srv_signal.ext_params &= ~SCCB_EVENT_PENDING;
 	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	VCPU_EVENT(vcpu, 4, "%s", "deliver: sclp parameter event");
 	vcpu->stat.deliver_service_signal++;
@@ -997,8 +1000,9 @@ static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu)
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_interrupt_info *inti;
 	int rc = 0;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_PFAULT],
 					struct kvm_s390_interrupt_info,
 					list);
@@ -1008,7 +1012,7 @@ static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu)
 	}
 	if (list_empty(&fi->lists[FIRQ_LIST_PFAULT]))
 		clear_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	if (inti) {
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
@@ -1039,8 +1043,9 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_interrupt_info *inti;
 	int rc = 0;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_VIRTIO],
 					struct kvm_s390_interrupt_info,
 					list);
@@ -1058,7 +1063,7 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 	}
 	if (list_empty(&fi->lists[FIRQ_LIST_VIRTIO]))
 		clear_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	if (inti) {
 		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
@@ -1116,10 +1121,11 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	struct kvm_s390_io_info io;
 	u32 isc;
 	int rc = 0;
+	unsigned long flags;
 
 	fi = &vcpu->kvm->arch.float_int;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	isc = irq_type_to_isc(irq_type);
 	isc_list = &fi->lists[isc];
 	inti = list_first_entry_or_null(isc_list,
@@ -1146,7 +1152,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 	if (list_empty(isc_list))
 		clear_bit(irq_type, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 
 	if (inti) {
 		rc = __do_deliver_io(vcpu, &(inti->io));
@@ -1662,8 +1668,9 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 	struct kvm_s390_interrupt_info *iter;
 	u16 id = (schid & 0xffff0000U) >> 16;
 	u16 nr = schid & 0x0000ffffU;
+	unsigned long flags;
 
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	list_for_each_entry(iter, isc_list, list) {
 		if (schid && (id != iter->io.subchannel_id ||
 			      nr != iter->io.subchannel_nr))
@@ -1673,10 +1680,10 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
 		fi->counters[FIRQ_CNTR_IO] -= 1;
 		if (list_empty(isc_list))
 			clear_bit(isc_to_irq_type(isc), &fi->pending_irqs);
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return iter;
 	}
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	return NULL;
 }
 
@@ -1769,9 +1776,10 @@ static int __inject_service(struct kvm *kvm,
 			     struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	unsigned long flags;
 
 	kvm->stat.inject_service_signal++;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_EVENT_PENDING;
 
 	/* We always allow events, track them separately from the sccb ints */
@@ -1791,7 +1799,7 @@ static int __inject_service(struct kvm *kvm,
 	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_MASK;
 	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
 out:
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	kfree(inti);
 	return 0;
 }
@@ -1800,17 +1808,18 @@ static int __inject_virtio(struct kvm *kvm,
 			    struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	unsigned long flags;
 
 	kvm->stat.inject_virtio++;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	if (fi->counters[FIRQ_CNTR_VIRTIO] >= KVM_S390_MAX_VIRTIO_IRQS) {
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_VIRTIO] += 1;
 	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_VIRTIO]);
 	set_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	return 0;
 }
 
@@ -1818,18 +1827,19 @@ static int __inject_pfault_done(struct kvm *kvm,
 				 struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	unsigned long flags;
 
 	kvm->stat.inject_pfault_done++;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	if (fi->counters[FIRQ_CNTR_PFAULT] >=
 		(ASYNC_PF_PER_VCPU * KVM_MAX_VCPUS)) {
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_PFAULT] += 1;
 	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_PFAULT]);
 	set_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	return 0;
 }
 
@@ -1838,13 +1848,14 @@ static int __inject_float_mchk(struct kvm *kvm,
 				struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	unsigned long flags;
 
 	kvm->stat.inject_float_mchk++;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	fi->mchk.cr14 |= inti->mchk.cr14 & (1UL << CR_PENDING_SUBCLASS);
 	fi->mchk.mcic |= inti->mchk.mcic;
 	set_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	kfree(inti);
 	return 0;
 }
@@ -1855,6 +1866,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	struct kvm_s390_float_interrupt *fi;
 	struct list_head *list;
 	int isc;
+	unsigned long flags;
 
 	kvm->stat.inject_io++;
 	isc = int_word_to_isc(inti->io.io_int_word);
@@ -1873,9 +1885,9 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	}
 
 	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
-		spin_unlock(&fi->lock);
+		spin_unlock_irqrestore(&fi->lock, flags);
 		return -EBUSY;
 	}
 	fi->counters[FIRQ_CNTR_IO] += 1;
@@ -1890,7 +1902,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
 	list_add_tail(&inti->list, list);
 	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	return 0;
 }
 
@@ -1966,15 +1978,10 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 }
 
 int kvm_s390_inject_vm(struct kvm *kvm,
-		       struct kvm_s390_interrupt *s390int)
+		       struct kvm_s390_interrupt *s390int, struct kvm_s390_interrupt_info *inti)
 {
-	struct kvm_s390_interrupt_info *inti;
 	int rc;
 
-	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
-	if (!inti)
-		return -ENOMEM;
-
 	inti->type = s390int->type;
 	switch (inti->type) {
 	case KVM_S390_INT_VIRTIO:
@@ -2003,15 +2010,13 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 		inti->io.io_int_word = s390int->parm64 & 0x00000000ffffffffull;
 		break;
 	default:
-		kfree(inti);
 		return -EINVAL;
 	}
 	trace_kvm_s390_inject_vm(s390int->type, s390int->parm, s390int->parm64,
 				 2);
 
 	rc = __inject_vm(kvm, inti);
-	if (rc)
-		kfree(inti);
+
 	return rc;
 }
 
@@ -2176,12 +2181,13 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	int i;
+	unsigned long flags;
 
 	mutex_lock(&kvm->lock);
 	if (!kvm_s390_pv_is_protected(kvm))
 		fi->masked_irqs = 0;
 	mutex_unlock(&kvm->lock);
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	fi->pending_irqs = 0;
 	memset(&fi->srv_signal, 0, sizeof(fi->srv_signal));
 	memset(&fi->mchk, 0, sizeof(fi->mchk));
@@ -2189,7 +2195,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 		clear_irq_list(&fi->lists[i]);
 	for (i = 0; i < FIRQ_MAX_COUNT; i++)
 		fi->counters[i] = 0;
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 	kvm_s390_gisa_clear(kvm);
 };
 
@@ -2204,6 +2210,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	int ret = 0;
 	int n = 0;
 	int i;
+	unsigned long flags;
 
 	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
 		return -EINVAL;
@@ -2235,7 +2242,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 		}
 	}
 	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
+	spin_lock_irqsave(&fi->lock, flags);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
 		list_for_each_entry(inti, &fi->lists[i], list) {
 			if (n == max_irqs) {
@@ -2272,7 +2279,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 }
 
 out:
-	spin_unlock(&fi->lock);
+	spin_unlock_irqrestore(&fi->lock, flags);
 out_nolock:
 	if (!ret && n > 0) {
 		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
@@ -2287,6 +2294,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (attr->attr < sizeof(ais))
 		return -EINVAL;
@@ -2294,10 +2302,10 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	ais.simm = fi->simm;
 	ais.nimm = fi->nimm;
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	if (copy_to_user((void __user *)attr->addr, &ais, sizeof(ais)))
 		return -EFAULT;
@@ -2686,6 +2694,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_req req;
 	int ret = 0;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2702,7 +2711,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 				       2 : KVM_S390_AIS_MODE_SINGLE :
 				       KVM_S390_AIS_MODE_ALL, req.mode);
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	switch (req.mode) {
 	case KVM_S390_AIS_MODE_ALL:
 		fi->simm &= ~AIS_MODE_MASK(req.isc);
@@ -2715,7 +2724,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return ret;
 }
@@ -2729,25 +2738,41 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
 		.parm = 0,
 		.parm64 = isc_to_int_word(adapter->isc),
 	};
+	struct kvm_s390_interrupt_info *inti;
+	unsigned long flags;
+
 	int ret = 0;
 
-	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible)
-		return kvm_s390_inject_vm(kvm, &s390int);
+	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+	if (!inti)
+		return -ENOMEM;
 
-	mutex_lock(&fi->ais_lock);
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
+		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (ret)
+			kfree(inti);
+		return ret;
+	}
+
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
 		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
-		goto out;
+		spin_unlock_irqrestore(&fi->ais_lock, flags);
+		kfree(inti);
+		return ret;
 	}
 
-	ret = kvm_s390_inject_vm(kvm, &s390int);
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+
 	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
 		fi->nimm |= AIS_MODE_MASK(adapter->isc);
 		trace_kvm_s390_modify_ais_mode(adapter->isc,
 					       KVM_S390_AIS_MODE_SINGLE, 2);
 	}
-out:
-	mutex_unlock(&fi->ais_lock);
+
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
+	if (ret)
+		kfree(inti);
 	return ret;
 }
 
@@ -2756,6 +2781,8 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
 	unsigned int id = attr->attr;
 	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
 
+	kvm->stat.io_flic_inject_airq++;
+
 	if (!adapter)
 		return -EINVAL;
 
@@ -2766,6 +2793,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2773,10 +2801,10 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
 		return -EFAULT;
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	fi->simm = ais.simm;
 	fi->nimm = ais.nimm;
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return 0;
 }
@@ -2945,6 +2973,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 		set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
 	if (!summary_info) {
@@ -2972,6 +3001,44 @@ static int adapter_indicators_set(struct kvm *kvm,
 	return summary_set ? 0 : 1;
 }
 
+static int adapter_indicators_set_fast(struct kvm *kvm,
+				       struct s390_io_adapter *adapter,
+				       struct kvm_s390_adapter_int *adapter_int,
+				       int setbit)
+{
+	unsigned long bit;
+	int summary_set;
+	struct s390_map_info *ind_info, *summary_info;
+	void *map;
+
+	spin_lock(&adapter->maps_lock);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(ind_info->page);
+	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+	if (setbit)
+		set_bit(bit, map);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(summary_info->page);
+	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+			  adapter->swap);
+	/* If setbit then set summary bit. Else if falling back to the slow path */
+	/* with setbit==0 then clear the summary bit so the slow path re-injects */
+	if (setbit)
+		summary_set = test_and_set_bit(bit, map);
+	else
+		summary_set = test_and_clear_bit(bit, map);
+	spin_unlock(&adapter->maps_lock);
+	return summary_set ? 0 : 1;
+}
+
 /*
  * < 0 - not injected due to error
  * = 0 - coalesced, summary indicator already active
@@ -2984,6 +3051,8 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	int ret;
 	struct s390_io_adapter *adapter;
 
+	kvm->stat.io_set_adapter_int++;
+
 	/* We're only interested in the 0->1 transition. */
 	if (!level)
 		return 0;
@@ -3052,7 +3121,6 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	int idx;
 
 	switch (ue->type) {
-	/* we store the userspace addresses instead of the guest addresses */
 	case KVM_IRQ_ROUTING_S390_ADAPTER:
 		if (kvm_is_ucontrol(kvm))
 			return -EINVAL;
@@ -3642,3 +3710,86 @@ int __init kvm_s390_gib_init(u8 nisc)
 out:
 	return rc;
 }
+
+/*
+ * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
+ */
+int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
+			      struct kvm *kvm, int irq_source_id, int level,
+			      bool line_status)
+{
+	int ret, setbit;
+	struct s390_io_adapter *adapter;
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt s390int = {
+			.type = KVM_S390_INT_IO(1, 0, 0, 0),
+			.parm = 0,
+	};
+
+	kvm->stat.io_390_inatomic++;
+
+	/* We're only interested in the 0->1 transition. */
+	if (!level)
+		return 0;
+	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
+		return -EWOULDBLOCK;
+
+	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
+	if (!adapter)
+		return -EWOULDBLOCK;
+
+	s390int.parm64 = isc_to_int_word(adapter->isc);
+	setbit = 1;
+	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+	if (ret < 0)
+		return -EWOULDBLOCK;
+	if (!ret || adapter->masked) {
+		kvm->stat.io_390_inatomic_no_inject++;
+		return 0;
+	}
+
+	inti = kzalloc_obj(*inti, GFP_ATOMIC);
+	if (!inti) {
+		setbit = 0;
+		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+		return -EWOULDBLOCK;
+	}
+
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
+		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (ret == 0) {
+			return ret;
+		} else {
+			setbit = 0;
+			adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+			kfree(inti);
+			return -EWOULDBLOCK;
+		}
+	}
+
+	spin_lock(&fi->ais_lock);
+	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
+		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
+		spin_unlock(&fi->ais_lock);
+		kfree(inti);
+		kvm->stat.io_390_inatomic_no_inject++;
+		return 0;
+	}
+
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
+		fi->nimm |= AIS_MODE_MASK(adapter->isc);
+		trace_kvm_s390_modify_ais_mode(adapter->isc,
+					       KVM_S390_AIS_MODE_SINGLE, 2);
+	} else if (ret) {
+		spin_unlock(&fi->ais_lock);
+		setbit = 0;
+		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+		kfree(inti);
+		return -EWOULDBLOCK;
+	}
+
+	spin_unlock(&fi->ais_lock);
+	return 0;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d39c1375de2..98e7d807d620 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -70,6 +70,10 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, inject_io),
 	STATS_DESC_COUNTER(VM, io_390_adapter_map),
 	STATS_DESC_COUNTER(VM, io_390_adapter_unmap),
+	STATS_DESC_COUNTER(VM, io_390_inatomic),
+	STATS_DESC_COUNTER(VM, io_flic_inject_airq),
+	STATS_DESC_COUNTER(VM, io_set_adapter_int),
+	STATS_DESC_COUNTER(VM, io_390_inatomic_no_inject),
 	STATS_DESC_COUNTER(VM, inject_float_mchk),
 	STATS_DESC_COUNTER(VM, inject_pfault_done),
 	STATS_DESC_COUNTER(VM, inject_service_signal),
@@ -2851,6 +2855,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct kvm_device_attr attr;
 	int r;
+	struct kvm_s390_interrupt_info *inti;
 
 	switch (ioctl) {
 	case KVM_S390_INTERRUPT: {
@@ -2859,7 +2864,12 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			break;
-		r = kvm_s390_inject_vm(kvm, &s390int);
+		inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+		if (!inti)
+			return -ENOMEM;
+		r = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (r)
+			kfree(inti);
 		break;
 	}
 	case KVM_CREATE_IRQCHIP: {
@@ -3257,7 +3267,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		mutex_unlock(&kvm->lock);
 	}
 
-	mutex_init(&kvm->arch.float_int.ais_lock);
+	spin_lock_init(&kvm->arch.float_int.ais_lock);
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
@@ -4379,19 +4389,28 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 }
 
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
-				      unsigned long token)
+				     unsigned long token)
 {
 	struct kvm_s390_interrupt inti;
 	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt_info *inti_mem = NULL;
+	int ret = 0;
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
 		irq.type = KVM_S390_INT_PFAULT_INIT;
 		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
 	} else {
+		inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
+		if (WARN_ON_ONCE(!inti_mem))
+			return;
+
 		inti.type = KVM_S390_INT_PFAULT_DONE;
 		inti.parm64 = token;
-		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
+		ret = kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem);
+		if (ret)
+			kfree(inti_mem);
+		WARN_ON_ONCE(ret);
 	}
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 7ba885cb6bd1..6d2842fb71a3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -376,7 +376,8 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
-				    struct kvm_s390_interrupt *s390int);
+				    struct kvm_s390_interrupt *s390int,
+				    struct kvm_s390_interrupt_info *inti);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_irq *irq);
 static inline int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
-- 
2.54.0

