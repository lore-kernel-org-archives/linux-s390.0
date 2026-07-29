Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCC455172;
	Wed, 29 Jul 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338991; cv=none; b=CcroNCxjGtHSxwUOmNt7CjA3/kS5qOGrxXA4x/O79LY90E6MQT2lI8mYMXnK8ylL7yrz27J/W/PpkRD73trKXDOybIL23vgKu3AFs1dg6D0HKTraR6/FauEealLmXFJTRxwqZdoN6z/OadlwejvYLPjpGCJG6YFbqposCEaQqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338991; c=relaxed/simple;
	bh=W7sxjPN80Ykg7WhBF3MATOx8YI492OEZTOIVgRfL0Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLU9iNbe1wPsZwecK9eAVp0IQhmuV/ORsX3Z2ZaYe2avL+u1yfZRSHE6KMMSaXsaMONeLWm/AIe6lorcAL50XKeO4gRwdpuPWWrxHto7+FBPiSHf2nQ6X1+z0SBngnjcNvC+oZLAtV/nXesWrWUcFPwACbrS7WV2KakUs3wzcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PN6g1vp6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PN6g1vp6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHtuV278808;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FLPvJVvI9U9fgnu0x
	LnJlDwrnaAytQSWPf1zKvPc2fM=; b=PN6g1vp6wH1EIiS/Q8gAeRy3dGNlg3Y3Y
	D3/CTDOc6O7VTE1wJwj+/in7KkqlPUuQZnd37mIDHB/s9C6f1wp/CiMh0sWhh9+T
	EJO5vswrz3mrtnHNGJyEom2e6JePUEEk3Fa1uFyzDmbjbfAJ8zVs5R+/lLE4kZXh
	Gxz94RbGXqqEiAo0kYgV+u+myEC/rMA61bvQ0sbke3yI+qEQ/Y47a1nKlUkKJss7
	/yuqefwEQ5SbcVgCBmPsTVKOimnkBySOygjRsPy6LmDRATGtqU6PcBR7T+Llm1jh
	46fnlFvha3ZDrKxiv+2MyQz6eCDVNIcHKFthCdaLuQtftYk83hqQA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjam3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQLJ7030836;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y70gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTdhW45875698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE592004B;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA78220043;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 03/13] KVM: s390: Fix overclearing ESCA in case of error
Date: Wed, 29 Jul 2026 17:29:28 +0200
Message-ID: <20260729152938.782383-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXxYJBGDW5QAD6
 cHzbLVgwR7AiLR4fhEObBSF34g5j2WeFn+xhlW0uoS1JpW7WLUs9HPCDW3x9euPo0e3kbeFFS6E
 Xrdd5UQDQuMcmn9ALco/v7p6RmU5heo=
X-Proofpoint-GUID: XxL9nivA9nEhDkFpiQFh-QARJkc5SCco
X-Proofpoint-ORIG-GUID: XxL9nivA9nEhDkFpiQFh-QARJkc5SCco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXwx0fqWnyBCBQ
 w14tDmXZiuKqpl2X+Xd3hBwDxBdziyC0X54dby3xaqESsTcBpXFHMqk+XRo865WMO9LDpe3aE4I
 lq4ixg/8Y5+fWYVDFmsX7wFPcfHFSloHL/qOawtgmfN/bwruhiH4CbOrw5ATQs2GBCw6ycBVcvL
 m8caPpho0ZVWSG7xjxpXnoBzwSwuXWr5RU2210webgoPs3qe9nMiCmFQCWgFHawQ/IbnlFXmdFK
 B2QzLZb5dE5+O5it5HxB9RU7mwZtpIcUdMt5hSZcflJDl1wVJ84G93BGh7Adi3Tfe9iarAjTSa4
 /GwlJPVxwV22O03sJtlyle70Mdu3n+Pb3+FK7TMJf0aCot+ULz5HFNuzb2rZClkIm4aJzvp5tBk
 XPXni4JvxOogVgB8rZdxhSq7ZTWCmcYhiwkklE578gwgWbTSXQU3DTNsjzK4HIa/WopqBQwbiVD
 8tWBGRoO9O6DoJuFlaQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=OniIQR2WiTFW0jQNa14A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the pointer to the ESCA in the state description is
not set.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..2acdff130fa6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9ec5833a0973..58cec3703c2d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3461,7 +3461,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

