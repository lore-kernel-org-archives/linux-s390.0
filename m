Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013251;
	b=064pzrcbvupNXBVyf7BIwQL9SrK5Kxe+jYgrxLmR9sAp8TCiHdaxrO4gPTVxec2HjAOD
	 OBoLHCAaSC1848nDTL5YwaYJMURN4wOslrn9QcdT2mUwevgXQ8SOW4XooZkYh5QlMl9+k
	 L9uX/DK8/JtyPijRjmOltfbJpwp9yKpYLwUizOXDDcCdinZQK/zpBzyfLUliCLpqt4kM2
	 MF1NikHN+A8tDnDmkg2ls7bkK23U8ysa8s5IBgPn56QOezPBEZK8ZvcIlPKFQmVc6yL+u
	 aEQqnSPZyYtN3D9QmwdYCLKeLA1ob6kBloJBfQDVn0DwqfTa1XjgnsQ6iZqQwrbn0uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CBf7AWQYCI1unQGyxWjBYTfEQ4noFftW/mcLDjuEmbY=;
	b=iePTTFr2EFtHWH66o9UVD3jd3wvr9D7wiztF0bSfFwT3wfTj/N9iGcktuA057Dl2CpKx
	 hnKavzTnCSMePXCGD0fQ9S0Sa7gq14YZ6FeWZ6KNwD2QXiu0prfUwPv0628TsE4UaS5vM
	 4vUNpQz5Kd5JyX6otKgjMe+rbNin6Z9NRvWcO2y2S9A3iwW7BqLZnAUhAVvsE/EhzKIlI
	 HqTgSa/Gs2nrwxdCwiy7h6DGwtDSL0Fd5W8O8nXVWwmHcyE6krVGV740dQ5Hdvq3IjZG2
	 jJI1TNNqLvwuF6g+ujo2WXax/Fd7aqmknJ4lNp/43ALwzQMf3Io6ws9GsaCBpg8P6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="BOpfj/rG";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC86606A333;
	Wed, 18 Nov 2026 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC86606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BOpfj/rG
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDRQhd1235282;
	Wed, 18 Nov 2026 14:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CBf7AWQYCI1unQGyx
	WjBYTfEQ4noFftW/mcLDjuEmbY=; b=BOpfj/rGUmoVr2zgc6GLO9us4lsMbU+ZR
	QwAHs1m4BQQmHL2jY6mF7BpmAIqn1jFm0k3HnPdSNQIkSmHiyN6+cgbEIk3njmBs
	nU7MsCVJPvAf5cKO1e5U8Oh7zNQPl6VK3JI4dPADJAZeUubwtz2jYP4sDyz0fxq7
	jgYhiPE6ub78pfDaGYNMd2E6pCGnkI/p7VIAR1rq+jByC7pR31caMliJxu96M0rP
	IT0xMt/zt1sYr8zxQHirGkh3gGke0kb2wdolHy+vKOPaMuhFR64cF3q4MD1yAw7z
	imsmgYOxEv6X+e3ZCT8ssEJ5FeQ0+04j/toutD0OOk9m9XxeTliKw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vjv9p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZ0pR3470712;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt8swe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElBa040108492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07E0220040;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E3B2004D;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/8] s390/module: Add error handling to module_alloc_ftrace_hotpatch_trampolines()
Date: Wed, 18 Nov 2026 15:47:05 +0100
Message-ID: <20261118144709.202520-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: he32Eg0Xkqn5tmsaa1Xp2QwLmbooNdfn
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Phm8p_znH9fYv2e1ZEkA:9
X-Proofpoint-ORIG-GUID: he32Eg0Xkqn5tmsaa1Xp2QwLmbooNdfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX/HU3DevVqm6m
 rTriairz6eb+fDktrH3AYllK6PWge8bBLcbV8gv4DDx/IBK6Dbtosx5HsfQ9QG0MD5a9mV84tdp
 TAoiR0YdgDkCMc9jMD/xVE9gXAH3NRuAIx7kyPC9tqkLBUodMLZuYpUVLrV8eEDKCeGVdOMWw/Y
 xDa/ltUu4qyShf4g3fHu9iuXXRUVSJCSAIUOqMgCwkdg+0OfwkdcGkp9VWxPopjvz+4DeqFTbCh
 kXI5kHAQxTkKbmhmMHl4Do6Y6OQFiyKXMa0sOTZB6ijUicUcgHJvVfhja5R+m8EnfaEzq8XyZAe
 hRJyjz0OrtsHVvryf90CV4gev38UdM+GMVTIfBEU2Eh/MOpHsXIROLNfOiG0+VUjClybTzoD2Hx
 QPejwz6S2Nz4wVVYtPhMYtfLLRzCTv/JsbqhfaWhSinvRWNomB4QR90BqS7q2V97xE44OLaMKeZ
 Cm96VEjrNCd8ZB6FqJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX1818oAlqOFx2
 yygTavCrU8xp7biv5nqFbKRIMUabZ5em85TC6Sg4tLfBLnUZZzjYlkiHP6w0lmZHmfycqbSESle
 ltxFm9V3xRXmj1u6Bs5ityQjzn4iC6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057

Let module_alloc_ftrace_hotpatch_trampolines() return NULL, instead of
a pointer to a not executable page if set_memory_rox() fails.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/module.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 9d1f8a50f5a4..86ace854e22d 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -473,13 +473,18 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
 	char *start, *end;
 	int numpages;
 	size_t size;
+	int rc;
 
 	size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
 	numpages = DIV_ROUND_UP(size, PAGE_SIZE);
 	start = execmem_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE);
 	if (!start)
 		return -ENOMEM;
-	set_memory_rox((unsigned long)start, numpages);
+	rc = set_memory_rox((unsigned long)start, numpages);
+	if (rc) {
+		execmem_free(start);
+		return rc;
+	}
 	end = start + size;
 
 	me->arch.trampolines_start = (struct ftrace_hotpatch_trampoline *)start;
-- 
2.56.1

