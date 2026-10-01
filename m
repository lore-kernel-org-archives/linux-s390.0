Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE603F9F56;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850788; cv=none; b=kPOo44Bc38UFuHGcK6a10modtzCkUOzxR2fi/sMXquVA5IRnikwudo86sWzifAixnGS8851QQoPtw0B6dkuaNYcPAInBC8Lsc0m/kI3seHfytbOBCWABHItOmVIn/9NO0F04nLTMBmhDq9H0CF10AY7PJe8nVK4erdyPm48b2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850788; c=relaxed/simple;
	bh=JvLSMfgaqWDZk1cnIEuo9K2RAVQVNiVn8fSEPDacpxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlPuN5mAoblNWZjBlC5dJdtNFfziRBglUp5eAKQewnR17GD8IPNcvEbHDbB1ElFwdsFm/wupOCwnxnUPbdQq6JuAohEKzfK80UIAiFSxcen3BuTqulk4dp5YuLnRnDRZpfpMP1D96Cdyo9sJXO9M/YYnVUIQgbMySwyM96d7WXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LD+CBmZd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LD+CBmZd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175is31086158;
	Thu, 1 Oct 2026 10:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5A43Kg2NlFt9c+8Lz
	HAw+b+D1T05j7lbk8zIa1s/FQU=; b=LD+CBmZdWO7L1PyWMkEb2XmolcbDGuOAc
	8mhrMuzBWJhDhUF/npaqjaMdyVCLmTrXwBUJaPlu05aDQ9JsIuO7L4R1wyvhvJKH
	iBdhZdldkdLbIxgISf2aI6fFGlqSDU/U6cT28jfhfg5+vj8AqNfu3Tip6co56yBm
	4IuNu7AlfkoPJ4iyc2HW6ocLJEcZoTolMptGv2bwf72PP9fQY6kJ4ik2lIRkzK0E
	ayVB0aGDEjGP4vtSWDjbEXnYlI+OX6qsJqsc9NJAfDl7AfrQty0vCdECkPQ4u66Z
	yqFMSwlPuFyzLWpwzlHY+fdBRkdGgWcQ8E+5AbAwARzCV9nNwx+uA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthch7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172WqL589661;
	Thu, 1 Oct 2026 10:32:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWslS51577102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B919F20040;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7406E20043;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 23/32] s390/word-at-a-time: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:38 +0200
Message-ID: <20261001103247.1989111-24-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ybUl6ue5tOlK5M5d258Md9WObW8AcwwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX9YPc/SzFNnu2
 qdWk2Fq/cPbgSag8gvowfE/Dd2V4PtoaPXjUEWd12Da+J4W4EStWPe5bWNdPANs513IcImeDFeV
 dGEdp9g/iOxfmCk0xNw45gXZNGmZ5/3kLu3Iquslfuxmxmo0Dsy1gEKxKjwKPnF33eZg9G8kN6n
 eor8CXZ4RHfrcfheetKSS6HlsHyaoiWH5BDlG+o2+6vcc+GBSqjhNhfJ3btDLb9BoUQDFPb6ui8
 hHH7DQ47tYzG3wu8GX43MYD9Qc//nJC0E0hypBIhJQyd/G3eEetL80kBhAid1iQVnWeyx4nSng4
 SVphQx4DE1s2EP7xJOjm2ePYJLL08i82Z41KAd2H0nqVbuYPWdDtde7e+HS3qFNStvleIZAUruA
 c3Uh37d+A63mvJsPmoBR96WN9DUCXxlWyZqRggmIXGUVrznm96hEUhEXZIqsr0gnDwLv3AyJTHr
 mjuj5sFXXQpWz1MM0+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX9LHXwGwsoO5z
 QK7rHzlTwL9Z1Y2rML2GFTkDmHNujFBFCBh+QzCUBV6CLHMQ/YsmLiOEnG1ok18NJ8pX+Y9mhEU
 tBCHyDPVh9B+KqTx0Yo6wvcRPw30nhw=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=X_HBxJtN7YIEH_6Nee0A:9
X-Proofpoint-GUID: ybUl6ue5tOlK5M5d258Md9WObW8AcwwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the load_unaligned_zeropad exception table entries to use
EX_TABLE_INSN. With EX_TABLE_INSN entries always point to the faulting
instruction, so the duplicate entry and nopr padding are no longer
needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/word-at-a-time.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee7699..0b7779c8d5a4 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -54,9 +54,8 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 
 	asm_inline volatile(
 		"0:	lg	%[data],0(%[addr])\n"
-		"1:	nopr	%%r7\n"
-		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
-		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
+		"1:\n"
+		EX_TABLE_INSN_ZEROPAD(0b, 1b, %[data], %[addr])
 		: [data] "=d" (data)
 		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
 	return data;
-- 
2.53.0

