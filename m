Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8998455166;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338994; cv=none; b=LJnF1AfFsoxoKNndDRnkbmmCbBCarmS4Pp7LsLgfxqbxzSRFCOuc8bovL7P4eg8SQmr0hF9x27YwyGOrleOBsoGWJOoyn4CDxQ/TEnlt0Ymw6sG7f9mreQ9xRR2vxaksf/UI/Hzkr/AXBvFbeCFtZ8PeRmIJxekRLeJuD2kEWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338994; c=relaxed/simple;
	bh=7UvQyx27d8vwJAJLJQBS/ReKc7adoA1JGjhS2mCAxr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEVlgADFPVTgmVu0Nu0Y4mOO2smoA7zBxmfJazbmE2ROKZH7b1fP++VFAvENKjssa71genhkjK9U0/Ribd8LPAWAQxskYw0kuuI/Z2TrHo92fm5tfHTgmiVtb8wpzHK1SECGq241j02t/wzx1VXjFIVcVZQ5GKtZuB9Z9iVLoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DeGhhbPe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DeGhhbPe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHgQ0278514;
	Wed, 29 Jul 2026 15:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T5GbFLGBcbJRvJ/pF
	MV4h5th2+viF93Lba+wROVTgXw=; b=DeGhhbPemnBFDBRpYwEaxpNhq3a+mE/Ou
	uUe15U/Rukgb8k8O9Phg9aoJXpfgEv0muZA8AUdu6rAU0oW36YWteyEjikaBatw8
	Z19q1Q/ia0RQbDNawJ1fSlNjqlPo2vvDYTGCbv4/8Icgxc+tr21fSjw32jK9Svw7
	1WlAQyzsmp2Y/xL47eJqGQvyipGdmS43MvkHEhNc+jrkuXrBQ+J6Yg5Q16DjdOtb
	ErKT5X/9l8l7NFo45QUR6Tpzjfh892qisb+r4JWQNpwcI7xOphZ0ICI297ujzWBB
	xNFZXmvIQOW8gs8fbr9bTT7HaboeSGenOnRflzoUEd/3Hk/6q+ubw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjam3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQSns005714;
	Wed, 29 Jul 2026 15:29:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgf3hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTewO30277934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C37020040;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFFF2004D;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 11/13] KVM: s390: Fix ordering when adding to SCA
Date: Wed, 29 Jul 2026 17:29:36 +0200
Message-ID: <20260729152938.782383-12-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX5C+jk7dyaCdm
 2n+Lqe6sYsPmRpWoyh5d6V/aswFImhbRQb0MFvLEHi4Oethrdgz5k1oLTuieOv6pFVTGKW0iuX3
 KegTU3w93x951PsrZpWNe5YWrF8FpPk=
X-Proofpoint-GUID: iExcwQuTp6AgBSgCMjX7nRveE_s1iQoQ
X-Proofpoint-ORIG-GUID: iExcwQuTp6AgBSgCMjX7nRveE_s1iQoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXxuNDO0a9nEpR
 bv9cGz7BeCXrEsGtoezPbaogprSeLY8nuMjUkQlRBdl1plSeSONWZZlCoIFcUR/DoAhQiPYDFR8
 KDUtyBgm3zod6ja4XN0KMzF1fmlNrPk4s4jrBPi0/liNydkdLCmO69irHE/sEnn+JFiO1UCXK1g
 DVGzbshs9Lgtn2lz+zW+flZn+RSa2YlGT+zsjavCPe6hfFtQhkNhJmwXEDA2RxUzuUX7OzbG51g
 Uc5WpRLkQPJ2Yo07hRlC5akJGNA0g6oJwV0Xt+eJgpnSnvhMe3VfQ3lG7xLJKr+fOR39AMuVvk3
 JbdGv2AkGknfjJa+KP9+d+ciEQONbvVNcxpfcqE+yvJTKOiXoeKSkV0GHa5cWyldzJYxEExB0uL
 s5SbML66op129AYY2MA81tbThkjQs2Jwh6m/80OdHQmHUsNqbGc0iWKNtXxtUsOWfj2OIi1pBOH
 eobAc7Uh+EuVrDXvXyg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a1c6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DpaZzcUc-R7GdRs0254A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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
index fbe9abf365df..cdda7a00a0ff 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3481,8 +3481,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

