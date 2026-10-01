Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DB3CAE60;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850786; cv=none; b=OM6nfUGDnHoJc7oLLoY92+cvsZge2LTpCYP9myw7fx5GZH/hDpNs8xMKYxR9ylR5F3yURxhnahAF1BG30EEIb9AQUrlQGN+93LpaNeKsOa0YIZeeHcEl0h+qyF90pyuntSUM1U7B/OvfqlevBoGlcvaqOsKuWYAenTCykWcXv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850786; c=relaxed/simple;
	bh=qALfMiUHDYijJcvbtCwBcC0OPIYQ8lDGDlviiADxdU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDUHApbfRvzPK3h+QxQZI8bYYJARZNQb6MXYavZAgf+8rlwDuL8BJ3qBX1S/kqo8IGwobgrWXtHftZbsbzDvrTYlg42r1uPMRBzDeZntQPenNWu8O9usagbRidkfe4yPPtGIlziUvnBzngbIX4epqLfk2f06sJ/Rvz8iAOcIzno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sEUs1vKd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sEUs1vKd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175l724041113;
	Thu, 1 Oct 2026 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i1NqJTaCCaaWkP3mr
	EF26OKwrpoEAGqjT9RmUwL5PuE=; b=sEUs1vKdGJljXHiPfswlpoboFCllx11HB
	btiUEcatOUgohdNS9YqTYMNONWjedfoC3AP+0XyqTLHEBtWuzy4dvBje2fskFQIA
	b+bQHXhFjP2MBVtt9pXOn+HfOy1T+FzZR2zLBQvHYtAhRYhuQsoCm+QLmZH+SD/f
	k1rYzNhTF4yRoTkgiIZ41ABgtD3yynDKbz+ldd64QprV9Vyx8i8D0BsAU9K3nW1E
	ymL/XWTs66y6b+Aqsbl/uJccCEwl8Awpl2mx7Q60xsW4AM4WRFNwcQrQn5KqEyBT
	KfDp1MN4kVKmEZQvjOidUDX/A0dhar8CKynWPl4/93MicI7LkxFEA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfna-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Yrj589689;
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWrVs39911710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E49AB20040;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F51020043;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
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
Subject: [PATCH 17/32] s390/cert_store: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:32 +0200
Message-ID: <20261001103247.1989111-18-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=v0tfPaRulT_9CaumWagA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwMK+a4RdyWKa
 s2xq4Z07+nRqiVunZ55ACr0ub7oQqX3vLsw54hsQConUyt7pIPNaYz6W84TkLGNDboaDkIINTFJ
 Pq0A6wTQKhMkt8LkD8b0vtvpcV+oNCw=
X-Proofpoint-ORIG-GUID: dVP0wDgjR1zw-dR_f1gACLaG2O8Y9DBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/2CNVf66kQUX
 awijCpmhcyxBBJw4DglkTCdG8ZOXXMpTl6fkffLLoRQPTMLaVA3Yqm+I7pmH8guxT07li9jBGbW
 HJYDE358UI++QybO8DnCltnONz89VRVZWXUg4nVmmtr8Uk6R7zMrlfCM70s0guDELO3pQfvP1GA
 xbJCd8l9YpVY0+v4+Ia9sPvyOv56RLtHw+RnjIHjWcH3JFRleE0tVJb0vq5H858yI8czbT83B1S
 D17BCAqPY0G6dOgQMYEBIk7VskToV9+bGHTRYoXt1JMtgh4WRw5tm7nVONNcmS7jDpwHR1IZqcS
 3ciGumZx1FGNyqU1AH+ltliJN99BUO2bGocrBJdysbWXvFY/xcL3pipLNGNSyesvK8ZnQ/ZeWpi
 orA2iouDUq5WeOLF3Yhs31XVpoBVuOfWwqx3kWbuXKvGuGNW9vCR4EzilpBlBT9W2T816ehS9op
 zSqJz3jYMDh6/a4N/Hg==
X-Proofpoint-GUID: dVP0wDgjR1zw-dR_f1gACLaG2O8Y9DBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert the diag320 exception table entry to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so nopr padding is no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index dc1992a675de..998f2da56175 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -236,9 +236,9 @@ static int __diag320(unsigned long subcode, void *addr)
 	union register_pair rp = { .even = (unsigned long)addr, };
 
 	asm_inline volatile(
-		"	diag	%[rp],%[subcode],0x320\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b, 0b)
+		"0:	diag	%[rp],%[subcode],0x320\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [rp] "+d" (rp.pair)
 		: [subcode] "d" (subcode)
 		: "cc", "memory");
-- 
2.53.0

