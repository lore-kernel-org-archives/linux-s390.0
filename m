Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F1407CF6;
	Mon,  3 Aug 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760855; cv=none; b=koTKKkSIyvyHzJ9kDRoWWa3BJGzbMC14/ne8r64zGoqNVlDfsetQLWH5PPQx11FN+rEiKRS0nLhsZF0AcPNvdrhgHbZFPaCHwUpi0h1TL97gI6TUbt6Cjmo4BLhKcu65z/rIdaGqKz7hG4pnFLOxJ6jZfpYafWk6NWBbiVk4KN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760855; c=relaxed/simple;
	bh=PWQEXfjf2M8Pe8mPgTxXDz3JhyP+iGsS452FFoGtb24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQoFKbh6y2SKovZQL0yqjA7ROGK6CgODOFDjNr1aZl+BK5gZZHl2ImK5B0lb0HU/CuP00WdqgOmeXDMI+jxuCXWNrsk1n3faKJyY+wkkkasi5S1d1PPd9SeIb8UJqh5DbggDJ3CeCTENrDM/RVQv3nGQFMTeKIUrfY+IWi7ugwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B9BAt4If; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B9BAt4If"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CI31h1938467;
	Mon, 3 Aug 2026 12:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0DtyPJY1DgYM/AyYN
	MX7APaTCdtFubPxSlrx2X+rcvI=; b=B9BAt4IfbGteBJtjB57XG4w/dwm0vy38h
	g3iHjSYXg6OwUYLmrgAzPHuPgJyQAQl30IcVtXBBAQ4Zy3UYhO2J1vDFBwLQSzTZ
	JBDIieJf4rbw2W9FPEMPDNMyGVCShnMLJz8S3gNhCEZTMOU+2fzTGt5YB+7VA75c
	503Zxc4R4RPlsBGvGFCnUJgUDL0HVF31Wg6n5sFLhlOD2FtQwxZN3ZZFU4UNVyPP
	uAHCT0naggJ3MvyN2cXWbNEmP0pvTmgu5kyVVlStuckGVxP0YdAtyZlKOUVvi71m
	lHjEzlrBcayVTJx9WbCmptBp6IcfBSldB3eX8wzPRM2+6achf2UaQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgqcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQFb0025921;
	Mon, 3 Aug 2026 12:40:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyd3hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CehQ232702970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98B8220040;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A71320043;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 05/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Date: Mon,  3 Aug 2026 14:40:32 +0200
Message-ID: <20260803124040.126471-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX0zg/Dzn+EKFA
 KEaHJovAedrscr75rW+hBvFaQA9qtsByOoEfy/18O5HxvT2QgTHWQC9km2coJa+3kfLqhIuwq2u
 X5IpsisjA5+0s7e+lpppQCBGivG4h6Y=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a708c52 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YAUebeNNc2VAqFE0BCsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX7/wunoxHfF5C
 B4B4X+iq3/xAikHjBfM1HnElqv3omaNqMRaH3LZMd8laYKuhnqcXxyIcyvr8akOd+6of4aaAMyB
 3PsC6MaOY9wsZ+9DA/t8yM+SZ497mwJzQdjGLxhniDs70omPCINx3Gj5wVVV/GSqgUnqtF2UJZd
 tSYqpaY4fa3xpofuJi1n0vfeeLhbA8RwkHZRc6DNbV94YjWEqxSi5d5dHWK8fFIJXYSTlNjLgwt
 vmn5V34iN9ectD6s9eL/tTkdWiFfuyWnF7CqU3lK27T9C4pwGjQJkraYgvwDWjY3KcviK7AyV35
 qfqSh49mVUDtUm5SmaKDjp4RatNF1y/qnpx8TqensbsJaoGagrRNvZ+Wgmz3LWwrQyVOnResP/C
 aUjBDSFRza6NF0AsCeDhp6jDaLf42yAryvSrBr2pjWkXYR1S4K+++BfN2/5ZRagM61zf1cvt9cu
 wEhbc5sptv4ras7Ldww==
X-Proofpoint-ORIG-GUID: h_L4ozKgWh5axP96127R4EwNLwGSOIxc
X-Proofpoint-GUID: h_L4ozKgWh5axP96127R4EwNLwGSOIxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA.

Fix by not touching ESCA for UCONTROL VMs, and fence the
KVM_S390_INTERRUPT ioctl altogether. Add extra checks in
sca_ext_call_pending() and sca_inject_ext_call() to make sure UCONTROL
VMs won't touch ESCA.

Fencing does not cause regressions with userspace, since UCONTROL VMs
never used KVM_S390_INTERRUPT ioctls.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
---
 arch/s390/kvm/interrupt.c | 19 ++++++++++++++-----
 arch/s390/kvm/kvm-s390.c  |  5 +++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2acdff130fa6..6b3f97a7513b 100644
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

