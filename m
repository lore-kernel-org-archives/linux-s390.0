Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482487;
	b=elj/SDiVRJwOufcrDrbD53yN+fklgj0N3Bca4rlXhD+UCwWTv1+awja8sKwtDa2PH1Kz
	 q1PbWICNnT3jzVl4na+Se8LyyfOoIkZ27U+ld1Nz6vAi+GfQHrFltIipL+nIGrY3MMfCV
	 2LZGktvoF4we+17oFNRwEHo3haDhMZ/2K9+N6n3q9PQyYjN7tsB5rlt02NV/adzvdRbID
	 pvLiOvT9YGBo1ZK0azHMT/bijD7liNWeIPh3XfVVKuufOXFcinIQR7Z/KN8RWhpsDP73W
	 rUJcOmlyZvy2ECqIHtOr7KQ9x/u1ivuOKzq1hZzwO5yHRLO6I7lcLl5ZZh+z1QlOxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482487;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=k+qapT6NU9MlPtKxWhA+ygMudV1yAAwINU3p5TORfok=;
	b=RQlwRGAUM86IlwPQeTkqNRaIoueeSrUV42y1jtargy+T+1RSd5Vp7pQ4fX0O53wNI9zJ
	 CAL9KzjqfNkAbbmk3mMiUY9b7By+0S7IgLsN4Ss7bacnabGznuLwZbdHj9t2cCNfl7Zx/
	 25ic5zdODkB/1ykbbpS2acnC4WMaxf6Ni0OKIaTgbZMIfRAd4BX7EQKa+x74ic33U6hI7
	 htOiXasKObuMr2KQXHiSDAPae8DC1pIq0dhkREelCHTX3B0ZnYXo543GxHbHx45InVmeM
	 8nLkPCnWxzVYTuCaKwpFr8ekaA2N/Kugi1hn54BKgpGFCJCN0iOgDM+Af7rQ806666A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFIrkNr6;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223E60A2620;
	Thu, 12 Nov 2026 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6223E60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFIrkNr6
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2jJWM2799054;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k+qapT6NU9MlPtKxW
	hA+ygMudV1yAAwINU3p5TORfok=; b=hFIrkNr6LB3qtwnpHaExJvlyHajpNVG76
	dDcEIqZhhzumHot1I4hIINvp7P5YmHfs3zE76RXF1FYYO6LYcxhhxVQAFa/HdufC
	YjheszOVB9cHAGHsKKLdHAzEQpb77XPzo/9Ns7k+atp0LvV0YcNak0tb64aCheyS
	kJeXI3wotDBfQLnGFRLAA8SsfS9H42BuHZQekilak3+zHyL/t2mOGM+jqen257qQ
	yYZIfEIBxPRuQSii/bP5X4f5/J3TBW1KoVIuaE6vU37L96IHy0pY2nTjMFAFVMVx
	Rd98AroyFnLbkUpPBLsZ8wB7fVSbSiFir0ytpDYy6ZXT1VleqX1pQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkxq5d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAlAFP676357;
	Thu, 12 Nov 2026 11:21:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0t83bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL64c29294978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 757082004B;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B6D2004E;
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
Subject: [PATCH v1 5/8] s390/kdump: Exclude crashkernel CMA memory from vmcore
Date: Thu, 12 Nov 2026 12:21:02 +0100
Message-ID: <20261112112105.1169118-6-zaslonko@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5a127 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=5hpF0e2snCNyji1aR44A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX5N7pui6ELIko
 LMTZGdK62deTXUKFbmO7FCo3N7+giuhPuKG9bgO/V05v1Unzvk76w/9eX1O8SLBP9edcX1k080D
 DcuIISmt2NpJvCDSYDH4h9q/pYXcp0OugQ3RVFJQNZTB6ibjyeaEaU4UWZCorvDT683uzwJTAzR
 iB2jg3nl7xSRdfl4HnLZN6NBPYo15qhEgPei5+qggUKrAekvQ4xi17abx3dvQbWa8efgyAIj5YU
 e5QEf7abEtQ6GzSs+OmwPnRCxAXKu2bfnjqTst+8KrfrmDc1j2T+hwj7RO7O89Gg444/aze6zFA
 9bC6akkTXc4b5M7CYSh86TYkYQ5/NmQ/hPDXL0KIny2njfEai26AW4U7QXWvPSRaotnAbTalhsm
 pLHTrg2vvsmgZHGjXzNhKZzmX41sb8+mf6OEtfZIP9Vy5WxPRyGNL/yso4aT4hu9t/dSkKc8RdL
 OMQBHCxFFnOR/nwhJ3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX5GgZiEOUJrHX
 N1KAGjJ7gtL182EWun4O5fjxU54CIXmQB+K8p/G+uRgzLe3oaRHkCy0ZIS3t8/IndTx4jHsBLsD
 j8W+9/3xxbBH4vtdy3jEQMcWVEpBufI=
X-Proofpoint-ORIG-GUID: -rR4R6wvfRyQLLFk8TVp7glioEgI78cg
X-Proofpoint-GUID: -rR4R6wvfRyQLLFk8TVp7glioEgI78cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

The kdump kernel will be using the crashkernel CMA memory of the
crashed kernel, so it must not be a part of the dump.

Keep the CMA ranges handed over by the crashed kernel in oldmem_data.
Add them to oldmem_type next to the crashkernel memory, so that no
PT_LOAD headers are created for them.

Merge adjacent regions, such as CMA areas placed back to back or next
to the crashkernel memory. Otherwise for_each_physmem_range() returns an
empty range between them, which ends up as an empty PT_LOAD header.

Use the original ranges even if mem= limits usable memory in the kdump
kernel. Build the list without depending on CONFIG_CMA in that kernel.

Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/boot/startup.c      |  1 +
 arch/s390/include/asm/setup.h |  1 +
 arch/s390/kernel/crash_dump.c | 48 ++++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 95543656d1b8..111b146a3332 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -529,6 +529,7 @@ void startup_kernel(void)
 		physmem_reserve(RR_INITRD, parmarea.initrd_start, parmarea.initrd_size);
 	oldmem_data.start = parmarea.oldmem_base;
 	oldmem_data.size = parmarea.oldmem_size;
+	memcpy(oldmem_data.crashk_cma, parmarea.crashk_cma, sizeof(oldmem_data.crashk_cma));
 
 	read_ipl_report();
 	sclp_early_read_info();
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 7e992f3953b1..7048985ec014 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -100,6 +100,7 @@ extern void (*_machine_power_off)(void);
 struct oldmem_data {
 	unsigned long start;
 	unsigned long size;
+	struct crashk_cma_range crashk_cma[CRASHK_CMA_ENTRIES];
 };
 extern struct oldmem_data oldmem_data;
 
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index d4839de8ce9d..f2f4a5f40d60 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <asm/asm-offsets.h>
 #include <asm/os_info.h>
+#include <asm/setup.h>
 #include <asm/elf.h>
 #include <asm/ipl.h>
 #include <asm/sclp.h>
@@ -29,13 +30,14 @@
 #define PTR_SUB(x, y) (((char *) (x)) - ((unsigned long) (y)))
 #define PTR_DIFF(x, y) ((unsigned long)(((char *) (x)) - ((unsigned long) (y))))
 
-static struct memblock_region oldmem_region;
+/* crashkernel memory and crashkernel CMA memory, sorted by address */
+static struct memblock_region oldmem_regions[1 + CRASHK_CMA_ENTRIES];
 
 static struct memblock_type oldmem_type = {
 	.cnt = 1,
-	.max = 1,
+	.max = ARRAY_SIZE(oldmem_regions),
 	.total_size = 0,
-	.regions = &oldmem_region,
+	.regions = oldmem_regions,
 	.name = "oldmem",
 };
 
@@ -478,6 +480,37 @@ static int get_cpu_cnt(void)
 	return cpus;
 }
 
+/* Exclude the original crashkernel and CMA reservations, independent of mem=. */
+static void oldmem_type_init(void)
+{
+	struct memblock_region *regions = oldmem_regions;
+	unsigned long base, size;
+	int i, j;
+
+	regions[0].base = oldmem_data.start;
+	regions[0].size = oldmem_data.size;
+	oldmem_type.cnt = 1;
+	oldmem_type.total_size = oldmem_data.size;
+	for (i = 0; i < ARRAY_SIZE(oldmem_data.crashk_cma) && oldmem_data.crashk_cma[i].size; i++) {
+		base = oldmem_data.crashk_cma[i].start;
+		size = oldmem_data.crashk_cma[i].size;
+		for (j = oldmem_type.cnt; j > 0 && regions[j - 1].base > base; j--)
+			regions[j] = regions[j - 1];
+		regions[j].base = base;
+		regions[j].size = size;
+		oldmem_type.cnt++;
+		oldmem_type.total_size += size;
+	}
+	/* memblock iterators expect separate regions, merge adjacent ones */
+	for (i = 1, j = 0; i < oldmem_type.cnt; i++) {
+		if (regions[j].base + regions[j].size == regions[i].base)
+			regions[j].size += regions[i].size;
+		else
+			regions[++j] = regions[i];
+	}
+	oldmem_type.cnt = j + 1;
+}
+
 /*
  * Return memory chunk count for ELF header (new kernel)
  */
@@ -626,12 +659,9 @@ int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
 	if (is_ipl_type_dump() && !sclp.hsa_size)
 		return -ENODEV;
 
-	/* For kdump, exclude previous crashkernel memory */
-	if (oldmem_data.start) {
-		oldmem_region.base = oldmem_data.start;
-		oldmem_region.size = oldmem_data.size;
-		oldmem_type.total_size = oldmem_data.size;
-	}
+	/* For kdump, exclude memory used by the kdump kernel */
+	if (oldmem_data.start)
+		oldmem_type_init();
 
 	mem_chunk_cnt = get_mem_chunk_cnt();
 	phdr_text_cnt = os_info_has_vm() ? 1 : 0;
-- 
2.55.0

