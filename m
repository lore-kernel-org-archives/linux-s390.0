Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580425F96B;
	Fri, 10 Oct 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086334; cv=none; b=bg2gu5NYisRbbzIermL1Znm/JaIZ17ZS/dCWLLlRckxmN3nLPI8ECzRo03jX5MFrb1/cUxkgStKMBGdE10MmKWoJo8qvwY1XRr1tB/LuCND8431A3fZqM5xrJlq1nIQgHxHkIV1mcLobcAa3W2bwtpGnZIj5T1WMBxAclBNXyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086334; c=relaxed/simple;
	bh=mYOiOTMrqUu6itztQQgYeopmr/ZphGWC2fdQY4fCjrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmqhpdEFR4QwuZJe8adkyLsgFsCN7N5OcknFhgyn2Ox08Zh/+FgmR8yF/wPKshtB7SA4FIpVe0KY/Moaw4+ZHczhctm+HM1dQmgVYdetELIh5ILbQprVxpDF7MgNj3QcGIMIpulzQ9w/QbDUZ/Clwm0EWRqyOJfX09OW602liyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UI0q4ces; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UI0q4ces"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Ksa5R031169;
	Fri, 10 Oct 2025 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KQ/aGM9rH94UftiKI
	ale0JIwz3RTAt1rdgKxSr6lQpQ=; b=UI0q4cesThQ2CNy40uv/IG7muqFRSOxJ0
	ib4m3/7/pIDWBf6vU4Sgt3KZGQMi1YPGGPc+j5QMIO+5pX6IcqKfi8UKKa6y6hfc
	Qn0TFwH7uCVRQxevaMLfq+Ap8uQzn++VCRUjF2vai3Y19QOueKAGxFPhuFtypqjm
	mP8Th08nEQutshbKV/a64pZAyl3VlcmM16NSZhtSwJoRqlAhcPzPXpkNjtTBaHtM
	dJL0NxExnBzKURxuAwDyd72doGI/CAfrGluOUqDh3T3B2sd+4OrXVtPT/w55So1+
	uED4M2ElaS/6GqI+kxkNtaqQ4MbGS0E50/qZJwMJ5tlwOlxTrfQug==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81sfxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A80RPO020979;
	Fri, 10 Oct 2025 08:52:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9n109m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A8q2uT29557378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 08:52:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9182008C;
	Fri, 10 Oct 2025 08:52:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8D620091;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v3 4/4] mm/memory_hotplug: Remove MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date: Fri, 10 Oct 2025 10:51:47 +0200
Message-ID: <20251010085147.2175918-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NQZ6OBCpbR_KwvA3CBqGLHLSeBLUL9uv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9sQhrIFWT5ji
 Q/nDGehyq9f4Qgq2fZFe4OIFBLijyz9538qI+jWDYxxQUZaXurBDhNvjdEn+G3NnOVBvgsnKSuD
 zVZvW9d+KvqsWrlZ83yXnWASD45FlnFjwX6pC6y8E1mYzeuEIcR+AXpEzuM6Q86YuE5JTmZu5TB
 ZZPqzVJGNcbSFFrJtN0wRSuQB2Z2f6aq7xx1hvDp0ks4A6efIsIS5LLGZhvVX0iQE4YryhVqNuD
 pG3UWxnpdSLxeK921W3RhGlaBgUrxR1csVgluMOUpzXNFRpHtpZ2iKorkx4Y92QbDFUsOuEDbui
 CWDe7YXMPEqji+DMe3BH3bU4rHGwXccrzdmmeyrjdPZhfQ1/gyvg0F1zzlWMezfyARW7CJyhSg5
 sKlMN6DgdTjAF0f7QSBzuc2H7apZCg==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e8c936 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=rQaNfnSK3a-WYbhgV1gA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: NQZ6OBCpbR_KwvA3CBqGLHLSeBLUL9uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers were introduced
to prepare the transition of memory to and from a physically accessible
state. This enhancement was crucial for implementing the "memmap on memory"
feature for s390.

With introduction of dynamic (de)configuration of hotpluggable memory,
memory can be brought to accessible state before add_memory(). Memory
can be brought to inaccessible state before remove_memory(). Hence,
there is no need of MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers anymore.

This basically reverts commit
c5f1e2d18909 ("mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers")
Additionally, apply minor adjustments to the function parameters of
move_pfn_range_to_zone() and mhp_supports_memmap_on_memory() to ensure
compatibility with the latest branch.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c          | 23 +----------------------
 include/linux/memory.h         |  9 ---------
 include/linux/memory_hotplug.h | 18 +-----------------
 include/linux/memremap.h       |  1 -
 mm/memory_hotplug.c            | 17 +++--------------
 mm/sparse.c                    |  3 +--
 6 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6d84a02cfa5d..fc43f2703ae0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -226,7 +226,6 @@ static int memory_block_online(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
-	struct memory_notify arg;
 	struct zone *zone;
 	int ret;
 
@@ -246,19 +245,9 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
-	arg.altmap_start_pfn = start_pfn;
-	arg.altmap_nr_pages = nr_vmemmap_pages;
-	arg.start_pfn = start_pfn + nr_vmemmap_pages;
-	arg.nr_pages = nr_pages - nr_vmemmap_pages;
 	mem_hotplug_begin();
-	ret = memory_notify(MEM_PREPARE_ONLINE, &arg);
-	ret = notifier_to_errno(ret);
-	if (ret)
-		goto out_notifier;
-
 	if (nr_vmemmap_pages) {
-		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
-						zone, mem->altmap->inaccessible);
+		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
 		if (ret)
 			goto out;
 	}
@@ -280,11 +269,7 @@ static int memory_block_online(struct memory_block *mem)
 					  nr_vmemmap_pages);
 
 	mem->zone = zone;
-	mem_hotplug_done();
-	return ret;
 out:
-	memory_notify(MEM_FINISH_OFFLINE, &arg);
-out_notifier:
 	mem_hotplug_done();
 	return ret;
 }
@@ -297,7 +282,6 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
-	struct memory_notify arg;
 	int ret;
 
 	if (!mem->zone)
@@ -329,11 +313,6 @@ static int memory_block_offline(struct memory_block *mem)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
-	arg.altmap_start_pfn = start_pfn;
-	arg.altmap_nr_pages = nr_vmemmap_pages;
-	arg.start_pfn = start_pfn + nr_vmemmap_pages;
-	arg.nr_pages = nr_pages - nr_vmemmap_pages;
-	memory_notify(MEM_FINISH_OFFLINE, &arg);
 out:
 	mem_hotplug_done();
 	return ret;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0c214256216f..ba1515160894 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -96,17 +96,8 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
-#define	MEM_PREPARE_ONLINE	(1<<6)
-#define	MEM_FINISH_OFFLINE	(1<<7)
 
 struct memory_notify {
-	/*
-	 * The altmap_start_pfn and altmap_nr_pages fields are designated for
-	 * specifying the altmap range and are exclusively intended for use in
-	 * MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
-	 */
-	unsigned long altmap_start_pfn;
-	unsigned long altmap_nr_pages;
 	unsigned long start_pfn;
 	unsigned long nr_pages;
 };
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 23f038a16231..f2f16cdd73ee 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -58,22 +58,6 @@ typedef int __bitwise mhp_t;
  * implies the node id (nid).
  */
 #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
-/*
- * The hotplugged memory is completely inaccessible while the memory is
- * offline. The memory provider will handle MEM_PREPARE_ONLINE /
- * MEM_FINISH_OFFLINE notifications and make the memory accessible.
- *
- * This flag is only relevant when used along with MHP_MEMMAP_ON_MEMORY,
- * because the altmap cannot be written (e.g., poisoned) when adding
- * memory -- before it is set online.
- *
- * This allows for adding memory with an altmap that is not currently
- * made available by a hypervisor. When onlining that memory, the
- * hypervisor can be instructed to make that memory available, and
- * the onlining phase will not require any memory allocations, which is
- * helpful in low-memory situations.
- */
-#define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
 
 /*
  * Extended parameters for memory hotplug:
@@ -123,7 +107,7 @@ extern void adjust_present_page_count(struct page *page,
 				      long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-				     struct zone *zone, bool mhp_off_inaccessible);
+				     struct zone *zone);
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index e5951ba12a28..30c7aecbd245 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -25,7 +25,6 @@ struct vmem_altmap {
 	unsigned long free;
 	unsigned long align;
 	unsigned long alloc;
-	bool inaccessible;
 };
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..238a6712738e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1088,7 +1088,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-			      struct zone *zone, bool mhp_off_inaccessible)
+			      struct zone *zone)
 {
 	unsigned long end_pfn = pfn + nr_pages;
 	int ret, i;
@@ -1097,15 +1097,6 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	if (ret)
 		return ret;
 
-	/*
-	 * Memory block is accessible at this stage and hence poison the struct
-	 * pages now.  If the memory block is accessible during memory hotplug
-	 * addition phase, then page poisining is already performed in
-	 * sparse_add_section().
-	 */
-	if (mhp_off_inaccessible)
-		page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
-
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE,
 			       false);
 
@@ -1444,7 +1435,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 }
 
 static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
-					    u64 start, u64 size, mhp_t mhp_flags)
+					    u64 start, u64 size)
 {
 	unsigned long memblock_size = memory_block_size_bytes();
 	u64 cur_start;
@@ -1460,8 +1451,6 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		};
 
 		mhp_altmap.free = memory_block_memmap_on_memory_pages();
-		if (mhp_flags & MHP_OFFLINE_INACCESSIBLE)
-			mhp_altmap.inaccessible = true;
 		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
 					GFP_KERNEL);
 		if (!params.altmap) {
@@ -1555,7 +1544,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	 */
 	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
 	    mhp_supports_memmap_on_memory()) {
-		ret = create_altmaps_and_memory_blocks(nid, group, start, size, mhp_flags);
+		ret = create_altmaps_and_memory_blocks(nid, group, start, size);
 		if (ret)
 			goto error;
 	} else {
diff --git a/mm/sparse.c b/mm/sparse.c
index 17c50a6415c2..b5b2b6f7041b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -951,8 +951,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	if (!altmap || !altmap->inaccessible)
-		page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.48.1

