Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB2262D0B;
	Wed, 29 Jul 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338989; cv=none; b=hfZ7l/gYqxeTn/9QLHTxXe18CCNF1EGEWMGjd4GOMv01g4bGGQud4Fdzp5S9l3HmmxUb8j4UYDYSCgb5ymDTPYwFqCN0z2ViBjdLTozr50N7qr8uHhNWRz1q2C0+WedcAxcRhfHBhFS1LKtVJplqOKjtonwZeKDqc0FSAnWUTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338989; c=relaxed/simple;
	bh=7OvvlM4X3cAxB4HaphEJSDyyvC6RlZA+JAfYRP2hjNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLP5DgTp8Zq0B9vIcxUIgzVpxcAD0i+cvo0kstHGazt9keBG8JHLB1cySY0C2yPcn+uus7ULish4ydUG+tTUPGWrUjK5LE7fcCWz2F+6u5f2xQE1DPSkafRmC540W/rnAE17mYlRUwp5vU9pk17OHAQzLf13c2vyzmv2rSS6Us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QNySdjNp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QNySdjNp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHbRO388620;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PkY0LLVCPFsDbNIgI
	FsNgi+DmUPawb3x3oXVFLMMmwI=; b=QNySdjNp53WV15Lu+nO3Kf20IwXoR/rbM
	zodXqn4D8gF86GMmTp1ftRkASbXcbJmK2TIjdKlIuj4hy4UH2YdbGlVcSeWw/LSS
	EAx+PRWGNWL1JrC33sv6K8sMOLSEawjGEf6HR3GgsRVtZBV1bMUXANP/aPENfrob
	B3bt23XC1C0sbbdEUz0yInYMVpXio751u3suBFEiJeGC+nysBokY4SlYDeCed9bl
	spm9nfjLKqxSbDmJfLMjsKv3mu5o3XLQ7kpSYwE/BTdpA+5+WvLsbWqjwBdMkQ3J
	VVVD9nu90nLmItRudXQk6+flKxjn7I9Ez69m23S1S3IpgfrcNUK6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xueff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQJ4c005659;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgf3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTdIo45875700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4471120040;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E3C2004D;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 04/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Date: Wed, 29 Jul 2026 17:29:29 +0200
Message-ID: <20260729152938.782383-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B8NQptOVQ7MA1tvV1GhBqWq60fKiaG9G
X-Proofpoint-ORIG-GUID: B8NQptOVQ7MA1tvV1GhBqWq60fKiaG9G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX6zazywwIgh4/
 wucn67uTDXVJqzHv60OcvWt3n+pJPgTCZWu3SG1s+WFtXfcnDOgo0kUWuFm6FyVmkOHJydvzKu9
 RmMe5n6omZBqWUBsu8HW5j+5PrbS0+c=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Ldj-dCDcYccjn2ExLKoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX83qev/QoCtBq
 SEXSop6UrYmxhWWWZmP15QCXsIpp3rNapwuGAZHx/a4QhOslDGMO/c2YSsaNO4C39bwXMDITVb5
 ftPRu8xWprUPTRqn9SZ/ZYN5cSgZxMWOldoPefTCZswGQF2nRXpq4a2wdXdVHbfunKcQtEoywk+
 Cxwxg378SyXgaRObg17qe7iXmJmJOkPyqOnh2gmV69qsIzOLsUs74UvdIvUCM/mfHIqyzT7P+eB
 SNFFfLBoUjcEV8EE8ONTFW0RtjsEOsPQcbvY36GCMBPzcLAza3I3/tkPYh5+Ov3fsya0PuVb9CW
 GqMck9e/A+ZYGGKQtXvInKqNfUfpyY4Vyr9+IG4RGSCtzGTaJEkbG8FXExN6WHY8t7xnSOLvHdb
 P3E+SLSnkC/eUY6fTNiQLoVwWn7V5eZN4uO1NDP2ENJHDNd2aBHQ7+Xi9QlK9nxxpfsFDQml/79
 TjBXgAguf967YJIvBBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA.

Fix by not touching ESCA for UCONTROL VMs.

Opportunistically add checks in sca_ext_call_pending() and
sca_inject_ext_call() to make sure UCONTROL VMs won't call those
functions.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
---
 arch/s390/kvm/interrupt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2acdff130fa6..d02724bd1829 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -50,6 +50,8 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
 		return 0;
 
+	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
+		return -EINVAL;
 	BUG_ON(!kvm_s390_use_sca_entries());
 
 	if (src_id)
@@ -66,6 +68,8 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 	int expect, rc;
 
 	BUG_ON(!kvm_s390_use_sca_entries());
+	if (KVM_BUG_ON(kvm_is_ucontrol(vcpu->kvm), vcpu->kvm))
+		return -EINVAL;
 
 	old_val = READ_ONCE(*sigp_ctrl);
 	old_val.c = 0;
@@ -84,10 +88,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
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
-- 
2.55.0

