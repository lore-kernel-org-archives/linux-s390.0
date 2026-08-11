Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338B3BF662;
	Tue, 11 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463816; cv=none; b=WzwjcDwqUC8Lddh7XkbhmrramahsSiNW7zlDb0YnNel10o4Psu0X8gZLtdLi6OA9kmnVhbWhFnTPcj4yJoO32mi8XSnK4d2/q/wBeQyBqjBn5zTvXRiAGHQJGYSfCFsp0rllWz8H01ErzpFwj2ocGcJT2qZ9rmf9wOW1k4w9XF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463816; c=relaxed/simple;
	bh=uihA8GEr/2CatiGJCv3/85n/F+bhb6Sq8yUKT4RXTsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnwrpaAVavx104Fq63gofgx0sAt7nnmzq8ebYhJwm0/AaB0qGnncgfSqoDsWDjoiWGgFfNu3MrNqk4LZFj/82LQ6EPiBHlyxwwEvnckPmTzxQe9v15Dq1TuFm46+pfg6Na+x4kkmowpavczlj+GWS8FfB+COAjPcSxQN5GLDRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tDGOzoVH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tDGOzoVH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX96P451232;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fyWxpKQHUrSeFEy+s
	4gV1QL0/lvKP1pmHExyIDiu2no=; b=tDGOzoVH0MxavuIaHJMKf9Gt+WpJEp+45
	h32axnVqob2QBPf2sI5rhsPXq957k25C58kD7huWwhBlXIWVkM0CS9NziWhzrTid
	Cd6gmyPM2KhfYk541wtfvIDgIjB0iM6znhnOe1xQOzRQ6+9nfbuqlMdGQeMxIZEr
	/ZR+7cPOI+yI+O9GMr5rDHi/9RDEp1/ZTZb7uAT9uR+EzrIR5WQ9u6uoNYOUxNhe
	mRiRW8lA7OpctiaHap2POw85FfL6lxg2HdMjzBNfkg9h/5uNwp9n4KqtKgFSrs9T
	D0QqH7HHaDpg0RG7rQnT+hUDHjjgsUbfGhiU51+tkyRjs1ZHhqyfA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2w5bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuEYb016123;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1d82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhF237290346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF3F20043;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8E720040;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 08/11] KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
Date: Tue, 11 Aug 2026 17:56:38 +0200
Message-ID: <20260811155641.219777-9-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7r_voGox4_RORL1y__EA:9
X-Proofpoint-GUID: 5WBqdSTF8wD1I7OvJuxzouyHbWrHJlcK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX9UKY+eQ0nB2b
 n5kVx/6ifwTw0xuttN7CamSRNrU/wDGm6xk9/weRequvOUe1VQy18XuZbDuzS/hRacCA9nvQlD5
 5S9ln74Pch4kLXKqiRsWrb/B3nIDuJp64ayEAAR/3kjahvfPCMqzHYXbDDt8V2HLGds5JU21mBc
 nQnIeJ00RzEC1Fit7ADzIj30HCMVm1U8QoRk3eYKS3qj7VwSFOteQft9N0OWu/kFDuEH8ojKdcc
 pqSbCJo2JPFemaiZBD5JAlmyDrypbu//Yid1/ZZM5ks4BBWJL2jYlK73oJ2vVF4AV4vfyzzvCKE
 /c/AVJo/ScYsjHzonf64ti0tMCI0VEOfvXa/0weTp6bnBzDRrwuDwTxLnTtZzB80Mb/epFeSNq1
 zkERLrnnw7rCMN1i+mY8b4/HUA7aLs3DKLKsgYrI4CDn7Dg/PX4EVFiitPAGBNfMEJL1w3X9vF9
 69RJBVA+RVQan/Qub4g==
X-Proofpoint-ORIG-GUID: 5WBqdSTF8wD1I7OvJuxzouyHbWrHJlcK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXyzQu8g6DXg8g
 K/4poxrwkDKfW72qgU+fYYCBl4c5zP4iSmRqT3zZXS4hTO9btiFAgu1Rc98HDoKGyZJiE6RFDIB
 ZwXny8d06R62irG+MNmHbohCHN86U6I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

When __inject_sigp_stop() is called for a Stop and Store Status
operation, if the vCPU is running, the interrupt is marked as pending
and the status is stored by the thread performing the KVM_RUN IOCTL.

If the vCPU is already stopped, the status is stored immediately.

Storing the status means writing into userspace, which might fault, and
__inject_sigp_stop() is called from do_inject_vcpu() which in turn is
always called holding a spinlock, which is obviously an issue.

Fix this by returning -EWOULDBLOCK from __inject_sigp_stop(), and
adding a bool flag to indicate whether a store status is needed. The
callers of do_inject_vcpu() are modified to pass the pointer to the
bool flag; whenever a Store Status operation is needed, the callers can
now perform it outside the spinlock.

Opportunistically refactor kvm_s390_set_irq_state() to use
scoped_guard() and __free().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 68 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 400ce7195b87..d38b9da0d09e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1550,23 +1550,21 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 }
 
 #define KVM_S390_STOP_SUPP_FLAGS (KVM_S390_STOP_FLAG_STORE_STATUS)
-static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq, bool *storestatus)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_stop_info *stop = &li->irq.stop;
-	int rc = 0;
 
 	vcpu->stat.inject_stop_signal++;
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0);
 
 	if (irq->u.stop.flags & ~KVM_S390_STOP_SUPP_FLAGS)
 		return -EINVAL;
-
 	if (is_vcpu_stopped(vcpu)) {
-		if (irq->u.stop.flags & KVM_S390_STOP_FLAG_STORE_STATUS)
-			rc = kvm_s390_store_status_unloaded(vcpu,
-						KVM_S390_STORE_STATUS_NOADDR);
-		return rc;
+		if (!(irq->u.stop.flags & KVM_S390_STOP_FLAG_STORE_STATUS))
+			return 0;
+		*storestatus = true;
+		return -EWOULDBLOCK;
 	}
 
 	if (test_and_set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs))
@@ -2102,7 +2100,7 @@ void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu)
 	spin_unlock(&li->lock);
 }
 
-static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq, bool *storestatus)
 {
 	int rc;
 
@@ -2114,7 +2112,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		rc = __inject_set_prefix(vcpu, irq);
 		break;
 	case KVM_S390_SIGP_STOP:
-		rc = __inject_sigp_stop(vcpu, irq);
+		rc = __inject_sigp_stop(vcpu, irq, storestatus);
 		break;
 	case KVM_S390_RESTART:
 		rc = __inject_sigp_restart(vcpu);
@@ -2150,11 +2148,16 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	bool storestatus = false;
 	int rc;
 
 	spin_lock(&li->lock);
-	rc = do_inject_vcpu(vcpu, irq);
+	rc = do_inject_vcpu(vcpu, irq, &storestatus);
 	spin_unlock(&li->lock);
+
+	if (rc == -EWOULDBLOCK && storestatus)
+		rc = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
+
 	if (!rc)
 		kvm_s390_vcpu_wakeup(vcpu);
 	return rc;
@@ -3178,7 +3181,8 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_irq *buf;
+	struct kvm_s390_irq *buf __free(kvfree) = NULL;
+	bool tmp, storestatus = false;
 	int r = 0;
 	int n;
 
@@ -3186,31 +3190,31 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user((void *) buf, irqstate, len)) {
-		r = -EFAULT;
-		goto out_free;
-	}
+	if (copy_from_user((void *)buf, irqstate, len))
+		return -EFAULT;
 
-	/*
-	 * Don't allow setting the interrupt state
-	 * when there are already interrupts pending
-	 */
-	spin_lock(&li->lock);
-	if (li->pending_irqs) {
-		r = -EBUSY;
-		goto out_unlock;
-	}
+	scoped_guard(spinlock, &li->lock) {
+		/*
+		 * Don't allow setting the interrupt state
+		 * when there are already interrupts pending
+		 */
+		if (li->pending_irqs)
+			return -EBUSY;
 
-	for (n = 0; n < len / sizeof(*buf); n++) {
-		r = do_inject_vcpu(vcpu, &buf[n]);
-		if (r)
-			break;
+		for (n = 0; n < len / sizeof(*buf); n++) {
+			tmp = false;
+			r = do_inject_vcpu(vcpu, &buf[n], &tmp);
+			if (r == -EWOULDBLOCK && tmp) {
+				storestatus = true;
+				continue;
+			}
+			if (r)
+				break;
+		}
 	}
 
-out_unlock:
-	spin_unlock(&li->lock);
-out_free:
-	vfree(buf);
+	if (storestatus)
+		r = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
 
 	return r;
 }
-- 
2.55.0

