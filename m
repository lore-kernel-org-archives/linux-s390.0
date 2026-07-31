Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BC42BE86;
	Fri, 31 Jul 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502915; cv=none; b=LovLx1AtYOuRM9ffQdwZsTQoeUzLKHIwkZEt9F5E6lBZmdAhri/lIgMgFzqlM4OcURuXk1UInvilrl2p1B7pNLec+JISgYp/yTqK3talwmETXYeQjIFPi3cISLV+Bw1nKgLMdFQ0+Y3CQFm9nmLcKfkCLrXRHzzDEuyhBzLRE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502915; c=relaxed/simple;
	bh=eaeBNZ9YdlmEngpslj6Plaaezy+Oxl1yRHDDNOrYPc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoZ24YUy3suLGDUfSoBwY+I4DFtPYtIGzt5odSOEArFvFl0ycUXnkARHWIzExEg11Kb2Cd0VcPRG670pfuarSs0ZGvd5x2htKleZVkdLJSbInrVW8+u3LD3zg/PPsRxa5lHnLfbUX01otQJ2ysd3MzfSEW4PUHfqptzaaGOrK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nH1gPBXo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nH1gPBXo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlqW71765837;
	Fri, 31 Jul 2026 13:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cYACTU3Ehy66po10q
	WiN+GQEIAYJ6njLKHh+/AMnRyg=; b=nH1gPBXoIbiWmmKVHN9Lje+6NdIh+AooA
	rq8AeQmsnkBVN13qd4ndbMrhNeEzAlK5B2tn0xiOk3VzZ2YPVeWdj2njA4ht/5Rk
	fRXkUQw0s78ak9XUYFt2xnGqU8z5xdgXZ4RG5W7gBPVkuj5F6bhyqpBNpCUVtLIw
	72e7ziDEv6WjAK1NMQhAaKWQnAUBKbFx8MuvyUusSNg9lerjp+jwkR3fT0Uf4J/v
	0fL+9ykjMb1psXB0s++6e+AVAKRbYcPSzTvpliarcZa+INEGLSMJiyjVrNyAxGFE
	aCVFZzzHb6w7NRzy8r2R9k0hbInkKoMhD6a0Dxlpxt1Op0oVWbrPA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y5504-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEci026835;
	Fri, 31 Jul 2026 13:01:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqs46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1iSA29491694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E4620040;
	Fri, 31 Jul 2026 13:01:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE53520043;
	Fri, 31 Jul 2026 13:01:43 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 05/14] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Date: Fri, 31 Jul 2026 15:01:29 +0200
Message-ID: <20260731130138.173983-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yG814ASr9ahDzcOyYjmQfscmjds_78JU
X-Proofpoint-ORIG-GUID: yG814ASr9ahDzcOyYjmQfscmjds_78JU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX6iXfj6SfzD4v
 0pxPPvOPWYEvSJS2HS9dO4bVh4+VWOOvv83xxZCwhbMuo2rkj0pL5KYSz4/PGeTYruY3NBJ1LSQ
 oefWdFJj7FSB7m/MI/BKu+zEGhSfXl0=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c9cbf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EUfh2IAhO5dQcouLE0wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxaHIJd5xKUyU
 sRoAmD18mnzG26MOJUpRrvJE/Lq96GPDs7euGWbGiEzlfafkOrAd9Ioi8ly7EvapoPbfSYDt628
 HIeE+WSFjhcVVCvbwwdMpvS8ejTHbKpgKZB0lDzGJieqomOdW7q7h6FR+eH8W41KgJhw3jI9JcL
 SdF3Tv0oV9VAgkwHfHccMdLDL1reQNMnfE5T9CTp+hsEQKsn4mQ9M/Wl8svVnbTn0JB9F2VFKN8
 opNowXnp8/jiUFcNoNEX737m2GH3xDN1NadkBqSps74IRWcyvFDyCZ/5MHAaHQIAgwkyXpM/Whg
 jQXxmYafIA4lC2vXs8at2ULHXdWbc3el2N//kxmHbGDiaeIw+6NGJ+9gNk2fBmFBmdyoeQk3kuC
 F6VRzz3mEPmoawgc1hdVgwXffW0Ts86Sy0Atdbpqyy4gs1dC5tK0eaj017JDUcWXS2YKTZjJM9j
 7TfNbFtgJx1RJKsHJnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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
 arch/s390/kvm/kvm-s390.c  |  5 +++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2acdff130fa6..9db68e3ac178 100644
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

