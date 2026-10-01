Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D14C6513;
	Thu,  1 Oct 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850798; cv=none; b=DT/5iUV3oBJ8twcErES0NkGaATDi0ylw8KWUbnF34PIIT79PP5ScVPluEC6RGWuJHbPUiODPqT0oS3PbgMR8O8a3hmtGMV4Z0+96y59a7QDUOWA8OTxKqKExxxNb+fB/U6Yf53zLmtXN7NUhhR06aCMEW2XAMZ1vv/dubg+h01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850798; c=relaxed/simple;
	bh=lOVt6fRHkL67HIayEMfcBQwHdzYnZwvEeAqeC+93DAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSo0z/0Z+5q410Sm9GhgkNpTyXDsEbjYmakKmjrsEnq2Lk8+1zZwJut1uPtbI5HfgouUVN4hS2eirhGq5KX0pqRqHGoSn9eRRBG7AQ1nzfty7VGcKQ1qm0EoVPAdqAJXJU/IXVobqk2qpNJcw8jN4AYyuf7eeRVx2JCSVmFgfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UMJ3cz2Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UMJ3cz2Z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175XRJ1086069;
	Thu, 1 Oct 2026 10:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JKcX2BsLv74WL1cHg
	tBrNWMgXefDMoY0913nCCrkHVg=; b=UMJ3cz2ZrPOlGMDRNBm86JzLtjHc3tDsq
	OJ+56mqFxvSWMWAvWgZWZ5WmPhKExhzj0x16qwrxgO5/FniTEFM7G46fTuMaCCdr
	z3FlfBaxvHLIGA4dbe914ki9X8g2/hmNpKNN9qidK66a1q5HefPv9UG9zXVj9Cuu
	cVOYCi6+2lnyZGj/BvSq2f6/41qHi9zaQqv9drQURbOGx1WCotnINxQuh6WXYRMW
	635MQjN2JSzil+/oYqGDXXOsusKCE5fVbVnQH+sJYr0aHwFoiwuo1quDuM4yqs0S
	Ohx/zehAvDoXF6eiBsf46IxDdR97bp2myS3tPdJpaZmGsapP6e5BQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthch4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172d9i561256;
	Thu, 1 Oct 2026 10:32:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8kb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWsDq51577100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED5720040;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28D692004B;
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
Subject: [PATCH 22/32] s390/traps: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:37 +0200
Message-ID: <20261001103247.1989111-23-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZFDgKvJzBbVCwbrVFDU7sj67y6UKoVjg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXyG50AFsXWZXh
 hVT6IPROt7VoHqy64snjVrEXEFiGalTyuZ/3lYNcm+xS6LpeWIetZuv0jy31rQREC4LKfp6OC/Q
 Zmvsauj91jsN2RmHiEUk5g0ZBPLNYtgMBYpC04wiclURCuRhT26ZY4uuZ2kcDYcTmFeK0Bs96VQ
 b6TnR/4QAuFITksFTZelV6tseXXcUP8dT+Ror0Q/iw61/+aM34i6QjnAhS5STDoZ1wz9mNL6t1O
 t6s6KwqtDyBYBVcgpIQqf2hA78YpBg7Bxvebq/Ga+JzI30tgi1B+6XdbnGH6bx3dVv9tZlnKHx4
 bKxAB76EPVsgl+Nqf5jcKqm/5v9lurom20azYZIGgcJ0djboWRNlsY89iOxpLt95ZuaHJAnh5JA
 TFo/McVBSdcpr1XTQZU3F+P3a2f08YsTmhvfz0HQ575icSYeaZMkv81wRZHBnNpN5XrhDaslRT0
 df9u3sng6tQlJ0XTyIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxUp8yrSHKpuy
 ou0cz/TXPlCyGlP74dkGxlAsD4vaz/O1El8UPklkK+nC3PwiZhK+XS5w8tn3I8bdukV2xm1sQ6s
 0rO5ipvm5gIO9YiLc3L/aifuskRYnyg=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Ji3n0d5mBKs_EfBJuWEA:9
X-Proofpoint-GUID: ZFDgKvJzBbVCwbrVFDU7sj67y6UKoVjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the monitor call exception table entry to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index a0937b4a6cf3..7d45fa6a21dc 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -312,10 +312,10 @@ static void __init test_monitor_call(void)
 	if (!IS_ENABLED(CONFIG_BUG))
 		return;
 	asm_inline volatile(
-		"	mc	%[monc](%%r0),0\n"
-		"0:	lhi	%[val],0\n"
+		"0:	mc	%[monc](%%r0),0\n"
+		"	lhi	%[val],0\n"
 		"1:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [val] "+d" (val)
 		: [monc] "i" (MONCODE_BUG));
 	if (!val)
-- 
2.53.0

