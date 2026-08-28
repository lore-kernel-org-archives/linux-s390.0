Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109546C4BF;
	Fri, 28 Aug 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925669; cv=none; b=I2ILIbiQ6i0s5w02LV80NS0tm/KFCw+Qi2zXbQbzS+1a7Ue2fyc3s2Fp5BK99BJ9+Gp6xsMVG6q30okv7rqyXABYMUOVs1OyNxD+JsAH/8W7jgg3jKY63MUi+zVvc2xsHzWMXv+4eWyN2juxsiJcbm2lKUOrcAwVQ6fc49qwfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925669; c=relaxed/simple;
	bh=trzcJm5EyDLLKO5hrBgE9GOuRebi+4xZPl2W2/cN160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di2XXJVoglNKuTeMQon6DdN3/zKTXm2wL0Xj0ZrAnzJzJX/4ChwyZStNnJ3fzWGaCqJYFBxVNjQHXhSK4F65jFZYfRWHwlmY6Jg+FyqnNZUej0YFmo4e1KlYbJKJhZxEDZsqRyvEslw9aBCPUpMbgEzUAN5gJmspCJ8SI/Hg/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AaqF+Xko; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AaqF+Xko"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVqsf2133908;
	Fri, 28 Aug 2026 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lbd47BmNO5Y7UucVm
	gai0iLiKMpcVkapS4/JAXNLPHo=; b=AaqF+Xko8CjUsLT40OzVEQhcITPdigiWM
	q+PWqTGuf59BFdjXITJlzEpwlLCQVq/vO0Zls+0y9K8hQcGZmjwebj0Q+uVFfRtI
	THYYwYquvAMeQEoj0laHTNBtupcsL4K6lXLQaIzZ8MoSYo+NHjiGB58tHyXe3lEh
	XKjz+9mCCfAPxtBYPPPHZAWGkJ+Z7+1RMmOTeh2JlZP0PLHQwhVjIlZQswquN0Eq
	HshTk8Hen0PXvLQQO273lRNXaPGcTY8Bjua/cwfGx8dpIaO3+QpOxTGupNSpIxWx
	wP1QDSF78m4wqYRvgBmjlMjnbgh76lHU+CoQPmVRTPzXHJ9QDel3A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5cpav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDuHiV005569;
	Fri, 28 Aug 2026 14:01:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyp89x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SE10Kc35848520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 14:01:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC83F2004B;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704D920040;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.26.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 2/2] s390: Warn if kernel command line contains non-printable EBCDIC characters
Date: Fri, 28 Aug 2026 15:59:35 +0200
Message-ID: <20260828140057.1728173-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828140057.1728173-1-iii@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EfsDZmlkM8By8v5FbjHaUhTAm4pfNmTn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfXzyXoRWsaMG6o
 RSEdLgpBo9U6gF/4O/RnXMH1ulLZpWrIt8TawqgfsDFHw2oh7uovsWw0LfAeTzcpHC+WWC3I232
 vGnKk37g7gfjK2Vj8Tn9K+vOYkYOHs4=
X-Proofpoint-GUID: cel9gqYVXQXW4BV2smEn0Q6cbQDY-3C-
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a9194a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=39odpbwlhLosNuJWjRIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX6FA0XePmdlw+
 s87M6mdbzL4398eapYSlyITr7S5hVtRL8w+3/t93AxDMxDcTMGGc7uJ44owC1trp+01ufsvYTb8
 gzx9EgTS0GDfAaxR5GW/AOX+KZUKxqOtHKuvTmP1EHU0Dmm4V9NlwXzNjfj7gjDqy3LTYBnXHD2
 zCBmZOUMoV3Q3J4BmXpVcEAJbrlGmAKJNP8WiSFx1hAa0ONErTepLtcB+NvdGbVt+o/a799LDl/
 NtxvUVfy8OGhPbvtFbJbSmUCn49vQAGy55a3NPPqbxJLLhrWJ7LoFxn2nOAWPaa5EtnTYKFFf0H
 efaacEutR1fMpCilqpQmx0R12sQF1OW7U7c9WA5H4Xo2XPhzKcZhVIk6+qWHspYgNgI2FUoKjf5
 0mBmOw0EfmVoCBA/yoQo/z9pGNztMtzfREvkPXDfpOUz4GDKyG2RqlTubwfp8wJDO+8JZIPVLks
 c8r7gqc45xRMeZDP9xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280117

Users may accidentally add multi-byte UTF-8 characters to zipl.conf
parmline, for example, by copying snippets containing non-breaking
spaces (\xC2\xA0) from web pages.

The kernel will then interpret the entire command line as EBCDIC,
making it unusable. Distinguish this situation from the legitimate
EBCDIC conversion by looking for non-printable characters and issue
a warning.

The current solution deliberately makes the following tradeoffs:

* Do not make this a hard failure, there may be a very small number
  of users who put characters with diacritics on their EBCDIC-encoded
  command lines.
* Do not use heuristics with arbitrary thresholds, these may fail
  intermittently on, e.g., punctuation-heavy command lines, and having
  to tune thresholds in subsequent patches is not desirable.
* Use the invariant subset of EBCDIC to determine whether characters
  are printable, the vast majority of command lines will contain
  characters from this subset.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/ipl_parm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be76..24573307263ca 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -173,12 +173,23 @@ static inline int has_ebcdic_char(const char *str)
 	return 0;
 }
 
+static inline bool has_nonprintable_ebcdic_char(const char *str)
+{
+	for (; *str; str++)
+		if (!isprint_ebc_inv(*str))
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

