Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BE42980C;
	Fri, 31 Jul 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502923; cv=none; b=Mv5evNAIpLBcVdWm50gb0DBy6PAYlUeRx+EmpdJFUO3IrB95X1ksjhmTWS2daY2Peg/sASJeREz09pdTqFXyrZKZc+EpixiKKu3ynTg7H+kTcSlcETVLXyhpIgBzTMlzCFqvjVpiHJgBil8F7KuGdgpCSJeD0vR1x7A9fcDC6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502923; c=relaxed/simple;
	bh=SueeGW913y+l6iNRtLVYVpFY6wBTQ6KEeYtAQFCxDSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO3jVRzMJjSMFig014SFRzkx616I5WBFHnFBberuD+nShLMYMIalsEWQOgZAWTss7ad+nwsZc4pd/asT2Qei3K6wWIal8cUANXXMfunajz0dTdojwuBuChiGL+U3z7pxshXwpTw5nEORQMOnjC8eDeM6F+hQM47yUB08sIUw9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lJZVTaDk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lJZVTaDk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmGSw1671896;
	Fri, 31 Jul 2026 13:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kD16CCXM6IusG0twE
	5s++dKeFs80vjBLnsgXBQEbWo8=; b=lJZVTaDkuQVj4jkOANv8zc+Fh9MT7SQON
	sSFCqNfvVV32k1PBNl/BN1SAQX6RvjDi5/rVWRmRuiWd7Sxc3lUzqCtAXKsqRkKo
	69lzXmhzlhFPcjP8q2ikXOxveNVXyhc1lP+1+F/jVwhajqQ6xJBmZuMrVrxWW/gh
	BZfbSlX//+m8LYbThNlSB7E3qjTr4AJTH+bn/2v+KzDVzeCwe+/lwRuU6MJVz/k1
	ri4SGUmsAjFqTgbeRfIth9Y7/xrxabedFohBO9aQuiOPXl1WpoyuU7sqW7K9KZl3
	i4XQPbyOdPwpHH4y5VKpK4tfRm/btfY7gQvoN+Gc7u3uyD8s8ImAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjm2rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuHpb023551;
	Fri, 31 Jul 2026 13:01:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yfp7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1ptx29753660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D917820043;
	Fri, 31 Jul 2026 13:01:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD6120040;
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 12/14] KVM: s390: Fix ordering when adding to SCA
Date: Fri, 31 Jul 2026 15:01:36 +0200
Message-ID: <20260731130138.173983-13-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX3CyY+nnpGGNu
 Yg65Zy5O3buNR0ni2lET5YdheD96XiNk8PgkhMqyOzeCs/ilIPROYX1Uv3HWiefLkTp6Dy69DRR
 TNT2Zbcc+K1xpgx0VufC0hdhfpusKFI=
X-Proofpoint-GUID: Xh89OLpgrZIBOYtzOz5gJ8DkgEibMMox
X-Proofpoint-ORIG-GUID: Xh89OLpgrZIBOYtzOz5gJ8DkgEibMMox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2xiGA8EyeXz9
 L+eixoMWOYbxVzk2F8fEV5TydjtQ/q6GOTyDCik/uhYujjabPuQipB+f0pE5M4kFBkeg9he5Zet
 rEfMTMFkpUS6Huy1Xw7OIbDY0I4EZu3Ay855yjexuhCQeWLXS+Ww3pikAwadCu3j5tIFZX0Fb1O
 adv28okDhZewvj+5BWlPB4hNH+uWh8RP34GFgxbQPTU2F3D90qn1GoITBnALMyNEJ+kBeZlpPKZ
 XWnp5Th9Zvs92jh1YYJoS17LhwgV09AMFPCG6KNcKUr//uGf87dnOvHYKwfJJ6pmRiwle3Zc0Q4
 N9I6LPp/ykNiNWZNCaFMP8xwLyILfZhViQxGO5AA33bL8+jPxiqJmhjjl853pe10/bx8ncF75Gf
 2qYibDFmoP9r1eI6v4Dm0BnLyr19NoPMJWMOzp1xb2dYuauBegr5X8wfXpU3QnIsj24CzuGuGqn
 Di736QksryFEh6Z0Adg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c9cc7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DpaZzcUc-R7GdRs0254A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

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

