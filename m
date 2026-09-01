Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26C3ADB89;
	Tue,  1 Sep 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272759; cv=none; b=KwMllx+GOtuyyai6/sszzjPpGt6Lq9h9CsDoN+YLT01kUOIfNRbmIrUR598+663CY5jxu5a/mMghg9sop8bMBIv3M1A5jk9J6y3EkuuYbUIkt1iDbn4tQHVMTAmET0gJ0LY3qbN9lVuN9qGWliPFr93RPs5FmEiXfr+iBbVjAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272759; c=relaxed/simple;
	bh=pdk32iXxP9+kPF+rRomwOjd0o/URiuuI/h5iDH0hod4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT85x1k0ThXcSawTuUv02I1J9+N0hKJTHWpDdmrQnTuXtM9qMSp6xzVdgi0rYr7cL9STMzBtqI67aRgnVqeT5PhKs2MIa0DX6tOQm2ZCdfeKK9FwGyqsp2A8lSJUT14aaGTryka7MMlsaHpo0R4T/s83QVhVw2bvaBHUEKaSYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvnEfYXr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvnEfYXr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVYS53645096;
	Tue, 1 Sep 2026 14:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HWPwr9Cys0yEhBMVx
	7tf3pwo/oJjq4cxNbBL57K7Dzw=; b=rvnEfYXrzH8BaDy8K26CMuwTdFLx3Pojc
	2aD98Z/WmZREYUhZ48qfgo7zrEizPuL2A+PkXZDKCA5vIfU0oUIoLnBZClTTE8KY
	VcnmqGUSw90ATF4gPA7ZXw6zPW8xEBrnZBYZit883xVOvg5riPiF0XZ1WFxHnafT
	113Bw86AgIdCraH+aDlR67sU7IWKPFvWqRz3POsN/iUDc99cQN6r8oqJWVGprIUC
	SFK2tiHI+2VSXke8KV5RJbzrmlzP7vV+SH427msqZVyDjBIXcjRejyS0VpocJ2Q5
	FUZZzb7fcp7RCofa+jE0BDcQHEENxUS5aGnxWGTBdrAB6EM3CkHig==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r8b9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBit1030223;
	Tue, 1 Sep 2026 14:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark45c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EPpf850987452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:25:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A9620049;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BDAC2004D;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH 1/2] lib: s390x: snippet: Add snippet declaration macro
Date: Tue,  1 Sep 2026 14:20:25 +0000
Message-ID: <20260901142538.42553-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901142538.42553-1-frankja@linux.ibm.com>
References: <20260901142538.42553-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a96e074 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1RXJupqVPAlOi2bitYUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXzRkQErI5AQ1X
 okDN48yrjIqiKSG+0TKdhZ/4KnpNQvcJBUoCrj1HaNly8MtU8tEBbNA9a28QtRTk7qFfygVSZ4a
 A7cw5S2HrjUymHlEp8Bi+24JSwTV3NgMlueTWh/2Df62C2g1nKgE7BiM8A/z2apxIo4A7cyffUq
 nKBzRcRC1GU+SOmbFmM7Gg5ES+w01YOPhhS/0+YQyV5BzSasIFpcK9TkHht4lTbc5Z5CaYmplhB
 EC0apT35mOqYWNshpreEMu8Z+R4DaeLsPD1+SMSj4uMC3dZYe7bOQADQKzw5E6Cgn/M54g3GqSg
 uGgukkp5S+dhN0IQZaaHNr3K/v1g9wmJR0/I5sFAkwZykLsVlOwiFfi7KJzMsTj/2/CCv2ghfx5
 ORqlkatauVt92X6XFIqBrVrf2SotmvKKbK7lgGh1B0+t/gIZvwqMdrGUm5CedVZp2E4Nk3xOWMs
 4neivUHRMl4E7QacC7w==
X-Proofpoint-GUID: JAXTROdsBFD6Kiu92m4-wr0SjfzTKZpI
X-Proofpoint-ORIG-GUID: JAXTROdsBFD6Kiu92m4-wr0SjfzTKZpI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXyGNfKZLSSP63
 zn3yKsYMBAPZZBFaVb7TKozc+Zjiojy9oyfIv4wkgB7j/H/KEVqWlc5P1gun/V1MPAxgzQ8RbcH
 uIP262gwsiQLRG9RZlchaby8QX3IMy0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010124

Improving readability.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h |  9 +++++++++
 s390x/mvpg-sie.c    |  3 +--
 s390x/pv-diags.c    | 15 +++------------
 s390x/pv-edat1.c    |  5 +----
 s390x/pv-icptcode.c | 30 ++++++------------------------
 s390x/pv-ipl.c      |  5 +----
 s390x/sie-dat.c     |  3 +--
 s390x/spec_ex-sie.c |  3 +--
 s390x/stfle-sie.c   |  3 +--
 9 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 83d74387..6f82a873 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -30,6 +30,15 @@
 #define SNIPPET_HDR_LEN(type, file) \
 	((uintptr_t)SNIPPET_HDR_END(type, file) - (uintptr_t)SNIPPET_HDR_START(type, file))
 
+#define SNIPPET_DECLARE(type, file)				\
+	extern const char SNIPPET_NAME_START(type, file)[];	\
+	extern const char SNIPPET_NAME_END(type, file)[]
+
+#define SNIPPET_DECLARE_PV(type, file)				\
+	SNIPPET_DECLARE(type, file);				\
+	extern const char SNIPPET_HDR_START(type, file)[];	\
+	extern const char SNIPPET_HDR_END(type, file)[]
+
 /*
  * Some of the UV memory needs to be allocated with >31 bit
  * addresses which means we need a lot more memory than other
diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
index 21082c53..ec0737be 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -84,8 +84,7 @@ static void test_mvpg(void)
 
 static void setup_guest(void)
 {
-	extern const char SNIPPET_NAME_START(c, mvpg_snippet)[];
-	extern const char SNIPPET_NAME_END(c, mvpg_snippet)[];
+	SNIPPET_DECLARE(c, mvpg_snippet);
 	pgd_t *root;
 
 	setup_vm();
diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index b6f08dd2..e7cc0e85 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -18,10 +18,7 @@ static struct vm vm;
 
 static void test_diag_500(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_diag_500)[];
-	extern const char SNIPPET_NAME_END(asm, pv_diag_500)[];
-	extern const char SNIPPET_HDR_START(asm, pv_diag_500)[];
-	extern const char SNIPPET_HDR_END(asm, pv_diag_500)[];
+	SNIPPET_DECLARE_PV(asm, pv_diag_500);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_500);
 	int size_gbin = SNIPPET_LEN(asm, pv_diag_500);
 
@@ -69,10 +66,7 @@ static void test_diag_500(void)
 
 static void test_diag_288(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_diag_288)[];
-	extern const char SNIPPET_NAME_END(asm, pv_diag_288)[];
-	extern const char SNIPPET_HDR_START(asm, pv_diag_288)[];
-	extern const char SNIPPET_HDR_END(asm, pv_diag_288)[];
+	SNIPPET_DECLARE_PV(asm, pv_diag_288);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_288);
 	int size_gbin = SNIPPET_LEN(asm, pv_diag_288);
 
@@ -110,10 +104,7 @@ static void test_diag_288(void)
 
 static void test_diag_yield(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_diag_yield)[];
-	extern const char SNIPPET_NAME_END(asm, pv_diag_yield)[];
-	extern const char SNIPPET_HDR_START(asm, pv_diag_yield)[];
-	extern const char SNIPPET_HDR_END(asm, pv_diag_yield)[];
+	SNIPPET_DECLARE_PV(asm, pv_diag_yield);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_yield);
 	int size_gbin = SNIPPET_LEN(asm, pv_diag_yield);
 
diff --git a/s390x/pv-edat1.c b/s390x/pv-edat1.c
index ff762c75..05afbb41 100644
--- a/s390x/pv-edat1.c
+++ b/s390x/pv-edat1.c
@@ -36,10 +36,7 @@
 static struct vm vm;
 static pgd_t *root;
 
-extern const char SNIPPET_NAME_START(c, pv_memhog)[];
-extern const char SNIPPET_NAME_END(c, pv_memhog)[];
-extern const char SNIPPET_HDR_START(c, pv_memhog)[];
-extern const char SNIPPET_HDR_END(c, pv_memhog)[];
+SNIPPET_DECLARE_PV(c, pv_memhog);
 
 static void init_snippet(struct vm *vm) {
 	const unsigned long size_hdr = SNIPPET_HDR_LEN(c, pv_memhog);
diff --git a/s390x/pv-icptcode.c b/s390x/pv-icptcode.c
index bdef3a05..35bfde56 100644
--- a/s390x/pv-icptcode.c
+++ b/s390x/pv-icptcode.c
@@ -33,10 +33,7 @@ static struct vm vm, vm2;
  */
 static void test_validity_timing(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_icpt_vir_timing)[];
-	extern const char SNIPPET_NAME_END(asm, pv_icpt_vir_timing)[];
-	extern const char SNIPPET_HDR_START(asm, pv_icpt_vir_timing)[];
-	extern const char SNIPPET_HDR_END(asm, pv_icpt_vir_timing)[];
+	SNIPPET_DECLARE_PV(asm, pv_icpt_vir_timing);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_vir_timing);
 	int size_gbin = SNIPPET_LEN(asm, pv_icpt_vir_timing);
 	uint64_t time_exit, time_entry, tmp;
@@ -82,10 +79,7 @@ static void run_loop(void)
 
 static void test_validity_already_running(void)
 {
-	extern const char SNIPPET_NAME_START(asm, loop)[];
-	extern const char SNIPPET_NAME_END(asm, loop)[];
-	extern const char SNIPPET_HDR_START(asm, loop)[];
-	extern const char SNIPPET_HDR_END(asm, loop)[];
+	SNIPPET_DECLARE_PV(asm, loop);
 	int size_hdr = SNIPPET_HDR_LEN(asm, loop);
 	int size_gbin = SNIPPET_LEN(asm, loop);
 	struct psw psw = {
@@ -131,10 +125,7 @@ out:
 /* Tests if a vcpu handle from another configuration results in a validity intercept. */
 static void test_validity_handle_not_in_config(void)
 {
-	extern const char SNIPPET_NAME_START(asm, icpt_loop)[];
-	extern const char SNIPPET_NAME_END(asm, icpt_loop)[];
-	extern const char SNIPPET_HDR_START(asm, icpt_loop)[];
-	extern const char SNIPPET_HDR_END(asm, icpt_loop)[];
+	SNIPPET_DECLARE_PV(asm, icpt_loop);
 	int size_hdr = SNIPPET_HDR_LEN(asm, icpt_loop);
 	int size_gbin = SNIPPET_LEN(asm, icpt_loop);
 
@@ -173,10 +164,7 @@ static void test_validity_handle_not_in_config(void)
 /* Tests if a wrong vm or vcpu handle results in a validity intercept. */
 static void test_validity_seid(void)
 {
-	extern const char SNIPPET_NAME_START(asm, icpt_loop)[];
-	extern const char SNIPPET_NAME_END(asm, icpt_loop)[];
-	extern const char SNIPPET_HDR_START(asm, icpt_loop)[];
-	extern const char SNIPPET_HDR_END(asm, icpt_loop)[];
+	SNIPPET_DECLARE_PV(asm, icpt_loop);
 	int size_hdr = SNIPPET_HDR_LEN(asm, icpt_loop);
 	int size_gbin = SNIPPET_LEN(asm, icpt_loop);
 	int fails = 0;
@@ -224,10 +212,7 @@ static void test_validity_seid(void)
  */
 static void test_validity_asce(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_icpt_112)[];
-	extern const char SNIPPET_NAME_END(asm, pv_icpt_112)[];
-	extern const char SNIPPET_HDR_START(asm, pv_icpt_112)[];
-	extern const char SNIPPET_HDR_END(asm, pv_icpt_112)[];
+	SNIPPET_DECLARE_PV(asm, pv_icpt_112);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_112);
 	int size_gbin = SNIPPET_LEN(asm, pv_icpt_112);
 	uint64_t asce_old, asce_new;
@@ -311,10 +296,7 @@ static void run_icpt_122_tests_prefix(unsigned long prefix)
 
 static void test_icpt_112(void)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_icpt_112)[];
-	extern const char SNIPPET_NAME_END(asm, pv_icpt_112)[];
-	extern const char SNIPPET_HDR_START(asm, pv_icpt_112)[];
-	extern const char SNIPPET_HDR_END(asm, pv_icpt_112)[];
+	SNIPPET_DECLARE_PV(asm, pv_icpt_112);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_112);
 	int size_gbin = SNIPPET_LEN(asm, pv_icpt_112);
 
diff --git a/s390x/pv-ipl.c b/s390x/pv-ipl.c
index 1219573f..af2cfbcf 100644
--- a/s390x/pv-ipl.c
+++ b/s390x/pv-ipl.c
@@ -19,10 +19,7 @@ static struct vm vm;
 
 static void test_diag_308(int subcode)
 {
-	extern const char SNIPPET_NAME_START(asm, pv_diag_308)[];
-	extern const char SNIPPET_NAME_END(asm, pv_diag_308)[];
-	extern const char SNIPPET_HDR_START(asm, pv_diag_308)[];
-	extern const char SNIPPET_HDR_END(asm, pv_diag_308)[];
+	SNIPPET_DECLARE_PV(asm, pv_diag_308);
 	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_308);
 	int size_gbin = SNIPPET_LEN(asm, pv_diag_308);
 	uint16_t rc, rrc;
diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
index a5ff0872..46d20dab 100644
--- a/s390x/sie-dat.c
+++ b/s390x/sie-dat.c
@@ -63,8 +63,7 @@ static void test_sie_dat(void)
 
 static void setup_guest(void)
 {
-	extern const char SNIPPET_NAME_START(c, sie_dat)[];
-	extern const char SNIPPET_NAME_END(c, sie_dat)[];
+	SNIPPET_DECLARE(c, sie_dat);
 	uint64_t guest_max_addr;
 	pgd_t *root;
 
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index dd4ab77e..e79208df 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -21,8 +21,7 @@ static bool strict;
 
 static void setup_guest(void)
 {
-	extern const char SNIPPET_NAME_START(c, spec_ex)[];
-	extern const char SNIPPET_NAME_END(c, spec_ex)[];
+	SNIPPET_DECLARE(c, spec_ex);
 
 	setup_vm();
 
diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
index 3697e1ae..e3642078 100644
--- a/s390x/stfle-sie.c
+++ b/s390x/stfle-sie.c
@@ -20,8 +20,7 @@ static prng_state prng_s;
 
 static void setup_guest(void)
 {
-	extern const char SNIPPET_NAME_START(c, stfle)[];
-	extern const char SNIPPET_NAME_END(c, stfle)[];
+	SNIPPET_DECLARE(c, stfle);
 
 	setup_vm();
 	fac = alloc_pages_flags(0, AREA_DMA31);
-- 
2.53.0

