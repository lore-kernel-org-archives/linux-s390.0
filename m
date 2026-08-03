Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136036826B;
	Mon,  3 Aug 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773379; cv=none; b=N4aDEA/6Hqv+B+C+AMTicn97F90be4QcT7VA+YBAyhh88X+8x+d5newYqQD/dBqRLTiQ0ldzEhoIPxXhF0SZH50uzYBM2tx4kH9oHML8DwqcLI6K/Q+/AbZoRweiNp9LYYQWrrJrvjmjNYAKcn2Il4iceE3G6xIFkNMQkJZersM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773379; c=relaxed/simple;
	bh=1CDNQnGJ6u5l235BTW13Pu2fG0U1W6t2OF/UKePghUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpWj1hD/T5sPt31QDZ/3CsInr3SLa68eWdTEkDAF2P44tOtXoIM17i2iyV00jJoa60GVaoFuz5/xMAevapIfjAbI9SKnXY4TeQcootfChNpA5dzNVgITL2N/AceFtbzWABOsV3jAePOOle1Rcqlr+WDQo3jyKmFO2GlCuLPmijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HNuE6o6k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HNuE6o6k"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHeqj2206019;
	Mon, 3 Aug 2026 16:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qr8q1DqXz1kAekac6
	Q0bm4lQzLi+47/ioAKWODU7abM=; b=HNuE6o6kN2CaVdSVd3kiTbx7zg6kpv1oF
	jvSnqgeJFaYvbrK+ckOqksGHtcS+6NJO2kyF0lVjTSHZmTzQnGpKfgR1c5zQhLh+
	5saKACN7peaU++KTPaoj8CneMz5IRyOu6KrMeYpQ3n7WImr5jkcAHBblJQilINkd
	ClNRH89nhZUkNUyr54JYgYqGJYqSkdQrB+zsJUPIPiTWL+6yIlO6zZO5g57Vp+l4
	s8dqeAXIpuxIeY/Qn4k6m9M/nQ2ie1rJQCp1hvxWtGW0ylngRPreW5u9t1e3ID5I
	BR62K0bf7C3MWhEI8DFutSelTRDkUuCm4xA5EONOy6TUsGP76JA6w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1he4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuFpR026451;
	Mon, 3 Aug 2026 16:09:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qeau0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9QMq42926488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD26B20043;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C31332004F;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 15/23] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Date: Mon,  3 Aug 2026 18:09:16 +0200
Message-ID: <20260803160924.236807-16-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwiI+FfLxbbsw
 /fqAkYghsNu0+nB02NACgespUo0Xln+itSlzImzeFKGrhQyLkUtH61SbxCHHOJxnJPmpDGikOok
 KlhD7whUyaCepIcrQzKmetot0OarfRtsnXKsiPcK1FZWGWl3X+DY2Pv1q1tet04y/wb205mC071
 E1tgAs78hkXq96gyd6cMqqDyVoRFDTiSrIS5yEr3iDzCm7yfpHxKx615uzmtfCjt7D+0LSrQDLr
 AQCM0sdhL9RDUcDL775D8AVnHc+u2XIxbPl9jxKFgfirMr3QrvSCa+ZpGoiw3VnX6lYGCwhYlhR
 bUW+LNOJfV6AgGynYtXSUvt7URAAjWFCU6HecpkcDG/KEVpQ/Y9viIF7cEomeshpNOsrWdZ6Tc/
 fVKRVnGhrj9L37GTI3y+Obu0fhaCu6UXNofD8OkSZpO4/LO9oxFswQq2EBQnvc0JFzyicH+bi4w
 JcUaxoSDaxz5uFJY2qw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70bd3d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=YAUebeNNc2VAqFE0BCsA:9
X-Proofpoint-GUID: DQykfINUoOruobe0KeHul2sk-7OKdI9Q
X-Proofpoint-ORIG-GUID: DQykfINUoOruobe0KeHul2sk-7OKdI9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX+iElBH7p55vj
 ePonL6bUrgBdcOp8pn06tnabqyGTiTDLq/TV954ZStpya5lL4/GzpLRqjx9OJ+Rh1/LkyQo8Coi
 jt37GAsQPxeLU+jfVogttdQaTJL9y/U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA.

Fix by not touching ESCA for UCONTROL VMs, and fence the
KVM_S390_INTERRUPT ioctl altogether. Add extra checks in
sca_ext_call_pending() and sca_inject_ext_call() to make sure UCONTROL
VMs won't touch ESCA.

Fencing does not cause regressions with userspace, since UCONTROL VMs
never used KVM_S390_INTERRUPT ioctls.

Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-6-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 19 ++++++++++++++-----
 arch/s390/kvm/kvm-s390.c  |  5 +++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bb4e72466043..8f24bcd1a6d3 100644
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
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return 0;
 
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
+	if (kvm_is_ucontrol(vcpu->kvm))
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
index 5b2727d7dfd1..21574f57be72 100644
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
@@ -5456,6 +5459,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 		struct kvm_s390_interrupt s390int;
 		struct kvm_s390_irq s390irq = {};
 
+		if (kvm_is_ucontrol(vcpu->kvm))
+			return -EINVAL;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			return -EFAULT;
 		if (s390int_to_s390irq(&s390int, &s390irq))
-- 
2.55.0

