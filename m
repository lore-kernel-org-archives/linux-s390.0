Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1135F60F;
	Thu,  7 May 2026 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184530; cv=none; b=n3k0n5EgzYvhPWLoYTuWu+kqbU0LG+9GkbTL+SWSaOEqQy5zYPh1yxNy3DSP5YYb2jOGg7l5Pfv/xJQ2gwsuTW+wabhU8Fz2V4zkU9tN5CLy+HilBF70C3Jh+VZDTcFYGcE7idHF4FRWgQTgpwPNGhMszlIQPbxXQ3NRtcNJ33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184530; c=relaxed/simple;
	bh=EAcr7chHKUqST8Dm0yjywItPUyxHW4fBBNRU9Vm2QJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF7y9xeQgebyOCgYD9egotvUWNtT0NdiSCow0Mt2qlyCp6a8gGKSMHwWnNuFriqL1VALTuorwlOc9yBGzedIE3X5DFoLlXI/7nYQXqx7pTKZBoPGDVxj7BohInhMDZFmm0nGxF4Uj5wRdPouPlDo+KGa1Cv+MCh6YRX2MKzg160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TmAXJku0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TmAXJku0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647CPg3Y2808530;
	Thu, 7 May 2026 20:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r/NDFnm98gJ01g/mY
	T8+zZJvuq70m8k+EtM0ZrIJcGU=; b=TmAXJku0hajj5lRvEdCvoAlgRKMGvLSAC
	6TRZrqirhy/+T+SGs5qvbgv1rg2Ar7iLaX0klmxCWwYi/Gw5mqjAwNIY3X5f5Qfd
	kLSPiZQzMNhoa71uMm0m7Z6bRlKcoUn63EWVqEA1CpC22LW6iT5a2pYAQZmg8HKi
	iwJ7udgi5aV9yMjdYn6I4Jgx3jeLdy3b97HUFICGGkShILVQpZd92MspfNfaXfA8
	ALBU5w+g2U2/+dVYArGjPdDFAOBMshJUSsfGtIBY/ztM2+MobhLZriGjNNyDJZ6J
	CsAZlkrpEZlKhpmbs9m1sMIoSiU59mcbO4mrEfhnRUHZVffUPiNnw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1rnnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647JsTEt017766;
	Thu, 7 May 2026 20:08:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10070drx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647K8gbW51511728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 20:08:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224A82005A;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D972004F;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 May 2026 20:08:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id DEC45E05E7; Thu, 07 May 2026 22:08:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/3] KVM: s390: Toggle operation exception for userspace
Date: Thu,  7 May 2026 22:08:34 +0200
Message-ID: <20260507200836.3500368-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507200836.3500368-1-farman@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z7njWV2EfEfHUUduxzESRAYY7RBjuuM3
X-Proofpoint-GUID: Z7njWV2EfEfHUUduxzESRAYY7RBjuuM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIwMyBTYWx0ZWRfX446U5Fv4IyeL
 qHdWndA99CWcxWsAJB5ABdk+RYhkZnDLOKywNUDCnpQgMazARKz26D+3WDN8CnZINXbSqyzifAF
 O9yeogvfOKKylp2s6xyo9EYpLI0hiIBKv/EICyYmN9YttJFy3gRcW7iD3eobuai0D4yIJb3twyf
 U9j6snDFF7uef/zWO4y07AeyeBgJ1ZCfdDpw7Kii8C9gEgxn+WsSCjrczvaHO5EsYtETln99n9c
 okSTLRU0pRJ1Q4fa+DSgW2ht5FS9XY1nyKM3Bc6S7vwJaYxgV9EjIQ/w7IeK3gyltogC5638vRt
 oeYiSM22t2YesIQXz+6yYjmHm06yslxd0Ifxg4CEgDQPra4Wj/p6eW5bbVFF+QuEKrBj3FRj8Zz
 U589HJSBlFLul/t9bSFm+eKItFpwKzwDOkk0O0qPOT/buPakwZkS/e8ucP90JykUFVKvqvFAvC+
 rOW9j3Z0s1oFIk9SW/Q==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fcf14e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ea8k8XiQOFGV3AjeF4IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070203

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

Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation e=
xceptions")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..a91a42174302 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3521,7 +3521,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu=
)
 		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
 	}
-	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
+	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
+	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
 }
=20
--=20
2.51.0

