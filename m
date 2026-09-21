Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DF45563E;
	Mon, 21 Sep 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980029; cv=none; b=Mvv6vfoZKvHzwrcroVFnWdRkqmwnwMZVz6UIpnoKKDuN0M6D/AOkbffoqKZTkMnKh8LY/Fti4DP7cW8MuUX5dpjl9r8p+I8SN4TtWpe9PBkJlclBKvxEROKdioYGYgwNoVFwQdVysA38XTHSx9sUuGkEHVYUnBXW3wT3Bqsu/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980029; c=relaxed/simple;
	bh=ETfxXUjrRH4J/di1U8Xgg8F4wjJw+tcsn5O1uG+VX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBrvF1CIOpYXP5ul9TUap5DD57wA/dJMvx2T3BQSPZw58yYRRI3iW7y1RUMYql3JMW9gk9o0gX7+1B4mASaxkecc0Q79WmNPJt4odgjPgHAv6BISCY7uC6jnlNM4X3jj8BXmzMdwBBj/mhGbGLYKZpy+JG4U83vFs/COjQbfLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BkPwEYT3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BkPwEYT3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZwmV3155098;
	Mon, 21 Sep 2026 08:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hCQN16gxRDgP67dcL
	modHocT/4BhIAkQwOZ2klcPTOE=; b=BkPwEYT3RxgRqdkzSuRKfbNOZEf1Cgaih
	RAzrKFfkuo9HFxdQTQ+yhgFBWpK76Pao97uS8OmYvUqcWToU5qcwKKqMdQRZs3Dj
	AdV4a16aDquy8DMxk7lzIuba3839ij8E0fuOsC9a5jW6swrnUNoLbAKqZAcbdBz7
	KQ8GMQc4YwEiquwRa7Bm5ErTUtKuUliY9VBJjoq+ScX0n4SCZanC2773UZLZXPSA
	sMG/3wAiviFioyyFr7kTmkDQpY44iBktDNe1Zbm3gjwNFFGq08p0V/2FqEp93j7y
	o39/0EM3rohkTMynfqJCmw5/IhIK1y4iemp04pMVKBAAUREtMkwNg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fjua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HbFm924664;
	Mon, 21 Sep 2026 08:40:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4mrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e6LU46334418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AAC20040;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7014E2004B;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 01/11] s390/percpu: Fix comment typo
Date: Mon, 21 Sep 2026 10:39:55 +0200
Message-ID: <20260921084005.4022574-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921084005.4022574-1-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VUjrXUgmpgCtQJW1ezOWXRIGkWs6lCV_
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0ed6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=I_7Bz9khIIb0WmrdVP8A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfXyhmUrkbVp54U
 Fmpuox1AtyYQX714enej4cDjix55DmX12szIJudkpK0GvHDz8jfGpdr99LD7szWeWr1pSlNKFNt
 MlGatkGZVGlqKaoc+M9xc0DaUc9Lehw=
X-Proofpoint-GUID: VUjrXUgmpgCtQJW1ezOWXRIGkWs6lCV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX/FxQnbMiOY4T
 AFF2wxTocN6hxXomb0PVIPgMypJsbxo2Q8BFDvXfba+h6VS5f7ruFEAF6SCNB9Y9Mkd5xqXzklM
 GqsYQNFO8QIxUT5aQHMt/EE60bcjXw/AtyQB1CiuMR3vqAXBavEhm3dHYc9K0OkHLH6QpcdjTYW
 4CsY+N7xR+quqLu42oKb/XSUWDsn1KufL44GQ9QmehfbnsmY7/HIZ84roAKjj4ASh4FPJ0tf75i
 PftmUgdlYfomqY4n/+9abOyi62KWNeyDf2JyI/+QU7x9heAnpW4MEtEBDx6jnKOoz7kvZFNvL07
 jPjzG1pWjKY9s/iqblw6OlIlbHjlKNLagaQhS3ZNYAZP8MV4FClp+SoJ1ECZFJV1ygeZk+JQjcX
 76HoWAziXrZw0JZUz/KuR7PTj0aXn5BSKx8W3LUzpHLDSnCDtgXCg03fOF+cQYVCsLs6nD/OWsV
 MHeYSujZe1uLCpMTP7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

This is all preempt_disable() / preempt_enable() pairs and not
preempt_disable() / preempt_disable() pairs.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index feb58acf87d6..31012abe8292 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -63,7 +63,7 @@
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
- * Avoid the need to use preempt_disable() / preempt_disable() pairs and the
+ * Avoid the need to use preempt_disable() / preempt_enable() pairs and the
  * conditional preempt_schedule_notrace() function calls which come with
  * this. The idea is that this_cpu operations based on atomic instructions are
  * guarded with mviy instructions:
-- 
2.53.0

