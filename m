Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CB1FAC4E;
	Mon,  4 Aug 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298573; cv=none; b=EbZZrOuqIQEnaCYay0gxphYKekbc31ys7NqJrCFMjysw5XrpggMZ/JE8EPwjjIjZUYxVc+9r4RhLHJCf+Jov32DgD1ur07Lzk2lSZ5paFbx6u/KCm4YBjDZ+rliw8xVcFySU1/bUxopObektaMHFRaXWu1WpqKYzwNAJw+CNfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298573; c=relaxed/simple;
	bh=LXaJJmPQqXnbL/bmZnzqXb0txLVlMmOtBWlErQC9Kr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/XP+1cT2O0cZ5DFdqALpRcdjvmcvmTseSQSfx4NwwxXKvhP/OGBWp5m7xRAz9FotZ5sMVR8rVXU6XhyklSDIoVBdzFOduCJ0TwBIzn7ErFPpDT3JMuoAOEu/30xtUlgHy2T+qnYaNlO4SoDergi3Uj1zNIcUEpQIPwoRpSlr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWb3SHUg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWb3SHUg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573Kfcls029457;
	Mon, 4 Aug 2025 09:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DAQV0AwXeHE/PwMvOBgIQg+ASlsQc1X48WemPBpqA
	p8=; b=fWb3SHUg47YjoUVNywFxRPTsnu/Wezkhd2rU3UvNgA/pAP9FTpxFEjxPP
	Agd74NEokr2BHiA6vSZJMZgYBju4FucUXFjPRAzUZwyrx+KPfsM1gu4UhYThI71s
	YV3FCGqacauCfc6SfG79AT+Wx9yUaRNMDtdng+I2y6tEw1MIJR2ArWXQ+5Adk8EO
	7ebYvx4Ef+xuMq0qx/jl3D4jZysMZ5OASnA7UH3YbM5UPdrrDPM93GSr0Qyvfkth
	6MNukVXhEZWT/NnbBeUZ2Oj3L7MJWls/vEFLGOcGUum9r5i3H2Ke9wBuH61bGe5l
	fnJ5ObrkB2Be0iVkRbHr3YmM3FLsQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3fxj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:09:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5745fU3C002484;
	Mon, 4 Aug 2025 09:09:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wcyw3qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:09:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57499Kxs47776186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:09:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CC542033F;
	Mon,  4 Aug 2025 09:09:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C95B2034D;
	Mon,  4 Aug 2025 09:09:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 09:09:14 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, sumanthk@linux.ibm.com
Subject: [PATCH] mm: fix accounting of memmap pages for early sections
Date: Mon,  4 Aug 2025 11:08:59 +0200
Message-ID: <20250804090859.727207-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=689078c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KawUSfIWrfKEQJWuwW8A:9
X-Proofpoint-ORIG-GUID: Mqcg8VsFLq_ouAd6ooDn7elCav4_qeSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0NyBTYWx0ZWRfX69T6gTqLTtTk
 gNMtzS5VDmmjbCVGiGeAdc3H4texRhpBLJQusvAaX1ZmQNPnsBfeEAR5VHx7tNOeOwFAWyiCbhn
 QU48qNiDoEWQr+TkTLD2/mO4hRvUJBIGQ9dFDBjp4gwhhS0WSifIZpx2HigXqXM/xoDS4OkhfhL
 tfNHl+IvS2r75+pLnwBMV0jGKqia+H7O2gzwgEk0LmlqxS1N9mqO++gpN5jYcxDTZPDCz8epJmW
 puCNvnRlC46oejNbzP5yjH1OBJresuJWBv70SZQSZ6OCzxpCjkEDG0UsciM/93/CebN27iOtrIB
 BZiQnu+gV6MA7dQgAVr9TAYCVhgUIHzZGK9xsswwHO8n7rFKSCWoP+BtZndpSOkU0OGqQ2zHRG0
 ZEkd2KVmhWrOjPBx6Gk4VSb08FA274TH4Hw3huVDjJA9D7wyV1nrx4S7t4Hd5He5rZJlajS8
X-Proofpoint-GUID: Mqcg8VsFLq_ouAd6ooDn7elCav4_qeSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=434 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040047

memmap pages  can be allocated either from the memblock (boot) allocator
during early boot or from the buddy allocator.

When these memmap pages are removed via arch_remove_memory(), the
deallocation path depends on their source:

* For pages from the buddy allocator, depopulate_section_memmap() is
  called, which also decrements the count of nr_memmap_pages.

* For pages from the boot allocator, free_map_bootmem() is called. But
  it currently does not adjust the nr_memmap_boot_pages.

To fix this inconsistency, update free_map_bootmem() to also decrement
the nr_memmap_boot_pages count by invoking memmap_boot_pages_add(),
mirroring how free_vmemmap_page() handles this for boot-allocated pages.

This ensures correct tracking of memmap pages regardless of allocation
source.

Cc: stable@vger.kernel.org
Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 mm/sparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 3c012cf83cc2..d7c128015397 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -688,6 +688,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.48.1

