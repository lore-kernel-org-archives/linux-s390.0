Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB47445AF8;
	Thu, 30 Jul 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428851; cv=none; b=e0uR3fvKiZn74EbnodLMKZNX2BlBK78oLZYvZyi+2jKoqxso6DOIImp4DUApFD703xLMtb/vbkAqDcgWnHNkRJVc+Ly/g/0WKzjcMHQelzzlgLeXuickyQOqYspf5vmoZkuUCWmTERsPyfiMFI717XKShrT4MRCxpvznvoOFQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428851; c=relaxed/simple;
	bh=hKubbBzqZd6NJNFK6Yt8H2+4HqO4Ru+2UeuYo2TwXHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHLak8pxdpXU8+dESHAPlWupAab5bXpB8aJHyM0o/DfC+byS49lUrY9GEcFjkC+/Vw35MXPSvYxCo9J8fiQXYo7Jz3pbP1SeM9XVU3zAiG6ifBvCofS7G5g6kFZ0+YLm+AhCtZCSkOYoV8Tw7p5wKZM725iuijgzp3am6Fr/hfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NtEiHFCr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NtEiHFCr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFm2E81561673;
	Thu, 30 Jul 2026 16:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7vgRzzSTY5wjVZPaV
	tLkXw2+uUC57cnRDJYBjCL1UFA=; b=NtEiHFCrKAkXCBBn477F+Mg9azPNBsBRm
	ub69kQvDb35iiSZagZYpwGhYHsp0dw9jI/Ul3KuPnJOGngHZtdmlPDC+m2sk4P/d
	aBmAKakZNsqJPShx1mWkc1A8ikwtvItMxdnqwuHYQ2oVxUB8VASmE5+aYZ5JhmfQ
	aZWmz6XYgnj6V6z0UOQe5rOPbxM8yVgiWiXOY1non2Mc5Gis7xbAAqHsTF+nyhAa
	5bbA9BaQAHgRGziG7CmMqBBLkuywfJb9HYOllT7CpZSuOfh7gFXfTmkTK0ImjWgm
	sq1GPs/FNpivAV/Wm3t+zCM+JGKki823qS0Q0KV65MMkwtpJgon8g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycrq4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQRvA014724;
	Thu, 30 Jul 2026 16:27:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwc98f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRFt735127788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1A520043;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7769020040;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 04/14] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Date: Thu, 30 Jul 2026 18:27:04 +0200
Message-ID: <20260730162714.133327-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bVpXfntj3CJFsOY4VkNMIFDHRvN1_ooD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX/IDrZ2IaUerp
 naNiiog3cxNX04MeLJxfLDxiqzJK/Id8BbFGxB+ziydlmICpgq0BnYfja0c8zDc27WMAtb5xl/s
 Cweq48W3/3mmhCTTtSMaganyZ0XRUQLhof5BC88gujwPOdsS23TPgDCGo/s1akqcSySeT6DaMtY
 XG2zCYsZsrB1rJU20WemkX7qXzxHDCsd/Rf/BCYuJ4ywUj6YFox220f/Nn3/mYQyu8J5dkGWO19
 ovXBEr1PGZTFIZ+7+AbYK4ngQp66O2MJE+roCft6HjbXZKxGqvayKvlvDwMqaeKgPFSP/UnZehD
 79dlrU7aKKmurjPolQ4zibeMBRdVCm69pOLzoOgI45hARX84ssA5ApTsGNbilPpAgrKYuqPMAJQ
 yB8L4H4msX+QKekpozg7Bu/qmdBzvdF/X+0QdSSh3V3OY7ObmCi90UbOk3Eo58Kgtn5z5yLPRfM
 Suqrm5fe6vgzt3ZPzYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXwmK6cKrroqn3
 JowMYCtiCD2eGqNBKjwfQnYs7JpbymceXmFPWbiHfJ8Ogf4XWD/aH2O6nN2N8DKX/69Cm0RQ+bV
 nrHC0l6emG3ewg1b5JCX2Ty34kDP/8M=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b7b6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=EUfh2IAhO5dQcouLE0wA:9
X-Proofpoint-GUID: bVpXfntj3CJFsOY4VkNMIFDHRvN1_ooD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA.

Fix by not touching ESCA for UCONTROL VMs, and fence the
KVM_S390_INTERRUPT ioctl altogether.

Opportunistically add checks in sca_ext_call_pending() and
sca_inject_ext_call() to make sure UCONTROL VMs won't call those
functions ever.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
---
 arch/s390/kvm/interrupt.c | 19 ++++++++++++++-----
 arch/s390/kvm/kvm-s390.c  |  3 +++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2acdff130fa6..6013f28e3461 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -45,13 +45,16 @@ static struct kvm_s390_gib *gib;
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
-	union esca_sigp_ctrl sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	union esca_sigp_ctrl sigp_ctrl;
 
 	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
 		return 0;
 
+	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
+		return -EINVAL;
 	BUG_ON(!kvm_s390_use_sca_entries());
 
+	sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 	if (src_id)
 		*src_id = sigp_ctrl.scn;
 
@@ -60,13 +63,16 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 
 static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 {
-	struct esca_block *sca = vcpu->kvm->arch.sca;
-	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 	union esca_sigp_ctrl old_val, new_val = {.scn = src_id, .c = 1};
+	struct esca_block *sca = vcpu->kvm->arch.sca;
+	union esca_sigp_ctrl *sigp_ctrl;
 	int expect, rc;
 
 	BUG_ON(!kvm_s390_use_sca_entries());
+	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
+		return -EINVAL;
 
+	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 	old_val = READ_ONCE(*sigp_ctrl);
 	old_val.c = 0;
 
@@ -84,10 +90,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
-	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	union esca_sigp_ctrl *sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_ucontrol(vcpu->kvm))
 		return;
+
+	/* Initialize after the above check, to prevent going out of bounds */
+	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
 	WRITE_ONCE(sigp_ctrl->value, 0);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 58cec3703c2d..19ce7ebb83c5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2934,6 +2934,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
 
+		r = -EINVAL;
+		if (kvm_is_ucontrol(kvm))
+			break;
 		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			break;
-- 
2.55.0

