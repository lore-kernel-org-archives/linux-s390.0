Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AC43B6F5;
	Mon, 24 Aug 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582307; cv=none; b=kmitTGzYVZ/vYs2oblZt0RjIGwu1TXFgfqUCB4mq7XttEYnuPZTCcwxFpGtU4UaeDA2J04fBqCnF9vvHxEF8HWiBUReU8prKnq8X60Y2uju7q7PS018UfeVox7jfK+QTJeLxjZ8OI4vGU44cMQ6g+VfZUNfNk79aNJ3Sw/PT+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582307; c=relaxed/simple;
	bh=BBY0YCbnsG3DJImbjWxX1trtHfRO3bOVi1eqEVS3K6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWfkrVvk5uaEPJJ4AnF4rEkhzuF58fbj/YlzXIzxwLla8SMuxiZa72RybWULEsDPTTRPvxby9IjBXQVmOfGM2ySoGjxW7xP3Uq6Cm+99bldc99rPyBtUUUQ3pnG7WwEVZAWQG/7m7OsNbCJtwEefLTecUJe1EK+Kg2pg0pwCeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCHV0K0u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCHV0K0u"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1qdK1846127;
	Mon, 24 Aug 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/LVzZOo3tBkpcAdFW
	+8E/NZ+wmZknK2eadH1ahyy8ZQ=; b=aCHV0K0u6SGb0fviLisBNxvIHGXbsUejH
	G+0NbR4dLhS1g0LQ7xkWPHnupzANasUEAoTkKWj7yGYq1kjEZFmSfTRTaZKnAjY3
	e3qZb80zWQUV/dGP5aogSKI1X59q13CHWcbESf0gUS5RiiCTvXPu+Z5Rb/+dean5
	1skb/YnRNRHipQOUyQQ7VD+6LhA8Y6Wxll9LYL+KKXH5GpHAGbWQjMSgtVdOz+TC
	vhTDCPuV5qn8aQLc1lgcvdTo2OKBD8/DPug2EPPUoLFxVM4JFyEKZ0E1DWWAArkE
	FgapLrCoib19fSpfySSSE9LqAvkdqQGJZsgXzRCL4NKh0NhGxZV0A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hj7b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGvv030454;
	Mon, 24 Aug 2026 14:38:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxfg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcGX746072170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00B32004B;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAF42004E;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 03/13] lib: s390x: sie: Memory rework
Date: Mon, 24 Aug 2026 14:35:35 +0000
Message-ID: <20260824143740.291583-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX5AgkHy0+l/Td
 htiC4wgJKo5tvXk4A3WYl6IvfcSerufID96MPmdRRmlEr8F6ziFr5HVIg00Xpgv/mU5Q4SrPH33
 6uAT+dVjMNniew2iTVY2aoN/88Hm4bo=
X-Proofpoint-GUID: uH3ERkTKwuFc61CPMxAxlY5bmaGZ3Yx-
X-Proofpoint-ORIG-GUID: uH3ERkTKwuFc61CPMxAxlY5bmaGZ3Yx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX6EnXC8p1ua+n
 xnYe4wS8fNAyJf4Ty6+g/esTCs/ro+Wpo7/SPnYyR4V9hrDu7wG3GdgXVAIzeFolOUR8qFtQfC9
 hMdzds7hY44CKxOy2cr5b8VCdypKX5fQ85gAGeWEX+akB4+IE9Hw3PurchVZEQia4ciHTwkgYLm
 TsYR4DR8UNK1Efwlu2o8fYsDaKiLvomRICdQEtXMJk0HZa19blwqcsvPiKKANBX5bJ/ApC7WDsk
 AxKDEL8MVKVGSx8Luys+s9wbfcF+h7X3UkBSTE13V9ARxrARvqnKD8wfTmpEG4DUCMAclDRBew/
 YIjXZeh7AaJvKRMb1AxU0CK8D9OypcBEJOWot1FAkWwrgNSxsVi1BHU76La0UGszTBuJowoKu1M
 IQdJ6mCp8IOoDGUlthUs3IeT6tsvIuAUvdsA0pZZJdkBmzkSfB692BuUlhrlOpXEZnqKvyvD5HS
 wFj3qHjW10J4pn53FJQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=P5YABbDz-ArF3oV-gF0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

Make sie_guest_create() directly alloc the guest's memory.

Also we never freed the memory that the sie library allocates as the guest
ram on destruction of the VM. Most tests reuse the VM or just leak the
memory since the standard allocation is one megabyte and tests only
use single digit numbers of VMs.

It's time to add automatic freeing to the sie library when a VM is
destroyed.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sie.c     |  5 ++++-
 lib/s390x/sie.h     |  2 +-
 lib/s390x/snippet.h |  9 +++++----
 s390x/mvpg-sie.c    |  2 +-
 s390x/pv-diags.c    |  2 +-
 s390x/pv-icptcode.c |  4 ++--
 s390x/pv-ipl.c      |  2 +-
 s390x/sie-dat.c     |  2 +-
 s390x/sie.c         | 13 ++++---------
 s390x/spec_ex-sie.c |  2 ++
 s390x/stfle-sie.c   |  2 ++
 11 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 8757f610..ad1f2ade 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -122,8 +122,10 @@ void sie_guest_sca_create(struct vm *vm)
 }
 
 /* Initializes the struct vm members like the SIE control block. */
-void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_mem_len)
+void sie_guest_create(struct vm *vm, uint64_t guest_mem_len)
 {
+	void *guest_mem = sie_guest_alloc(guest_mem_len);
+
 	vm->sblk = alloc_page();
 	memset(vm->sblk, 0, PAGE_SIZE);
 	vm->sblk->cpuflags = CPUSTAT_ZARCH | CPUSTAT_RUNNING;
@@ -192,4 +194,5 @@ void sie_guest_destroy(struct vm *vm)
 	free_page(vm->sblk);
 	if (vm->sblk->ecb2 & ECB2_ESCA)
 		free_page(vm->sca);
+	free_pages((void *)virt_to_pte_phys(get_primary_page_root(), vm->guest_mem));
 }
diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
index 3ec49ed0..85d691d5 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/sie.h
@@ -59,7 +59,7 @@ static inline bool sie_is_pv(struct vm *vm)
 }
 
 void sie_guest_sca_create(struct vm *vm);
-void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_mem_len);
+void sie_guest_create(struct vm *vm, uint64_t guest_mem_len);
 void sie_guest_destroy(struct vm *vm);
 
 uint8_t *sie_guest_alloc(uint64_t guest_size);
diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa..94688f49 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -125,11 +125,8 @@ static inline void snippet_pv_init(struct vm *vm, const char *gbin,
 /* Allocates and sets up a snippet based guest */
 static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
 {
-	const unsigned long guest_size = SZ_1M;
-	uint8_t *guest_start = sie_guest_alloc(guest_size);
-
 	/* Initialize the vm struct and allocate control blocks */
-	sie_guest_create(vm, (uint64_t)guest_start, guest_size);
+	sie_guest_create(vm, SZ_1M);
 
 	if (is_pv) {
 		/* FMT4 needs a ESCA */
@@ -144,4 +141,8 @@ static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
 	}
 }
 
+static inline void snippet_destroy_guest(struct vm *vm)
+{
+	sie_guest_destroy(vm);
+}
 #endif
diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
index 920dee29..ac33923c 100644
--- a/s390x/mvpg-sie.c
+++ b/s390x/mvpg-sie.c
@@ -117,7 +117,7 @@ int main(void)
 	setup_guest();
 	test_mvpg();
 	test_mvpg_pei();
-	sie_guest_destroy(&vm);
+	snippet_destroy_guest(&vm);
 
 done:
 	report_prefix_pop();
diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index 09b83d59..b6f08dd2 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -156,7 +156,7 @@ int main(void)
 	test_diag_yield();
 	test_diag_288();
 	test_diag_500();
-	sie_guest_destroy(&vm);
+	snippet_destroy_guest(&vm);
 
 done:
 	report_prefix_pop();
diff --git a/s390x/pv-icptcode.c b/s390x/pv-icptcode.c
index 5293306b..bdef3a05 100644
--- a/s390x/pv-icptcode.c
+++ b/s390x/pv-icptcode.c
@@ -164,7 +164,7 @@ static void test_validity_handle_not_in_config(void)
 
 	/* Destroy the second vm, since we don't need it for further tests */
 	uv_destroy_guest(&vm2);
-	sie_guest_destroy(&vm2);
+	snippet_destroy_guest(&vm2);
 
 	uv_destroy_guest(&vm);
 	report_prefix_pop();
@@ -368,7 +368,7 @@ int main(void)
 	test_validity_handle_not_in_config();
 	test_validity_already_running();
 	test_validity_timing();
-	sie_guest_destroy(&vm);
+	snippet_destroy_guest(&vm);
 
 done:
 	report_prefix_pop();
diff --git a/s390x/pv-ipl.c b/s390x/pv-ipl.c
index 61a1e0c0..1219573f 100644
--- a/s390x/pv-ipl.c
+++ b/s390x/pv-ipl.c
@@ -135,7 +135,7 @@ int main(void)
 	snippet_setup_guest(&vm, true);
 	test_diag_308(0);
 	test_diag_308(1);
-	sie_guest_destroy(&vm);
+	snippet_destroy_guest(&vm);
 
 done:
 	report_prefix_pop();
diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
index e40e348f..a5ff0872 100644
--- a/s390x/sie-dat.c
+++ b/s390x/sie-dat.c
@@ -101,7 +101,7 @@ int main(void)
 
 	setup_guest();
 	test_sie_dat();
-	sie_guest_destroy(&vm);
+	snippet_destroy_guest(&vm);
 
 done:
 	report_prefix_pop();
diff --git a/s390x/sie.c b/s390x/sie.c
index ce5b6069..f08564b1 100644
--- a/s390x/sie.c
+++ b/s390x/sie.c
@@ -20,7 +20,6 @@
 #include <sclp.h>
 #include <sie.h>
 
-static u8 *guest;
 static u8 *guest_instr;
 static struct vm vm;
 
@@ -70,7 +69,7 @@ static void test_epoch_ext(void)
 		return;
 	}
 
-	guest[0] = 0x00;
+	vm.guest_mem[0] = 0x00;
 	memcpy(guest_instr, instr, sizeof(instr));
 
 	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
@@ -82,19 +81,15 @@ static void test_epoch_ext(void)
 	sie(&vm);
 
 	/* ... should result in the same epoch extension here: */
-	report(guest[0] == 0x47, "epdx: different epoch is visible in the guest");
+	report(vm.guest_mem[0] == 0x47, "epdx: different epoch is visible in the guest");
 }
 
 static void setup_guest(void)
 {
-	setup_vm();
-
-	guest = sie_guest_alloc(SZ_1M);
+	sie_guest_create(&vm, HPAGE_SIZE);
 
 	/* The first two pages are the lowcore */
-	guest_instr = guest + PAGE_SIZE * 2;
-
-	sie_guest_create(&vm, (uint64_t)guest, HPAGE_SIZE);
+	guest_instr = vm.guest_mem + PAGE_SIZE * 2;
 }
 
 int main(void)
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index fe2f23ee..6ab4144c 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -71,6 +71,8 @@ static void test_spec_ex_sie(void)
 		report_info("%s", msg);
 	else
 		report_info("Did not interpret initial exception");
+
+	snippet_destroy_guest(&vm);
 	report_prefix_pop();
 	report_prefix_pop();
 }
diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
index 21cf8ff8..8df1185c 100644
--- a/s390x/stfle-sie.c
+++ b/s390x/stfle-sie.c
@@ -133,6 +133,8 @@ int main(int argc, char **argv)
 	setup_guest();
 	if (run_format_0)
 		test_stfle_format_0();
+
+	snippet_destroy_guest(&vm);
 out:
 	return report_summary();
 }
-- 
2.53.0

