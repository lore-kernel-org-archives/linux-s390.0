Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB240DB33;
	Mon,  3 Aug 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760859; cv=none; b=E26WIpTX+/is+M8xc2gz0vesBjJcXXz7OYAa5I+FmldFnaxRJur94joCOL7cN1JiVblxMvfBdd5K4etYvuW41ul/D2EXBjulgRu3llD6/Z7Wy8OKttSQ2CgNWtDn7s9KFcfHXTQj3kQh+LwtE64odvs0cIbm+f0Y3nJQQZQvdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760859; c=relaxed/simple;
	bh=SueeGW913y+l6iNRtLVYVpFY6wBTQ6KEeYtAQFCxDSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3t7a4t9Nf0SqbckZ1nd0h6e1u2LosD6nmjrlLCQ8nHbLm4XkZhC1Bo3EvantO9PR0FAvc07AJfk6uQX0B2D33wrZblwvmLrfXEFwmbf5dF977gAcvNSQ4C5A4WepdM9jNHG0iMlZ62Ba6nSGUXkOr2skBOBpZMEopa/3DURBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYXLa1gv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYXLa1gv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CIq5h1939728;
	Mon, 3 Aug 2026 12:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kD16CCXM6IusG0twE
	5s++dKeFs80vjBLnsgXBQEbWo8=; b=dYXLa1gvB50ogq/Ry2pGwmxRm7G5d1GAe
	X14shRmxJX+KYvNADyiFBo9+lQzmRGE0CmgZzU89UEF3Ji04blU+oU30f0ism6pP
	xOwPQjpeT9uqt2vDt8lJhSiD9zumurxCRaXxXpwcheOJo704LsSmrQc7axgTouxF
	esSp3vFo5BUEN6PknjwACKRQbAZ4nbmcHjAT9NcgVQOXSfond7c8OVsZzPfcOt7B
	MmTpuRmMCpffqpIOGFyPGff8YDTCfikkv8Ok8505S15CP3TfSnwImZqzD/AUkjqX
	4WznAyZBb+QOoWfUZzk0NUvA0F3hlgeV5q+CJXOZuXglo+psZJqew==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgqdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBcuS016815;
	Mon, 3 Aug 2026 12:40:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwe5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CelXC29229430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AC2520040;
	Mon,  3 Aug 2026 12:40:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9A422004B;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 12/13] KVM: s390: Fix ordering when adding to SCA
Date: Mon,  3 Aug 2026 14:40:39 +0200
Message-ID: <20260803124040.126471-13-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXxHzVOFYr1kzz
 Hov6aWiR1YAS0vXp+JXMtVVQU36X1IlYI9vD6XraCim1SLQd/5K+t8xqNn3ANzyI50NSaCumhU8
 t9VLF27p1k90jBQiWngQMcAcNZpzWXw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a708c56 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DpaZzcUc-R7GdRs0254A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX2rbK8XZ+AOgs
 w1hTcNlJAaCWO1vl9fSv2D+kGupHaUZ2xECa4ogbcyswEWcmn9X2+3dDKee76FR64p3qiXlIf0z
 9OVE/noc62JPjw9ifPZ+vcP7rBBBjEG7GSV9c5EMxpSeb3YZByJgv5DnUr96jsphkkRFayG6ZxC
 qy+SdMEA9Gr+8EC/CwOVgy2vnl57CuWvGEsZ1hZ2//ufsUokH7E5MrhuvGvwQk3wBY7UwxrS8w8
 CxTr9rervC2/fXsYCmM5GPN3c1Yzk/Boetzrjh5raUsFQ3abPztXRbOOEI/WSdw/7MF+wKnzHVd
 3EWiuYUU1bHyW2SrJNgk3YuRBr876TOmlF3chmIlfR7+ZCEx3sluSIqNH+w7jjtNZFywcX2eEBK
 fNiZxaeEi4Wx7cshP92oS391I7RVQG25bVMhUj3tsrXV1b/I2zW/epWP94EESSJxAY+J9hEZGnM
 a2ze8yigQ0Y7H1Mr/3A==
X-Proofpoint-ORIG-GUID: 7rLfAkHWlYQUo97yIxm2-XveVALHTIsW
X-Proofpoint-GUID: 7rLfAkHWlYQUo97yIxm2-XveVALHTIsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

When adding a new vCPU to the SCA area, the validity bit in the MCN was
set before the pointer to the state description, potentially allowing
for a race.

Fix by setting the pointer before setting the bit.

Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9b8a35e7dc82..518a69c55e85 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3485,8 +3485,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

