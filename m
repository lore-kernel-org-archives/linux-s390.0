Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE9281375;
	Wed,  7 May 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622097; cv=none; b=hNhHDwAbtNE4jovSD8z00pQFpB4AVR2dli59DNScQ0T8KAcPYvAK/1x32GmFvnWifkZNhTPEtAgBjSVohEgYFTXC+4Y+rB17B0cSQdYqtplG4Ua3Nwmfp1mO6DhGAgK1tp9MZ0g7RA46xD9H3NQeJXcnpZvj36r/54dVYMtf0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622097; c=relaxed/simple;
	bh=YiKcNwPNNMVFO3y7RF2CWj+EMibd9DO9NwQZNjUa2pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtSOCCakJMuBNmQz1OgRkS2EN/0aw4KCwL4TssR7rHMaapjHMrlzaAyBsSDs1OEK7z7y+e3kcdc9gBaWO34wv/XFGfOMr27Ss6asQtWWXUJJH6KTmpET6JJDOOVetbyC0wHbb9tChGWozzpS6vyK1UwLK4rS5v0TfWz2mnyA3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HecTc2/N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HecTc2/N"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547AY9og007250;
	Wed, 7 May 2025 12:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ATE+TVfvA/Vz6alaY
	aJMjHxO6SwwaW8miGELtbRP2SI=; b=HecTc2/N6sIiEezvI4r9Khx+Zl39rfeee
	hsEjtZZmKsGd7yVAtDPVDqBaE4LddhbXf9BwAdGtU3fSmzYiruN/fLhHZm02ljqI
	7xuvXBXexcTLkwN/SPvAxdW/XC9/HxHw9x4K/PpRpdq3lUfRRkTc/ZXo6pDFeCz5
	NVK10K02iHr2n7j/mNlKXtrcx9dhmV/9TMr7TMETPfvHTSd8LXBx5KMuAyxt1FO9
	X6sgTG66XS0dZgl+FgNnRj7MuuSGVuvuxpzZ5fdyRn2NeQ6v9AZMasx7NRy4yYOb
	q8XDxGn3r6EkHe7Qed74WLIWwsbRzs3DzUZ7tLU5pznz5YMLWc+iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fth8bgpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 547Cm6OZ016838;
	Wed, 7 May 2025 12:48:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fth8bgp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5478tVsp002826;
	Wed, 7 May 2025 12:48:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp0pf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547Cm3Ir53215582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 12:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5DF62004F;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2972004B;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 38933E0126; Wed, 07 May 2025 14:48:03 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v5 1/1] kasan: Avoid sleepable page allocation from atomic context
Date: Wed,  7 May 2025 14:48:03 +0200
Message-ID: <0388739e3a8aacdf9b9f7b11d5522b7934aea196.1746604607.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1746604607.git.agordeev@linux.ibm.com>
References: <cover.1746604607.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pVWMKYbZEyw2181c1bTTvK43aZskAEH7
X-Proofpoint-ORIG-GUID: hX6cycSgroZu4hLcRJQRahMCIvMXjD4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDExOSBTYWx0ZWRfXwzS0DU99voB0 DUdkEcnzrLPuEpcFmM3cBCcJSTCF04Q5q0YQKRp7NxA2DN2sqZyOSDNnGyLMBgAVFRxguf7FsZA vH9ck7xIs1vpPGuE/5xGIdT4hkK9UnaQ2JalU4cOHvjvrf5XjO96WsZHdjRZf9uuV9Zlu1fBqLW
 reu+hFA6nbzQk/dnlO1X3wjeg8TqDT9me+niYt3ngPXMRAWnLFNWRPwc7KojxIDjUlcljpvFglt rgggo+W7UWT9vJolJrB0ZnQeGVvqKeBe1QxvFuUfZxTBknlFdmTV20HZ6NSQNRDfi9Z91lmFIWL dYH4rdEz5ZONgu0EWVbByfi2VH//Ppox6m8JdyvqnyVQFVbVe/SNQFPWjKhUShla5LANrkrFUQ9
 Fa3tZNRGw//ePxBPs4oUVpR0d/G6PogNe9uFYsQMnOh6bR80/noPqv1p8McDYcWEEzQZoJ0F
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=681b5687 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5xA_3oZvIydUEubUgb0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=384 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070119

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
 mm/kasan/shadow.c | 77 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 88d1c9dcb507..660cc2148575 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -292,30 +292,81 @@ void __init __weak kasan_populate_early_vm_area_shadow(void *start,
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
+	int index;
 
 	if (likely(!pte_none(ptep_get(ptep))))
 		return 0;
 
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
-	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
+	index = PFN_DOWN(addr - data->start);
+	page = data->pages[index];
+	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
+	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
 
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pte_none(ptep_get(ptep)))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
-		page = 0;
+		data->pages[index] = NULL;
 	}
 	spin_unlock(&init_mm.page_table_lock);
-	if (page)
-		free_page(page);
+
+	return 0;
+}
+
+static inline void free_pages_bulk(struct page **pages, int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i]) {
+			__free_pages(pages[i], 0);
+			pages[i] = NULL;
+		}
+	}
+}
+
+static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+{
+	unsigned long nr_populated, nr_pages, nr_total = PFN_UP(end - start);
+	struct vmalloc_populate_data data;
+	int ret;
+
+	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!data.pages)
+		return -ENOMEM;
+
+	while (nr_total) {
+		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
+		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages);
+		if (nr_populated != nr_pages) {
+			free_pages_bulk(data.pages, nr_populated);
+			free_page((unsigned long)data.pages);
+			return -ENOMEM;
+		}
+
+		data.start = start;
+		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
+					  kasan_populate_vmalloc_pte, &data);
+		free_pages_bulk(data.pages, nr_pages);
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
 
@@ -348,9 +399,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
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

