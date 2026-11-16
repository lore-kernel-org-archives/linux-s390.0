Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850207;
	b=VWDPm38zhB5CvhMNZ/qu91f/AF0BwYj/K22k7IT5bOhj0MCP/JzNKDlmrqX7LAbH4lAS
	 9MI01336daAgL4wxvrBQBX7bBpNf7HxL+JZRs49gRVBXSVXdlKvCX75zvLc88rJngU8li
	 k9e3VzmDTQ8tAZappsoqzTqINgfVdRPT4mNSSgN6gZCUwEcBcFF7MOg0oUkFnHSTipKtc
	 nYNvs7z2tGiCwF3aRw0ftmzBNelBFbHS8K8h6F1nrHDJ6FN1KpzgenxDJ98yvCji8LtsP
	 9wYRbOuC5qNvOl6Usdb/UF6kSoC7b0U3kLXZjZLkmG+HLebhUo33ka/PuoGnJ7ZtWZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850207;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6A2dzypJdDqzcacYhTZur84EXajqP4RZ3u8QIJqNlUk=;
	b=Ayjp36PEYYxEcvtH6idZZXxFoCwLAzABgR1vgXZTkDTNXQD8sXqqyFmQucPFQoLiE6QG
	 SL4thklCspWrPArrFvnbylacl0l/QTXnwqkviswuKP1US7lFH0fm8m7uwUUhcP5NRlbr+
	 63QXpKXr3EC2SrsCqQPTmGpVjpqvMSoFr/nN5aFu6099fnfLEGpVvUfWwRpxLXleZf3bQ
	 O4xD/2JeQePA3YD7XTd1SfguQQz4JSlnMIhpmlqCj6OU4Q0n21lteaQPJfab8Ucu9KzOn
	 SuRDxKCmzStZwHHO0hGJfYAGc88+ThDq9Tgr1YZZolQT0s8vKUkTcTpKhTu6YPJpHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ie2S77rT;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D8A606A32F;
	Mon, 16 Nov 2026 17:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D8A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ie2S77rT
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQ4nb3778357;
	Mon, 16 Nov 2026 17:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6A2dzypJdDqzcacYh
	TZur84EXajqP4RZ3u8QIJqNlUk=; b=ie2S77rTrpoomi9mjPazuW/peVacCZHJc
	H6kNgz53Kku8v3Zrk/9FikGEa8rMR9BKWQDXonDQk+eXws91kHytvZ3jmeHwBTld
	ccvWIv6fwqFzpLx7on6XGfsi9S016yJX5M4u8uUeiO2CgEQBs94VaRQAePyPkCpQ
	rGr/s9ctCpPCBULLR1JJROXGM8UQyXisHHAf8ZDy4gUZNkmzKK/46VcL0iGc3j3q
	luZipJ8dbJWhf8GCFR7PizU0YPZ1ITsLbox6noIJYXBBMWgU65FAIurbQzknniSl
	dw3ZqS0sMOW0Wm7j/k9J2VnC++uzqkoABnwJvQpafBeiWyY3jisJQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc4xr81-347
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:30:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDGbNB005807;
	Mon, 16 Nov 2026 14:35:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02ju831v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZhMK32375074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 219AB2004B;
	Mon, 16 Nov 2026 14:35:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B102B2004E;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 15/15] s390/cert_store: Initialize ism array in query_diag320_subcodes()
Date: Mon, 16 Nov 2026 15:35:34 +0100
Message-ID: <20261116143534.158375-16-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXzieaQANU9W4P
 A/2y1Za9pnvHs/Y7aLsEOn+gXNQRGjEE9LDf9TgJ5RRgs3PWOJD1WMA0aKGw2vrvU2WciIBPZG0
 0vYIhisr7uJFQebBL9arxO5nBbfFkpY=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afb3d9d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3fHDt-PhUZzG2Uy4e7wA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX3CI7si2CTCKn
 5UAGHr1njcXcKVVqLMi/00PTqypsspJUs7ImnbBmIesDYhhr5VY3eKr0UQWnUYxzDrH9qKkFVtX
 0c/c+ThiKivwp3qSwvGl422VdRESCSrZ3XpOWUE6e6MXprwfuqewdgzSFVyeHu2DXyCM6PupsQH
 eC76U98gcEPU2j6opw5gkJz+KdDC/DRU63QJJwz6wy+tM1nq7myYeSzxkv8kNOa0l31X1qQyULH
 4IpX7QgrNCkC128tkHC3ILZjwyZt0hba0052Q5S8ezZl50V4uAzAqc22X3EGNoF7xcnxfOgo6f5
 O8cfRp4m+nfJIJBUNB/q8b9puKGP4up4RZozvhAkphpk+53tGf5SyzuS20aSyDa2jhhZNTVD6CE
 G7egF6yqE5MVG4StfohDkCQxq/tZpSBcijy8EQn5owJal/elvO8LgvpqpCF8kI6At5hMeSayFdH
 tQgx2AwsC0O192xvHsg==
X-Proofpoint-GUID: NlHbR10hIiQ6UtMWakS_oyq7Kci-cgeJ
X-Proofpoint-ORIG-GUID: NlHbR10hIiQ6UtMWakS_oyq7Kci-cgeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

The Installed Subcode Block returned by DIAG 320 subcode 0 may be smaller
than the ism array. Initialize it to avoid copying uninitialized data to
the debug area.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 12fc0ee87f3b..e3cc9389a50a 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -670,7 +670,7 @@ static int add_certificates_to_keyring(struct vcssb *vcssb, struct key *keyring)
  */
 static int query_diag320_subcodes(void)
 {
-	unsigned long ism[ISM_LEN_DWORDS];
+	unsigned long ism[ISM_LEN_DWORDS] = {};
 	int rc;
 
 	rc = diag320(0, ism);
-- 
2.56.1

