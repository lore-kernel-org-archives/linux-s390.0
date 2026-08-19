Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2D3CF1FD;
	Wed, 19 Aug 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166273; cv=none; b=K/11sttu4SeBgGuUSAU+EGoy/3tengkv1C8MDm0VTns3ylNruy8nmpM8yBo82MqkQnE1tv5s48aXextb1hH7hj38uawM7COCjnjVRpB/f02BU5o85WQf+Nui4ix5tQm1phEN1kQhCRnt8xp4Lm8adjw0XQGWT+kF63Gt6E57iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166273; c=relaxed/simple;
	bh=Yh6x5c7C90XvY3tJvBUImvXwTP1fR/823l/c8XVfpi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LewOW5jW5cjDZP8vspzEK0v1wiP7qVfzfFgLmE65HZLeT+/JDK8BGKS5xLeEchUiOqzS4pBQhckpo9u4aSMR9uL77AbVtsoJUwzE5On1SoiLPIR09oaZfhjsIi4+ZX/h1ZlNtk41ikVWtx/pecnPU2unFuRBkwi+lSKqdj5h+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mok/gg5H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mok/gg5H"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1bbt4162548;
	Wed, 19 Aug 2026 19:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lC0lKvipPFO9/L1SK
	BtOO2oeVQ18wx7xfqxgDcvR10s=; b=Mok/gg5Hujzy/d0cwY1XEErPR9BGiaW1R
	Ng8ZG4Pm7c6b/1ADRvsRytIeGc+4uRoffPUdkAhxvsLTaWNe4lYkGoWBhFr6bEqP
	NHeOpUDAjHQIEBU3C0ksq2fHD1jLC7IxGOA18iYzEMtBYhmIZbkAhlr6tuJ/yj4R
	4p0TvYo/0dveLuMIRuXFZtUzk29XzB+hQkAWPj6BvJZNwZLHged7Vf4yQ9WsXmfo
	5xlAEIbehdKFMnblrta1WuPZGrmjCtX8qDbl6/3Joc7tvAiRGVcMnSrnvQ74Fk7D
	S/IPGcY2aADrSgwD5FHDPVYxZvWcsA0gmKMVBceWBSICq0qftmLnw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1dq6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JIuJPu020899;
	Wed, 19 Aug 2026 19:04:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekagb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JJ4OJR45220172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 19:04:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D991820040;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB61B2004B;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection behavior
Date: Wed, 19 Aug 2026 18:41:10 +0000
Message-ID: <20260819190408.247843-2-frankja@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85fe3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mNrvo4Ka_OWIiVjgUZwA:9
X-Proofpoint-GUID: MFGdAxwdSqJFOSDWyu-VQ6qSdTdJMtpG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX0okedqiTYl2d
 VLJZ9DbvgM59X+RskDXytmnAAnf5hBXtv13vMTXwo2rVzyn2hOkS09X4UkoZBwvhpsUS5YX88ez
 s08TZSxWOerbzEsZEosPBWby4Zbj0pI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX+XMspeXjWQtl
 qk9Jvl1enBTGDTvFEUttEnLvnxPqhjvI8ll7nYWCNwDypuHq6Ldqmzze0xdDx1a5rsyrExnL0AL
 d+L1XeCOuFZsdP3xjmgK3dq59sZBg+mt1MMnX0ajiaNLRbDm+kYEOKNc6F7CynwLm0yzDmpSnoq
 QsZhWQQMNv8frW+HKUPeE/oVC69p+MLJRHGi6DL8OAxQ1iq1Fn1WdWVwG8hTtNJE3Q102dIDazV
 +vTxT0TPiUg9h6SwcA7IBckcNhWT2SNA0+C3Cx/CNDz62dAy5/msog25X8kSqIrIkLPvt4rKbpt
 ze1ULbm1BZHB5N3FcYzAkm5HkA3Vp6i4RwiRnsXWLcYGo5h33YeKfbX8q1vJfMeH+XLEUPbCpXF
 JBZ/SMJpMz02PpQTJkbW9YXw0Vpm+KKNmZ3f+AMitTA/4Y007bp5Zg/bgaGCGxTy8BUsLeI4USG
 L8OAbMQcFp71dklcVGg==
X-Proofpoint-ORIG-GUID: MFGdAxwdSqJFOSDWyu-VQ6qSdTdJMtpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190147

Floating IRQs can be handled by any VCPU that opened its masks. The
current design does not check if the mask is open when a floating IRQ
is injected via the FLIC. It will wakeup the last VCPU that went
sleeping hoping it's the correct one.

Improve this by checking if the VCPU has pending IRQs and if not try
to find another VCPU which can take the IRQ.

This is not the final fix around this topic but we'll eventually
inject a pending IRQ. The current code can easily deadlock a VM and
with this fix we work around that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 86 ++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8f24bcd1a6d3..3af060ec5be8 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1915,49 +1915,93 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
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
+		return isc_to_irq_type(isc);
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
+		if (nr_tries++ >= online_vcpus * 2) {
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
@@ -1974,6 +2018,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		rc = __inject_pfault_done(kvm, inti);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		/* Grab isc here since __inject_io() might free inti */
+		isc = isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
 		rc = __inject_io(kvm, inti);
 		break;
 	default:
@@ -1982,7 +2028,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	__floating_irq_kick(kvm, type);
+	__floating_irq_kick(kvm, type, isc);
 	return 0;
 }
 
-- 
2.53.0

