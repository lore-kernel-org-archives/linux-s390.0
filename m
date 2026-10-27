Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111438;
	b=VnvzLPAktg7zJIgZog0KBesfe36DvnnaE0Sz1LLOY+wsBgSHAqv/q6Nuou8DQ17wihZK
	 rlIHtQ24RM/DKT+NLsJAoDpuocDABisktngb5Gowl//OgQ/cB+Sv6vGXnTlSCUFYll9dY
	 7hY/QV2ZpfXatV8Crl0/m8/w59iPQr6+J1PEQ3ISQ77oZnhAowIzUN/tdN9tFPvs8Suh1
	 TKZNN0jGOVWmH1voYfaz+O8e0ofR/guaP22cGy5ZE+jmdDC9lHEFeqTheWi+gXeVclPtg
	 MT58ig3Q1Xi6sCuuEPWQUJ/XhZyDjRpUlof51NQHltblZisbrx+c7b/ZB8RW4uXPxYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lqL3djTG05RoEiIbHOfHo5N44BuyMiU2okbEWsvYjkQ=;
	b=DFT90Bvw2U/fJZifkAXiA7yCSnMvAQSH3L290650+g39vyQap352ZCOkdepacfKFZO5W
	 zjnT2iALkOVb8toEoNsTyl6I7oM6TJ0OTni4/ipnsle3AJhmaBqnYrNdDSC+31SQxlrMS
	 YTJvfY0GK1L7GXjOOmAIv1gnweq1yEvP+jutZjQBam5yXsMBhczinYf7LBbhgLCWmwthJ
	 f9HkKcQZ/fS7O6QLt/ep/hoBH5r94z8oc8HYltnwqaEoBRgqskGNj9HEPhvc/+eHd042W
	 qBFzVFw3Co6WZAadNCKmy7X9xHLWhJj1iyyqVW+4omuSBIL8H6WxqeA+cqvJnQ5AFzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PjCW7Izk;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A480606A33A;
	Tue, 27 Oct 2026 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A480606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PjCW7Izk
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEHxE2607543;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lqL3djTG05RoEiIbH
	OfHo5N44BuyMiU2okbEWsvYjkQ=; b=PjCW7IzkYuqf/mg00STmf7ldru0Yl+tQ5
	aMn5Lnjzn+ixZj08/25Hk+1E9TrzxKDUFzsxvQBFDatdVDpgzaqbb3SB3BObrrPh
	UQh9JiniaZ+ckcBZLQWpdYkY2ve81Ox2IlOtWdmlcuDMZeqWJGO87fRpRpJoJ70b
	cyyQ36o92X1dTK/lnEkSX35NcEfYAfPC7Lil3YBRVzekLOhJB/GjGPwflw1+z+wR
	yoDVXuuv4+TmtiM+dC9uuEkv8ouxcx7S5zOrF/iA03zCKWREWtMNc4dXniiJOfOk
	owKXY7xt3A/TgjckSNC1RNLoaJMsp/0IIwj1JoEaUauYOJs9usHeA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m83b3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoPEB098173;
	Tue, 27 Oct 2026 14:30:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1rcx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUWIl46268860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0099620040;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C96BB2004D;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 05/10] s390/module: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:25 +0100
Message-ID: <20261027143030.3154657-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1sbAzsCcC0CB
 sKJBtW/0EvnKN5fUzdIR0d93aBKD4yFXCmGUt54hi/GFGT5o2w1CWFWjU3yiCLiCD/heyVVZqMH
 WKCvmHx2+DXWHCqVpsUmFgwmw78qTCA=
X-Proofpoint-ORIG-GUID: EuTQVsJWdJoaQYIU304Up1pM8D5aWSNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXxYPcbdzxaZkP
 9mA/13swVStjD9gfaRso/RM0ptxLV90YomRontq8ODK+2TCSkgdANY82mWwXe6dEqwOd/R5Tt7r
 qNcO7/IF5Nl3GLTKaWu00mVBI4jH4TrAe/pQGgIVS6ZZHGkkutzZCeO4MllHERlzndYEcs+2GVc
 a9QTb6EI2IY3yoGsRXgvA/sJ28fcceVslR0pz79SCh9uUWsu6w3afg/YNaCkOuhpnv6sHNghgAM
 1zi9QTQRcDYKK0mbD2UcZykOJ5ofspPmWa7DW6K0PPphg1q8N6TaoHg/kkToujZ7CydQNQ3jJ1R
 ccaJpRrO0NQNZeICfBX+VUKrGaBsHlI4Uwscy2R7sscCuRkl7tSmcAU9xv1Y37Ohk+JOIaVy1Tj
 egNP5T2whNmhsDnFwakY8CIAWxoBBJIW7DHm1Y43o1KOAlWIp+uah/b5/hZUEFhCYdQtVhV92+M
 axZgUiHM4rccOcFAuKA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae0b58c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=z_AhinQEcSNdGhEKinwA:9
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: EuTQVsJWdJoaQYIU304Up1pM8D5aWSNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Acquire text_mutex in apply_relocate_add() in order to serialize text
patching.

This is part of larger series where at the end s390_kernel_write()
requires that callers hold text_mutex for serialization.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 9d1f8a50f5a4..79bc80d7bd02 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -462,6 +462,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	if (!early)
 		write = s390_kernel_write;
 
+	guard(mutex)(&text_mutex);
 	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
 				    write);
 }
-- 
2.53.0

