Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758036C5A2;
	Mon,  2 Mar 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458510; cv=none; b=F+HiRVOqT9nDt9ov/JWhmuvbwlWgdAuGXyux7Imm8J44vhqBDuaBSuZ2ktpJKcr2i4c0yxq3lCr0J8YMGwmUqGmajfqEozV9g/J+Agsj8D0bOuTj48NjayiiL2Rp5PLoanbMfSflA2iY9f/s/FW8TTZW2ibCfZDajKlcklBM7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458510; c=relaxed/simple;
	bh=jeWt8/qWbAHXBZzMcvFsUQgA7HkulneeSnnjQRn0xVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS8urDswcaWlwX3UiN6ekS9bY9jTNHDwblerK1nhS4dNyjJafQPgKVoJTtDdoO3x5nGr0OOfM4irdGXN81bjSYdwfusYRNhviv0rMG+OrM4tHie4tjeoS9f210zy5T7TFQsAGNz5mJ4kqEHI1C0TZPFG+MTowiHXlMHY9UNLZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lVYxrk2J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lVYxrk2J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622C8YNs1479574;
	Mon, 2 Mar 2026 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hQGiFMvGP92KVOth8
	/151J7vjaoi0/ag7kKFFBJnHvA=; b=lVYxrk2JoFMqDx58KE5H/iaGy06rhJaMc
	5MUtHV9MAbDbIkNHSbRL5j0HcCNKgIcCpKBMygYCeyQUTGhSxYaQqoXqjIi6rict
	yNd30DPO5SzOQe7YO5YvwNQ4/1KTD3HDpS92QiSJoQSpNT3kFItG1KpFRn7CTcn+
	idjuk7PpeWHcIll8Ib4sxHIo46KBI3o/8qZ1XRaKY5nmu8V9plhVAJu77sjPixar
	tw7ZuxGO774ZNaErAEqGbyO+vdj+ugB2GB7kIWUDgYpC5TJh6lHAFlj5fdO4SFgA
	Pb8MzEG3cxy0O4Nu/RW7aLTIbAhkKpaTOEsv8l+Mm2nPET8wuB2SA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3pmeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Cl2UI016756;
	Mon, 2 Mar 2026 13:35:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmxahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622DZ0n643123032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 13:35:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B63B220043;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B69E2004B;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/3] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Mon,  2 Mar 2026 14:34:58 +0100
Message-ID: <20260302133500.1560531-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302133500.1560531-1-hca@linux.ibm.com>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NBD98cE0vI31DgngZOz9aKQfOSSaMgx4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMSBTYWx0ZWRfX+iG6z0ZPJWGG
 i761kHddp0ag/z+r73dfyB1px+atb0oILz7Lm0HzJO7uw5WalxnMieNAnnYoPZodY95xVZKaS5Z
 wMYalv7k+gF2qh6PU2+ne0I+UXu+Tyo/Xp1siURtNjOkXxF2bGl0iH0cq9UmkViVWPE1TaU3c5d
 cZFNXPeonXwjWv6RM8BF7Q2cWCpiktjfgSjKwEc+K5UiqOS1Kl48pCBAVCeQ1d2JG9ZcxETbF5R
 fJr12INw0GnTk1Xz9qI2xY5wE07py/o6K+gHzQsdnvxs5BIpmhMnraycGVgBAhPD7cKqdg9DTFF
 bwUvXQtRsPFaFaWiQpJ2ctEAgT4ews+/kEbkNFKSyHnyjYFe4x+USzelv/tIhpuSbw6j2dOSFvC
 46/4ZUaQSKG/3pyW98PirNUPVkfcHUkZ9gE/4Ij0qatj9jMi5suB6NZEQp5q/rOMhXoM3iNzXii
 EC7YofmDHkTe1ixefHA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a59209 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aKZOg4wb7pFh2cTURR0A:9
X-Proofpoint-GUID: NBD98cE0vI31DgngZOz9aKQfOSSaMgx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020111

The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
"p1", and "p2" are input operands, while all three of them are modified
within the inline assembly. Given that the function consists only of this
inline assembly it seems unlikely that this may cause any problems, however
fix this in any case.

Fixes: 2cfc5f9ce7f5 ("s390/xor: optimized xor routing using the XC instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index 1721b73b7803..d703c44d5fd6 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,8 +28,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,
-- 
2.51.0

