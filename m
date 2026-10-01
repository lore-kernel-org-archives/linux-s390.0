Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C783C0A15;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850797; cv=none; b=J/DpJT0RFHC2UJlozHKm1RDp1H7BQ1XKhbVOLG5mv5hcQEgXHJ6/seJvDKHWymEQXjt/IXC97953Ra8taoHE0NBfGfRm0vY2h2C9Um526R2Q1OLiNbrHx/FjS3GrGCM7/cpVG/gOBPbei1s6lJ8MfcwIwrylU1DuFjL7GJtSCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850797; c=relaxed/simple;
	bh=fIzP0kg97yfxjKPQS5BpSfjwFSVn1uQSecRZbQM6iLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy8ROfHPFWzBSARdtCUTt5DAHfgdexGouXxUR3P/HuiRMLFLrRQUPdZ/AXDXRJwOXCiAaS7OQVqydWvPJimfX08MDxMQrwxMQzvBfwbJqrv6IgEHht/YZXrRXtKV76JmrP5HX8aOODUZfijabzNGJScQooKKe6kjTtGggN+sCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fvrl0QdG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fvrl0QdG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175gvE1119430;
	Thu, 1 Oct 2026 10:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P+o/pg+BpNei8NmYt
	CIDTUMYvkvKtybX45FF2F6s2zM=; b=fvrl0QdGM3++hC3fYq9z8SjKjibyd2utf
	SRhDTRZt5B417FW0IccR4NCHn9R5JR3Bt2WND0QqO/rfN9rWBXjeM20VPjf6BxUl
	POqLxXE0D9Xl6Z18Isnb6OFm6cmtusddtyhNplIpPl0EUyzPFbaNYUQZ0hyZ0pDO
	QGSU/rZNxzSdnMMQQfoYFxYHwE6HkNN70gCoC5Go/3AU5CQ8lEBhWmyetS7YkIQk
	SSDVobyzG0SgMl7u1UfPvIyg+YucYyHBhJA/ZXgupvu+Gor0spciAxW9r/Nd2cm7
	XurqLtnBGAz8oGUB8MmF8B4+52LDTMQUUGFjDH213dpVgbi+wodLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5jrb6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917HQAE545533;
	Thu, 1 Oct 2026 10:33:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsdg18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWuxJ40960278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319C520043;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02DD2004D;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
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
Subject: [PATCH 28/32] s390/dasd: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:43 +0200
Message-ID: <20261001103247.1989111-29-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX5Pef40cxztMF
 Ql5Waux6irdernjCpElyo9TtO6vrMvmX/QrGX1n031XG4Fdzw7vHDIEv5he/xtT9ZcJCAktR2aQ
 2nMKKDSFKWzL2l55P64rWDVYCJGbvPg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxTCTr+jzTlUv
 Qk0unmG7CxvNoIBxXDfeOgSRmX0CUF630b6y+3MU8SrIYBH8itXuwMlj9v1+Qjez5ZCzT5AdQBz
 QsH92jaMFFyBTsPTPqgCDEzcVKZbYM3pNnhgqxkXkP10hKKLdQp9+Tv0JTsQv48vuirx52X5cqi
 BwctQdfnP+7mM4DqEvNMiXMhEC0W9uHEFgHw2xE+Fv/MPzXDiLbjWHNAsYW2RCxFcnXbWBUeST1
 GIbFbb9HhH2VktJ1XSQdmpzisK6Ix3iwPn7+exX2SFSGWUaw0oA2K9Ri7wrv95VODNu6UlYJlA7
 jIGqYroG32lDM7T02e7mVZDzPGU2BfV0Q7vy/ZRXrTHWIU8GNATllN/M1hB49+AkXbzLgdWFnsq
 k6PVj3v29rdjpMm6Iwu4Lm5v57P7lrCsG8gUEp5YdTiPAjqpKd5sC5fXB22GUnrZPJeK/Xb1KII
 /DkMqJd/Rp5XBYPpaxA==
X-Proofpoint-GUID: 90Xd05oboSehiGjPjy-Fovp8wZJvg9f9
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe36dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Au6vXNqMMFVQ2yI6ppsA:9
X-Proofpoint-ORIG-GUID: 90Xd05oboSehiGjPjy-Fovp8wZJvg9f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the dasd_diag exception table entry to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/block/dasd_diag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index af68c2ee659d..ce391d35adf9 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -77,11 +77,11 @@ static inline int __dia250(void *iob, int cmd)
 
 	exception = 1;
 	asm_inline volatile(
-		"	diag	%[rx],%[cmd],0x250\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	diag	%[rx],%[cmd],0x250\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b,1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [rx] "+d" (rx.pair),
 		  "+m" (*(addr_type *)iob), [exc] "+d" (exception)
 		: [cmd] "d" (cmd)
-- 
2.53.0

