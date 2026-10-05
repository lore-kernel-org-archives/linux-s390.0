Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50D41611D;
	Mon,  5 Oct 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192184; cv=none; b=Adh+Hzl+ljoMw5Prk5u+G8SJAXNMPBV/d5qwEo9sb7kypnfxlCrja/1V8x7jL5uwY07n58m9iSX2G4GaHis/i4ZXJob1nox0eBQYwc35vP8HofXhadGnuT5igGxky0SPmwdMbLz32RLZZ5fqDVqgYVJu6Colj89JPTkBdWPQxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192184; c=relaxed/simple;
	bh=BGrAo7AyaaQoWhFwGYcjhYN3aRdZEeobmKziPW72M08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8eIXyMIbp3pJ7x5PLptBnbTVyDaDi5LqvOJ3WXD0gO2TiPr/p1vUTaztQYrwI4EbH0qd93qDtTuvvFQIzkkl+r6LAwA1tryatC4MWQl11+YQrcGCa7k7EUgyPSrkWr6myFMh02xBH8V9XUy7wlupMW4yHMFcFQMEF5SDvVTBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eqUwXmjb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eqUwXmjb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515ZU13290349;
	Mon, 5 Oct 2026 09:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/9py2qkgrBP45kBweUQ2C/k/kJiManV5GG0pwAEbn
	Rk=; b=eqUwXmjbLVSXc19zV9EAaJLOYPDcK3REfD+q0Bmo1uEdM1ozixuAV6YQM
	lCH9TCDRU7gC1TZk6dt711L2b2/2c4U+ve84N6FC8kdCMvoiP86p18fqD3Gad76H
	X7mKybkE4Ydvl+2asn6LtbsqvdQLKDLE0MdxpCsECg7veTZk6Vps7C3ZVIXZLqa9
	dU2VzSm5gqDN2RbUA2Z07pDiGlBsuY/2ljVCx4OjSou+V7IIFIrEoU/7QFM0fx3N
	5QcC8NxP/zU7AOAm8o5ihHdZ7oMPLihQ+l7i/oRhd0iL0PviINEN8fMA6LJlsCVS
	uI+9aul3tQ8tVK+SbkRffSSlDOpkg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv0ms4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:23:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956ReIZ2203895;
	Mon, 5 Oct 2026 09:23:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgmq76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 09:23:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6959Mune48169402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 09:22:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A21192004E;
	Mon,  5 Oct 2026 09:22:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 837C020049;
	Mon,  5 Oct 2026 09:22:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 09:22:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2] s390/dis: Mark non-NUL-terminated character arrays with __nonstring
Date: Mon,  5 Oct 2026 11:22:56 +0200
Message-ID: <20261005092256.2740363-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Niuu0iK0G-YlTG0XKS-6VTcwyRfQF7yZ
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac36c75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hxsTDYNwqb7sgjUZo4oA:9
X-Proofpoint-GUID: Niuu0iK0G-YlTG0XKS-6VTcwyRfQF7yZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX/dDWql/J2U+0
 A/CfMnSAnoOp/UfdcAEdEgR/E0y9+0JG/IAY4dlBDDVfMn99XWFStLy0LlU9QJKvDtR4osk+FWn
 OgIFy+W2MVyLY2fT27Pk2DdY45ja3Iy/ZBGPHcy6xP2PzlEVTx8MP88Iv6SiwnsiwETDYqF07Ot
 aCtRTZxoKNlhztDmrAa0snd1n6sMuSXvPJe7IE73MYM1XqLCGjeDcAbtqWa/wzO3IZPH5wO5Xz3
 nkmJMcn83Ee8OdIwZWQpiXIqGdnaVc0PV6zJaHTKXfhrJd1llNIexSS1cZWp3S3USGb0WYKCrjt
 RDFRNGOTLE3jZ+uGlGFNg87kULsCfkmCKeX3474GMQcWvbjdDGOe+NPQ6dCdFkoS5OxtCzC9d0W
 Y7ue9M9IpKAIOAayGnDCAHaPAGhcsogkSbJ6m+i5+6tPmbyZH/kDsUyEcKm17pYT76pqgyCV09U
 teuOcwhSs4r0AM35H8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX04GS1JRyGjIT
 NAeneNE8qzWUdf2KysiDpPBitkb6tge+8m5BOesI4Fhhj+SmTg8GsLDyBsIyZoPYfOKcImoCUHm
 5wqilyK6NGlv+gxZWwxd8/ouV5p4yUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050036

With [1] the generated string initializers were changed to use an
array instead of a non-NUL-terminated string. The reason was that GCC 15
warns about string initializers that truncate the NUL terminator with
-Wunterminated-string-initialization.

The better solution is to use the __nonstring annotation, which exists
to deal exactly with this problem. Therefore use it and basically
revert [1] in order to generate more readable initializers:

Before:
[LONG_INSN_ALGHSIK] = { 'a', 'l', 'g', 'h', 's', 'i', 'k', },

After:
[LONG_INSN_ALGHSIK] = "alghsik",

[1] commit 7cbae7ea3de5 ("s390/tools: Use array instead of string initializer")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---

Notes:
    Use __nonstring_array for long_insn_name array, since compilers before
    gcc 15 will otherwise warn with:
    
    arch/s390/kernel/dis.c:343:1: warning: 'nonstring' attribute ignored
     on objects of type 'char[][7]' [-Wattributes]

 arch/s390/kernel/dis.c             |  4 ++--
 arch/s390/tools/gen_opcode_table.c | 23 ++++-------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 1cec93895b3a..9c349eb884bf 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -51,7 +51,7 @@ struct s390_operand {
 
 struct s390_insn {
 	union {
-		const char name[5];
+		const char name[5] __nonstring;
 		struct {
 			unsigned char zero;
 			unsigned int offset;
@@ -340,7 +340,7 @@ static const unsigned char formats[][6] = {
 	[INSTR_VSI_URDV]     = { V_32, D_20, B_16, U8_8, 0, 0 },
 };
 
-static char long_insn_name[][7] = LONG_INSN_INITIALIZER;
+static char long_insn_name[][7] __nonstring_array = LONG_INSN_INITIALIZER;
 static struct s390_insn opcode[] = OPCODE_TABLE_INITIALIZER;
 static struct s390_opcode_offset opcode_offset[] = OPCODE_OFFSET_INITIALIZER;
 
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index 7d76c417f83f..820905eca78a 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -201,17 +201,6 @@ static int cmp_long_insn(const void *a, const void *b)
 	return strcmp(((struct insn *)a)->name, ((struct insn *)b)->name);
 }
 
-static void print_insn_name(const char *name)
-{
-	size_t i, len;
-
-	len = strlen(name);
-	printf("{");
-	for (i = 0; i < len; i++)
-		printf(" \'%c\',", name[i]);
-	printf(" }");
-}
-
 static void print_long_insn(struct gen_opcode *desc)
 {
 	struct insn *insn;
@@ -234,9 +223,7 @@ static void print_long_insn(struct gen_opcode *desc)
 		insn = &desc->insn[i];
 		if (insn->name_len < 6)
 			continue;
-		printf("\t[LONG_INSN_%s] = ", insn->upper);
-		print_insn_name(insn->name);
-		printf(", \\\n");
+		printf("\t[LONG_INSN_%s] = \"%s\", \\\n", insn->upper, insn->name);
 	}
 	printf("}\n\n");
 }
@@ -249,12 +236,10 @@ static void print_opcode(struct insn *insn, int nr)
 	if (insn->type->byte != 0)
 		opcode += 2;
 	printf("\t[%4d] = { .opfrag = 0x%s, .format = INSTR_%s, ", nr, opcode, insn->format);
-	if (insn->name_len < 6) {
-		printf(".name =  ");
-		print_insn_name(insn->name);
-	} else {
+	if (insn->name_len < 6)
+		printf(".name = \"%s\"", insn->name);
+	else
 		printf(".offset = LONG_INSN_%s", insn->upper);
-	}
 	printf(" }, \\\n");
 }
 
-- 
2.53.0

