Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE2451996;
	Mon, 12 Oct 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794196; cv=none; b=rGRCDiSAkHjc/vdYllUkCF9yGBHiTECZw17odr0I2DSG5my176rv6MCRBveNzq2Ad3VO56eQVIXDQ6lhgt06Gye4zDmgT+mFZLsk3IZluoHfTEWl5IWqK3VAxY4dZiFQzTRplSmp3hWcFDJd1nt94x/x+/s9w2uaAAnI7qIJLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794196; c=relaxed/simple;
	bh=nifRBjQUnAgOWYWt6aAXunm02Bn5IVCvPwUT3qAs4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB4M595I6dEHnkItPAmIsYUGfHKD44Edbp9XixP59T+Y9e8kEcK3kDjjJ62q5enUXZSJ6RPDz70Q4whvHg9kmt8mOygmgu/HTbM7BCytZnljn+BBtVC/Oz5XBqNJcISiUnn+7uVy+IZj791ME7Yhq5YUEoiIEOwgcpGkI3ja9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qDiz3xJ+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qDiz3xJ+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5ELvQ3564889;
	Mon, 12 Oct 2026 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pr3Cgcg9w16A7bl+X
	C2fr8grC2hX2WRdQ5pNW2eNhiA=; b=qDiz3xJ+SQT3OnBbVIFZNw4if7iZhXfLt
	vtL0AQFe6ypQ3frsyq5LpAsmTteNv6ynmM7goArNfuwxC0nwoLdKJRW/fVGGXRVu
	Cf0whFQV+Jp/4UkjwfMRVioxWlcYW9gjrJoueXrd24Ct1exEbUbaqFi5m9mEKHOp
	ndyKIS84VYDTgw6yjzC7r/gitlJUMIFxJyJZWdh3APBdNU1VyVhdz4ld2w6jPPrY
	+379l9HM53iOwG+cErYD87LQUis+aGae8lHnvSQUa65SB15guzAXLkrD24cnjaI6
	c3PEC6mOhPxu56iZcRs/bnaMw257EiDBNwa7FVHx3SZzWvUiYejEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug7y4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2HS3934755;
	Mon, 12 Oct 2026 08:36:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfv6dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8aUhd48562498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:36:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455FC2004B;
	Mon, 12 Oct 2026 08:36:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1953220063;
	Mon, 12 Oct 2026 08:36:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:36:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390/probes: Fix wrong mnemonic comment for clgib
Date: Mon, 12 Oct 2026 10:36:29 +0200
Message-ID: <20261012083629.2109206-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012083629.2109206-1-hca@linux.ibm.com>
References: <20261012083629.2109206-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc9c12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pnrY4BMTjYs2EQVELv4A:9
X-Proofpoint-GUID: pGW21Ze2rr6iLFscTNR7S9ENy1-oLBUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXyhGgjtI7g1tS
 ijPBvlAgF9bwuTKRy6aTKTHRAglGXFQnanU4YrOxTA2V84Oz/8VqpjfcH7+AsvQNuQOXMoOwfmV
 sK9l5yRD+wnbwLDjcRyJ7GwxXarC2UdEskSYw3FEb6JUBaX14N6+6bOdcXCFX6JlqOj6qpxUdE9
 Xd3SRM65CndMiS3QaRTWAJKJYt4Vv/Ovv+pS5VSDMh/hjZ4Et2xLSNnRV/FdE1e7//0jlaZ5Xgv
 3574Wt2yQkkqpfmV9wUSnyaDDSzPSLQd+iQBNoKNx+UK3ijqcXU/L+Nu2+ROHdI4Z8V3/QEQgWQ
 bBUalz5C/iGnXqOf7+dndZGhfJBHe7/eZ6Z9fBSH5rMVEiWd4YLooQlI1TAtMNlZGWPQBkia5yA
 JCWG1K1YjPoy9gPoGXjwa0m5bPCM/KuQqE/R9ccJRUrx8WY1spgp/OJUBP6NMRJY9xVjOvQxvy2
 JZk669X3+aIbGy0VMuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX4sTRygwI8s4y
 FaxCFXWQT37Xs5bjmqsHAlN0mpnXxGmrYTJHzPazMAeAJwpdGdqzaSjpBwo7igzICLUKDSi/aHA
 OlVnE1FNa2Er/SIhb3lptW8XTyHPmBI=
X-Proofpoint-ORIG-GUID: pGW21Ze2rr6iLFscTNR7S9ENy1-oLBUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

There is no cglib instruction; the correct mnemonic is clgib.
Fix the comment.

Fixes: 6b169ac9b434 ("s390/kprobes: add support for compare and branch instructions")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/probes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/probes.c b/arch/s390/lib/probes.c
index 3e7654223b05..66221ec16822 100644
--- a/arch/s390/lib/probes.c
+++ b/arch/s390/lib/probes.c
@@ -112,7 +112,7 @@ int probe_get_fixup_type(u16 *insn)
 		case 0xf6: /* crb   */
 		case 0xf7: /* clrb  */
 		case 0xfc: /* cgib  */
-		case 0xfd: /* cglib */
+		case 0xfd: /* clgib */
 		case 0xfe: /* cib   */
 		case 0xff: /* clib  */
 			fixup = FIXUP_BRANCH_NOT_TAKEN;
-- 
2.53.0

