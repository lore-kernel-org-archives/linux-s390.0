Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0339EF2C;
	Tue,  1 Sep 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272759; cv=none; b=HVWMCLRgg6nPi5lUtQFaOe+PjRjgAwHxPaAxBfEce8rpBPsE5SUgKNuDGPQWs1DE6mdaJDt+RPy6q3AVV+zNrg5kMM3vyOmvggfawJGmEqZtMhTG3QgrA8/ZBmyyoz5Eq7xCNDK6eXhHoyPBTXb2S8WBbYvW4NKHcvO5dXVfBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272759; c=relaxed/simple;
	bh=h+9VPOXV0Mli9gX0Ujy7ZsLn8GQB9x3Bzt812QCmhLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRcYF/KotReh28ATBKkaq5QBB1uv1dD3nx5qz+eVk2WwG+Ynur6vByLd0P7IrLSUCJVH7D6oJfPicyHTlPmiTfIGCzqh1J5O0HJn1brGZwXO0hTF1XZtfUwpwmhoWKVahjpg3HPV7rPahVhPPTEdaxPSL4uM0H0c25qyMaXwlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vj66M+Su; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vj66M+Su"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVduQ196910;
	Tue, 1 Sep 2026 14:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zR+9xY6JxRA+W7Bwg
	Gt0BNoY/yODEGn+/Vyj82H71Wg=; b=Vj66M+Su/3A44JDG8/nqmK2pQcUVqgLb5
	49ewQ7YPKaFq2SsIjBbQSFVJsHAM2UdazyN+vn5IuQ6eMwbnCID+o6OnyDe0TvHl
	XuiYuGpD9FQtxfbH+oe0XuisRAPXsEIcPfvPUvaqwicSVzDVbxI4RUNfQl6q1rnJ
	J8hCtHHIU7BC40vFHktEuOrT7jdVU/+NgLNlTFsz0al2WGBna9dkU78shsmC+Lqh
	RdoztGpHH+IDV0jI7FY5ULjuMhIEKaYl/IDkJcDODV/hj+T21RQHBpSrB7kpW4fQ
	5JMxfPp0NiCSNuwSzFuqDjl9ah9tp61CaTnQGKMqb/VGMPn/0YqzA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudr8ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBeN6010545;
	Tue, 1 Sep 2026 14:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqcat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EPp9n50987454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:25:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B92A2004D;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A842004B;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH 2/2] lib: s390x: snippet: Add setup macro
Date: Tue,  1 Sep 2026 14:20:26 +0000
Message-ID: <20260901142538.42553-3-frankja@linux.ibm.com>
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
X-Proofpoint-GUID: ViAnC66Pm3HQA1IJHVe2qSuNeehz72C0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX+0g9zlKrCjIE
 GLCvfT60++BQ0uV8pz4areaNQdudInrhLXLN5GyEbpGmdiN6xg/GQdSz2gOpT1mLk2RoRGx7AkS
 q4ffC42voji6w32ZxXejkSGzI4DfnVV0EM1C/Q+CIkoTHfOzHPnHqllmVKlwuZa8U959UQgNAQ9
 q7I51Uk9VMvopWEHkh43pWwBv/4YT7zgHJPUMOL35kPEl2C8jl+IMi+Alfo+J+vlneJubB0mpsS
 sKQ1J97hRMfZ1xuBchuuUNlFqUHTGR0Z7eBTGg2yPZtkH4WY/wr/uLGxUz7ZRP+1DMNfoMh0cHt
 QoH9W4HLkKb2QG5+lPvzC1zUoX1us1B/7lwYCCkiumcawud55r8vdgRu8cSoOwcZfL7NQ0NzSfM
 3rs4WISi0tfs2rK0d4Afenz6/VrUsLZDw8SQ8CrBBhXYLVAzemDPa6JZPbUBAD83q7kNRvQJYon
 y1Xn+K0pd04wIy8vE4w==
X-Proofpoint-ORIG-GUID: ViAnC66Pm3HQA1IJHVe2qSuNeehz72C0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXyH0WIXh5GY07
 kWfWnxs6SwC0OQjV7twrMVVxNleBtYGlH1+vhPP933VArl5UcI28XM6k+R4ldJrwbjyzx9e5bxB
 C49TJ7njZzx3AM66EpHu0hsn/VK8JzQ=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a96e074 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZFv_3fxanNfayzl6hBUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010124

SNIPPET_SETUP() takes care of guest setup and snippet initialization.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h | 18 ++++++++++++++++++
 s390x/pv-diags.c    | 18 +++---------------
 s390x/pv-edat1.c    |  7 +------
 s390x/pv-icptcode.c | 42 ++++++++----------------------------------
 s390x/pv-ipl.c      |  7 ++-----
 s390x/spec_ex-sie.c |  7 +------
 s390x/stfle-sie.c   |  4 +---
 7 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 6f82a873..0ff7ad7d 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -39,6 +39,24 @@
 	extern const char SNIPPET_HDR_START(type, file)[];	\
 	extern const char SNIPPET_HDR_END(type, file)[]
 
+#define SNIPPET_SETUP_PV(vm, type, file)			\
+do {								\
+	snippet_setup_guest(vm, true);				\
+	snippet_pv_init(vm,					\
+			SNIPPET_NAME_START(type, file),		\
+			SNIPPET_HDR_START(type, file),		\
+			SNIPPET_LEN(type, file),		\
+			SNIPPET_HDR_LEN(type, file),		\
+			0);					\
+} while (0)
+
+#define SNIPPET_SETUP(vm, type, file)				\
+do {								\
+	snippet_setup_guest(vm, false);				\
+	snippet_init(vm, SNIPPET_NAME_START(type, file),	\
+		     SNIPPET_LEN(type, file), 0);		\
+} while (0)
+
 /*
  * Some of the UV memory needs to be allocated with >31 bit
  * addresses which means we need a lot more memory than other
diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index e7cc0e85..a5f32954 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -19,14 +19,10 @@ static struct vm vm;
 static void test_diag_500(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_diag_500);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_500);
-	int size_gbin = SNIPPET_LEN(asm, pv_diag_500);
 
 	report_prefix_push("diag 0x500");
 
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_diag_500),
-			SNIPPET_HDR_START(asm, pv_diag_500),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, pv_diag_500);
 
 	sie(&vm);
 	report(sie_is_diag_icpt(&vm, 0x500), "intercept values");
@@ -67,14 +63,10 @@ static void test_diag_500(void)
 static void test_diag_288(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_diag_288);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_288);
-	int size_gbin = SNIPPET_LEN(asm, pv_diag_288);
 
 	report_prefix_push("diag 0x288");
 
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_diag_288),
-			SNIPPET_HDR_START(asm, pv_diag_288),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, pv_diag_288);
 
 	sie(&vm);
 	report(vm.sblk->icptcode == ICPT_PV_INSTR && vm.sblk->ipa == 0x8302 &&
@@ -105,14 +97,10 @@ static void test_diag_288(void)
 static void test_diag_yield(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_diag_yield);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_yield);
-	int size_gbin = SNIPPET_LEN(asm, pv_diag_yield);
 
 	report_prefix_push("diag yield");
 
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_diag_yield),
-			SNIPPET_HDR_START(asm, pv_diag_yield),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, pv_diag_yield);
 
 	/* 0x44 */
 	report_prefix_push("0x44");
diff --git a/s390x/pv-edat1.c b/s390x/pv-edat1.c
index 05afbb41..5dc1f42c 100644
--- a/s390x/pv-edat1.c
+++ b/s390x/pv-edat1.c
@@ -39,12 +39,7 @@ static pgd_t *root;
 SNIPPET_DECLARE_PV(c, pv_memhog);
 
 static void init_snippet(struct vm *vm) {
-	const unsigned long size_hdr = SNIPPET_HDR_LEN(c, pv_memhog);
-	const unsigned long size_gbin = SNIPPET_LEN(c, pv_memhog);
-
-	snippet_pv_init(vm, SNIPPET_NAME_START(c, pv_memhog),
-			SNIPPET_HDR_START(c, pv_memhog),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(vm, c, pv_memhog);
 }
 
 static uint64_t tod_to_us(uint64_t tod)
diff --git a/s390x/pv-icptcode.c b/s390x/pv-icptcode.c
index 35bfde56..71baef2f 100644
--- a/s390x/pv-icptcode.c
+++ b/s390x/pv-icptcode.c
@@ -34,14 +34,11 @@ static struct vm vm, vm2;
 static void test_validity_timing(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_icpt_vir_timing);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_vir_timing);
-	int size_gbin = SNIPPET_LEN(asm, pv_icpt_vir_timing);
 	uint64_t time_exit, time_entry, tmp;
 
 	report_prefix_push("manipulated cpu time");
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_icpt_vir_timing),
-			SNIPPET_HDR_START(asm, pv_icpt_vir_timing),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+
+	SNIPPET_SETUP_PV(&vm, asm, pv_icpt_vir_timing);
 
 	sie(&vm);
 	report(sie_is_diag_icpt(&vm, 0x44), "spt done");
@@ -80,8 +77,6 @@ static void run_loop(void)
 static void test_validity_already_running(void)
 {
 	SNIPPET_DECLARE_PV(asm, loop);
-	int size_hdr = SNIPPET_HDR_LEN(asm, loop);
-	int size_gbin = SNIPPET_LEN(asm, loop);
 	struct psw psw = {
 		.mask = PSW_MASK_64,
 		.addr = (uint64_t)run_loop,
@@ -93,9 +88,7 @@ static void test_validity_already_running(void)
 		goto out;
 	}
 
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, loop),
-			SNIPPET_HDR_START(asm, loop),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, loop);
 
 	smp_cpu_setup(1, psw);
 	sie_expect_validity(&vm);
@@ -126,20 +119,13 @@ out:
 static void test_validity_handle_not_in_config(void)
 {
 	SNIPPET_DECLARE_PV(asm, icpt_loop);
-	int size_hdr = SNIPPET_HDR_LEN(asm, icpt_loop);
-	int size_gbin = SNIPPET_LEN(asm, icpt_loop);
 
 	report_prefix_push("handle not in config");
 	/* Setup our primary vm */
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, icpt_loop),
-			SNIPPET_HDR_START(asm, icpt_loop),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, icpt_loop);
 
 	/* Setup secondary vm */
-	snippet_setup_guest(&vm2, true);
-	snippet_pv_init(&vm2, SNIPPET_NAME_START(asm, icpt_loop),
-			SNIPPET_HDR_START(asm, icpt_loop),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm2, asm, icpt_loop);
 
 	vm.sblk->pv_handle_cpu = vm2.sblk->pv_handle_cpu;
 	sie_expect_validity(&vm);
@@ -165,15 +151,11 @@ static void test_validity_handle_not_in_config(void)
 static void test_validity_seid(void)
 {
 	SNIPPET_DECLARE_PV(asm, icpt_loop);
-	int size_hdr = SNIPPET_HDR_LEN(asm, icpt_loop);
-	int size_gbin = SNIPPET_LEN(asm, icpt_loop);
 	int fails = 0;
 	int i;
 
 	report_prefix_push("handles");
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, icpt_loop),
-			SNIPPET_HDR_START(asm, icpt_loop),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, icpt_loop);
 
 	for (i = 0; i < 64; i++) {
 		vm.sblk->pv_handle_config ^= 1UL << i;
@@ -213,15 +195,11 @@ static void test_validity_seid(void)
 static void test_validity_asce(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_icpt_112);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_112);
-	int size_gbin = SNIPPET_LEN(asm, pv_icpt_112);
 	uint64_t asce_old, asce_new;
 	void *pgd_new, *pgd_old;
 
 	report_prefix_push("asce");
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_icpt_112),
-			SNIPPET_HDR_START(asm, pv_icpt_112),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, pv_icpt_112);
 
 	asce_old = vm.save_area.guest.asce;
 	pgd_new = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE * 4, 0);
@@ -297,16 +275,12 @@ static void run_icpt_122_tests_prefix(unsigned long prefix)
 static void test_icpt_112(void)
 {
 	SNIPPET_DECLARE_PV(asm, pv_icpt_112);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_icpt_112);
-	int size_gbin = SNIPPET_LEN(asm, pv_icpt_112);
 
 	unsigned long lc_off = 0;
 
 	report_prefix_push("prefix");
 
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_icpt_112),
-			SNIPPET_HDR_START(asm, pv_icpt_112),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP_PV(&vm, asm, pv_icpt_112);
 
 	/* Setup of the guest's state for 0x0 prefix */
 	sie(&vm);
diff --git a/s390x/pv-ipl.c b/s390x/pv-ipl.c
index af2cfbcf..8affeb1c 100644
--- a/s390x/pv-ipl.c
+++ b/s390x/pv-ipl.c
@@ -20,15 +20,12 @@ static struct vm vm;
 static void test_diag_308(int subcode)
 {
 	SNIPPET_DECLARE_PV(asm, pv_diag_308);
-	int size_hdr = SNIPPET_HDR_LEN(asm, pv_diag_308);
-	int size_gbin = SNIPPET_LEN(asm, pv_diag_308);
 	uint16_t rc, rrc;
 	int cc;
 
 	report_prefix_pushf("subcode %d", subcode);
-	snippet_pv_init(&vm, SNIPPET_NAME_START(asm, pv_diag_308),
-			SNIPPET_HDR_START(asm, pv_diag_308),
-			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
+
+	SNIPPET_SETUP_PV(&vm, asm, pv_diag_308);
 
 	/* First exit is a diag 0x500 */
 	sie(&vm);
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index e79208df..102f0345 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -22,12 +22,7 @@ static bool strict;
 static void setup_guest(void)
 {
 	SNIPPET_DECLARE(c, spec_ex);
-
-	setup_vm();
-
-	snippet_setup_guest(&vm, false);
-	snippet_init(&vm, SNIPPET_NAME_START(c, spec_ex),
-		     SNIPPET_LEN(c, spec_ex), SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP(&vm, c, spec_ex);
 }
 
 static void test_spec_ex_sie(void)
diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
index e3642078..178c6815 100644
--- a/s390x/stfle-sie.c
+++ b/s390x/stfle-sie.c
@@ -25,9 +25,7 @@ static void setup_guest(void)
 	setup_vm();
 	fac = alloc_pages_flags(0, AREA_DMA31);
 
-	snippet_setup_guest(&vm, false);
-	snippet_init(&vm, SNIPPET_NAME_START(c, stfle),
-		     SNIPPET_LEN(c, stfle), SNIPPET_UNPACK_OFF);
+	SNIPPET_SETUP(&vm, c, stfle);
 }
 
 struct guest_stfle_res {
-- 
2.53.0

