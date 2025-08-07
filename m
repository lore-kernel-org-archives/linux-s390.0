Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10535959;
	Thu,  7 Aug 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591777; cv=none; b=nrzk1ECyj+3ZLt+8CzJUXcWeMswAZ0MUOJ2BXhweGGd7ghHTsxYCBsnutOap8cvfz3v/BBNeyUe0WTViCzJFIkNAtHYNYI757zn0ahOP4g6CNyo2dxkdNqCPHqdT+lXUCYGKim3RgnyxMSXwRB51M9be8udw4WSlJr2ottdIJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591777; c=relaxed/simple;
	bh=ZoQzIXp3rakOxPPgb+1zQCTb3aKhJz4zxp+ORodGSfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9Lj6LK5ATnqZljrJ3AnPwfKRQ2QYdy/R85adP1DAalHZtFA5ih01grfRFGiuKBh39BucA4wpi/1OwGiVLnUhqCu8xTReTvYkqI/Pmk44CDa6vrFFQvz2PKCadE0jdRRHj5FijE4XMpDiqC1tE7IeRakk38ftV1mhSw6yI65wZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mof9kBKP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mof9kBKP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577FK01Y019425;
	Thu, 7 Aug 2025 18:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aKhneyAzDdfZGjI0wau8ksWW5iYO6xcbL43ns9QOC
	Zs=; b=mof9kBKPdjsZeCBrQDBVlm/p4u6oxZBgLpqgrk/EIf/EqANKdmzqXnWdp
	np5K+dxnbK3XyYO7kAAawTkhyYwl7b/53NMwuVpbSDqwQSsoPF8zSQKs0aBx23Pi
	/8oQUHDTxgNz2jPIQVye7btQtlouYVStUoGxA1IHEX8l3vkjFVWlmB+ZJ9Rcrk3N
	l/4R3aZ5+BSMVc5FPesHA0jts/hVMs+EQd0tpCiKFqfbFXtfaeqgnh4+PzNPS4ps
	6u/JJJe7Lw/gnvk1dJVDuYfZM3B+3F5H1NpqS4u/AWmc+k31lwf7BlmdZqCvqziJ
	E/9DeyfwwL/Ffn+F8HfSV9rAQkmQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u1ef0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 18:36:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577ITA8c029483;
	Thu, 7 Aug 2025 18:36:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u1eeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 18:36:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577Gq7Yf022661;
	Thu, 7 Aug 2025 18:36:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqj5pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 18:36:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577Ia19l48890134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 18:36:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CEBB20043;
	Thu,  7 Aug 2025 18:36:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2259A20040;
	Thu,  7 Aug 2025 18:36:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 18:36:01 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>, richard.weiyang@gmail.com
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, sumanthk@linux.ibm.com
Subject: [PATCH v4] mm: fix accounting of memmap pages
Date: Thu,  7 Aug 2025 20:35:45 +0200
Message-ID: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q6gTKsj0jKKFacG6gPQXzsemAJFWNtlj
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6894f217 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=cUr1TRy4Y1kx_8V_9hMA:9
X-Proofpoint-GUID: zyRnUKR7nx37eiBWiP3FzLDWANvrDLTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE1MCBTYWx0ZWRfXxAj55tLiecDX
 ZawhDJzPQ98PWwrQ282eCqurzzmouxKExGZuL82WEpF/C1GtVaqMUjm1TFyJVCeKZ8GehrrSvlO
 foGcE4RTwsTs5KABA/ZBr/j6a4PYQ7JloGXYU7GpSSDZ6ojC6iN+7x3K+r66RoyU7qdypCM/kuk
 wthcc89EeopQhctjFvnHcf7PZFQ0u+i3eSBEIjP7eHE67DPhw3u+7M//QLeoiJAiFDagdssVabA
 2MA2kDG2a/Nfz+iZrvFaBC1BQOsGQiknUiiPrJoaSDyugq+mWDsPo54QMcFN5H/OPdtmvbH4E0i
 FF6O5W6bOMJw9D02JgYfbgRwz6ppmTf7gvG6a2fef6lYpMsaRSBODafigN3kBwOw9Z2/3CrH0gU
 Bi1cnXU0KVYeJwnbP47DvN0HFGIa5Oa4tv4BT5bwiVS19M5StY+eafBU6uvBU3bttjGISXPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=737
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070150

For !CONFIG_SPARSEMEM_VMEMMAP, memmap page accounting is currently done
upfront in sparse_buffer_init(). However, sparse_buffer_alloc() may
return NULL in failure scenario.

Also, memmap pages may be allocated either from the memblock allocator
during early boot or from the buddy allocator. When removed via
arch_remove_memory(), accounting of memmap pages must reflect the
original allocation source.

To ensure correctness:
* Account memmap pages after successful allocation in sparse_init_nid()
  and section_activate().
* Account memmap pages in section_deactivate() based on allocation
  source.

Cc: stable@vger.kernel.org
Fixes: 15995a352474 ("mm: report per-page metadata information")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
v4:
* Add fixes and suggested-by.

v3: 
* Account memmap pages for !CONFIG_SPARSEMEM_VMEMMAP and only when memmap
  allocation succeeds. Thanks Wei Yang.

v2: 
* Account memmap pages for  !CONFIG_SPARSEMEM_VMEMMAP in
  section_deactivate().  Thanks David.
* https://lore.kernel.org/all/20250804151328.2326642-1-sumanthk@linux.ibm.com/

v1: 
* Account memmap pages for early sections.
* https://lore.kernel.org/all/20250804084015.270570-1-sumanthk@linux.ibm.com/

 mm/sparse-vmemmap.c |  5 -----
 mm/sparse.c         | 15 +++++++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd2ab5118e13..41aa0493eb03 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -578,11 +578,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING)
-		memmap_boot_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-	else
-		memmap_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-
 	return pfn_to_page(pfn);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 066cbf82acb8..24323122f6cb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -454,9 +454,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
-#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -567,6 +564,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				sparse_buffer_fini();
 				goto failed;
 			}
+			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+							   PAGE_SIZE));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
@@ -680,7 +679,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
@@ -856,10 +854,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early)
+	if (!section_is_early) {
+		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	else if (memmap)
+	} else if (memmap) {
+		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
+							  PAGE_SIZE)));
 		free_map_bootmem(memmap);
+	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -904,6 +906,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.48.1

