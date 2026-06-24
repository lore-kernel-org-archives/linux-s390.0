Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FD2D876B;
	Wed, 24 Jun 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299980; cv=none; b=cnqhB+wgjKfhigle0jggo8KSId5XEoeT3dEdE63GTYxhYSeEqXQ5nZR+VkomAiJNYa4E4H8v2jYIZruQbZShMHJYe17oN1/P/RGqEdXmmpbfLmGlixpYaEMQVzLUrTVwt6TXISJKnPdsDXhyUIDIKgvQ7pddI1HtjpsXWtnft/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299980; c=relaxed/simple;
	bh=cZn1NhFw7R5qDVhZ2oS/a/6xW4NoPwObn0OCreWVHdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A83/Lx/Kb65vx9DnitxPrauL+i1rysqfNV0knfyghHIq/miSHxQVYCzokxPR1zmL3Ioqw8PCxS8mB6wtUViXJRTjrH5joSs2DKt6fchL5ZEUYnUUsGdRUATHMCgP3xkkstafxE+QrDOD/oXm9Efs2xVUu8oUAMl9Q9Vo4wOu8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GtQuyVTB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GtQuyVTB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmXBI644374;
	Wed, 24 Jun 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bifviIFYZVFzan9GM
	up+pV7cwuDFizvJnR9xpenGnSM=; b=GtQuyVTBkkdS62m49SCX3NO3CaYhT/ZCw
	RQHF5WhdcZcsVhgPsPilbMu8YY6rrjWIU7fvoTiFGI14Z/Kei7rN/5PfENZM/2cI
	1NAmnBeT9KW8zqKETVwOeBGn9oET3EKUWDABDYZ+HdtHnsLSYra1U245gMoMyWNS
	QsifdpGxC3BaueBNrbgwbyGaLzyhOmolbpyslL6oTSwgcoUXb+Pk1Ke9gPn9XKyV
	+DAPrWjbPBKWX+Pw1GB0/npXPogIRmsOpY0ysNjjn64lLQDRPCPed5f8piv9QURr
	FAq5IbYfaoJSjTVRpB4WyWWLyYLiIyPdTYkkafS3SHzDLJA6SB1Jw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4kscj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4jEt022100;
	Wed, 24 Jun 2026 11:19:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg80yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJT9g49283356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CFA520040;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D47CC2004B;
	Wed, 24 Jun 2026 11:19:28 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/12] KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74
Date: Wed, 24 Jun 2026 13:19:17 +0200
Message-ID: <20260624111928.144283-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfXwhP7BhdiJ+e2
 IWESylMahDw1HoomsDSHCQVGkLqcqiqCrRZwebWRiAcP+dXWL27oVAIgWj1RJ4oiyOLJVM6tLgP
 7h5bILChX547GDhpjLJ7ZFzyQS00lU4=
X-Proofpoint-ORIG-GUID: zyu73OUs8UopM8U0sdSppuLdtlRMEyWF
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3bbd47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ea8k8XiQOFGV3AjeF4IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX/gI62Og5Ub2V
 wrczzUIhwX9VcPQmkvSwXZ4Z4KsutRniQIbxK/jkG+GanypZO780GB7y1OqKxtmfHT3trJy3CN6
 Vf7ehcCHBHxwye4kpDrT96DBYRSSubvpMwRci4UDNaqlHtf9sksD39VB9jn8NBiEuTHoUYdqjUk
 Ae+FbNVbAm8gUjtvc4URzS4rR6yxDzLvHdZO4Ot4dLdhjwWnnnFHzNN6VBBDCVXBr+9XiAUmmpc
 rV1ZecOczzEsIYi+xwJyq2kUvNRh9X6C6mZrOhcR31udGKHg6C7pnmIkA33OiEbE9+2L4/jHlec
 qFYfn7yYxQXfKKkJqIAp6EP2mdO/YllfQzcur+MB5JKWUtLoUjoFSHv9TBGN21p6Es96tUoKott
 75+p2Qw2z9jVlOHcyhrkkXyL8ef/GaZv2cYI3X8w+vxFQ3fjgx6hAZSBdg6AuO79yHzkvh2xP3o
 19VSCbeOR3S6IjbdBQA==
X-Proofpoint-GUID: zyu73OUs8UopM8U0sdSppuLdtlRMEyWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094

From: Eric Farman <farman@linux.ibm.com>

The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
to be forwarded to userspace. But the actual enablement at the hardware
level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
user_instr0 are enabled. The latter is associated with a separate
capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
unconditionally enables this bit in kvm_arch_init_vm(), but the guest
could disable it from the CPU model and thus ignore this capability.

Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such that
either capability would enable this type of exception.

Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation exceptions")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
[Fixed patch title, as recommended by frankja@linux.ibm.com]
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260507200836.3500368-2-farman@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..8a3d55410f06 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3542,7 +3542,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
 	}
-	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
+	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
+	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
 }
 
-- 
2.54.0

