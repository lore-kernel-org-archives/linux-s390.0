Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69132ED40;
	Mon, 17 Aug 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969018; cv=none; b=fiBXaft7LHLlHIwAtntRDMbhDc6hhB125leJo+KtmHLC5uquQs0WyV02JBBmx9lhPLlyXyARD1aIlT3JJ/KqOFHzIYO//R4F50+O/8QyosJAX0T6kcvGSIG99nuhPCZ5QpicLj/yqDjET5ST4AVhyG0ZpLrskwS/fB2XGsCn19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969018; c=relaxed/simple;
	bh=hli8MrkSfRG+dXI3KmzQ4CBKAavffVT13Kl8db5FPjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cD5rw9XfhgptnKs86jyUyv47GspA9+jZjH4H5CDWv/T7h0+Pwsf6K80lGP6x+nNKsc5P2F4cmiMZJgh/3uPu7valxWJ5WhPEczFNQBjnC7JVGedrAIAgfy945kzWabp+y193ZLTwZVvwvvB3SXnl6MbGHfbxvkD8SOqiWNQtduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gn8lahRh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gn8lahRh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HAa7fx3685920;
	Mon, 17 Aug 2026 12:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Bs6xL2BcdsGOVMGQnq8CcaiQSPauz5kER/3pIU7JP
	dM=; b=gn8lahRhR/sDbOiVfs6IvQNqNqFFA9ebNZ1LADRm/3OUsQXjjoIsDeexB
	ehWwP/ntvGEJ7dT85IGcAyM8k5l7eJ4QOYSH1iONOClaoUB2nYWpjuFpIlWriCOm
	bGwkLCXfuPCqziwlK1MGQgaMeZuMpMD8nwc/tPs3bg01O4FsvLNAiKT3ic1gv42H
	vu+Ol7zrjFJeHai/9HvhzmAGx5s/L1CSUsdCPkGOdxaUm+JFu2W1rOprdOZAbI6d
	Z6/2Q4hXGNT+V59UJjbNiLxrcPb6fxD7a0G0B3FNL9UY3nn8j1+1WvRgveKA1nuI
	ld5YxcksLH1yo32a3re9s/oBnIfJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3j5qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:16:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HCC7oe026184;
	Mon, 17 Aug 2026 12:16:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5rj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:16:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HCGp7L40698284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 12:16:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0E12004B;
	Mon, 17 Aug 2026 12:16:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D2E20043;
	Mon, 17 Aug 2026 12:16:51 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 12:16:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com
Subject: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
Date: Mon, 17 Aug 2026 12:13:10 +0000
Message-ID: <20260817121631.159451-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: exSsGlBu-fY0Wj8y5-C-yO_h8LUDqUJX
X-Proofpoint-ORIG-GUID: exSsGlBu-fY0Wj8y5-C-yO_h8LUDqUJX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX3s/cbsIQkPzv
 rDi0VSN87lUC09rKF5jrRqBP3M6dkZYAt5Z5fRtPMieBXRV4lp25D/bO9j+A6ncsgfN/0kbcHRR
 upF7IFQPgLMMMGmMH4+Cm1PpfMd1mJY=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82fbb8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=eafQdAodyzljY6xa4VIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX7KHT5RrSI33v
 Sn8ihypIefCRjJPf5pfcQVqvA+XowMsMGlNyxrd1cakVOXt/C3H5xmmi75m7XrGUfr29SOjQeOI
 9/rFXsc6ewVRDKpqagAYqcHRlTM4LSAhmmIt5LwnjIMt9LR9jfFF1AFjKO4dzzE78VLrahp1HER
 HM9DtBoVaVX9u0/agNkaVVHzdHvzHQRv5pBX0DoHWuH9MzNxxen1XmFXPed0rhBFEoMlrj/986T
 7QsNzNgSW0NZzlVgcyNcA2KAPqNML+XagbPDJhYKPfdsWfd35JAUgxyH/z13xx+IVGeZrP/Ztjd
 tN2s1Lv+rVw+OIDCUZhjDponVNAadVG0+Ef6Wb2EywYZatVjKFhJfO7ZeqNz/xOmGsdCmkSo8/a
 EZhiCapvmX9KapgdHMEwSLnUcXhAiRhSGmKEA55ER5kKzp/3aG3jgZFVV9dESXal7w9GEoWXNNG
 Q9RQxsbKCL7YAvG4uVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170091

Floating IRQs can be handled by any VCPU that opened its masks. The
current design does not check if the mask is open when a floating IRQ
is injected via the FLIC. It will wakeup the last VCPU that went
sleeping hoping it's the correct one.

Improve this by at least checking if the VCPU has pending IRQs and if
not try to find another VCPU which can take the IRQ.

Also add a function to distribute floating IRQs which can be called on
VCPU enter or exit. It will check for pending floating IRQs and wakeup
sleeping VCPUs which have pending IRQs.

This is not the final fix around this topic but we'll eventually
inject a pending IRQ. The current code can easily deadlock a VM and
with this fix we work around that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

v2:
 - Rebase onto master
 - Added IRQ type check before delivering

---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/interrupt.c        | 63 ++++++++++++++++++++++++++++++--
 arch/s390/kvm/kvm-s390.c         |  3 ++
 arch/s390/kvm/kvm-s390.h         |  1 +
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b4182ca4435f..1d62bdd7aca5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -467,6 +467,7 @@ struct kvm_vm_stat {
 	u64 gmap_shadow_r3_entry;
 	u64 gmap_shadow_sg_entry;
 	u64 gmap_shadow_pg_entry;
+	u64 inject_redist;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8f24bcd1a6d3..e67cdedb5aec 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -367,6 +367,37 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 	return active_mask;
 }
 
+void distribute_float_irqs(struct kvm *kvm)
+{
+	struct kvm_vcpu *dst_vcpu;
+	int sigcpu, online_vcpus;
+
+	if (!READ_ONCE(kvm->arch.float_int.pending_irqs))
+		return;
+
+	online_vcpus = atomic_read(&kvm->online_vcpus);
+
+	/*
+	 * Not too worried about synchronization for idle_mask. We
+	 * might burn too many cycles but apart from that waking a
+	 * vcpu is not harmful.
+	 */
+	sigcpu = find_first_bit(kvm->arch.idle_mask, online_vcpus);
+	/* Well nobody's sleeping so someone will likely take the IRQ soon */
+	if (sigcpu == online_vcpus)
+		return;
+
+	do {
+		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
+		if (deliverable_irqs(dst_vcpu)) {
+			kvm->stat.inject_redist++;
+			kvm_s390_vcpu_wakeup(dst_vcpu);
+			break;
+		}
+		sigcpu = find_next_bit(kvm->arch.idle_mask, online_vcpus, ++sigcpu);
+	} while (sigcpu < online_vcpus);
+}
+
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
@@ -1915,22 +1946,48 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	return 0;
 }
 
+static u64 inti_to_irq_pend_mask(struct kvm_s390_interrupt_info *inti)
+{
+	u64 type = READ_ONCE(inti->type);
+
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
+		return BIT(isc_to_irq_type(int_word_to_isc(inti->io.io_int_word)));
+	default:
+		return 0;
+	}
+}
+
 /*
  * Find a destination VCPU for a floating irq and kick it.
  */
-static void __floating_irq_kick(struct kvm *kvm, u64 type)
+static void __floating_irq_kick(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
+	u64 type = READ_ONCE(inti->type);
+	u64 irq_pend_mask;
 
 	online_vcpus = atomic_read(&kvm->online_vcpus);
 	if (!online_vcpus)
 		return;
 
+	irq_pend_mask = inti_to_irq_pend_mask(inti);
 	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
 		sigcpu %= online_vcpus;
 		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
-		if (!is_vcpu_stopped(dst_vcpu))
+		if (!is_vcpu_stopped(dst_vcpu) &&
+		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
 			break;
 		/* avoid endless loops if all vcpus are stopped */
 		if (nr_tries++ >= online_vcpus)
@@ -1982,7 +2039,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	__floating_irq_kick(kvm, type);
+	__floating_irq_kick(kvm, inti);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..d6d46688d980 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -86,6 +86,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, inject_redist),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
@@ -4572,6 +4573,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 		rc = kvm_s390_deliver_pending_interrupts(vcpu);
 		if (rc || guestdbg_exit_pending(vcpu))
 			return rc;
+
+		distribute_float_irqs(vcpu->kvm);
 	}
 
 	rc = kvm_s390_handle_requests(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6d2842fb71a3..a2bcf4acac16 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -375,6 +375,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
+void distribute_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int,
 				    struct kvm_s390_interrupt_info *inti);
-- 
2.53.0

