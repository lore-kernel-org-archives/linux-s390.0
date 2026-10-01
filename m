Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1538A720;
	Thu,  1 Oct 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850787; cv=none; b=MOVR7ACby6CYwf7v/YDS+6zns+JMsRPpUZ6o9GJInPm8814yluH0XtuzDMFa+D66Y39MklHhG0QKl0jcF2RVHB4PFInJ7uDJ7aCy9ZqsuAkmXx3Y6UnUkAxN/zfIpSz3j8uAFA1LrKtGfXowf0O8EfxzdYfsPyMo+jq9uLnmHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850787; c=relaxed/simple;
	bh=hFUc9nLnew6v++ThGVdWQyuXHzrVfbmEI+sSrkMQ02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjodHeIdjiJqEh2z0giVw67KiMt6gSYSdo02zl3yfBkp/29UxVIht33dLkI1M8gyhA0mUzXsBVpaK4VpTrSOm5NkrrePJOmgsv+xuarzDTbUeY0vra3MUzC4miFbLsFOPqsaxpqYGpIbwCfXLmQZ8SKe4JN/L8aY7Jo2CQjKbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GRc9RI25; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GRc9RI25"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175dGx4040963;
	Thu, 1 Oct 2026 10:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iWj+e+Ke2rnOVVGHa
	1A/Ow1MGLeXrKCvtm90GL20XSo=; b=GRc9RI25QxjNsTPhya7PwoAK+9O43YrVJ
	wWR2GPHbyIOFn368Q2GLn83ef/AMp5uApNV69E7+zpubST/X5iOa6q6fjvJjM3bK
	1lwMj6Qjq7qrZhaXbmfq8h7QsmnDeBFNkzy9Gw8XnMxvtE2USnr5hpAVS0LtBZVb
	JC1EM1xaoPBkC23kTqhDbmQSU0legrJzsNoNaLiWbBTL78jrsBIPZOKtMcJkwbii
	X6WL6+0vzE0h7xBiJiwitHDrrELNXjhGyiS3WXiNXQuNCd/FZC+upWCik4MptA7i
	qI1aWMMVc1QRO3pVPuoO2dq+IfSIcaEyDn2dqa3nSpvk34TyweOcg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfn2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Vq6589645;
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWpFK17826298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831BC20040;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46DE72004F;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
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
Subject: [PATCH 12/32] s390/lib/uaccess: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:27 +0200
Message-ID: <20261001103247.1989111-13-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=jY0IQecRv-zprqHvm7kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX55anP7GG+jV2
 wA3mTZTr1B3+dnynKf7ieP6OZvkk2k2WtfaMEPoxxosIY6lBERURYY6Qza+/Rv34Fql6QjDcDy8
 GoelBFJlu1RaZr/IzkzrKcRR1N0qX84=
X-Proofpoint-ORIG-GUID: NjtXsp49KaAK4fcQzcpBQckIsjgZqmaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/73BxbErAoEc
 AR8w6u/CumwmzXDyfitfwWsk7CNs1GTM99Ux4gnJNSvDu8/rvnsDwB0L7gcIq6lX28vSM2uVG5n
 nYpON85kf6a25/GyERifWoCxhctSkSBq4jXz9og5OgFOAPKVM4wH5j1VxlxlNIK7VXcsut0TQnZ
 hs0gVAp9AeD4ijJXDb6KYVpv4/SVRCe4sMlPsdxIq2IqlY6cITWscMKtPsFXTH1bk2m8y8kIwPO
 64F7YEM7er357rih+RGKn1i0MmD1dOWmgjdpUF1nGpfZNt8PZ1SGw1ChOnJH6H6nGmxVKb5s6ro
 kUV7ngOpogaNAR6NH1f9EYbnBuv8efMD+PNSSmeZPpCQYsZhbxr8i6PhSYH44vdO38XFLb7uffd
 0VVraBp4WzlyQcjkB/f2nk3sziZcEDSFrHSwt5trn1h4zdvVUqdcgvzU22I+ahEkGPB07hE4CfS
 yLqN+2SDvnIE2i8Rd4w==
X-Proofpoint-GUID: NjtXsp49KaAK4fcQzcpBQckIsjgZqmaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all uaccess exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/uaccess.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 0ac2f3998b14..d3f462c12bba 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -49,24 +49,22 @@ static nokprobe_inline int __cmpxchg_key_small(void *address, unsigned int *uval
 		"20:	spka	0(%[key])\n"
 		"	llill	%[count],%[max_loops]\n"
 		"0:	l	%[prev],%[address]\n"
-		"1:	nr	%[prev],%[mask]\n"
+		"	nr	%[prev],%[mask]\n"
 		"	xilf	%[mask],0xffffffff\n"
 		"	or	%[new],%[prev]\n"
 		"	or	%[prev],%[tmp]\n"
-		"2:	lr	%[tmp],%[prev]\n"
-		"3:	cs	%[prev],%[new],%[address]\n"
-		"4:	jnl	5f\n"
+		"1:	lr	%[tmp],%[prev]\n"
+		"2:	cs	%[prev],%[new],%[address]\n"
+		"	jnl	3f\n"
 		"	xr	%[tmp],%[prev]\n"
 		"	xr	%[new],%[tmp]\n"
 		"	nr	%[tmp],%[mask]\n"
-		"	jnz	5f\n"
-		"	brct	%[count],2b\n"
-		"5:	spka	%[default_key]\n"
+		"	jnz	3f\n"
+		"	brct	%[count],1b\n"
+		"3:	spka	%[default_key]\n"
 		"21:\n"
-		EX_TABLE_UA_LOAD_REG(0b, 5b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REG(1b, 5b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REG(3b, 5b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REG(4b, 5b, %[rc], %[prev])
+		EX_TABLE_INSN_UA_LOAD_REG(0b, 3b, %[rc], %[prev])
+		EX_TABLE_INSN_UA_LOAD_REG(2b, 3b, %[rc], %[prev])
 		SKEY_REGION(20b, 21b)
 		: [rc] "+&d" (rc),
 		[prev] "=&d" (prev),
@@ -133,8 +131,7 @@ int __kprobes __cmpxchg_key4(void *address, unsigned int *uval, unsigned int old
 		"0:	cs	%[prev],%[new],%[address]\n"
 		"1:	spka	%[default_key]\n"
 		"21:\n"
-		EX_TABLE_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REG(1b, 1b, %[rc], %[prev])
+		EX_TABLE_INSN_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
 		SKEY_REGION(20b, 21b)
 		: [rc] "+&d" (rc),
 		[prev] "+&d" (prev),
@@ -160,8 +157,7 @@ int __kprobes __cmpxchg_key8(void *address, unsigned long *uval, unsigned long o
 		"0:	csg	%[prev],%[new],%[address]\n"
 		"1:	spka	%[default_key]\n"
 		"21:\n"
-		EX_TABLE_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REG(1b, 1b, %[rc], %[prev])
+		EX_TABLE_INSN_UA_LOAD_REG(0b, 1b, %[rc], %[prev])
 		SKEY_REGION(20b, 21b)
 		: [rc] "+&d" (rc),
 		[prev] "+&d" (prev),
@@ -187,8 +183,7 @@ int __kprobes __cmpxchg_key16(void *address, __uint128_t *uval, __uint128_t old,
 		"0:	cdsg	%[prev],%[new],%[address]\n"
 		"1:	spka	%[default_key]\n"
 		"21:\n"
-		EX_TABLE_UA_LOAD_REGPAIR(0b, 1b, %[rc], %[prev])
-		EX_TABLE_UA_LOAD_REGPAIR(1b, 1b, %[rc], %[prev])
+		EX_TABLE_INSN_UA_LOAD_REGPAIR(0b, 1b, %[rc], %[prev])
 		SKEY_REGION(20b, 21b)
 		: [rc] "+&d" (rc),
 		[prev] "+&d" (prev),
-- 
2.53.0

