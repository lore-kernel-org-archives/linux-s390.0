Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B4230BF1;
	Tue,  6 May 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542084; cv=none; b=GSS4xSnZzPfrwh/6tFR9yFRs0jR/FVtP61ZzXK6yxslA+ChgIcMS4ar+VriY0t1AL4bUCwf9Nxr1C8sU+faC9OF30ff3/Sk5O6iFPS3QHj0ZoK4MTFaFgywmxB5Aq5zA388vLomZwLPVqrX9ZeF6DlXHvVXCs/NorxS2/31v6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542084; c=relaxed/simple;
	bh=PJ/A98zTFhbDmyeJfLx5VQQ15Kqp6FpAqBrQudnmT3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwWOciGnJ9x9u9MBarEOcHC3xcINVOsvSOiOaQAGMdvlY0gRlyIRmOC4ZaSRHfvfxVT/SrtmUC5sqGVYdjAvct34GwJnNUm9IaG7QIoQhZJCufmzHaxRWPuC84EzwJgcKe4MAzBwQhuuxjOFCRYibZzCZJuRxpF7Uj7N1bf1G7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QByLYebl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QByLYebl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546BfhC0014212;
	Tue, 6 May 2025 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dzBR/+qfdFMk0c8Aa
	JeFQ5l+BbLWcZ5nmAQZ9zLtQDM=; b=QByLYeblndeMkFTrFPtICrZuEBZT3BtF8
	zRFnvuplqldnZox7CMzosCyeFPDQ3ZM1GzdDJCMlEbHRpMphndJ7SMCLbw3Yb9pB
	IoNl1O8vw0cswa9KQgY27cRn+PG9YdDiZniHdDllZLRBQl9EAuVddP2WDFoHYxin
	+8luv4AemiteSO1Qu7XFgt0wZfazrt53p2YtC/tD/E/4TfFUW7ECwo2P9NsELpUK
	/0BbDpu8uyOBuG2f0At1tWWXdrA2nYjH5nwODc4YlXqnYVDmjes4owx9P5eAP+jw
	vFOmOkxvMWEU821PEKmy5C2noukDUqwhPNu3RUS3S0sbuaxgabFrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw3s04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546E5We6004309;
	Tue, 6 May 2025 14:34:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw3ryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546CJO7F004253;
	Tue, 6 May 2025 14:34:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb20j01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546EYYPC31326568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 14:34:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF5120065;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41CE42004E;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id F0FE2E09BA; Tue, 06 May 2025 16:34:33 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4 1/1] kasan: Avoid sleepable page allocation from atomic context
Date: Tue,  6 May 2025 16:34:33 +0200
Message-ID: <7d43dec252e2c7e62cfb3e2e28569de8b86cb3e5.1746541531.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1746541531.git.agordeev@linux.ibm.com>
References: <cover.1746541531.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzNiBTYWx0ZWRfX/zjZLngcZ6US kotPbBA2uY2erVGlovHf5GUu/TbwDOrQ6eFisROStP5OrixZORB2FiEAOb5f1XCd2fNc0CEjdbb hiLTv0bj6xy94UklVcsa4gm2P/eWOMVFu1poGG/XyCvI2cT1nsK8oHs8vEbVq+FaUor+C0qKcxt
 I7kWwQ6SgelZzPCySaFkBdYPEzjrWRh1A7d/PSEaCdH99/+/c3fm4ZtDc4BBSAaUtsh+IroouVJ hsugKElxXlqstgywgRR1s9cGCTb0bcMk149GiOSALcCJVeluhfrG3Kxury1E9lk2odDuUBwutF+ HtAPDDanMRMGsGNxfcE2gw3tlb7/pN0dno9SB5becVYD8BiQ2pu1R4LHtDDf3QayS/DgjxqOWb3
 Hm3k34zWiwAFwjXXcrV/4xzYToczLrkpZ5oik8/mbOe8wN6gbwiAZ2Rb+gXv4LNcLmDhcI7I
X-Proofpoint-ORIG-GUID: DNGHTKrGEiaGUDmykMvplCGYLuuAbheV
X-Proofpoint-GUID: WgPURwJLc5LYo0Q9X8XE4AgpNAql123R
X-Authority-Analysis: v=2.4 cv=IaaHWXqa c=1 sm=1 tr=0 ts=681a1dfd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5xA_3oZvIydUEubUgb0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=456 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060136

apply_to_pte_range() enters the lazy MMU mode and then invokes
kasan_populate_vmalloc_pte() callback on each page table walk
iteration. However, the callback can go into sleep when trying
to allocate a single page, e.g. if an architecutre disables
preemption on lazy MMU mode enter.

On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable()
and arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash
occurs:

    [  553.332108] preempt_count: 1, expected: 0
    [  553.332117] no locks held by multipathd/2116.
    [  553.332128] CPU: 24 PID: 2116 Comm: multipathd Kdump: loaded Tainted:
    [  553.332139] Hardware name: IBM 3931 A01 701 (LPAR)
    [  553.332146] Call Trace:
    [  553.332152]  [<00000000158de23a>] dump_stack_lvl+0xfa/0x150
    [  553.332167]  [<0000000013e10d12>] __might_resched+0x57a/0x5e8
    [  553.332178]  [<00000000144eb6c2>] __alloc_pages+0x2ba/0x7c0
    [  553.332189]  [<00000000144d5cdc>] __get_free_pages+0x2c/0x88
    [  553.332198]  [<00000000145663f6>] kasan_populate_vmalloc_pte+0x4e/0x110
    [  553.332207]  [<000000001447625c>] apply_to_pte_range+0x164/0x3c8
    [  553.332218]  [<000000001448125a>] apply_to_pmd_range+0xda/0x318
    [  553.332226]  [<000000001448181c>] __apply_to_page_range+0x384/0x768
    [  553.332233]  [<0000000014481c28>] apply_to_page_range+0x28/0x38
    [  553.332241]  [<00000000145665da>] kasan_populate_vmalloc+0x82/0x98
    [  553.332249]  [<00000000144c88d0>] alloc_vmap_area+0x590/0x1c90
    [  553.332257]  [<00000000144ca108>] __get_vm_area_node.constprop.0+0x138/0x260
    [  553.332265]  [<00000000144d17fc>] __vmalloc_node_range+0x134/0x360
    [  553.332274]  [<0000000013d5dbf2>] alloc_thread_stack_node+0x112/0x378
    [  553.332284]  [<0000000013d62726>] dup_task_struct+0x66/0x430
    [  553.332293]  [<0000000013d63962>] copy_process+0x432/0x4b80
    [  553.332302]  [<0000000013d68300>] kernel_clone+0xf0/0x7d0
    [  553.332311]  [<0000000013d68bd6>] __do_sys_clone+0xae/0xc8
    [  553.332400]  [<0000000013d68dee>] __s390x_sys_clone+0xd6/0x118
    [  553.332410]  [<0000000013c9d34c>] do_syscall+0x22c/0x328
    [  553.332419]  [<00000000158e7366>] __do_syscall+0xce/0xf0
    [  553.332428]  [<0000000015913260>] system_call+0x70/0x98

Instead of allocating single pages per-PTE, bulk-allocate the
shadow memory prior to applying kasan_populate_vmalloc_pte()
callback on a page range.

Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/kasan/shadow.c | 63 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 88d1c9dcb507..fac521b8a7e1 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -292,30 +292,63 @@ void __init __weak kasan_populate_early_vm_area_shadow(void *start,
 {
 }
 
+struct vmalloc_populate_data {
+	unsigned long start;
+	struct page **pages;
+};
+
 static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
-				      void *unused)
+				      void *_data)
 {
-	unsigned long page;
+	struct vmalloc_populate_data *data = _data;
+	struct page *page;
 	pte_t pte;
 
 	if (likely(!pte_none(ptep_get(ptep))))
 		return 0;
 
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
-	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
+	page = data->pages[PFN_DOWN(addr - data->start)];
+	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
+	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
 
 	spin_lock(&init_mm.page_table_lock);
-	if (likely(pte_none(ptep_get(ptep)))) {
+	if (likely(pte_none(ptep_get(ptep))))
 		set_pte_at(&init_mm, addr, ptep, pte);
-		page = 0;
-	}
 	spin_unlock(&init_mm.page_table_lock);
-	if (page)
-		free_page(page);
+
+	return 0;
+}
+
+static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+{
+	unsigned long nr_pages, nr_total = PFN_UP(end - start);
+	struct vmalloc_populate_data data;
+	int ret;
+
+	data.pages = (struct page **)__get_free_page(GFP_KERNEL);
+	if (!data.pages)
+		return -ENOMEM;
+
+	while (nr_total) {
+		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
+		__memset(data.pages, 0, nr_pages * sizeof(data.pages[0]));
+		if (nr_pages != alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages)) {
+			free_page((unsigned long)data.pages);
+			return -ENOMEM;
+		}
+
+		data.start = start;
+		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
+					  kasan_populate_vmalloc_pte, &data);
+		if (ret)
+			return ret;
+
+		start += nr_pages * PAGE_SIZE;
+		nr_total -= nr_pages;
+	}
+
+	free_page((unsigned long)data.pages);
+
 	return 0;
 }
 
@@ -348,9 +381,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = apply_to_page_range(&init_mm, shadow_start,
-				  shadow_end - shadow_start,
-				  kasan_populate_vmalloc_pte, NULL);
+	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
 	if (ret)
 		return ret;
 
-- 
2.45.2

