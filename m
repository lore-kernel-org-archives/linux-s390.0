Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C7423E86;
	Wed, 12 Aug 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531488; cv=none; b=qxYQiXMiBn6eQpREbanss9NYvBIrRYpaMlqipd4wd2/kqolSK1toCKx2pZHjxuhpsoWHha6SPUGFwb1wettUcOv3MqYr81inlsQeDIeZ3Qz+72zDGONKJVuSzMt0UOBxXJ5yuj9en5ZnEMWg3XCttUJuWpv49ve2uWP7qh4hqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531488; c=relaxed/simple;
	bh=vAJfMwNoZugO6CmlIUvP76I2pLemu2cSuj7//V5N/F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZPGJIz0bJ19KmbZWz4OOnTR3QdUgocTBiWa+og13nctRgLRocPlPV56E6F3AoV1+ACuMFuENJyCnHnBzR3KHng7y8M5P6erCF5Mpvq5bEaHrOZoR4H+LC/4db+xjER/jIZOMhn1jr047nSnJi0Dz0+8+VxrsvJ6KluGekBpnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kEt53wXk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kEt53wXk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA20V23177978;
	Wed, 12 Aug 2026 10:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LLsAJhIVUpJJ7G96H
	wU/F99+Tl9WvdtstdZcIlv9QmM=; b=kEt53wXkBqSqeXq2ZJkpvu5bpKusBqyaf
	UGaz/45Zq2JXDywQV8jpRsmOAguKjVPZmTEt+/tMBQfvw6KDdE+8qMF30HstbWR3
	C6t2iwCdjJO6Bv0cS+I1xN1vd1F+bK47xlttqUuU/6V0QXh8EVh5sGlNAuHG+e9J
	HBTksGC1Dg9cjd8nIiBX13+n8Vtx5Qcf7wqxZbB99dw4NMLaFbhSMvXCvMf2EsCb
	TDUMe6rIjO9IW69rL4XaPMJSLg9fP5ZGbM6rrbkh8vB/BoxHTV0J9YSrGjRztTlV
	oiqs9DVAEPepwdRgq8scdHbX58tzz2ifGgRpkMiAlm334IqK8MlQg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9t1fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfHpl017833;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w5qk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAicbn47448560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 269112004B;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 015C920043;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 6/9] KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
Date: Wed, 12 Aug 2026 12:44:33 +0200
Message-ID: <20260812104436.109741-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXxV/+Wp5meW07
 TQWPbUtyOJo3AcY7FkJNUC1GD2QdaG+QncxyX6/65BI9EEKl3MZniMuEjn70rlKyy4nXZVRSRId
 cBgb6NT2Nxouytg+xFAx4jBULVM9/HEHwu0bURsAKAJtAmZh3UlI1rjwLZRh18I4J1H6WCE0lqx
 S+66Lu7VQrYRnBKWc1NmyRzqvv+ttGdJbyWRcBpK1Lhfi7Z5nRRizXrdDFSTA7syfHCzPKQnl6A
 SGztZwB0Q9ySGuGzltBvdpouI4QjAK9WhVZdX3z5pjdsj0XHgTfcm9EWe8CISzfrxvyLwdSo3et
 ocbeRtGYbf05AOxNZKzFJVIp2leTEGUvYBjnzRGF/01jcGEpMQTtDm8u/HWhe4dJY9bW+RD42N6
 C7jdENFXm0dUEoEiNVRwD++wvq7Zc2hKoVbNrm6g6J6l90cW9Tz3D8X37BRxku7XNgs+rVoiqoH
 7vOKYCOJyondezR5PjA==
X-Proofpoint-ORIG-GUID: Rrfu7Co3gcsU2SmlEd9hKPHxT7xVuCon
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX9Oh7Q2soaHAV
 l7If6ndXILz5eNFiqqbhl5ikEoTT3Vr/UPID8rQWaqMSZ0Hh36729XJbrXkTXwGqJ5Z5vO8qsaJ
 TZ2Kc9ooPZ9X4TYlonbimKHLVWAipKI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7r_voGox4_RORL1y__EA:9
X-Proofpoint-GUID: Rrfu7Co3gcsU2SmlEd9hKPHxT7xVuCon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120084

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
 arch/s390/kvm/interrupt.c | 70 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8e4b88bce31f..6940f4d354e5 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1555,23 +1555,21 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
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
@@ -2107,7 +2105,7 @@ void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu)
 	spin_unlock(&li->lock);
 }
 
-static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq, bool *storestatus)
 {
 	int rc;
 
@@ -2119,7 +2117,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		rc = __inject_set_prefix(vcpu, irq);
 		break;
 	case KVM_S390_SIGP_STOP:
-		rc = __inject_sigp_stop(vcpu, irq);
+		rc = __inject_sigp_stop(vcpu, irq, storestatus);
 		break;
 	case KVM_S390_RESTART:
 		rc = __inject_sigp_restart(vcpu);
@@ -2155,11 +2153,16 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
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
@@ -3180,7 +3183,8 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_irq *buf;
+	struct kvm_s390_irq *buf __free(kvfree) = NULL;
+	bool tmp, storestatus = false;
 	int r = 0;
 	int n;
 
@@ -3188,31 +3192,33 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
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
+				r = 0;
+			}
+			if (r)
+				break;
+		}
 	}
 
-out_unlock:
-	spin_unlock(&li->lock);
-out_free:
-	vfree(buf);
+	if (storestatus) {
+		n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
+		return r ? r : n;
+	}
 
 	return r;
 }
-- 
2.55.0

