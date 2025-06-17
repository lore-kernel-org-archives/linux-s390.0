Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF7218592;
	Tue, 17 Jun 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168253; cv=none; b=sij6bXzqu6zG+kkVPM4fe+OCqtR4+qU67ApIrkmiiKQg1con6gBvExwArMehNJa7o97otesN4FH1upJ0Iexi39bcm2jeXk0EREPXkUsS/XxJKGFP0jLie1HHfLeuddWwDWxBsjUAjx4zONS3wMSvrMGOqg4AmmtiZmrDKrjhj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168253; c=relaxed/simple;
	bh=NCUcM86xiFcWGNr0WTQS6kqqA2KSkJZJYjoOIpWTWPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te6s0AY4i2CfIVNNCjQP4wgH+D1tG5Z8cmOWU2j+l/t4JMlWfr290FHN8w0u7CMe3csFnpVsLVDV2XO3G1cJYGHyxEvoyCBRz/ux6pn0bs3LfyU4B7DosHbx5HknNyG9HpEANanBoOcME2jjIKsYrvJYYLioOy2Nt1dCP265wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CsFS92oU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CsFS92oU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HAUFqW001183;
	Tue, 17 Jun 2025 13:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GQWlGtN3MiXssusU+
	VANLm/CsgQc1blpDDTKvD4LkdY=; b=CsFS92oUqVaDE5tyaxuiJVGCnVHwgkkXR
	TWh+ou1cryQ/HyUKlzJJNSj1Ktp/kjccb81S8rQ40BPIgN/0bet5v+rZO1OwRkHZ
	hpli9+oS9Ccf0t1e3EKDQEuUH2qX4wdgI2+YUaiu1IxB8edqbIxe2Snuc0KFrg1E
	tjEVd4zOlXvPOx6zfTgA+nX9k5iuIocUqbdDmde68XH6r09iJCHRFWfUigvsTTmc
	xHPkJNM9HYB0/kM2X68Sz53UXDSjpbfbHdE1/b699SFsswF1D3drEgn15xXeBy9z
	1+mpHHfV/D2OCUdYcALm2mbXFmv3xV14ZS859ICB9q76eDp4SmOng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4grde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HDD0AH025772;
	Tue, 17 Jun 2025 13:50:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5sv86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HDohdi50004324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:50:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C538320040;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72F7720049;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] bugs/s390: Remove private WARN_ON() implementation
Date: Tue, 17 Jun 2025 15:50:41 +0200
Message-ID: <20250617135042.1878068-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617135042.1878068-1-hca@linux.ibm.com>
References: <20250617135042.1878068-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwNyBTYWx0ZWRfXxfCYKls+zYjq cAvr+L2FVOFZ8/g4xpm9iiln9m34X/cPkvIbnGj8TuRiQEevG8WRz7ye0dORxZbMhgG/0/83PKf T1fX1kuwxC9P/ojeXQrsOx0vCycqzvGQ1Vfa6GmXasEAgidXNcLpGWSUxlFZJG89sMr5ZDJX60S
 htjPevzqfW5LsLTgnp5cWTkmJ6++weU1MJJ3NjU8s77genvt6twe+AGN67jNvfOeaMSrTv4A3zw jQGhpLJILcOnTtXTknzDmCUr0haSM0FPjIcnVxzFJkrGkokt7XV6jxstmSDF8jXSuSLgRFqog2R GVmceYRRV/TPBcDGJJtRQvXgLwrsKs1z/mQU5rf6x38FWyHpmZ0ajb+Fx22gIDPZUMnE2+NN83n
 qGpfjkhmmdT6FQlVwrKFAnHB33N+YRZ+K00x/ZYu2Y2Gu1dlZJV5Ke2iEGaTLzaG+HfL1WDg
X-Proofpoint-ORIG-GUID: naOQ3r7zgCTNk7IMtlFHUIUbXuilO9Oq
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=685172b8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=P0T1Fs9wcl-DVvcvJE0A:9
X-Proofpoint-GUID: naOQ3r7zgCTNk7IMtlFHUIUbXuilO9Oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=679
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170107

Besides an odd __builtin_constant_p() optimization the s390 specific
WARN_ON() implementation is identical to the generic variant.
Drop the s390 variant in favor of the generic variant.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 837bfbde0c51..58ab4efd9dd5 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -48,20 +48,7 @@
 	__EMIT_BUG(cond_str, BUGFLAG_WARNING|(flags));	\
 } while (0)
 
-#define WARN_ON(x) ({					\
-	int __ret_warn_on = !!(x);			\
-	if (__builtin_constant_p(__ret_warn_on)) {	\
-		if (__ret_warn_on)			\
-			__WARN();			\
-	} else {					\
-		if (unlikely(__ret_warn_on))		\
-			__WARN();			\
-	}						\
-	unlikely(__ret_warn_on);			\
-})
-
 #define HAVE_ARCH_BUG
-#define HAVE_ARCH_WARN_ON
 #endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
-- 
2.48.1

