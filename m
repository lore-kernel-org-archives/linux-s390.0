Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482493;
	b=BqHP9CLH1/kJ/WCn0V8Lf7XtOio8BXa7RrBjkY3BbijUmQsKY8g2BIzMQ41DCVlFRvle
	 8MPdFuT3B0mYY7uFdJ00cKyRZ+8X9EtvQ8LF/Z9GTaDCf3ptDvYzv+SkrsCLBzTfyX7XP
	 QofXAYk5S/MW4WAti5sYy7tcLuzKzzQAddMBTEqqvGXoi32WBJlIUX+ll4p4xYMbFDyMs
	 SvGIRsS21HsgkYeX0F6HSsGB1gjq95w04Yd4XxdSZCGHO8nlWBpZG8MYNzS2RRQMeZCE5
	 /dxrUt+R/dY48Sa6FVO1nCjnp9Hg8to/Af7+gQuX50C/vXExFVxqTrdAax4wURrpAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7CYfyF4Jc5S14E/dtF1l+cNi98OxfxJDI1dIrOszOJc=;
	b=yKNQfNJXmBElLtsDlKwg7dCTg7z1E/nzcfcKCrguPHPB7dq05B2NicG7znnwi+71LSfc
	 NZ7qtmlkGrCQCpQtut/N2U153IXSIkUya7nBiKYGb6Rmh2YMO7cEXr5EWEWdjDLbIzQQm
	 xr0tErthMGepjtmAk/hXeiN7PJeLCdOjjFIPyqXo/pXB5be3znKQ93gsl1G0+CdNNUEAs
	 F10tX8Fg6IDis6IGUgqubIpvQprqgzp7839xUWnWzuVEnZ3SZLOYPbOM/FekbcwOfK7JG
	 7jJStfWjJ2DeFLNkMqwN3HKvaKI1oZy5EyTUUxJikW4txf/QIfEjkBsbQ4EkrMvlG1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Adk64o1h;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0624606F408;
	Thu, 12 Nov 2026 11:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0624606F408
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Adk64o1h
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2jNpt2799310;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7CYfyF4Jc5S14E/dt
	F1l+cNi98OxfxJDI1dIrOszOJc=; b=Adk64o1huXjQZ8oZm7DguueJB8sV182uM
	FMu341gIfKZGWqe4Ugj72WJGLaMR8fCTr+ld76H+7RViu+XcdxlPoEHw+DcCL0sw
	n/LpUbmdzAxN7VWoIsFw7Td1SAOIdvY1sSPlX2lumLCllrKKDzMi2nEBUkT6mJFI
	BkzJbNycxksm+3kQf6sel/vJj6aMKIGFlNIc88sk5fDPipMLqK5ytMpN05dLGuGx
	MWqfQAx5AoAoXONaN4OImGa3639dfFp435mk1gi/1dDFSQQH52CBCbMwkKfGI2kP
	vN1GIozhatErVdXdcCXDIR42LJwv0Ki/+S9w1wQEcevIaBIj/QqGg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkxq5c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8A3cU106755;
	Thu, 12 Nov 2026 11:21:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nt05mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL60p29294976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F8C20043;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124CF2004B;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/8] s390/boot: Allow additional usable memory ranges
Date: Thu, 12 Nov 2026 12:21:01 +0100
Message-ID: <20261112112105.1169118-5-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5a126 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nVhZzFuCDwILylrjLncA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX+LQP3I7f10Ga
 3hDELxwZGeuiCqg1MV0H3TsObeMaIUy6eIur0A02bux0u3HWmIX/pLI2IsFRTKReKDDRWsjTde8
 0kV//6Dx8tpGo3PzD/kiAslwmG2M2Ahrxcs22sb22eZd1xl6noC3ZWqWJrN2Qh2CbBJAmJ+K9gO
 JnF66qabngNLtV/euZQ6+/0PaIrnWDjWGiPxGud0ROwHG5Cpqpmd2ir9Jj7TpRMml73UKCr24er
 9kgLUsIc3d/SdfqpOFJkocp6yn9VDU8wJKcGXv+K44ts+cieHHRDBPcGr9+eyE5V5yDL1Oxluf+
 Jj1f1HspH3fXz/n8cgH1Gk8OqaLPlwNCFVh46tiXb8+SQoer1huo32uGam2YzfIiubX4g1wBpMv
 lO3T6SF6UZjoZubNJg2O/zGvU+0xl47/CP/eeJL4YurW3gymvHyG/kQISOztzwcSxVy6V1dT3rW
 oZkNQDWbdRYjCijfKSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX+1FqLv4UHGNz
 E+3XIuCXb3s1O11QVTCwg22ClkRa/SebYAmJuc+1ADEZoyG8ufgDA4AarDZpV0+BYi55do6NUQ4
 A2ki3+Ay01fMA1xqXVqpPU1j/5q2pRM=
X-Proofpoint-ORIG-GUID: rwJs9-xW5JheTyUlkkyI6Uy0bTBc7uaW
X-Proofpoint-GUID: rwJs9-xW5JheTyUlkkyI6Uy0bTBc7uaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

All online memory above the usable limit is left unused. A kdump kernel
will need a few ranges above that limit for the crashkernel CMA memory
of the crashed kernel.

Add physmem_add_usable_range() to register usable memory ranges. Clip
them to ident_map_size and merge overlapping or adjacent ranges.
for_each_physmem_usable_range() walks their intersection with the
online memory ranges.

Use the same ranges for boot allocations, identity mappings, KASAN
shadow and memblock. Keep the allocation position separate from the
usable ranges.

When no extra ranges are added, nothing changes.

Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/boot/boot.h                |  3 +-
 arch/s390/boot/kaslr.c               |  4 +-
 arch/s390/boot/physmem_info.c        | 65 ++++++++++++++++++++++++----
 arch/s390/boot/startup.c             |  3 +-
 arch/s390/boot/vmem.c                |  7 +--
 arch/s390/include/asm/physmem_info.h | 63 ++++++++++++++++++++-------
 arch/s390/kernel/setup.c             |  3 +-
 7 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/arch/s390/boot/boot.h b/arch/s390/boot/boot.h
index 61a205b489fb..39d5fc520c0c 100644
--- a/arch/s390/boot/boot.h
+++ b/arch/s390/boot/boot.h
@@ -44,7 +44,8 @@ struct vmlinux_info {
 void startup_kernel(void);
 unsigned long detect_max_physmem_end(void);
 void detect_physmem_online_ranges(unsigned long max_physmem_end);
-void physmem_set_usable_limit(unsigned long limit);
+void physmem_set_alloc_limit(unsigned long limit);
+void physmem_add_usable_range(unsigned long start, unsigned long end);
 void physmem_reserve(enum reserved_range_type type, unsigned long addr, unsigned long size);
 void physmem_free(enum reserved_range_type type);
 /* for continuous/multiple allocations per type */
diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
index 941f4c9e27cc..f2de79a69031 100644
--- a/arch/s390/boot/kaslr.c
+++ b/arch/s390/boot/kaslr.c
@@ -112,11 +112,11 @@ static unsigned long iterate_valid_positions(unsigned long size, unsigned long a
 	unsigned long start, end, tmp_end, range_pos, pos = 0;
 	struct reserved_range *res_end = res + res_count;
 	struct reserved_range *skip_res;
-	int i;
+	struct physmem_iter iter;
 
 	align = max(align, 8UL);
 	_min = round_up(_min, align);
-	for_each_physmem_usable_range(i, &start, &end) {
+	for_each_physmem_usable_range(iter, &start, &end) {
 		if (_min >= end)
 			continue;
 		start = round_up(start, align);
diff --git a/arch/s390/boot/physmem_info.c b/arch/s390/boot/physmem_info.c
index e5248b637326..c9888d1669e3 100644
--- a/arch/s390/boot/physmem_info.c
+++ b/arch/s390/boot/physmem_info.c
@@ -195,19 +195,44 @@ void detect_physmem_online_ranges(unsigned long max_physmem_end)
 		boot_debug(" online [%d]:   0x%016lx-0x%016lx\n", i, start, end);
 }
 
-void physmem_set_usable_limit(unsigned long limit)
+void physmem_set_alloc_limit(unsigned long limit)
 {
-	physmem_info.usable = limit;
 	physmem_alloc_pos = limit;
-	boot_debug("Usable memory limit: 0x%016lx\n", limit);
+	boot_debug("Upper alloc limit: 0x%016lx\n", limit);
+}
+
+/*
+ * Add usable memory ranges, merging overlapping or adjacent ranges.
+ * The kdump code passes CMA ranges sorted by start address.
+ */
+void physmem_add_usable_range(unsigned long start, unsigned long end)
+{
+	struct physmem_range *range;
+	u32 n = physmem_info.usable_count;
+
+	boot_debug("Usable memory range: 0x%016lx-0x%016lx\n", start, end);
+	end = min(end, ident_map_size);
+	if (start >= end)
+		return;
+	if (n) {
+		range = &physmem_info.usable[n - 1];
+		if (start <= range->end) {
+			range->end = max_t(u64, range->end, end);
+			return;
+		}
+	}
+	range = &physmem_info.usable[n];
+	range->start = start;
+	range->end = end;
+	physmem_info.usable_count++;
 }
 
 static void die_oom(unsigned long size, unsigned long align, unsigned long min, unsigned long max)
 {
 	unsigned long start, end, total_mem = 0, total_reserved_mem = 0;
 	struct reserved_range *range;
+	struct physmem_iter iter;
 	enum reserved_range_type t;
-	int i;
 
 	boot_emerg("Linux version %s\n", kernel_version);
 	if (!is_prot_virt_guest() && early_command_line[0])
@@ -221,7 +246,7 @@ static void die_oom(unsigned long size, unsigned long align, unsigned long min,
 	}
 	boot_emerg("Usable online memory ranges (info source: %s [%d]):\n",
 		   get_physmem_info_source(), physmem_info.info_source);
-	for_each_physmem_usable_range(i, &start, &end) {
+	for_each_physmem_usable_range(iter, &start, &end) {
 		boot_emerg("%016lx %016lx\n", start, end);
 		total_mem += end - start;
 	}
@@ -269,6 +294,26 @@ static bool __physmem_alloc_intersects(unsigned long addr, unsigned long size,
 	return ipl_report_certs_intersects(addr, size, intersection_start);
 }
 
+/* Find the highest usable part of an online range below max. */
+static int __get_physmem_alloc_range(u32 n, unsigned long max,
+				     unsigned long *start, unsigned long *end)
+{
+	unsigned long online_start, online_end;
+	struct physmem_range *range;
+	u32 i = physmem_info.usable_count;
+
+	__get_physmem_online_range(n, &online_start, &online_end);
+	online_end = min(online_end, max);
+	while (i) {
+		range = &physmem_info.usable[--i];
+		*start = max_t(unsigned long, online_start, range->start);
+		*end = min_t(unsigned long, online_end, range->end);
+		if (*start < *end)
+			return 0;
+	}
+	return -1;
+}
+
 static unsigned long __physmem_alloc_range(unsigned long size, unsigned long align,
 					   unsigned long min, unsigned long max,
 					   unsigned int from_ranges, unsigned int *ranges_left,
@@ -281,14 +326,18 @@ static unsigned long __physmem_alloc_range(unsigned long size, unsigned long ali
 
 	align = max(align, 8UL);
 	while (nranges) {
-		__get_physmem_range(nranges - 1, &range_start, &range_end, false);
-		pos = min(range_end, pos);
+		if (__get_physmem_alloc_range(nranges - 1, pos, &range_start, &range_end)) {
+			nranges--;
+			continue;
+		}
+		pos = range_end;
 
 		if (round_up(min, align) + size > pos)
 			break;
 		addr = round_down(pos - size, align);
 		if (range_start > addr) {
-			nranges--;
+			/* A lower usable range may fit within the same online range. */
+			pos = range_start;
 			continue;
 		}
 		if (__physmem_alloc_intersects(addr, size, &intersection_start)) {
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 5eb7a3e1f9f1..95543656d1b8 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -545,7 +545,8 @@ void startup_kernel(void)
 	setup_vmalloc_size();
 	asce_limit = setup_kernel_memory_layout(kernel_size);
 	/* got final ident_map_size, physmem allocations could be performed now */
-	physmem_set_usable_limit(ident_map_size);
+	physmem_add_usable_range(0, ident_map_size);
+	physmem_set_alloc_limit(ident_map_size);
 	detect_physmem_online_ranges(max_physmem_end);
 	save_ipl_cert_comp_list();
 	rescue_initrd(safe_addr, ident_map_size);
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index ff6d58a476ba..a4fb8254f156 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -99,8 +99,8 @@ static void kasan_populate_shadow(unsigned long kernel_start, unsigned long kern
 	pud_t pud_z = __pud(__pa(kasan_early_shadow_pmd) | _REGION3_ENTRY);
 	p4d_t p4d_z = __p4d(__pa(kasan_early_shadow_pud) | _REGION2_ENTRY);
 	unsigned long memgap_start = 0;
+	struct physmem_iter iter;
 	unsigned long start, end;
-	int i;
 
 	pte_z = __pte(__pa(kasan_early_shadow_page) | pgprot_val(PAGE_KERNEL_RO));
 	crst_table_init((unsigned long *)kasan_early_shadow_p4d, p4d_val(p4d_z));
@@ -112,7 +112,7 @@ static void kasan_populate_shadow(unsigned long kernel_start, unsigned long kern
 	__arch_set_page_dat(kasan_early_shadow_pmd, 1UL << CRST_ALLOC_ORDER);
 	__arch_set_page_dat(kasan_early_shadow_pte, 1);
 
-	for_each_physmem_usable_range(i, &start, &end) {
+	for_each_physmem_usable_range(iter, &start, &end) {
 		kasan_populate((unsigned long)__identity_va(start),
 			       (unsigned long)__identity_va(end),
 			       POPULATE_KASAN_MAP_SHADOW);
@@ -473,6 +473,7 @@ void setup_vmem(unsigned long kernel_start, unsigned long kernel_end, unsigned l
 	unsigned long start, end;
 	unsigned long asce_type;
 	unsigned long asce_bits;
+	struct physmem_iter iter;
 	pgd_t *init_mm_pgd;
 	int i;
 
@@ -518,7 +519,7 @@ void setup_vmem(unsigned long kernel_start, unsigned long kernel_end, unsigned l
 	pgtable_populate(lowcore_address,
 			 lowcore_address + sizeof(struct lowcore),
 			 POPULATE_LOWCORE);
-	for_each_physmem_usable_range(i, &start, &end) {
+	for_each_physmem_usable_range(iter, &start, &end) {
 		/* Do not map lowcore with identity mapping */
 		if (!start)
 			start = sizeof(struct lowcore);
diff --git a/arch/s390/include/asm/physmem_info.h b/arch/s390/include/asm/physmem_info.h
index 7ef3bbec98b0..c6f9f2f5d26b 100644
--- a/arch/s390/include/asm/physmem_info.h
+++ b/arch/s390/include/asm/physmem_info.h
@@ -2,8 +2,10 @@
 #ifndef _ASM_S390_MEM_DETECT_H
 #define _ASM_S390_MEM_DETECT_H
 
+#include <linux/minmax.h>
 #include <linux/types.h>
 #include <asm/page.h>
+#include <asm/setup.h>
 
 enum physmem_info_source {
 	MEM_DETECT_NONE = 0,
@@ -47,21 +49,26 @@ struct reserved_range {
  */
 #define MEM_INLINED_ENTRIES 255 /* (PAGE_SIZE - 16) / 16 */
 
+/* Primary memory and the handed-over crashkernel CMA ranges. */
+#define MEM_USABLE_ENTRIES (1 + CRASHK_CMA_ENTRIES)
+
 struct physmem_info {
 	u32 range_count;
 	u8 info_source;
-	unsigned long usable;
 	struct reserved_range reserved[RR_MAX];
 	struct physmem_range online[MEM_INLINED_ENTRIES];
 	struct physmem_range *online_extended;
+	/* Sorted usable ranges, intersected with online memory when iterating. */
+	u32 usable_count;
+	struct physmem_range usable[MEM_USABLE_ENTRIES];
 };
 
 extern struct physmem_info physmem_info;
 
 void add_physmem_online_range(u64 start, u64 end);
 
-static inline int __get_physmem_range(u32 n, unsigned long *start,
-				      unsigned long *end, bool respect_usable_limit)
+static inline int __get_physmem_online_range(u32 n, unsigned long *start,
+					     unsigned long *end)
 {
 	if (n >= physmem_info.range_count) {
 		*start = 0;
@@ -77,29 +84,53 @@ static inline int __get_physmem_range(u32 n, unsigned long *start,
 		*end = (unsigned long)physmem_info.online_extended[n - MEM_INLINED_ENTRIES].end;
 	}
 
-	if (respect_usable_limit && physmem_info.usable) {
-		if (*start >= physmem_info.usable)
-			return -1;
-		if (*end > physmem_info.usable)
-			*end = physmem_info.usable;
-	}
 	return 0;
 }
 
+struct physmem_iter {
+	u32 online;
+	u32 usable;
+};
+
+static inline int __next_physmem_usable_range(struct physmem_iter *iter,
+					      unsigned long *start, unsigned long *end)
+{
+	unsigned long online_start, online_end, usable_start, usable_end;
+
+	while (iter->usable < physmem_info.usable_count) {
+		if (__get_physmem_online_range(iter->online, &online_start, &online_end))
+			break;
+		usable_start = physmem_info.usable[iter->usable].start;
+		usable_end = physmem_info.usable[iter->usable].end;
+		if (online_end <= usable_end)
+			iter->online++;
+		if (usable_end <= online_end)
+			iter->usable++;
+		*start = max(online_start, usable_start);
+		*end = min(online_end, usable_end);
+		if (*start < *end)
+			return 0;
+	}
+	*start = 0;
+	*end = 0;
+	return -1;
+}
+
 /**
- * for_each_physmem_usable_range - early online memory range iterator
- * @i: an integer used as loop variable
+ * for_each_physmem_usable_range - early usable memory range iterator
+ * @iter: a struct physmem_iter used as loop cursor
  * @p_start: ptr to unsigned long for start address of the range
  * @p_end: ptr to unsigned long for end address of the range
  *
- * Walks over detected online memory ranges below usable limit.
+ * Walks over the intersection of detected online memory and usable ranges.
  */
-#define for_each_physmem_usable_range(i, p_start, p_end)		\
-	for (i = 0; !__get_physmem_range(i, p_start, p_end, true); i++)
+#define for_each_physmem_usable_range(iter, p_start, p_end)		\
+	for (iter = (struct physmem_iter) { 0 };				\
+	     !__next_physmem_usable_range(&iter, p_start, p_end);)
 
-/* Walks over all detected online memory ranges disregarding usable limit. */
+/* Walks over all detected online memory ranges. */
 #define for_each_physmem_online_range(i, p_start, p_end)		\
-	for (i = 0; !__get_physmem_range(i, p_start, p_end, false); i++)
+	for (i = 0; !__get_physmem_online_range(i, p_start, p_end); i++)
 
 static inline const char *get_physmem_info_source(void)
 {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 3c1c66e6c281..9ec9dfc06761 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -712,6 +712,7 @@ static void __init free_physmem_info(void)
 
 static void __init memblock_add_physmem_info(void)
 {
+	struct physmem_iter iter;
 	unsigned long start, end;
 	int i;
 
@@ -719,7 +720,7 @@ static void __init memblock_add_physmem_info(void)
 		 get_physmem_info_source(), physmem_info.info_source);
 	/* keep memblock lists close to the kernel */
 	memblock_set_bottom_up(true);
-	for_each_physmem_usable_range(i, &start, &end)
+	for_each_physmem_usable_range(iter, &start, &end)
 		memblock_add(start, end - start);
 	for_each_physmem_online_range(i, &start, &end)
 		memblock_physmem_add(start, end - start);
-- 
2.55.0

