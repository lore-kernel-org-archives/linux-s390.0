Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA525B090;
	Mon, 28 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599016; cv=none; b=Kx3NzI4roBe1xiXRoWgKC1Ke/dv4TbZsirec87L+Ix4W4FFlcGtHpkWpJ6Taz2IL4sdviucqp2QiWAgILn2ke8uXZGJ6RN03vRmyoLeJGH5KmabcFn3PUjVjUlOdQYhKt2Mp4uqcFP+eHO1qa8UbOKFkP4wI+L3agY5aV2z0lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599016; c=relaxed/simple;
	bh=GMHjw555lf2OCZM7gtLGlYdUphlQlM4lpVMv463/sgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYgA5+HOZOBex9rBBY3a6hkF3q1bSBP8SFq0r7Cm90qkSUiybqC+DCzfCRO4NUbBJhRjzmKEhpr4CwC10ynFBhTDlzi1yqMP1pKIuTtEXvHHuKoIXpsGC6mV7DLBIeV+mk9hoyfWtQZyACxOq1zw/LfN8DJEYNiJbalM0dLaIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ccw4CjEo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ccw4CjEo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZV2i3374992;
	Mon, 28 Sep 2026 12:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2VBdqwtAOnkpVXZDq
	ScjssOrwsr/fqT7YFF867oAo0c=; b=ccw4CjEoM62MDVUA4nJlmYIskvkQwZwSe
	6WTm2C8rwqmy7k3Kf5tdrJ/cKUm64FTaL2SUXYjozkMWBK7TaIAvEMP6PfNPwDUO
	9UF1DHXldzKg2f8cJ4XAQq5mucM80oovpgRw8rLnR6wSCsNCPhW53+x1rVqNkZyA
	KDVeKZ3dmrYWZIBbtUGhgP+lvTdTbj8evJt3bffJzqngOs0/zuq9y0Pef3dFD2Qw
	8h6zMLkTAaKHg1/9XMmCUKQhEyySnAL5yzCUKoZ3hYUOsAo07bnRhOKCzU+lJr5p
	0VrRyOBoGE8RLa/NB36GPBUYE9Felblbcuzojv01aWhfnHG5GFytA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr18jm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHWph017601;
	Mon, 28 Sep 2026 12:36:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck56cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCanwW40763718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:36:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113662004D;
	Mon, 28 Sep 2026 12:36:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54812004B;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v5 2/3] KVM: s390: Kick PV cpus at the right time for service irqs
Date: Mon, 28 Sep 2026 12:30:56 +0000
Message-ID: <20260928123639.34226-3-frankja@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfX3cnm7wLL5eUP
 EAUBNCEMh0YDAhpHgsxpUEmqU8ulWLIxBrgQ6jM9HF53+DzJe6/ZriXuRIlfxEDd3DANmddo5Ws
 JFiCqerjakMPH7ynYzjXjAzOrpRwbBj8n4y19EWVETVcgvN41KZXbSg1DJ1osgzR+4+SsUSZ8Y0
 4CLcIdZW6buIRJuH+YAZf/bw8fh6wdsPy+n1fOwOUga4AmXHO7Qk1um7Azmu84QU+S2NGnoT/Mq
 v2KQYHj51NB26581/aQf28eZQ1y3M7LN8dlFtV33kbf5IFAAUv2vFOOBBgqpN1iVZHk8c/cQxS1
 KpdP57GNWt81PfhJRXUN7RjE7U8pjb7vwN9vRSbF7vYOIvw4p6Pql1MLCES2PGfcnIQIg+S4o40
 vWrV38VOnrO21CVUqLJnZ2BHzhPwllHpbqgkT6bXbHKP58ivfdFXvdNj1ahH4LOOhjgY3PxLy9z
 Ox1Ka68PAgOTqXxaB0A==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba5f66 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=v6lTVEQnP7o5kkgoLDQA:9
X-Proofpoint-ORIG-GUID: tUo_xESZkepubt9IuRTFod-N17RyzdXG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfX8PJSViItRIp6
 rIFjGnETuLPv1G9lbtxzVE5ouHpgCuu5KEgF2sb621KyRCrx9xPgjkNkTuW/W8MeZOauYe7UIPR
 EXcYp3BjXWx3GmX7BmjgxS9LCM0EZkQ=
X-Proofpoint-GUID: tUo_xESZkepubt9IuRTFod-N17RyzdXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280050

Service call handling is a two stage process for PV vms. First we
receive the secure instruction intercept and then the secure
instruction notification intercept.

The secure instruction intercept (104) is analogous to the non-pv
instruction intercept (4) with the difference that we're not allowed
to inject an IRQ when re-entering SIE. We have to wait for the
notification intercept (108) which tells us that we're allowed to
inject.

Unfortunately we never considered this difference and hence the IRQ
injection code will try to kick on the secure instruction intercept
where service IRQs are masked.

It's time to move the kick to the instruction notification and skip
kicking on the instruction interception path.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/s390/intercept.c |  9 ++++++
 arch/s390/kvm/s390/interrupt.c | 50 ++++++++++++++++++++++++++++------
 arch/s390/kvm/s390/s390.h      |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/s390/intercept.c b/arch/s390/kvm/s390/intercept.c
index ca1205dfac8b..031d8fb0df06 100644
--- a/arch/s390/kvm/s390/intercept.c
+++ b/arch/s390/kvm/s390/intercept.c
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
 
diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 1e013058f558..3c0e6216eee3 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -1963,10 +1963,7 @@ static void vcpu_intervention_kick(struct kvm_vcpu *vcpu, u64 type)
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
@@ -1977,7 +1974,7 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 	if (!online_vcpus)
 		return;
 
-	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
+	irq_pend_mask = inti_to_irq_pend_mask(type, parm);
 	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
 		sigcpu %= online_vcpus;
 		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
@@ -2001,10 +1998,46 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 	vcpu_intervention_kick(dst_vcpu, type);
 }
 
+void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The cpu that called sclp likely will also take the IRQ, no
+	 * need to kick anyone.
+	 */
+	if (deliverable_irqs(vcpu) & BIT(IRQ_PEND_EXT_SERVICE))
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
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+
+	/*
+	 * No need to kick on non-ev service IRQs for PV VMs, we're
+	 * not allowed to inject anyway. We need to wait for the sclp
+	 * instruction notification AFTER re-entry of the vcpu that
+	 * handled the instruction intercept.
+	 */
+	if (type == KVM_S390_INT_SERVICE && !(parm & SCCB_EVENT_PENDING) &&
+	    test_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs))
+		return;
+
+	kick_cpu_irq(kvm, type, parm);
+}
+
 static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	u64 type = READ_ONCE(inti->type);
-	int isc = -1;
+	u64 parm = -1;
 	int rc;
 
 	switch (type) {
@@ -2015,6 +2048,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		rc = __inject_virtio(kvm, inti);
 		break;
 	case KVM_S390_INT_SERVICE:
+		parm = inti->ext.ext_params & SCCB_EVENT_PENDING;
 		rc = __inject_service(kvm, inti);
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
@@ -2022,7 +2056,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		/* Grab isc here since __inject_io() might free inti */
-		isc = int_word_to_isc(inti->io.io_int_word);
+		parm = int_word_to_isc(inti->io.io_int_word);
 		rc = __inject_io(kvm, inti);
 		break;
 	default:
@@ -2031,7 +2065,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	__floating_irq_kick(kvm, type, isc);
+	__floating_irq_kick(kvm, type, parm);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index aa0d1d062f8d..9ed1af5583e3 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
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

