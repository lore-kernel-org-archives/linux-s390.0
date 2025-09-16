Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72E314A62;
	Tue, 16 Sep 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030495; cv=none; b=LDTFs7LsSQaW5vODGwrgfFnzzx+bYJ7UfB9ivybmdqDhhQRNOHZBqQytY6qMANjFWV9JhcfhpgRkBXNJHTBLKugi9Tbt3zxMnVD44/CslYr1xiTduDg1eBbZ8ZlFmrVWChGDzIWAuf+J2iB90NQ+Zfe3/cX2DT4UMZOtyPPGyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030495; c=relaxed/simple;
	bh=EGoRHm1AjdpF4qXWjotViM/Oqd6Csf2a+j9muOz8+oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7j5qfVLxGdzAhMucLDtFFmN9d3fJqRSfPzFYklOp8WZSo2IG+eVhAm9Zq5i8CazEWVTWTK7+8mhsUdBZpL/XYpnE2RNk28knQ7pLdwA1Iijwu0Z68p5amSWAT4P+J938ENYtNbyyesUvEq2edXrjyoy19pDhPK8ZdJlan62tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mvv+TWpc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mvv+TWpc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G6WECw018938;
	Tue, 16 Sep 2025 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GZWixmiRGJYwZ6gnK
	KhMrk/ZZIF2LkvvtIFicnLWZSI=; b=Mvv+TWpcGH0LN/uSwaAPNfFQif1X6oBVH
	o3xXnJVhrqPlMt4J3SKP9CocGQDZqN1MBqOdfzp2LT32BZmBv6HAQhpkvdN+Vq2O
	lgnLRxCk5LabP/mkWuNs72gk2L3YIvDHejJnLsljM8ETDy8WZ6BY2buk77WWIxqc
	ODv2xhlLAy8u/P7+17KgYNFznEDyFzmQuLoZqtqh/ac850HgPftAHEXJVp5jkkxy
	TfmhvyWLFB//MxV/Ybqv55nHv9UheJhxCq9DBpQWPJd2R5ShoKVnOVgPPbryYcFC
	ub2qdcAwiUqd4R/fgakeu8A9bYXfPaAZt/oDg8fyXGypL3Ae2K8pQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GDFuKB020217;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAMqMr022297;
	Tue, 16 Sep 2025 13:48:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpm44p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDm4lu61800848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:48:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 732962004B;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43A5C2004E;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 4/4] s390/bitops: Cleanup __flogr()
Date: Tue, 16 Sep 2025 15:48:03 +0200
Message-ID: <20250916134803.874580-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916134803.874580-1-hca@linux.ibm.com>
References: <20250916134803.874580-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c96a9a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=WNZe2jjSjyEjSw6ZzqkA:9
X-Proofpoint-GUID: Gt8n49tE_-xJqXxB-bNjnwxnk47POVex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX2HGr8igbeyNB
 GRIwXDJXUzo6aRUG36MI1G02Tp3zsXbQ2iElLry3cNM/6afuM9f1plehbUI52g5ffSyD8Q6k1Q5
 BdYdAuOSugtxk2BlYD3ZVsY5PI45ol03qpn8IWhrZedFlkGbrTzqQYeKtnifBEQ05meRDhCv7s3
 3R4NIFKutfMYrvKCYkeKfv2bQ14VCoTXh/lz1ykEvGZZngDrqzV+z0kAX2C1cNKsuRcdeHNp6EA
 ZvqkJGgUpqDj/iD9w4tJN4Q8rAqnCAFJITyGzEskPCpHDMgpn/k9dEoHO70siJC6PAH6F1p6/yf
 Qa44fTgceTgIy69sFLSE341cPOleE2NEkLCqdW95whiNuW5smKYeDjupXmPhCf7zNcIyPrJthC2
 BTe/mcNP
X-Proofpoint-ORIG-GUID: w-Dvi7ZrPluW_AOxAnObND3DaTwvTrDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

The flogr() inline assembly has no side effects and generates the same
output if the input does not change. Therefore remove the volatile
qualifier to allow the compiler to optimize the inline assembly away,
if possible.

Also remove the superfluous '\n' which makes the inline assembly appear
larger than it is according to compiler heuristics (number of lines).

Furthermore change the return type of flogr() to unsigned long and add the
const attribute to the function.

This reduces the kernel image size by 994 bytes (defconfig, gcc 15.2.0).

Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 5ff069fe9526..0908bab20d7f 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -130,7 +130,7 @@ static inline bool test_bit_inv(unsigned long nr,
  * where the most significant bit has bit number 0.
  * If no bit is set this function returns 64.
  */
-static __always_inline unsigned char __flogr(unsigned long word)
+static __always_inline __attribute_const__ unsigned long __flogr(unsigned long word)
 {
 	unsigned long bit;
 
@@ -167,9 +167,8 @@ static __always_inline unsigned char __flogr(unsigned long word)
 		union register_pair rp __uninitialized;
 
 		rp.even = word;
-		asm volatile(
-			"       flogr   %[rp],%[rp]\n"
-			: [rp] "+d" (rp.pair) : : "cc");
+		asm("flogr	%[rp],%[rp]"
+		    : [rp] "+d" (rp.pair) : : "cc");
 		bit = rp.even;
 		/*
 		 * The result of the flogr instruction is a value in the range
-- 
2.48.1

