Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E03081D6;
	Thu, 23 Apr 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947973; cv=none; b=F6RxC7FLFF1hb8V+uLZiLSElikTfkJnRDFXxNNm3r4mYUmVh46LW7bCxxOMFvfmTqxwQ1D0XWyHORXiD1zWkA3pPKH+2ExZqR2eNI5WIyERdIbux01eOA+QU9M23tY0AFhBF//MkQEx/7rcXUCgCG0F3pWxKYD6QoCRBwH5mCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947973; c=relaxed/simple;
	bh=ZHh12tIT7R0Hs5jBgYIxknN/SdiVfn9XiNby7R6fb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAntuArMSHtpzw995IVwEl9cKTsBXEqe2ryjSsbdfroROlmBz+9zOUytZNnC2rpWvAsxPaLvMzYCk2ZgUJZMl4FpizSxzb5eHKIlfmKnMnZUHUHMP61BP5M5Byhc/Icj2/a6sglG+2MWITlAFJz5zh0CWWk3zEhmsi5z8odz3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DfvqlNDq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DfvqlNDq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6ooHR3229044;
	Thu, 23 Apr 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MJlZtWw/4gdNS13g9
	bA4qysynpC7Oxq4YaW6tOTdmY4=; b=DfvqlNDqfiaCQcnXMPImWly2pL9DPULLH
	16Z2Ct8E942rtk0yqCT7q2hnN71vhUdXSCYM4hOGRoKTaBpT6DGvVV8c+C//KPqw
	PEyBS3IoSpykyVFS909aSzJz0MPV7Tv/cEZ1w7OceA1+3Qa+qwWtdJnR6kelaNMf
	OywEeTuo30ADn+jGWy8vj3d2jyoq95W8GLyMm+QtiTHOfK6h5w1EVVgXJSrFLNDq
	jASxulaX2Yp70YJuI9mHqG1MoaV9GYrnzhqfP+eyHMISxkuFOU/Jzizz8x1AaB3Y
	dczAw7HyGbNbFbnoh3tKHolIPjFKvgWSNRJauu7yCjUxIMUB2ne7w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28m8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCZRKY003353;
	Thu, 23 Apr 2026 12:39:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyek3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCdKkD50135316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:39:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E5B2004F;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FD002005A;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH 2/3] kvm: s390: Fix LPSW/E early exception bear behavior
Date: Thu, 23 Apr 2026 12:36:03 +0000
Message-ID: <20260423123902.14663-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423123902.14663-1-frankja@linux.ibm.com>
References: <20260423123902.14663-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _6Z3Sup1UrKEdmcLm6Z5Sa-wWUY0WQpJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX4EHTVB+VIMU5
 qLF3QnV34oQf0iGowjUN7HSECmoQkjVlaFyDOooednjyLVCrP1RHtQe1o9v23EVH+Sc3hPQ5RsW
 XpqW1Z8p1K7nMnJQjr80jHU96z1aO37HhPmF1klCI5lKPrwvL+BuejhsohPn0otA0AlWBql3IjH
 xENbbch0QyOvV0T01ANmRFvaMPj+ThvACSsNmHAgCyBoKCG4Z2jpaST3lKvw3z32RUjapVZpp7u
 7sO7iwY3OnpSX969dB5jAa4V1UT+3QC7EAga2oeTLPacz8AqH7/mcaLquNTkPPImvRpkYo6GYAO
 PXhEwJ3088Ounkc58fW3Fl1ykyDIuRYnTIIZTefmCXIWUl89Ych37vUqQ5GQsYN3+o48RuFcjp6
 2TXlvnKgU5PvCtrThJrg50kJ5S1AFCZt0gyB4Rj1kJr+Kc1s6Tm9C0FAHigHizGQf7n3+pkOk0G
 HBkFf0KTRFna2XwzO1Q==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea12fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FGL5-UHicGFpkBeQ7iUA:9
X-Proofpoint-ORIG-GUID: _6Z3Sup1UrKEdmcLm6Z5Sa-wWUY0WQpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230122

When loading a PSW a lot of specification exceptions are recognized
after the PSW has been loaded. In these cases the load PSW(E) succeeds
but the loaded PSW was invalid. Since the load completed we need to
set the bear.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 1653545abc68 ("KVM: s390: Fix lpsw/e breaking event handling")
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cc0553da14cb..56e63679f9d1 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -736,9 +736,11 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	gpsw->mask = (new_psw.mask & ~PSW32_MASK_BASE) << 32;
 	gpsw->mask |= new_psw.addr & PSW32_ADDR_AMODE;
 	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
+	vcpu->arch.sie_block->gbea = iaddr;
+
 	if (!is_valid_psw(gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	vcpu->arch.sie_block->gbea = iaddr;
+
 	return 0;
 }
 
@@ -762,9 +764,11 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	vcpu->arch.sie_block->gpsw = new_psw;
+	vcpu->arch.sie_block->gbea = iaddr;
+
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	vcpu->arch.sie_block->gbea = iaddr;
+
 	return 0;
 }
 
-- 
2.51.0

