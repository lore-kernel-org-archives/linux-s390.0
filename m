Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEB40681A;
	Mon,  3 Aug 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760854; cv=none; b=ecMBvKcBr0FMVL/QIeauz53606tSkggt5X45IMbwReUHxvg9UplVOABDR3qMroNME74rKJtCxgdUf14AzgRqWW1V7vHtF1z4aSTfcUAETFcqNQU/mGinlt4uxAMlQiEJeJT7cpTA2TCayqLDMi1WldwKgv8/G0e17WQuge+Ggd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760854; c=relaxed/simple;
	bh=mOUF/FNmKIk6xX+iKDVdfp/CuFGAPdAfGGNl/wapg7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHjCC23oWhMEGVTTyRNIHy93Z3eljCqtq5b+24dnvPSlap82oa7El5iHU+eZ2jy9SvfUTJXdUB1PlIAoWrIf7ViJO+BI1Orx1MDii4m91pY0+JYmQXqRZIR7m7cP27KwlPzcTvhShzno0iFFHOShXzrsI11j/M/2eze4lmSJt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jo1REzeu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jo1REzeu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CI1V82018764;
	Mon, 3 Aug 2026 12:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PxrXMPXbxz0kJ+bcb
	c10OSG0wGcTfT747aR8n3xRorE=; b=Jo1REzeuj7UmgOkFcWalNNt6dbR9vUWNN
	1KNAqyLrVO7Hh0YJNas7O6HEjCEVp9Upazx28uGjffy5oYUDtG2zu9s/pQp+0TDL
	+ipo8H4Y9KcArdJn9Y8lCIwXEeY+w51XrfPC35zeDE+fTRwNN4p15x9TFQ3kiHLB
	fPAE57yaei/gw2a9tqfVGNOttmZHvfqybXnpcOaYRWjywLAUCsWjEhEWFi09mIdK
	lCxEmvwHZOC6w09le+nIYsKjFwMxQMc41Y5WHYKHSUH1x7CpSDYhYTEDeZncYnSt
	e6IXkEh2W7XJ2gJkCVU6Enq0fw2H8prcmR/lrEAQslgxunwUlmomg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rr5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQG0T009744;
	Mon, 3 Aug 2026 12:40:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh59ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CehTa32702968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A9520040;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8F642004B;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 04/13] KVM: s390: Fix overclearing ESCA in case of error
Date: Mon,  3 Aug 2026 14:40:31 +0200
Message-ID: <20260803124040.126471-5-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX/5D64QuIkWdO
 dk3CvvQzeFf/oBWaMDgTEq3F/C9wm2aoJc8LWnYZafWblQSgU/FtnVaQTPJzE+9iGj9jKCRlR4F
 //jEAYrzKBLfqGZq886ZWv5X60R2x+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX3o72Hm2xx1lk
 UOWXYpvNEsB0SRO801Z1DssODIBqsRD7yh5N0CicOdYa8hAr+goArpqmiFCeTV06A1PrCt64J6X
 igtMlAhPJFXBSeyzcQWpKhCRBFAxVhltSHMEeaTrY2GOEW61gatMAl7w0cqyk2oLPgwIBSBLH/O
 k+avu0liO14B/MXQGHiiJ5qv/KODxVx7AT89Xv12/OXpdBz+vDsYWIAmwAcOBaimuF5MtXf0reK
 gInuwyKDsagfSQCVXDXhPz2GPzFDOu35VM6+KAcOsPs/yq10XbWvLf96/aLCLQ5gwZbYcZv4ZQp
 R/f3Cz6yG4umpUyWRwEx5WBzC4Klq2KawaAK1bVh+96KouJJMv/N1Hdub99iJW6S5C8c3i5ppHt
 avh6aH4kcfvGO+AoYHx0H0d3xTNe9SCZ/FiwEDRRQvGeCgtgdTXH14ulaNJUnysjLq3wMIbPnBx
 mLTLhSETH6RlYBsRUTQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a708c52 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=D5IZcPaqysaIEbzteRoA:9
X-Proofpoint-ORIG-GUID: diYJ4f2pusnU6GJRo69XVMXIdTjC02VK
X-Proofpoint-GUID: diYJ4f2pusnU6GJRo69XVMXIdTjC02VK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030110

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the vcpu->arch.initialized is still zero.

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
index 9be27db0a21e..5b2727d7dfd1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3462,7 +3462,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

