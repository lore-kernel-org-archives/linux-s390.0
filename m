Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770944;
	b=5ENkCiBXUV6lEXPwIaFP+Sa4lRMC01iJVGBG6Leh+9ibdgepkTWGj63mO9/Cdj6H43VX
	 t6O2Q1iupx3BTz7/9/PcVMVweQK2w2uqG+HW26iFDTtY7+hd/u2oxPZJpN1gIgP8YiFLV
	 xWxo3hjpSiz2quFwqBVXKkFQilnhz3JWcE1hux6StAaoV5yb4RSvQ0UHFaJgH6p6fp8VD
	 skB/9368SfaWPGsHL85kk8zmcR0cAbCAacM1/Nmb6dM/Qty3m5gRYicH9IYJbh7g+IAGi
	 pAw8hsgwbJ11T9FzOFrpuvNA9iHQWiaAcirZPHpSc7XKKOqXUzVe7jMm+PGjBVWT51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bID2BpoIY09HLgjD2eQALeygUFmNaSi2I6bMp351Yxs=;
	b=aQCkbcCfi0CmRUBEjfxlLwPtsm2OptCJNJnFgjHZ2VwQvfr3q4cbiLiRm7hAdYjqr9dI
	 K1LGHPSo729f2tKCT4Xn7SilQU1LgUCYgvErGDwe9pqSk603gaoCG4NReuh8fa9Ecg53y
	 f+UoulIpPeyMHsCtTmYCZpDZfquTygbjiao5rxQ1vXpc46UYP01q0UllkVfJ/i+101R5z
	 fYV8YvGLuAMI74vE/NtOcbfm5rS5bIPxqRao6a9CtyoEg6y5soAx8boWP7ul+/qcwlOSM
	 mv5GW1jKM64o67qTkK0GsLS3XYhsi3qS1yrUuC9/Sxq9PB5cb5uegPdfpaPL558rb0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P7VICVyL;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2E606A336;
	Fri, 23 Oct 2026 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D2E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P7VICVyL
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEKmB3113170;
	Fri, 23 Oct 2026 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bID2BpoIY09HLgjD2
	eQALeygUFmNaSi2I6bMp351Yxs=; b=P7VICVyLHFMgW70+UTgQU6idgCCIn+vdq
	HTEv0aO3dOowmNJutN6K/YL5HbriGc+p2DE7IOMR05XTbLi483TtYCMbCqfTGJbo
	x/EG00bPCS2Swm1vtobMiSczShiXA6AAEckm83+Z/PTOwSMywLCu/OO3+DkbJi10
	v7syUxqDyKLj07kwQ/HKk+PLq9MOByeQ3nZr4N9WDIZXQHH6ITWGzLWcsQLJiB6J
	SBHd5YYoN1nLI2mOeYxWduugj3k/dNJR/XZ0klCXkvxM552Uz0HUWdUiW3+S59q/
	yNfdPPmZmmknr9Ubv6r7fd4UbUfLVpDP5pwLLg6E0P+goLVlW6zQg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b5j16-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6AJD2263076;
	Fri, 23 Oct 2026 15:55:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck67dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtXmh38076874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DABC2004B;
	Fri, 23 Oct 2026 15:55:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7369D20043;
	Fri, 23 Oct 2026 15:55:33 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:33 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 10/10] KVM: s390: Enable 1M pages by default
Date: Fri, 23 Oct 2026 17:55:31 +0200
Message-ID: <20261023155531.206113-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb837c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GTA4chkwOabIMoMS33IA:9
X-Proofpoint-ORIG-GUID: EWqCh3UlhffR_SmsMJYUYqSqwIiUn8i1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX66l/TReu4vC6
 iq6TM3dVNk4YaIX9IOCAjV53fFM24D1IUk9FNHwGSTTRuMbFKkPqk2D3491HlXb+LxT95Oc+J85
 F/6xn2MI71is3h7yn31SQgqPjBlYLhillFZc3SFSeav9nBafQsguHZptPvGRhFI62Apc+L1m8FN
 a13+8rtnlt+JAqf0Ri8cE1r1qjf+KSazADkohERM/LesWWNlIB1u5mxhCAsXDohdzM6MSkHUk8Y
 gQ9KOhmaqnC35XYE6lwbmOK3XtAltDfTpWXxjCpiAfuuZvJL/O5oZ92hp3oQ/y63tl32U31Y0Xe
 yh2NbOCv8Kc5pUQBEABSR0w4vdry+y+VsVWCcoxigFItLKXuYD4vuZoB7MyU1rzz1ieRN2jx4lS
 mz8tAyMQECtb25pd42aPuW0JqEg6kvCXCRgx3ITFyz0LssfcxboU5eFRc4yzizdAJx0R8h7z/Lu
 jsm+smfbWNc7DM5iWUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX2dcXn8qAyTGA
 1ES33yJq4SVleNpLKD3cHTYyzj87IoUMtJeB6dJM4URNbpcH2CrQEH0cR/tRPQwjFhHgnq5/JRK
 jUluc9lEaGojTYeD08LThWIkwiw6nsY=
X-Proofpoint-GUID: EWqCh3UlhffR_SmsMJYUYqSqwIiUn8i1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061

When userspace uses hugepages (e.g. hugetlbfs or THP), use hugepages
for the guest mapping by default. Until now the hpage parameter had to
be set manually when loading kvm.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 280310870dac..71d79b4437ac 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -212,7 +212,7 @@ module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
 /* allow 1m huge page guest backing */
-static int hpage;
+static int hpage = 1;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
-- 
2.56.0

