Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089155237AC;
	Wed, 30 Sep 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789718; cv=none; b=elCVbnBO9Gt4Z3fkvikepkBfXP3JWUcREAvx5LeZ0uNUBxlgKThCQ1lKoU6GjqXr7a9/8dFEGBudo9tBEqt9JEllTE1HWMnXaopDLOcG62zRyGuwDUl3xCzFfH9LECrCMh8Nwrw23zWjJTPt5xyNtdgEI6nPQNT8WxDGZJpDiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789718; c=relaxed/simple;
	bh=gWy2InKcrxbBq22UfXETT/uOX4ZfrtUZ1bwRnhMubQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSqW1iP3M1ZO4idlms2CbxMIvvOC83vqqJfw1cp1gdpuUdqx1NLcmwHPofh3keAzk6/JE68XH/zOIuUUjyr9Lmin8K0SNN/YAxXM5TWoLwCMBjstUh4JiGD/Yf/8Eg9S/IDyH0ptXtwPqi4ccMxLYcDYVr6wE1SjzkgdmZV1C3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzXxCQyx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzXxCQyx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5f0m3171246;
	Wed, 30 Sep 2026 17:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u92NHBseWk0xCVbsd
	d3r69uqfoDcKPAc7OvgaQJTAck=; b=pzXxCQyxQUtAcgy1e8FGLm+1l2zIEAebr
	ibU9OUw3gfDgaQCtcUDwHhPf7wHH59B3lf4Yp1966C0bH5eEMwxVDxmpuLbkP6Yj
	aQok1zZ9yT5+MHbslJcbyYbGhKJOBATfPEX2JiJwoGTD3MLGCyk6RnPQi5ypJfOC
	sHeq2q5uMb+vkBFmAxma2kV+FxBt75X2IsosrgLXVgq9c9OjgK2H66aJt5kRd+Pc
	wbxdyDFQdDltgZMpdmj6sgkUpYB6SL+z+tIIxMkml1rOVAUM6wPT75xqzfiLcxZD
	zEklEKLSCbBy+qThZZA9oSagLGoFPpO0sc6ugT0+1QWVrOfF8ljgg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5eh09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE38Tr3541488;
	Wed, 30 Sep 2026 17:34:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcyv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYhK148497120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D232320049;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 845752004F;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v9 05/24] arm64: ptrace: Use constants for compat register numbers
Date: Wed, 30 Sep 2026 19:34:20 +0200
Message-ID: <20260930173441.66762-6-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfXzYCHepgWDRUk
 VWp0rHp5A+G8XgDLAUz3gpvOTlIzUJIvTW4MWd6dDvMRXCP0B9ysJbLxG4oGffG19c83ZpeVopv
 SewSXaI1GdfGcyukIkYZtLUFGwENPNE=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd4839 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=8sKaXpLx0aSSeG29UzUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Yqfa859gjKilqCtWyD9-n4HdF-vDJ9dg
X-Proofpoint-ORIG-GUID: sRDGFe8E5V8bzRp7R8p2vrAka8iyZ0Bc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX0HI0mMl4VLff
 Lmmv+O3B+xxnfwL/9jjDnKw/Bh574qcvI/PED6BahUS4o+jGfhmFnezxL1+ucxygxSjedZHqZxv
 R3I3WQZ8RjhBo6qvrHi+IKw8UX+RjLvBweuSn96KMJQb3B/6aQCwdAwyjxr7lnZXQstmEIbB0DA
 +ct5s155/gt3ekE++yrPaJH3nd5b4UJuZ2ZCiTobcztqSKStWb9tyMpP/VArgPqMuhWGH9Y4Vs0
 MJJhNprA3hOPlFsJx0STIUrcNEcvfcF/htmgY1V6nlAGamBw++JnxqtJ5tvJSw2UPbDZapISc7m
 9HsrGNSFHgGCYobAKk3WPV0U4YYPAk2E11egho4bXVJIbWPwM921Hyif53g6l1HtBuHcz8Pv7L1
 WON9e7a54UZVH3+yxVf23k0sdeT3NMf4NduhAale+7Wv7JzwNu8F2gjOjq+pFOiJKxBoGCH54Pj
 vPyfocsA5b41rhKYiDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

Define an enum to determine the register number for the mapping from
AArch32 and AArch64 registers. This allows for a more flexible use of
the register mappings.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h | 60 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index f7dc5fb9427d..49a83a0636b9 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -102,26 +102,48 @@
 #define COMPAT_USER_SZ	296
 
 /* Architecturally defined mapping between AArch32 and AArch64 registers */
+enum {
+	__compat_fp		= 11,
+	__compat_sp		= 13,
+	__compat_lr		= 14,
+	__compat_sp_hyp		= 15,
+	__compat_lr_irq		= 16,
+	__compat_sp_irq		= 17,
+	__compat_lr_svc		= 18,
+	__compat_sp_svc		= 19,
+	__compat_lr_abt		= 20,
+	__compat_sp_abt		= 21,
+	__compat_lr_und		= 22,
+	__compat_sp_und		= 23,
+	__compat_r8_fiq		= 24,
+	__compat_r9_fiq		= 25,
+	__compat_r10_fiq	= 26,
+	__compat_r11_fiq	= 27,
+	__compat_r12_fiq	= 28,
+	__compat_sp_fiq		= 29,
+	__compat_lr_fiq		= 30,
+};
+
 #define compat_usr(x)	regs[(x)]
-#define compat_fp	regs[11]
-#define compat_sp	regs[13]
-#define compat_lr	regs[14]
-#define compat_sp_hyp	regs[15]
-#define compat_lr_irq	regs[16]
-#define compat_sp_irq	regs[17]
-#define compat_lr_svc	regs[18]
-#define compat_sp_svc	regs[19]
-#define compat_lr_abt	regs[20]
-#define compat_sp_abt	regs[21]
-#define compat_lr_und	regs[22]
-#define compat_sp_und	regs[23]
-#define compat_r8_fiq	regs[24]
-#define compat_r9_fiq	regs[25]
-#define compat_r10_fiq	regs[26]
-#define compat_r11_fiq	regs[27]
-#define compat_r12_fiq	regs[28]
-#define compat_sp_fiq	regs[29]
-#define compat_lr_fiq	regs[30]
+#define compat_fp	regs[__compat_fp]
+#define compat_sp	regs[__compat_sp]
+#define compat_lr	regs[__compat_lr]
+#define compat_sp_hyp	regs[__compat_sp_hyp]
+#define compat_lr_irq	regs[__compat_lr_irq]
+#define compat_sp_irq	regs[__compat_sp_irq]
+#define compat_lr_svc	regs[__compat_lr_svc]
+#define compat_sp_svc	regs[__compat_sp_svc]
+#define compat_lr_abt	regs[__compat_lr_abt]
+#define compat_sp_abt	regs[__compat_sp_abt]
+#define compat_lr_und	regs[__compat_lr_und]
+#define compat_sp_und	regs[__compat_sp_und]
+#define compat_r8_fiq	regs[__compat_r8_fiq]
+#define compat_r9_fiq	regs[__compat_r9_fiq]
+#define compat_r10_fiq	regs[__compat_r10_fiq]
+#define compat_r11_fiq	regs[__compat_r11_fiq]
+#define compat_r12_fiq	regs[__compat_r12_fiq]
+#define compat_sp_fiq	regs[__compat_sp_fiq]
+#define compat_lr_fiq	regs[__compat_lr_fiq]
 
 static inline unsigned long compat_psr_to_pstate(const unsigned long psr)
 {
-- 
2.53.0

