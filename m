Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA473BE635;
	Tue, 11 Aug 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463815; cv=none; b=gzoxjyjR0NuDCTS5nKOspCE3KqnjDU0U/pZnwYM/dlB8iA64bXeV57tvKxitxW2V5U9AEVogjDV7M7HvN4YP4vqfSSCYMbVsBx1L9vQ6e2eamCED2FYiBdSkH/zZHqGQB6vaxEgoEF2U4GtNjek6KGUlXVHH0pWg5bNmF5kFy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463815; c=relaxed/simple;
	bh=JQMh3x3ooIJQeODnyzd/1NBcbiTHkVMOqzEQoA+6qrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZorcwGGOr94fDu4hoSce5Hcchm/Zdn1gb8DjWFzUaxGL+2z8JH6PJlfx07BlwLpL4Ua7yqeSRVfvngh9HMpgPI1dyceNuIRl2AYxwajQbpaPguBqGb2BfnefhnL2M+1WAAvnNjZF8913ANGOQ7OSxFNcuRESIUkd72fjqdwqBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJSTeRMl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJSTeRMl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWtYi3633607;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OE4Be9WHs87ZHWaXo
	CGiEeXU4lC7HNIxNEIo/QJomO8=; b=nJSTeRMlXUSHZIrSFhMcn2JEZJi5FrSHF
	ksfEHRJ06HU+21MJ2NwEkNtvtXu7NYJumuhR0ofZ+WICHkr/F8FzuD61o84auBMG
	E5PwheX0Ss49IURznZWu3+wUM38zSUsbzPOarnzM8+NpYe/CBoYcCUW4gPczqIOY
	8O7RhqmEJuKIR7lxVViCzJCn9reZyex20xYsV9KPSacBZwReiJgI09dUry47JJ10
	zqtUoxKrj1yOajYWRaU8whu6z3CXFlW6mVE+lByG2FO3XS1I3fMtvVxtQNo/Tgwg
	9LDYJ3xGcfYYHWhBXnnUiOXwDsqxqFeIhypAO+3aKcBAdCx0ZvhDw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pgg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuGPF031754;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9fu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhlF33685786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AC22004B;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE54D20043;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 03/11] KVM: s390: Fix get_all_floating_irqs()
Date: Tue, 11 Aug 2026 17:56:33 +0200
Message-ID: <20260811155641.219777-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=I56Ky5MJo1-tBM2s_1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+vTChXa7Aodq
 UAmD1X7HAGGEG7xMNAjBd6P6T/3X2wqOPAu9fofdLNlAz/swRiZRrCSpJmjSk+KkBOJi/Oc9mVd
 X735Pt9wIjzS7WAyUToPcMjA/l6ZVWtTrxAJeGrZWeo91QK0/lDUoR3TQFtOD3D6Mw7YUfs+761
 qfGIjTuBSR+dcGnDaKJ+UKRii5X7cFPofuQ8YhTv0SAjTHw7SY3AdC+CFJ8hnv115p8v/+Qvf39
 2labLknVXrO1ThlPv+es/trkGchKT+M9RK6rWB65XmlU4zGsyhu7p6MVPPt+Uh0ee6JNYdHbSJ/
 /Z4J+D8tlgt/XNo39PKOdMjEb6x2S6EuXoo1JF9tUM/7uYvOqgVYJgOLlcnIAf64Zu17ybDBD1a
 JdGCv2dt0N8E4jSGrLEJWaLX1x59+Xp4lqKFLcWvpRPe0zX6xkIEQ2sCZPOHOpDeFNklkE1sTe+
 /x6CliwoKkkK11GcHfw==
X-Proofpoint-ORIG-GUID: tAQKx-M9hmSQU1GLSbqAeGWBS7Qi_xHx
X-Proofpoint-GUID: tAQKx-M9hmSQU1GLSbqAeGWBS7Qi_xHx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXzEsmMqDSlr6L
 6ij61Xnlnd7Dm19CknpXlF3CCT1+Q69kZEQEHaXrj0gqR+QjyLk883RgydHtUgQYn6FkSX69mMM
 EWxb1MkrWFW/xbBx2oOa5tUigTSKKY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

When attempting to report all pending floating interrupt to userspace,
the GISA IPM bits are atomically tested and cleared, and the
corresponding interrupt description is written in the output buffer. If
the output buffer is too small, an error is returned to userspace, but
the GISA IPM bits are now lost.

Fix by moving the GISA test at the end of the function, and keeping
track of which bits have been cleared. In case of error, set the bits
again, so they are not lost.

Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interface")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 93 ++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6b3f97a7513b..30963e05e0e6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2211,15 +2211,14 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 {
 	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+	struct kvm_s390_irq *buf __free(kvfree) = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
-	struct kvm_s390_irq *buf;
 	struct kvm_s390_irq *irq;
+	unsigned int tmp = 0;
 	int max_irqs;
-	int ret = 0;
 	int n = 0;
 	int i;
-	unsigned long flags;
 
 	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
 		return -EINVAL;
@@ -2235,14 +2234,48 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
+	fi = &kvm->arch.float_int;
+	scoped_guard(spinlock_irqsave, &fi->lock) {
+		for (i = 0; i < FIRQ_LIST_COUNT; i++) {
+			list_for_each_entry(inti, &fi->lists[i], list) {
+				/* signal userspace to try again */
+				if (n == max_irqs)
+					return -ENOMEM;
+				inti_to_irq(inti, &buf[n]);
+				n++;
+			}
+		}
+		if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
+		    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
+			/* signal userspace to try again */
+			if (n == max_irqs)
+				return -ENOMEM;
+			irq = (struct kvm_s390_irq *)&buf[n];
+			irq->type = KVM_S390_INT_SERVICE;
+			irq->u.ext = fi->srv_signal;
+			n++;
+		}
+		if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
+			/* signal userspace to try again */
+			if (n == max_irqs)
+				return -ENOMEM;
+			irq = (struct kvm_s390_irq *)&buf[n];
+			irq->type = KVM_S390_MCHK;
+			irq->u.mchk = fi->mchk;
+			n++;
+		}
+	}
 	if (gi->origin && gisa_get_ipm(gi->origin)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
+				/* restore removed bits if returning failure */
+				__atomic_or(tmp, (void *)&gi->origin->ipm);
 				/* signal userspace to try again */
-				ret = -ENOMEM;
-				goto out_nolock;
+				return -ENOMEM;
 			}
 			if (gisa_tac_ipm_gisc(gi->origin, i)) {
+				/* set aside the bits we cleared */
+				tmp |= 1 << (31 - i);
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
@@ -2250,53 +2283,15 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 			}
 		}
 	}
-	fi = &kvm->arch.float_int;
-	spin_lock_irqsave(&fi->lock, flags);
-	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
-		list_for_each_entry(inti, &fi->lists[i], list) {
-			if (n == max_irqs) {
-				/* signal userspace to try again */
-				ret = -ENOMEM;
-				goto out;
-			}
-			inti_to_irq(inti, &buf[n]);
-			n++;
-		}
-	}
-	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
-	    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
-		if (n == max_irqs) {
-			/* signal userspace to try again */
-			ret = -ENOMEM;
-			goto out;
-		}
-		irq = (struct kvm_s390_irq *) &buf[n];
-		irq->type = KVM_S390_INT_SERVICE;
-		irq->u.ext = fi->srv_signal;
-		n++;
-	}
-	if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
-		if (n == max_irqs) {
-				/* signal userspace to try again */
-				ret = -ENOMEM;
-				goto out;
-		}
-		irq = (struct kvm_s390_irq *) &buf[n];
-		irq->type = KVM_S390_MCHK;
-		irq->u.mchk = fi->mchk;
-		n++;
-}
 
-out:
-	spin_unlock_irqrestore(&fi->lock, flags);
-out_nolock:
-	if (!ret && n > 0) {
-		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
-			ret = -EFAULT;
+	if (n > 0 && copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n)) {
+		/* restore removed bits if returning failure */
+		if (tmp)
+			__atomic_or(tmp, (void *)&gi->origin->ipm);
+		return -EFAULT;
 	}
-	vfree(buf);
 
-	return ret < 0 ? ret : n;
+	return n;
 }
 
 static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
-- 
2.55.0

