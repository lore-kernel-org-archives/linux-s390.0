Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA34346FB3;
	Fri,  2 Oct 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937894; cv=none; b=M3dfcVpVfE2bCpRGnpmx9WJem5mylwwEwyqQkPLG0xXwpNA+wAqNFkT1GJyH09vMEexhZFkTR9TPWA5fquC8hKCJY2W/VIhfErL2WmLzAeUurCdsn9wc61a+ujOWpjtYca4xR/D+oAUCl6PbOLbsk09Buhw1G/8QZQ356+t1gxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937894; c=relaxed/simple;
	bh=XsefLyeRvmnTMGpr6K7RckbUnCoIHGm0R0+g8uPUdFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVM7Ea2MsZWp8pyEMCYtPRjPaUUrUrkpEJOS/H9lhEXRFpdy3BD3nOQoitqWt/KMHaeyhS/Vki3uQDXIAkloqjuRVUrFgWaowSvVHhDUJbW/AeqZ7drLk7wroesp2MQj7aE/ajq/rygSmx6X2uqk5voaR85RNJw6DJbH9720Ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tntSNH+h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tntSNH+h"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A5Th22565955;
	Fri, 2 Oct 2026 10:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NqlQ4/vdzEfYpQsrFUcPUHHGE1MpU5k6RcIkFe6MQ
	Js=; b=tntSNH+hPznsZgFzHNMc+F9Gz+6YxQvH1S+dmMXPAGCyax7DuAgFGtN1t
	1feM2tdoVaE6mZHOn3Wsp3VT1292Q+J5RkFC0yqN8CfEwy+rzlaQh4u18s8nWwjU
	4Vo48Ovc1JBoQkGS+LMOl+rysuXM9eFgRbVAv4cE3Rjau9Lcgjvo/3s2XeoYl7Bx
	XpS+Xc51WufGbUhs/DEqTXbObtuvHna2IYbT/N4T3h2IOkBsvGQxU0xGMI+ms5AW
	LImFuLUVtF6qfXW4p5ALzCr5bHX974U/qTtqQzFel6FunURdRpYh4FlHVsvJVx3m
	u52Psr/qb+8l/U2VIdjvq+aVDeKMA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrrqp8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 10:44:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6929lbBA2378145;
	Fri, 2 Oct 2026 10:44:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7yeb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 10:44:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692AilXh28967282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 10:44:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA7120040;
	Fri,  2 Oct 2026 10:44:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56D92004B;
	Fri,  2 Oct 2026 10:44:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 10:44:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/dis: Mark non-NUL-terminated character arrays with __nonstring
Date: Fri,  2 Oct 2026 12:44:46 +0200
Message-ID: <20261002104446.2077269-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX5LciaHEJhl6j
 pdHN+iXbWkNXstd1pL2nfjaes3wQnuPHy/juYKyf36VlKaiHuDv0RVAXNgy/HVDZOT6KRnpl+F5
 LzymnMELKk9H7AkzBPDcMO4O9xrECs5NfXZAW7C6NxTLidmnEf6CZKlmTYMMvvpNn/T4qRcSZKp
 QEeqNUwtBZuAn7K5Qv5Ra+p9kByogsJITKKr+ujJ0KjcVwx7PuDHjLTuREdbXgaehJWHG6FoOBb
 ip8rN9+FqS6VeLrQISR+XEqm/ZiocWnXz7tnpc5NxNvjQ9E3w2R8nDSoL4LbKMojWgWWeqb8SeN
 AIQpR+UkqcCIblFiyc9R1+dyraXApcX3dSHzm5Zj6IhSHzwpiBsHI0GB9ywQvCzBu5kfxFikHu2
 CXygZQ992B9vgV/WisbRqBl5FT6nw6l0gRMWm1xA+kLcH8PbfzjeuW1q22LMX7sKz1daqeJc0uF
 LBdwJLZyzEUoYyHlkbA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf8b24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ZqJsfCv_B_X6anNg2AgA:9
X-Proofpoint-ORIG-GUID: X_DqaaXtrp9vns8pHDknjJvPYvNbpWpk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX9k0fOIEcfEOM
 UbTfmZ7nnfcgjFHfOmUR5q6gj/dYJve3qFCFJ08zb557KD7KuYAzZT5//KFqZ0maFg08fkrz5DK
 rUA2rh9Ki68KoQClRfgGuU1Lu1tuj4M=
X-Proofpoint-GUID: X_DqaaXtrp9vns8pHDknjJvPYvNbpWpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020042

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
 arch/s390/kernel/dis.c             |  4 ++--
 arch/s390/tools/gen_opcode_table.c | 23 ++++-------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 1cec93895b3a..556fe3956c7f 100644
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
+static char long_insn_name[][7] __nonstring = LONG_INSN_INITIALIZER;
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

