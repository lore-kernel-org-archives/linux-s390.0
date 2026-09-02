Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711D480DC0;
	Wed,  2 Sep 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384261; cv=none; b=Cb/Rja1FPk1TkCB7RX5yBTGLvPNE4Qk3cqz7mrkGV659yQD0CelyapWIrOSPyQy8gU2P93345OgSAjST0qihZLOW0b3z2bBB6Bz5BrxbdG9tsHUcYmwAEiAlUQNO6v+qtkB0FoJA5Iz2FcS3dy7fxc/alwLj2SrnDG0TGqzCPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384261; c=relaxed/simple;
	bh=jrKxKME1WPohkYm9u7CeFYe1qR6OTjHi/Vg1gcRBuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXU9AiqlwrYPJ9E8erlZA0ImgAAyGUlSmRX+ZVho05XXceTmw88DvDW9KvbyPwpdxCZxDVVee7DdvjWcRRcOUhkz1/LTCzjszg8yctZLcIpzQHJrtnc16mEeevH+6r/jHxslyTOyvJ7m2lmfVoiC03K+wqB3EikfCrWhfVs630U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EIfvtQFQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EIfvtQFQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KW3I41049293;
	Wed, 2 Sep 2026 21:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=H3SL7bUAnfRLwKeOA
	8bKyQHSSiDcErQJJkhSilH+/jc=; b=EIfvtQFQM8q1dL1fAVq8a6vikidYb7n7A
	hdIaF+dXiZr1YKuM5jPTNx0NSITpYHSW1v5xyrpZYY+56w7n+FJeXIoVcFgutAtp
	2/54yt1pcvtMgrBQ9Azv/L/6VXig2QYQVv1jNgDe102bm6GVpal6wgBOAze9JEc5
	EuMp03Tt59ZhJQ7CKXz0U7dbziKOm4t5MCVQC++jeW1gAYomAfWDbgk6VGMSyR/5
	ou2SHr40+nqlzF6uoSgSHk6SgmcVqh+yHByIlI8jji9IYhvOCYLgJFupsWUhyIIg
	HxGzhcekCNzbU9ON1MnRTa/RohqKz/SPCV4qH+pj3g+htUP25LmLg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq551mrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682LBKIK007422;
	Wed, 2 Sep 2026 21:24:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjamuqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682LO3a646334378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 21:24:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9815020043;
	Wed,  2 Sep 2026 21:24:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C13420040;
	Wed,  2 Sep 2026 21:24:03 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.87.158.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 21:24:03 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 2/2] s390: Warn if kernel command line contains non-printable EBCDIC characters
Date: Wed,  2 Sep 2026 23:20:18 +0200
Message-ID: <20260902212400.674450-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212400.674450-1-iii@linux.ibm.com>
References: <20260902212400.674450-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfXw0VyOIE7fCId
 RxUpazAOwWRtLJEeLatrXOjL+zuOmJ1b6nNLawhIj2AB5eoI9OnounWOB2QQKpd70f8Fum3M06U
 Imrmkq4PfCMKWg9pIo/aA1QZ2PD452BldpppBUT7MdsKHrJMA1jNjwTtG4lFWhCZY20apfVeDJL
 bkRt/Gq0LTWKXCNdQMiPZYrS7TsNvSUDRDM4lhV5o7J3IqwDKwJscPpLdmDzWHqHsIphXS492N6
 tQ4DoE1UDRnor+PIGdyJ0AQWau1735LzNfT7bgEcj9fE/uLThqROcJXRJbywreGShQgHhLtN2NO
 Ubo8tx0om+lj8MJxjkypsFFZDsvN6xmOzrB1cOBWdq5h0LWL5owENth4Bqx9qeQ/3PAb1cmkns7
 WqZB1r5iN0kB/SwBMqex9h64EC6GFGVNI4joY4Vvmne6UzZO/ZRTXJ6g74DD4uvmsE6w18R6BQp
 jjyaswTZpUZml10086A==
X-Proofpoint-ORIG-GUID: rbLPBeirqaaEXVVTZXHyR04gkmsuq9ZZ
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9893f9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=39odpbwlhLosNuJWjRIA:9
X-Proofpoint-GUID: ZE_Q_jnl6vcyUslAPJvnuj89-kOTBjSl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX/BuS91kWFtQf
 moDUcKvJ6uf9QB5uTAfDgiXMdZrj7AIuBDqPBZSi12RvFPwR4g4Q5nGsu5Dpi0OEIuWzTWGFh9p
 22hfPkLqJOV5nLRGRpLeK2xn/EqroRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020186

Users may accidentally add multi-byte UTF-8 characters to zipl.conf
parmline, for example, by copying snippets containing non-breaking
spaces (\xC2\xA0) from web pages.

The kernel will then interpret the entire command line as EBCDIC,
making it unusable. Distinguish this situation from the legitimate
EBCDIC conversion by looking for non-printable characters and issue
a warning.

Accept the following tradeoffs:

* Do not make this a hard failure, there may be a very small number
  of users who put characters with diacritics on their EBCDIC-encoded
  command lines.
* Do not use heuristics with arbitrary thresholds, these may fail
  intermittently on, e.g., punctuation-heavy command lines, and having
  to tune thresholds in subsequent patches is not desirable.
* Use the ASCII subset of EBCDIC to determine whether characters are
  printable: the vast majority of command lines will contain characters
  only from this subset.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/ipl_parm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be76..dc42ea574f8d7 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -173,12 +173,23 @@ static inline int has_ebcdic_char(const char *str)
 	return 0;
 }
 
+static inline bool has_nonprintable_ebcdic_char(const char *str)
+{
+	for (; *str; str++)
+		if (!isprint_ebc_asc(*str) && !isspace_ebc_asc(*str))
+			return true;
+	return false;
+}
+
 void setup_boot_command_line(void)
 {
 	parmarea.command_line[COMMAND_LINE_SIZE - 1] = 0;
 	/* convert arch command line to ascii if necessary */
-	if (has_ebcdic_char(parmarea.command_line))
+	if (has_ebcdic_char(parmarea.command_line)) {
+		if (has_nonprintable_ebcdic_char(parmarea.command_line))
+			boot_warn("Kernel command line was treated as EBCDIC, but contains non-printable characters\n");
 		EBCASC(parmarea.command_line, COMMAND_LINE_SIZE);
+	}
 	/* copy arch command line */
 	strscpy(early_command_line, strim(parmarea.command_line));
 
-- 
2.55.0

