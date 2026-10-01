Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244A3FA5E9;
	Thu,  1 Oct 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850786; cv=none; b=QVJ5Sj74qFLhtPRRWwLpY0EyFDXMfmcDG1kehB6p9gneo7M84Bw/EU0l0MgimwX3Ze7rOa7LHXP3wAi2YnRHhOGuDBButPPwXBb3wHlfBoVBmRfnjegKwShELu7UMA1SSlkA8t3XPa2uGCQpMWUM9+XHek7pgl6NV52nGiArkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850786; c=relaxed/simple;
	bh=GSv5p4gGXTuHdIYld1AfkJ2XRxJVNm6Np+jMgbFGdcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u82ELU8NwDEgE1eFjxD6d5Tb7F/cYklHY8qC1Y5x1zbWu3kqOFYg5UwJhT9q8olQAa+GxyHm3HFNIixPyuqegzpigGlxEMxms0bOVboN8cyXLbjlwzT3nxpmXESe4i5oMr4X9leEsb+PpoxcTVR3rnfMDvD9q6zPHM4gMxwCA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EEMkDj/r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EEMkDj/r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69176KUS1120833;
	Thu, 1 Oct 2026 10:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cihIN88vtGi+ScDAW
	XyOkJECb2E8cpqLSUFLgiw2SDk=; b=EEMkDj/ripvAxW2/HTxV2znptlXGsUWM5
	2sszNy2DJKntNA487c58eGwr4bIXCO9j7jep4266P0gwUA6ShI0TKhD0otv4paw8
	P4QmfofHFkZJewpcHd1/gwA0MMl9Lrq+zHSqwujANFBAuBTHvEa7es9Lg6yk3uy/
	zxVQCdEfv1H9gh/74cgtIymAmQetHNMFs0LH+oV7kOm7om7CA1h7HYJOzMRRD2k3
	99jUp0Fri+NXdeOSnEGeNXe2iXR0BaCMU2CMJH7vbwpqEenLL2tdz2yR5PQUkBwU
	766Q4cvCZMNUhhACJ4/doIZsLsMZ7kaAtUkzA9e47/fIyYcdD3B2A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5jrak-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172X5m520721;
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWnZB31523086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D854220043;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0F82004B;
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
Subject: [PATCH 06/32] s390/tools: Generate bitmap of nullified program checks
Date: Thu,  1 Oct 2026 12:32:21 +0200
Message-ID: <20261001103247.1989111-7-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX0CeOTWtW4uBm
 1UZGliD4iELfuVO4Qg71DuG7bfWNus4PBk1a75C2t7sbrRCqFjh7+t7TusoumSaQp2HVfHi1Xfh
 ClaD8XrCsjmqCjMNNHp4FsTAVIsMKMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3HlCyimHBu5D
 k0qOE6aTqmI53t7eRyiIs2vVa2L+GqPYCX0sqvkuOtxKp7kfbK9MxgbSrHU7XLkJa6poYd2tF2p
 DWI+0rgaVbBDCiP1FeRayyB4k4Rbg5G5mehhaAC1r/x2kCffKsi9IExegNHBKI4aquSLx84BUBH
 WWbu0QrIi5p2ZmnaZ7/+2Ztm2M12BDPlsscWabr69iforYaCvxnNavwdVGJMUaIfntotrz5R6B4
 U5ZPEFXoC1lf1mUAvVovW+E8eq8h0PCjjl/MB5PZFBYYm8wlWbsXO5DYQihED/cCDbIvgKJm5fx
 THbm0hqlbCHLFdMNgSwSvK6ry/1jQy1ml8HR7RTsZm/EkH6sSKab8wEMArZ9rUyhv3XWuv/slYm
 FskgdCShG4Cxb2d9OSYhGXm1L5p8LLL5oMdOdj8qEAdRU6p5NY5b4i4zfo6a93qB/I+/ei+XqZG
 39fTJwzPuz/GjABJpig==
X-Proofpoint-GUID: JyR7cmMRnA0pkdp4wy04lyxXl_f7VPh2
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe36d6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lkSWvLFn8bspC76GBR4A:9
X-Proofpoint-ORIG-GUID: JyR7cmMRnA0pkdp4wy04lyxXl_f7VPh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Add PGM_CHECKS_NULLIFIED bitmap to gen_bitmaps and add a --pgmcheck
command line option to generate the pgmcheck-defs.h header file. The
bitmap specifies which program checks are nullified, and will be used
with future changes.

Change gen_bitmaps.c so it can create bitmaps with different bit
numbering: MSB0 bit numbering like before (most significant bit is
bit 0), and LSB0 bit numbering (least significant bit is bit 0),
which is used for the new bitmap.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/Kbuild  |  1 +
 arch/s390/tools/Makefile      |  8 +++++-
 arch/s390/tools/gen_bitmaps.c | 54 +++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 0c1fc47c3ba0..d13dd7e3dc01 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += dis-defs.h
 generated-y += facility-defs.h
+generated-y += pgmcheck-defs.h
 generated-y += syscall_table.h
 generated-y += unistd_nr.h
 
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index ac267bb46550..ba1e42d005e7 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -4,7 +4,9 @@
 #
 
 kapi := arch/$(ARCH)/include/generated/asm
-kapi-hdrs-y := $(kapi)/facility-defs.h $(kapi)/dis-defs.h
+kapi-hdrs-y := $(kapi)/dis-defs.h
+kapi-hdrs-y += $(kapi)/facility-defs.h
+kapi-hdrs-y += $(kapi)/pgmcheck-defs.h
 
 PHONY += kapi
 
@@ -16,6 +18,7 @@ hostprogs		    += gen_opcode_table
 HOSTCFLAGS_gen_bitmaps.o += $(LINUXINCLUDE)
 
 filechk_facility-defs.h = $(obj)/gen_bitmaps --facility
+filechk_pgmcheck-defs.h = $(obj)/gen_bitmaps --pgmcheck
 
 filechk_dis-defs.h = \
 	$(obj)/gen_opcode_table < $(srctree)/arch/$(ARCH)/tools/opcodes.txt
@@ -23,6 +26,9 @@ filechk_dis-defs.h = \
 $(kapi)/facility-defs.h: $(obj)/gen_bitmaps FORCE
 	$(call filechk,facility-defs.h)
 
+$(kapi)/pgmcheck-defs.h: $(obj)/gen_bitmaps FORCE
+	$(call filechk,pgmcheck-defs.h)
+
 $(kapi)/dis-defs.h: $(obj)/gen_opcode_table FORCE
 	$(call filechk,dis-defs.h)
 
diff --git a/arch/s390/tools/gen_bitmaps.c b/arch/s390/tools/gen_bitmaps.c
index 4bc5f19dd405..2e5dc491b19e 100644
--- a/arch/s390/tools/gen_bitmaps.c
+++ b/arch/s390/tools/gen_bitmaps.c
@@ -17,6 +17,8 @@
 struct bitmap_def {
 	char *name;
 	int *bits;
+	int inverted;
+	int maxbit;
 };
 
 static struct bitmap_def facility_defs[] = {
@@ -27,6 +29,7 @@ static struct bitmap_def facility_defs[] = {
 		 * -march=<machine>.
 		 */
 		.name = "FACILITIES_ALS",
+		.inverted = 1,
 		.bits = (int[]){
 			0,  /* N3 instructions */
 			1,  /* z/Arch mode installed */
@@ -71,6 +74,7 @@ static struct bitmap_def facility_defs[] = {
 		 * guest facilities supported by KVM.
 		 */
 		.name = "FACILITIES_KVM",
+		.inverted = 1,
 		.bits = (int[]){
 			0,  /* N3 instructions */
 			1,  /* z/Arch mode installed */
@@ -116,6 +120,7 @@ static struct bitmap_def facility_defs[] = {
 		 */
 
 		.name = "FACILITIES_KVM_CPUMODEL",
+		.inverted = 1,
 		.bits = (int[]){
 			12, /* AP Query Configuration Information */
 			15, /* AP Facilities Test */
@@ -125,17 +130,56 @@ static struct bitmap_def facility_defs[] = {
 	},
 };
 
+static struct bitmap_def pgm_check_defs[] = {
+	{
+		.name = "PGM_CHECKS_NULLIFIED",
+		.inverted = 0,
+		.maxbit = 127,
+		.bits = (int[]){
+			0x10, /* Segment Translation */
+			0x11, /* Page Translation */
+			0x16, /* Trace Table */
+			0x20, /* AFX Translation */
+			0x21, /* ASX Translation */
+			0x22, /* LX Translation */
+			0x23, /* EX Translation */
+			0x24, /* Primary Authority */
+			0x25, /* Secondary Authority */
+			0x26, /* LFX Translation */
+			0x27, /* LSX Translation */
+			0x29, /* ALEN Translation */
+			0x2a, /* ALE Sequence */
+			0x2b, /* ASTE Validity */
+			0x2c, /* ASTE Sequence */
+			0x2d, /* Extended Authority */
+			0x2e, /* LSTE Sequence */
+			0x2f, /* ASTE Instance */
+			0x30, /* Stack Full */
+			0x31, /* Stack Empty */
+			0x32, /* Stack Specification */
+			0x33, /* Stack Type */
+			0x34, /* Stack Operation */
+			0x38, /* ASCE Type */
+			0x39, /* Region First Translation */
+			0x3a, /* Region Second Translation */
+			0x3b, /* Region Third Translation */
+			0x3d, /* Secure Storage Access */
+			-1  /* END */
+		}
+	},
+};
+
 static void print_bitmap(struct bitmap_def *def)
 {
 	unsigned int high, bit, dword, i;
 	unsigned long long *array;
 
-	array = calloc(1, 8);
+	high = def->maxbit ? def->maxbit / 64 : 0;
+	array = calloc(high + 1, 8);
 	if (!array)
 		exit(EXIT_FAILURE);
-	high = 0;
 	for (i = 0; def->bits[i] != -1; i++) {
-		bit = 63 - (def->bits[i] & 63);
+		bit = def->inverted ? 63 - (def->bits[i] & 63) : (def->bits[i] & 63);
 		dword = def->bits[i] / 64;
 		if (dword > high) {
 			array = realloc(array, (dword + 1) * 8);
@@ -171,6 +215,7 @@ static void print_header(const char *guard, struct bitmap_def *defs, size_t num)
 
 static const struct option long_options[] = {
 	{ "facility", no_argument, NULL, 'f' },
+	{ "pgmcheck", no_argument, NULL, 'p' },
 	{ NULL, 0, NULL, 0 }
 };
 
@@ -185,6 +230,9 @@ int main(int argc, char **argv)
 	case 'f':
 		print_header("FACILITY", facility_defs, ARRAY_SIZE(facility_defs));
 		break;
+	case 'p':
+		print_header("PGMCHECK", pgm_check_defs, ARRAY_SIZE(pgm_check_defs));
+		break;
 	default:
 		return 1;
 	}
-- 
2.53.0

