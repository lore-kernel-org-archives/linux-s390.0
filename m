Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789456;
	b=0L5+NECqnWd3juEVmv4Cb7N/kE/Jjioqr+U8vyZvf7VfVdJi8Cc3hBOg4BoPGNncQK54
	 Ii+1YVZEV4havjf8avS13UYHEoykEtVCh4rS1KXP+PapwB/u+FLsD3LUtIlHfxtA6IJIL
	 Sh51gpLM2aniLMXiyNSNA2w5x03Euf3h2AVk9d2L2SB3kdiadKipyb0oaIzsIgmmYE142
	 w5KooWgOAL9BbuEbZO8OlbxZQtx357dfOAQO9hgEVCehAUSbfoasyxvw45YV7N8YXIrNj
	 EhzkTkx6fjfsoNjpFLEeAW36t60hVJpukgBHa/d2OduhBPJ6xSlPXE19Ekg27BbUAHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0LekkFwRdKFJr5OMmSpf/kgWw3QfDNXDLDKIR7iSPPo=;
	b=Rx/auBYev0azA8RNhSs2fmhl7lojORdh7koAs6G8zaUHAonxumMyDtRasfZDt+UXPDLA
	 cpNp1slh21cwSljcmBQW6QD4yeIWbrEuxzrWCNg+7DveTF2H5YcIioZEX/0HO5OBGhDlQ
	 1mauPhH1TTYega2eCSW3C/acwlwZdxU9gf2Dr8ccDY38U6sg1DomRYL6QSaZMTEX9HY4b
	 E0Tir0NOusGimoUwGbcACydO1MjmXuEhdNnvcCKIQYiC4RkD0+rAh1ZkguXLqnmQrEtSI
	 VaGe2WEdMXVj6wJuOPVt4SQ/XmT59h2Oup4dEdOCCwsCsCo5ZDxWMOZlTjFdooYbqWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iAgdWp9c;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CF606B1AD;
	Fri, 27 Nov 2026 14:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4CF606B1AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iAgdWp9c
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE58DE3420095;
	Fri, 27 Nov 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0LekkF
	wRdKFJr5OMmSpf/kgWw3QfDNXDLDKIR7iSPPo=; b=iAgdWp9cTjYkryBDBlkJuM
	U1YfBEGIb7o2CzU1CExt/aKaKpYmELrxE1XlM4cTugJjoXjrzmWNFOhqdDJ2Xz4/
	ndLiCjG6xymO123y/iLg7qlrXcHnvL1UB3n4A39Dfk2rQb2wC078TaTOfeXcQIEo
	jVfF2lOBQi6Hf/ksApHvswCzERW7AjlIFMwY43O8oIW9lCgG4QPhd4FqaD0iFx1O
	r1sz1yS+I/+YH7qyiZW985gxMNY93m1sAtdRXntybDoxV0a2Bd7dCScjLce3p5Zn
	hU1/PaUjpsWpaiDGaX0FhbDmeqM8PPbFucM2gmS5w/ZgGId0Ai53Si7rlENxdwfg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fap8m8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4IJZ3999029;
	Fri, 27 Nov 2026 14:23:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2eu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENOR925232004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F3B2004B;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A991E2006C;
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:23 +0100
Subject: [PATCH v4 20/25] KVM: s390: arm64: Use QAAF init save area
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-sysreg-v4-20-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX969lkI/KxOG0
 fxPxXQsW5a1pADzxBQO7CHlwcdt9pSMpYzUuv9fRN76fHzHTEifgYCs3tiRrAitkOKo5LbTXt09
 yToNmvSNI2RlSa5eEEcvV7pAHOaO2RNX5H7xCGC3IVvYstILDKisSFC9rB0bWfFhAZWFI3D1E6K
 C4waGx8FcREw5yCdHBwR1nkJ+6fBpeG3Nm+bRgH9E2R2pi6PiAZ0u61OOWNOvfu3VqGbuJhbvKc
 Rzf+Z2orL0iJPRHUBA/9HnP6rfJ4PkX0L/qwN6GHO+/xh76nx8m1Z/2ga0eI5PwDnHEw4+CBq7N
 AB8Fkur9mdD0f4jhRlN7bsEXYs1a98XtSdqDK/gyv0xDXbsvjvbxLGfNpcpLFFxJzJpuEBpjK2+
 0bIQ865lLXjq6CKMvdwbWl/a3fltqWqiJYp81P/ex54rN0DwP+Lc5SEo3OhLq6VTiY/XJfVrgq8
 R/+22yg6JGlSqE1XhUg==
X-Proofpoint-ORIG-GUID: 9EZuR2zwNcaH2lTY3nOgD0HwW9O2e6cV
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b099262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=4v_MITeQBDqVJkbHs2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9EZuR2zwNcaH2lTY3nOgD0HwW9O2e6cV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfXywdAp5XkifOw
 MpTuFMjncpapVeP5AGU+Cwi80fLPq6l+N5tSnt8HxVrpWVsE5NKH/0OfHnSehGQVGKbI85aGOTI
 HuUQJH2GFyn1N6sCl0GCXbDwbrPoeFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270056

Use the (cached) result of QAAF fc2 (Generate Initial
System-Registers-Save Area) to initialize the Save Area.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 1 -
 arch/s390/kvm/arm64/reset.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index fb9c747de64c..8d3006837af5 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -377,7 +377,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	int ret;
 
 	sae_block->save_area = virt_to_phys(save_area);
-	save_area->sdo = virt_to_phys(sae_block);
 
 	ret = kvm_vcpu_set_target(vcpu, init);
 	if (ret)
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index 9fba709975e2..b36f45f30b9b 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -3,6 +3,8 @@
 #include <linux/kvm_host.h>
 #include <linux/fpu.h>
 
+#include <asm/aef.h>
+
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 #include <arm64/sys_regs.h>
@@ -80,6 +82,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (loaded)
 		vcpu_put(vcpu);
 
+	memcpy(&vcpu->arch.save_area, aef_gisrsa(), sizeof(vcpu->arch.save_area));
+	vcpu->arch.save_area.sdo = virt_to_phys(&vcpu->arch.sae_block);
+
 	kvm_reset_vcpu_core(vcpu);
 	kvm_reset_sys_regs(vcpu);
 

-- 
2.56.1

