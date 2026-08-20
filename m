Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70043CE6B;
	Thu, 20 Aug 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228161; cv=none; b=gh28/yrz140kghYA8tq4HNYD7kCDuEYZJQYwWXIWfL+a9InsmfkRKa7SM/PH0l4+mmAM4t1icvKrFysS7VfzI76XeFQiSFzDcAWEcClIoKH9pYxroO8ulwEtLNXCNBTnJKM3NhNCKQqZaq4kIb5ovrXHgiiLG2cl2iYEwhyrXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228161; c=relaxed/simple;
	bh=rA5v6Hm7hUwwHEFtNZOF0bPLKYGpCEZ/o3YH+bzmxEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IirOuh96IJomNlJJh9Hc6OPTSvrMPTlYDXFrAppcW+/7knWMia3e2h1KtZbdXvYEIsn3FC11pGj8mhxe/BpAmYHo0nKW89/s7Bl4TxFqWN2Gihazvb2qn7AnCPj00T6Z8YwQ1t00xznnO7f0CV+1Dd2iZZ5rqNgJLTYhEnJp5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sEKf1vtB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sEKf1vtB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9FJC62795134;
	Thu, 20 Aug 2026 12:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vc4VuYilY9rC7ogHI
	+M5x7l7vJe9uKwty4zH3GTmgWo=; b=sEKf1vtBS5X4Q5rnHWQTbSBVzvtS1ZoO2
	gV/oFmKhpIjBmo3gQpGgDSQ3QA+Vwlm9gDe6y1Lz6z5eb4FlU4ZBS7IXlbdzfnuh
	qvilRzZmiwsoyyIBOCWvUCEWVMXf0N0PdzaCLLR1N1o642LXurzpazZXv3Fry/vB
	iLl3b/k8puPTZyz+tdahLkaMUJi9YScuz1zSDaV9EZbj2F/nCFSotg0hueNBOOH2
	qPAIYpBb5EjRCjtO2h6LFAXP4h/3BUazk/GiKyjZuy6zZIkTuJF9zhvpVrfB2NZ0
	49OuQOnw2W6EtgzHCiZzpKff+HmJ5UdllqM25HKWJfT862geJZBFQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0a4sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCBHKU007160;
	Thu, 20 Aug 2026 12:15:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yp4q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KCFsIB28443054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 12:15:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37BBC20043;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F6D72004D;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v4 2/3] KVM: s390: Kick PV cpus at the right time for service irqs
Date: Thu, 20 Aug 2026 12:12:17 +0000
Message-ID: <20260820121546.24694-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820121546.24694-1-frankja@linux.ibm.com>
References: <20260820121546.24694-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _4JgbT-i_tl5Yh1j1owifUjEqD93hxeE
X-Proofpoint-GUID: _4JgbT-i_tl5Yh1j1owifUjEqD93hxeE
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a86effe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=v6lTVEQnP7o5kkgoLDQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfXx9B6MQZU8DBI
 TV09PbajDdVMsVM2V0yq1Heq4F4xQkSYWctN6vXL7C7NHAwiXGsPTA1h5yP+hTHXjkLc6y94guS
 fYy1MpOaHAJm6xwI1LU/D9NHoaENo5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfX6tVwGWGKnN5p
 cxu65RTEL299qADpGaGEbV3hBDH6Qi30y3/++YQ/AdSA5bI5OXNT3y0GFD1ism6Zyvj/bgKHM/G
 mrNxP9x3lXMZFYgVgMi+tVRQAjmJ0r+8pgdRPzgbCvvodo/w2yv3v7lxzFLjTZfR9nvUZt7ayCG
 hr0bQpVfJ9la6lnCNLiX683C5fFtc6SmnQixscXzfkSZ28RpwgzJ6cBLdGlGDRFRWHkJJgUunHA
 64x+1EAxZhRg26Z8GzQ47I8uCqUCCG6xX6ks0jT/tlJNsHxXThB5Mem2NoAP9i6SWmDmaofX+mT
 Or1FK57xrO0rvOXeEpix8/swq2LnC3jlotnxSNT05QpWoIaxX/CBeKxueT+Fl//F/Ao/isECZMU
 QvLbRYCwF8PoQ3OaNS1S2WBTGM1LL8LWmWlgtbdwAXlqhd/kJ9C4+2z/wBw/c0dkEWNEiExR8t6
 9w9QRGzhYYOuut6LE/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200089

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
 arch/s390/kvm/interrupt.c | 50 ++++++++++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.h  |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

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
index 87caad037765..b3e4bfeacff2 100644
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
@@ -1998,10 +1995,46 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
 	vcpu_intervention_kick(dst_vcpu, type);
 }
 
+void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The cpu that called sclp likely will also take the IRQ, no
+	 * need to kick anyone.
+	 */
+	if (likely(deliverable_irqs(vcpu) & BIT(IRQ_PEND_EXT_SERVICE)))
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
@@ -2012,6 +2045,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		rc = __inject_virtio(kvm, inti);
 		break;
 	case KVM_S390_INT_SERVICE:
+		parm = inti->ext.ext_params & SCCB_EVENT_PENDING;
 		rc = __inject_service(kvm, inti);
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
@@ -2019,7 +2053,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		/* Grab isc here since __inject_io() might free inti */
-		isc = int_word_to_isc(inti->io.io_int_word);
+		parm = int_word_to_isc(inti->io.io_int_word);
 		rc = __inject_io(kvm, inti);
 		break;
 	default:
@@ -2028,7 +2062,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
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

