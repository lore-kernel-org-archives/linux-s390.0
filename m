Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3F3F58D6;
	Thu,  1 Oct 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850784; cv=none; b=rXD9dXtEpFsI1NcGpP9VA/MRe+8faU5sggrQq6ip4A8iLkSccgQNW0M20Fsu2WorQwJOuCgfOC1WgLiTCT+dO/ZfRxfmJ7YyVM6JfmajYUFHrQFF4osjIiRJlmnhkLubnpqzR0n1cnV8iarPbykAHtb4hmbb/Snf+OpVvLxMq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850784; c=relaxed/simple;
	bh=5ju5TEWSoiZFZpLnT3dDL8INlBV2rQ92lt/J6kyX+oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyN7GvgcfofTLCiKBE/7MXwhPeLu6Zknw+h66yN2xR+Ue/ef0VEEip2yaHSS9awtbCHAqHDfc+Ldkc68vBQF54yBE6TnUuOBJy+vVIUHaP8Hc9SaLgR1jvDvAl2CZRnKNxKrWp2j3b8aq0MHPMXh0x3Imn8vMyA0b7Iu+9vLcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qG3Vyq+x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qG3Vyq+x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175R3s907233;
	Thu, 1 Oct 2026 10:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o9LuSPEkVa2NtKGiE
	FtmKPNkQQV9vGTEiKwrptS4Fwc=; b=qG3Vyq+xMdZah+EoEZP7Ihkq8/rF09hpq
	Fe9tK/yEGIZxor00qi0P9sc4URn3eWeEILUvkQwbZeml5A6LBt2T9BbIYSHVJA0A
	m8CaqjVFGtTZAUqNAC7qGZqztvoFneFrtjyV2bFXke8bKbnayRAyUUFRuYm4P/+x
	Qvwe2uFfp6zYUDauz4Vu0fnZxIreIP19PUOc+Ed81vjCZ8BTHvmctFxyG4DaYg5F
	VymF90W7Vu2/k/09s88p9xSN1aJV27smMIh7EAsLyDHDhwiaiZpBkaKlYcs4bkLT
	51oDQ7yH42e3IN0HDxydncdpyCS8Qp/+ipscMgn8HYYD+i3FiJoXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhspn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Vnw589646;
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWnQa31523084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F9220043;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B5DE2004E;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
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
Subject: [PATCH 05/32] s390/tools: Rename gen_facilities to gen_bitmaps
Date: Thu,  1 Oct 2026 12:32:20 +0200
Message-ID: <20261001103247.1989111-6-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: u7MMT2bWc79p8zzl5lLI7mxmsF4wuXfA
X-Proofpoint-GUID: u7MMT2bWc79p8zzl5lLI7mxmsF4wuXfA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwK1bO9l//w+c
 EA3Z1tjwZ8gf+rTpP6VYlVKfBv3Ql32+/ZwXQ3SnbNWJV80z6FBTYuMHidP+8N6pTKRKz6BIrNn
 SAxxAxZDWN1l+Y4+FOlKPEJcqE5ynVQ=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36d6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=AQZwbXL4BzLpkD4zlTAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXza3eQFjZrIoP
 +f/svfgDH3v7n6Mr7XIhmrzuXJjYXLQJxYXSEoO7pTXYlJNN3qg3sEzLWs5sz+CK8DU+FGHMnmb
 V5Cij3STRrY6Jbi1H9Dd4QZogukBCbfrgSxSxHq7N5ejgRcX3ZS+MfuzUaEpF9HruKAK5wJJzwT
 kp6lJSSOCAvxzIY5BwNJG0bzVY35ICUfDoLs8Kkxqca2/Mp+jtgfOxsWXgFF9bgrCSlcVAcAPso
 jq74JAGf+jXuLB3iWcgx/LJaHkKViVlpGGDOFfimyPEdwkWp6gc/Yc3ou094PJ0OxwdJCiEKaTV
 srIjvEkGyrCw9BZoTpI3/Zz6/eHBNSQldMWVQzAzshR4R4ilzOZDOqvHQ1BXQTfyIn1h7sbHfk7
 D+cYZFKFveuSv33SIb0pffvxEkbda19pgvbw7gO7A3CrppvWzTIYgw1P/1YruHeWavxuC7LRKWw
 1C4rU0tKMN1d41BY9xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Rename gen_facilities.c to gen_bitmaps.c and make it more generic so it
can be used for various bitmaps. Add command line parsing, and use it
to explicitly specify that the facilities header should be generated.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/tools/.gitignore                    |  1 +
 arch/s390/tools/Makefile                      |  8 +--
 .../tools/{gen_facilities.c => gen_bitmaps.c} | 49 +++++++++++++------
 3 files changed, 38 insertions(+), 20 deletions(-)
 rename arch/s390/tools/{gen_facilities.c => gen_bitmaps.c} (83%)

diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
index e6af51d9d183..e07d27143172 100644
--- a/arch/s390/tools/.gitignore
+++ b/arch/s390/tools/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gen_facilities
+gen_bitmaps
 gen_opcode_table
 relocs
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..ac267bb46550 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -10,17 +10,17 @@ PHONY += kapi
 
 kapi:	$(kapi-hdrs-y)
 
-hostprogs		    += gen_facilities
+hostprogs		    += gen_bitmaps
 hostprogs		    += gen_opcode_table
 
-HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
+HOSTCFLAGS_gen_bitmaps.o += $(LINUXINCLUDE)
 
-filechk_facility-defs.h = $(obj)/gen_facilities
+filechk_facility-defs.h = $(obj)/gen_bitmaps --facility
 
 filechk_dis-defs.h = \
 	$(obj)/gen_opcode_table < $(srctree)/arch/$(ARCH)/tools/opcodes.txt
 
-$(kapi)/facility-defs.h: $(obj)/gen_facilities FORCE
+$(kapi)/facility-defs.h: $(obj)/gen_bitmaps FORCE
 	$(call filechk,facility-defs.h)
 
 $(kapi)/dis-defs.h: $(obj)/gen_opcode_table FORCE
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_bitmaps.c
similarity index 83%
rename from arch/s390/tools/gen_facilities.c
rename to arch/s390/tools/gen_bitmaps.c
index 32dd5a57240d..4bc5f19dd405 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_bitmaps.c
@@ -1,24 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Simple program to generate defines out of facility lists that use the bit
- * numbering scheme from the Princples of Operations: most significant bit
- * has bit number 0.
+ * Simple program to generate bitmaps, for example facility lists.
  *
  *    Copyright IBM Corp. 2015, 2018
  *
  */
 
+#include <getopt.h>
 #include <strings.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
 
-struct facility_def {
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+struct bitmap_def {
 	char *name;
 	int *bits;
 };
 
-static struct facility_def facility_defs[] = {
+static struct bitmap_def facility_defs[] = {
 	{
 		/*
 		 * FACILITIES_ALS contains the list of facilities that are
@@ -124,7 +125,7 @@ static struct facility_def facility_defs[] = {
 	},
 };
 
-static void print_facility_list(struct facility_def *def)
+static void print_bitmap(struct bitmap_def *def)
 {
 	unsigned int high, bit, dword, i;
 	unsigned long long *array;
@@ -151,25 +152,41 @@ static void print_facility_list(struct facility_def *def)
 	free(array);
 }
 
-static void print_facility_lists(void)
+static void print_header(const char *guard, struct bitmap_def *defs, size_t num)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
-		print_facility_list(&facility_defs[i]);
-}
-
-int main(int argc, char **argv)
-{
-	printf("#ifndef __ASM_S390_FACILITY_DEFS__\n");
-	printf("#define __ASM_S390_FACILITY_DEFS__\n");
+	printf("#ifndef __ASM_S390_%s_DEFS__\n", guard);
+	printf("#define __ASM_S390_%s_DEFS__\n", guard);
 	printf("/*\n");
 	printf(" * DO NOT MODIFY.\n");
 	printf(" *\n");
 	printf(" * This file was generated by %s\n", __FILE__);
 	printf(" */\n\n");
 	printf("#include <linux/const.h>\n\n");
-	print_facility_lists();
+	for (i = 0; i < num; i++)
+		print_bitmap(&defs[i]);
 	printf("\n#endif\n");
+}
+
+static const struct option long_options[] = {
+	{ "facility", no_argument, NULL, 'f' },
+	{ NULL, 0, NULL, 0 }
+};
+
+int main(int argc, char **argv)
+{
+	int opt;
+
+	opt = getopt_long(argc, argv, "", long_options, NULL);
+	if (opt == -1)
+		return 1;
+	switch (opt) {
+	case 'f':
+		print_header("FACILITY", facility_defs, ARRAY_SIZE(facility_defs));
+		break;
+	default:
+		return 1;
+	}
 	return 0;
 }
-- 
2.53.0

