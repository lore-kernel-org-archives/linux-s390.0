Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B035963;
	Thu, 23 Jan 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648255; cv=none; b=mWCiVPSiW+Tdh7x9IqzBCH/0upD7hLSf4/6C/eWHOUXwL+/vkpmef/kBwGvhxZb/dukTD+KvA+5U54b6ennIsmhzLd/1m4GfgeVUF0nZgzeuHDG4sUdzyupaCpZNE3eESRsxavIjj1lqkzvLL5RLyXlGMaHArpDH+qkrzkzvvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648255; c=relaxed/simple;
	bh=qmqBKNDKzyqhXdXysrNbJFYXMqNItqbwx8zTayzReIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbZGWa9XC+iJCHnYGKJ/lDOjcJsxDL1yVOGJXBQT/3TBmUhQ7WQLD33n6rvULaDV3EbbBRTQiZbiuPttBq8OijdzhjMHuvhe61KVrET+WMs015a9GxZDE6FwqhUJ1UaY7TN1orekft/xJFMgqA2yegLq/Vu/77zwUgTweTOYDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtxkJeZa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtxkJeZa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFDZw2026932;
	Thu, 23 Jan 2025 16:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YaKfF8QWfZZOVyjwI4WO9vZg3BNftS8xatpcQW7ve
	f8=; b=qtxkJeZao5LvE0jSrD2oUSOuVzfPgwTkWpQriUX20cul73f3kuWYpka52
	xluV1SE868RiTQesich0bC1+wpFrcM31epPHi6YM6xlg1rodbafYod9UucRvJwOQ
	VySNsvk47P74z0lsPw3sxaa6C6uBzRrvMtNdL7BKz/N6y/XeRw90n1ykMSke5Z7/
	5cS64g8sP3SLEYXw4ez9EFDq9+WDk+od8l7DeHup2kNf1IsmjEX6mC2qyTIrE7pW
	CW5JfHc1dl0bCM++V9q7N5DvqPknT7QaN/0SI1RBuc7uQUTQt0LYkOl3cbDz/6bz
	6Vd8XMxvJ5hUTDKa/xbvlgzVs/y9A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7u09m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 16:03:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEBO0x024252;
	Thu, 23 Jan 2025 16:03:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yed6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 16:03:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NG3olX35258966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:03:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B4E20043;
	Thu, 23 Jan 2025 16:03:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50A7520040;
	Thu, 23 Jan 2025 16:03:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jan 2025 16:03:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E3698E030C; Thu, 23 Jan 2025 17:03:49 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
Date: Thu, 23 Jan 2025 17:03:49 +0100
Message-ID: <20250123160349.200154-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gmGbBPBMfKdUhbbs6F0NDqvs4fciIxjO
X-Proofpoint-ORIG-GUID: gmGbBPBMfKdUhbbs6F0NDqvs4fciIxjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=739
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230119

Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
level page table") misses the call to pagetable_p4d_ctor() against
a newly allocated P4D table in crst_table_upgrade();

Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
the call to pagetable_pgd_ctor() against a newly allocated PGD and
the call to pagetable_dtor() against a newly allocated P4D that is
about to be freed on crst_table_upgrade() PGD upgrade fail path.

The missed constructors and destructor break (at least) the page
table accounting when a process memory space is upgraded.

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
The patch is against:

  git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable
---
 arch/s390/mm/pgalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index a4e761902093..d33f55b7ee98 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 		if (unlikely(!p4d))
 			goto err_p4d;
 		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
+		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
 	}
 	if (end > _REGION1_SIZE) {
 		pgd = crst_table_alloc(mm);
 		if (unlikely(!pgd))
 			goto err_pgd;
 		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
+		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
 	}
 
 	spin_lock_bh(&mm->page_table_lock);
@@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 	return 0;
 
 err_pgd:
+	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, p4d);
 err_p4d:
 	return -ENOMEM;
-- 
2.45.2

