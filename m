Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD691245031;
	Mon,  4 Aug 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301346; cv=none; b=dSZb5dL+Sp/U9Mc2mYIum+o9g8HMZkzM/gNuhf0OkjjwQWlWqohlxomZQAfEJ1I0RVwF6F7G2Tf32M9XFmtAr32aAimFz/SssuBYF24+1kZrIcv8U8viwHib1/DM+hsSLnUw0cIuGhTzdZVq59JcijecA6xj2DJlLO7J7cJmr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301346; c=relaxed/simple;
	bh=LXaJJmPQqXnbL/bmZnzqXb0txLVlMmOtBWlErQC9Kr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urXng2deX39EQv1UFo9TLVFW0hZL94dm7j/LPsSFUzwzzfBswYD3WN25oNPtMvcHLD6QCSYnd9JgvtkLEOjcpr+Ji8dC+WXS9U8+OZ76LmQGHd7f3TPCFiF+RauRB1PLEJ3ImmHCQbj5fHTvBGMlQQ/j8kIwfiAxm95RDSZqqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JX8u+a3c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JX8u+a3c"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573IecYw009060;
	Mon, 4 Aug 2025 09:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DAQV0AwXeHE/PwMvOBgIQg+ASlsQc1X48WemPBpqA
	p8=; b=JX8u+a3cp4KDC/RV+NejW54b99E6nfTYDShlIaekUf1ehXchWAO2YpvP/
	tgAIFJUbMXx3+jiGiGH0PQH2a02nZWyCLNpMCrIPaRqGNN6EZiLD7sTfV0C1vNs4
	XLquDB49vtvYYvlSZjVaABXxwIg4WDEjKPow34Bc1a1I+CuqJp8wH/e2qV3mRUmq
	GXzLbIITjlyj8AvLfNr2uvyC6uX7gfQ7n8DV3Wi//saBdgVbRW9ITKSApHjdQTBF
	SCYKxFP/4ksZ4h38AJ/2KTVM0lSrlJL8qUhRON3ROTC0SdcooDEegCMqDSQes8If
	VtnxKCD4nv+oJPGeeOsTfhwW+9iHg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t0ggv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5746go6e006876;
	Mon, 4 Aug 2025 09:55:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmd38b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:55:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5749tYsA39715282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:55:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748E420328;
	Mon,  4 Aug 2025 08:40:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5238D20326;
	Mon,  4 Aug 2025 08:40:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 08:40:30 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, sumanthk@linux.ibm.com
Subject: [PATCH] mm: fix accounting of memmap pages for early sections
Date: Mon,  4 Aug 2025 10:40:15 +0200
Message-ID: <20250804084015.270570-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1MyBTYWx0ZWRfX9UqKj1uDacui
 qq95fm1prsbYncAw2VJR/2hLoXU2AqQa4QXuYW3LutQBIZId2CnnxZqTbXsqoAZvQjl6BNc1SyF
 Yw/4ArdNT74fBp+fXzfEaRz7j/Geihorx3YRrZskAV9y5OSvP2RuULBc+QrjyAlBVHNOD/Zg8tc
 WIQmobi9rnIrPFgtzmsueEcoKBkpMH0u/nD9Zixw0+QQ5yaFnS/7KB3OXEj8KQeimDOQ4JNrTxT
 Lbyz0xBl7SZ31ni2rxEvlS/g6NDsAzN/fE3M0yB0RclbL1pCEkxQL+mFKRmNgYomit8p+tefSVS
 Pd9+ztjHpBn1yZMC/+9aaLmQkUIU0uenFiDJye4d6x1mPiWGHQ9Xv7lJPmIULd+2t9cVzER1IeC
 L4pgNYl7iJhDxjKvQCI9BARrrl2r6dSVgZO52vAQ/dtWoFvYktlF73iDeIK2Yzms/hk/Fwio
X-Proofpoint-GUID: PFTZoDSImDPPihjzNlw7i8WSy-lbRLhl
X-Proofpoint-ORIG-GUID: PFTZoDSImDPPihjzNlw7i8WSy-lbRLhl
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=6890839b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KawUSfIWrfKEQJWuwW8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=434 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040053

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

