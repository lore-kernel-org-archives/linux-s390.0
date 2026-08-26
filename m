Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA34442FB2;
	Wed, 26 Aug 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756832; cv=none; b=qVXBb1n4KS88lCki0blKAZh23IndGRZXe1rdk7qqQCL9TxJHtnR0UDxnYtrAF4pFsu8ma/zrSPsIzudXgbufXRdN7NV0boqg/emG0uQMELJW7kJlgMmrJeL1teP75OzQzB+e2INKQk+Lb+XcMzyPhET6OZ6puYLBUsuQhO4daC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756832; c=relaxed/simple;
	bh=LCwM+ql/Vr9zb2J6bhTD1DkXvOokiYN4uy4kR66LXRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qptKGs8wPIgsd4jf5b/0idH8/lq/DK/epXK+2UcY+wCYaz2bxewdvjmIgKucHEZTM+z8ioePbswBdQLVzuxMsT2IBSTDZkOflOrlDbN5bFhYpjODS6ycJzj1ehEP0hM4QsOmlD2dVCv45Tov5pd8m7LRofDGxYp83XfWhzp1dNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T1IL0f/U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T1IL0f/U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1YxI2333826;
	Wed, 26 Aug 2026 15:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gpktLk+31CI9w3ye7jwDb3jHKLL/4oX6nmievhzDp
	Cc=; b=T1IL0f/UtEz9UUUxZDnm4I4KuAb8u+Ml3gTZV/O/Js0+ciKbupOSdNml3
	GH68sKJq+6OA7ozX0zTJLeuWy9pwo/qV5XpH/HHuMQYpziR+z6xcN9RuJ+WhH68r
	dwJSKcciQ/86eGyn9ehEtp9FIZTJTBDJ//0xsDnWUuNey0u8MSGtCx2FV00pFDPk
	wSwaca3GVOKzP92Jve+9+EZHbhpgLIRRuu3tq0El7w+LHXjmxVPeLWd+SA4iJdK+
	jgIj2aFL/4Cse4WsB8Csno6DaZjtE6pP+ptePOlHmkgxwZJadvbp9gL5n3zD4AnZ
	5JV6XUKP5igMiHUPVrn1MjPr/BWsQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqycxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:07:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuGCL032393;
	Wed, 26 Aug 2026 15:07:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyabcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:07:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF75ug40174072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:07:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114062004B;
	Wed, 26 Aug 2026 15:07:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C759220043;
	Wed, 26 Aug 2026 15:07:04 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.55.210])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:07:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] s390: Warn if kernel command line contains non-printable EBCDIC characters
Date: Wed, 26 Aug 2026 17:06:00 +0200
Message-ID: <20260826150702.949956-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hx0efX4kewsfcvq2L9uY11tueCnJE7N7
X-Proofpoint-ORIG-GUID: YSiCrpk1ueYBzPw6KaIN1psopYz55c5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX2xPdWoWXnw48
 UkrAC1x5yCvLkzKC0fct1LMl+iLX3+wctkZy0u9oJijNNbRn53/fgBTOulJWyhjrrA17SUDx4BG
 JfTkqUgIFmDRFfGtrLxvVrVf33Q1Vp8oqPWttXFf5sn9f2uEZ5JzVvz8P2IK1huw/0M3SzQJ4n1
 XyA8T1NQ8HPR2nB4GO+jFhkYGjwwOQNByhRQtEUd5fwDNNEfNu8YyJ1UhR8v4t75j8L+8yLjXMq
 CBIi+P8c1xQDwknN/lIiBAwXcsEK0KRheCJuI855wQcR5Xedcwy/dJFwu3ay3EgWwXAFKWQGmda
 dif3nAWbGbguXBqWS9AtZBow3hTCV318aRTWTvljn9ysNt9WU32jipAtyuIRQeDTXLaoHZSQcYc
 m82/znKYZ3DOB4D/WJWkrLBWmd/M1K74ybRqG8aeHx3XpR/Mpme8fZsdA9iUZkAdMwCzj2b4oXH
 JwMmIvx1cSlVyeSFNNg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f011e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OcP_M8VGz1HMc7azk8cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6Y3zoD368eo0
 rN0Q6ljWuKEXiAhv6P8/+iydCurxwvuE9M9w4ubTlsDQWXYP+EyYU45xfm5karrxh6kxJUTcBaf
 ZoVNz1AweF+GRh6WyDFwl7p4QLQTPw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Users may accidentally add multi-byte UTF-8 characters to zipl.conf
parmline, for example, by copying snippets containing non-breaking
spaces (\xC2\xA0) from web pages.

The kernel will then interpret the entire command line as EBCDIC,
making it unusable. Distinguish this situation from the legitimate
EBCDIC conversion by looking for non-printable characters and issue
a warning.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/all/20260825150840.537653-1-iii@linux.ibm.com/
v1 -> v2: Account for newlines (Heiko).
          Minor stylistic improvements: inline int i, bool return type,
          comment modality.

 arch/s390/boot/ipl_parm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be76..6ea800ed98258 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -173,12 +173,30 @@ static inline int has_ebcdic_char(const char *str)
 	return 0;
 }
 
+static inline bool has_nonprintable_char(const char *str)
+{
+	for (int i = 0; str[i]; i++) {
+		unsigned char c = (unsigned char)str[i];
+
+		/*
+		 * Open-code ASCII range comparisons, since isprint() accepts
+		 * high Latin-1 bytes
+		 */
+		if ((c < 0x09 || c > 0x0d) && (c < 0x20 || c > 0x7e))
+			return true;
+	}
+	return false;
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

