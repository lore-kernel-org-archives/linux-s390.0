Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0C3BE630;
	Wed, 19 Aug 2026 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166273; cv=none; b=k8PLeSL+kJKhICH+kyNiNi4Olvhk2kS59WsGiR0p7LDc1i+/x8AfC4PZ4YdarqKHV288rVFPiTj7xib7mD36qArwDruADUHErTcZN/P7SeD12FE/4gvKhlIL61OrxpAZjCrxyhb2WiQgRcMW72ctgRehO6bAPvklWD3BicMNjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166273; c=relaxed/simple;
	bh=9bZhviFo6xJp33bVnTvAGdbcX3ZtXtML1jded61wJmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsUcUH2EXI2UC3/xVfwuWlmVKqNLisHBOrtnNjgantWAyRdfkMtQFBZrfvfUi/eCbJvr95MtJLALChMb4+jm7gsM/qQsouPvquaUCxaNwP7nwu2EQ91xAh2aqdYZ6TFK+KAqYQTHoQ2uEfvOFp21vj0B8jsoz7ypytveaQxqHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IDl6cOXh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IDl6cOXh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1pJe4100533;
	Wed, 19 Aug 2026 19:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qku/RsADLEdhLSd2y
	457tZiQvvtri6RamcnI+LJaj2E=; b=IDl6cOXhUI4vqTZuhwtT6fAOzK8289qxC
	s7P08EfhgJSeDZMAWUMok7skgFh9DddhdDmkKW6lsX5SsoKs6aOeYnAH+8Z2yc3X
	gS+LRir7zH43dKj4UUX6ENtsMeqlpmYNkeRk0kYww6DmYxgAqvRyI20PpgKjfGPv
	98WOukGAh0hQLalkk3JGVCd4YU5oFNDIDKdrtSSv3jGmJwyBS3QvVka0wVhdbPlj
	Ym/TRH8cpN0x7erhZ0v7XHhZNh4engK17m652AOmnGmPkEc1Itl7bjbLati9LSYF
	31o5ahN+ON0irSEOhOeRrRzm9wMYrnvrELp+faD5qD/emQlXZz2Cg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu45kka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JIuKBR022790;
	Wed, 19 Aug 2026 19:04:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhaf3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JJ4PrH7078224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 19:04:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0642620043;
	Wed, 19 Aug 2026 19:04:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF232004E;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v3 2/3] KVM: s390: Kick PV cpus at the right time for service irqs
Date: Wed, 19 Aug 2026 18:41:11 +0000
Message-ID: <20260819190408.247843-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190408.247843-1-frankja@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX+l0TiGhIqpC0
 Z2wUB/TBQ+hnkXjAphNfxsRe9eVXvK8ywGoX+Y+G99Ac4FUyq0LGdPT+kKkLZg869aaib1mMTIk
 W58ERFUDEWVmLVvBJQn40hTMPrifzBE=
X-Proofpoint-GUID: Zr4BPKpUCQZBUeGcm_zau6lx-EvbwAEj
X-Proofpoint-ORIG-GUID: Zr4BPKpUCQZBUeGcm_zau6lx-EvbwAEj
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85fe3d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=v6lTVEQnP7o5kkgoLDQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX2afSB/435crF
 OaYOEp7/5rKMpc03eezzkwqps0Hpg6+wgEJchbLMTo6QVg8R26RycXJSPSLtqgGbuBjJaWWz5gw
 +gjNnmXQlPDBEtcKRI+mo7AV9XzdKTVICYS633mc1P4TdInbNHHCSWDYv14UaDbHSLBbvzJ9onR
 zueS2rTef0PJVy55wJK8Q452913cnvUGikQZ64i42gnJhD6jQJEnAo/AE07BIYqttv+5wkjtCmm
 iGn7GJFaQnH0dmyGjm5PR3cJazZVyOSnITCrIsnWnWQXWTPBxbFk3rKMEHDah3TDEJ/HZIuauR+
 BLY7ZEoMWnjIH7WvahSjHLkeuuq7rUCwpvArKH6UchkT7Ez7/aLw6yxp9oX+RkHbQDemDe7RKD4
 j/Tfnm+VGv24k9inDzG/keHuwDqiJKm/QVptaXLkHuWvKfVkOWNwuTVke3kTtgdqZwbFqAk/l5I
 Led7cH3OguVDZAbGdYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190147

Service call handling is a two stage process for PV vms. First we
receive the secure instruction intercept and then the secure
instruction notification intercept.

The secure instruction intercept (104) is analogous to the non-pv
instruction intercept (4) with the difference that we're not allowed
to inject an IRQ when re-entering SIE. We have to wait for the
notification intercept (108) which tells us that we're allowed to
inject.

Unfortunately we never considered this difference and hence the IRQ
injection code will try to inject on the secure instruction intercept
where service IRQs are masked.

It's time to move injection to the instruction notification and skip
injection on the instruction interception path.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/intercept.c |  9 +++++++
 arch/s390/kvm/interrupt.c | 53 +++++++++++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.h  |  1 +
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1980df61ef30..e1de3f471ffd 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -536,6 +536,15 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
 	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
 	spin_unlock_irqrestore(&fi->lock, flags);
+
+	/*
+	 * We missed the floating IRQ kick since we can only inject
+	 * when we end up here and not when the irq was injected via
+	 * the FLIC.
+	 *
+	 * Now that we have cleared the masking we can kick cpus.
+	 */
+	kvm_s390_pv_sclp_kick(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 3af060ec5be8..53ba74a749e8 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1960,10 +1960,7 @@ static void vcpu_intervention_kick(struct kvm_vcpu *vcpu, u64 type)
 	kvm_s390_vcpu_wakeup(vcpu);
 }
 
-/*
- * Find a destination VCPU for a floating irq and kick it.
- */
-static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
+static void kick_cpu_irq(struct kvm *kvm, u64 type, u64 parm)
 {
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
@@ -1974,7 +1971,7 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 	if (!online_vcpus)
 		return;
 
-	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
+	irq_pend_mask = inti_to_irq_pend_mask(type, parm);
 	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
 		sigcpu %= online_vcpus;
 		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
@@ -1998,10 +1995,49 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 	vcpu_intervention_kick(dst_vcpu, type);
 }
 
+void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The cpu that called sclp likely will also take the IRQ, no
+	 * need to kick anyone.
+	 */
+	if (likely(deliverable_irqs(vcpu) & IRQ_PEND_EXT_SERVICE))
+		return;
+
+	/*
+	 * For the other cases we might have sleeping cpus with open
+	 * masks. Time to find and kick them.
+	 */
+	kick_cpu_irq(vcpu->kvm, KVM_S390_INT_SERVICE, -1);
+}
+
+/*
+ * Find a destination VCPU for a floating irq and kick it.
+ */
+static void __floating_irq_kick(struct kvm *kvm, u64 type, u64 parm)
+{
+	int prot;
+
+	mutex_lock(&kvm->lock);
+	prot = kvm_s390_pv_is_protected(kvm);
+	mutex_unlock(&kvm->lock);
+	/*
+	 * No need to kick on non-ev service IRQs for PV VMs, we're
+	 * not allowed to inject anyway. We need to wait for the sclp
+	 * instruction notification AFTER re-entry of the vcpu that
+	 * handled the instruction intercept.
+	 */
+	if (prot && type == KVM_S390_INT_SERVICE &&
+	    !(parm & SCCB_EVENT_PENDING))
+		return;
+
+	kick_cpu_irq(kvm, type, parm);
+}
+
 static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	u64 type = READ_ONCE(inti->type);
-	int isc = -1;
+	u64 parm;
 	int rc;
 
 	switch (type) {
@@ -2012,6 +2048,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		rc = __inject_virtio(kvm, inti);
 		break;
 	case KVM_S390_INT_SERVICE:
+		parm = inti->ext.ext_params & SCCB_EVENT_PENDING;
 		rc = __inject_service(kvm, inti);
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
@@ -2019,7 +2056,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		/* Grab isc here since __inject_io() might free inti */
-		isc = isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
+		parm = isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
 		rc = __inject_io(kvm, inti);
 		break;
 	default:
@@ -2028,7 +2065,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	__floating_irq_kick(kvm, type, isc);
+	__floating_irq_kick(kvm, type, parm);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6d2842fb71a3..8e886bcef4a0 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -375,6 +375,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
+void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int,
 				    struct kvm_s390_interrupt_info *inti);
-- 
2.53.0

