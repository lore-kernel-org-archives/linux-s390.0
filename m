Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2A3D45F7;
	Tue, 25 Aug 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670541; cv=none; b=oujMAmJqkx3Zwg/wKHeMJgdilhqHVrYlA7/gyRMJXJiuSDNbRO0rB0nPXWZ+gHtgbTYRVZZzzvTMgLwogjMQ/KnAdIe/Mo3xeL/jRnUY8Vp47bck+CUoTGb01au0lePDCJt47atjyz/3+Ya1aolUC71Mv17rWzaKxaDNTDMVGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670541; c=relaxed/simple;
	bh=8z2EaJ2EtWHq7UsP4hz7AyVoyak+q/nrKwpp0Acjo6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMxMtgR7QJxX4caO8LehoyeTyKgVHC259ij08DHCcS/q5FqMGHyXyouv7M+OOqZOxhKm6lgSvLLIiLjrECP5hE9YQav83Yj59Sba0yTMukKLNIkX7OZ4ZnM4Ac8jlKTyIyQUvXaqxQFnGZ9fKr2B7h0KPJi2GN3q7fQe7UYqeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L3bsOV80; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L3bsOV80"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYbMi1140599;
	Tue, 25 Aug 2026 15:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0tLpKQlzMEVvB6moRgrh6KBpywAfn5Fz+4QgkhESm
	VE=; b=L3bsOV805qYCOx+m8Ne6ry8DSQRPwpgiCcW2nbxrSS5UIyfrbX+LNDtvS
	GGbcRuyJYibFt4OgQWRon9H6PpHP4zqpbmw6yVB/ZFuFMrnzF+ie3UnBys/YPjTa
	YLi6PNYflpPDxocoRtk7W8eRLvL5rN6VR+ibeDrIDx5YuGkcGnMKS2Krh0PI3/XR
	fhvZqlGnd7i049f5slKKdQqucFVXyh//eoBhaCyv6C3R0Zk73hwwBeNpqgQHwB+4
	Ndx5aIPtSZq3/77T++wnUWXJcmeSAso19yDAbwjSFa6mlgwD+awX5vpH/n0wUJJU
	hehvqjaeuuMGUPCSbCU3NYyVRFZcw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4rxq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 15:08:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PEuPTc002415;
	Tue, 25 Aug 2026 15:08:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy4k6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 15:08:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PF8mxi12845418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 15:08:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90C642004D;
	Tue, 25 Aug 2026 15:08:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5889D20043;
	Tue, 25 Aug 2026 15:08:48 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.91.93])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 15:08:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] s390: Warn if kernel command line contains non-printable EBCDIC characters
Date: Tue, 25 Aug 2026 17:08:08 +0200
Message-ID: <20260825150840.537653-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AkAwMNCWrPaq_QzMGZwDTSoTPJGr7xCK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX1kbJCDtMC2zo
 h1rer6bk5B00MxrInnGsO7vDdVzBCQYateWULCfzA2WaUoShCQv798SH85RaX01vGJ+4OsWbgFo
 DAcjFrDEwYklg8n2Q1xVSDBgGaar7Pg=
X-Proofpoint-GUID: AkAwMNCWrPaq_QzMGZwDTSoTPJGr7xCK
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8db005 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=aQDSXqF5Te1O2uXpIX4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX6Z3ZfNY72XlJ
 TzKFamgvhCCfYQJBPwMqn4Gchq4N2DverDjI+rKghgbGVU646HiX2U+otWj0bcdkszJ2P3vl6y0
 Lhtu+GbRsiOdtQsODS8RZVrncZ3tEmUlv8Zf+elpPyE8gUtIao9CB5iEVxDam9PQk82KnLxwXZ7
 3MkBhd2KI00IFUWAyWOeLyR8m5Kq8MbkyR1VpAypknmVxEoY5Vg7IZ7VSuNPZtGS5EMTN+ZJinc
 OUd2JC/WvRx3aLRTFFuZBv8NdQFqq3LTujHqF0mGjuHEaAoSmKtEzzXOCyOQxAneM9xOlX7Hwk2
 qb7Wn52bNMVrjtCG6Fw7gakehn0Rq7WQx+eCj5yFeMYWE5Y9P2wcolVhnYhTJN24BgExnLklUGz
 VWboSq3ok2FuVrRUFyuDRyK551OqtRP/zWTDFFORPFathl6H7SNlp3Z2eM3T+Zed2EUwK5XvuYQ
 vAto1KebxLrurpFECIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250128

Users may accidentally add multi-byte UTF-8 characters to zipl.conf
parmline, for example, by copying snippets containing non-breaking
spaces (\xC2\xA0) from web pages.

The kernel will then interpret the entire command line as EBCDIC,
making it unusable. Distinguish this situation from the legitimate
EBCDIC conversion by looking for non-printable characters and issue
a warning.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/ipl_parm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be76..71c0c26d56bba 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -173,12 +173,29 @@ static inline int has_ebcdic_char(const char *str)
 	return 0;
 }
 
+static inline int has_nonprintable_char(const char *str)
+{
+	int i;
+
+	for (i = 0; str[i]; i++) {
+		unsigned char c = (unsigned char)str[i];
+
+		/* isprint() is Latin-1, and we need ASCII here */
+		if (c < 0x20 || c > 0x7e)
+			return 1;
+	}
+	return 0;
+}
+
 void setup_boot_command_line(void)
 {
 	parmarea.command_line[COMMAND_LINE_SIZE - 1] = 0;
 	/* convert arch command line to ascii if necessary */
-	if (has_ebcdic_char(parmarea.command_line))
+	if (has_ebcdic_char(parmarea.command_line)) {
 		EBCASC(parmarea.command_line, COMMAND_LINE_SIZE);
+		if (has_nonprintable_char(parmarea.command_line))
+			boot_warn("Kernel command line was treated as EBCDIC, but contains non-printable characters\n");
+	}
 	/* copy arch command line */
 	strscpy(early_command_line, strim(parmarea.command_line));
 
-- 
2.55.0

