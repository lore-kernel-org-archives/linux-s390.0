Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9B374736
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105600; cv=none; b=fZBRcrfxF3utt+hHXR127504MRvGOUDentFkgVuf0G+Ebu81aeimhRosZz8ee13jbTXzTZ+AOZ0M7M/vUw5h+jFX0rnZg8sT6SgcExw/ZnOapuwBHe4MYMkERR4XwOk0pBMoBH4aJRZjqyI+rWk1JLw026019r+46sxWK3H2boE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105600; c=relaxed/simple;
	bh=jRbWnX5LVBNAl9B3S9CoEgXhQBd2I3z6MkF6T4xaWsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJWYUb7DmDVKg6xyaeBYvAyZ2WY+W16h/Yy3JcVLyFBQ87LKv2SN5Bg5XjVVyzzZm2QRLinh3IqIFy8Gv7rXNsA/Nj6Iu6E7VoxnZYDB3GXEPYbu8rBYPUqszTWWaoL7qBD+aP+koin1GqkOgvQ0Sfjssa/eYlUvF3iq5KHa6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEvwlQop; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GEvwlQop"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQlqNAg7YmGMtU2zToh4UykdOV+ZpXIvjbeNwJDuSLQ=;
	b=GEvwlQopNT6g5r3qPFA3hw4hEH5lzxHgG6gobmbs2WMGHD+HZGnd7GNY/CkoXbEowidLAw
	tx81cT6J81Oodk5830V5/Eg35UClUBMuKripPGXqKWJTXSeijwrsHxbsky+sC0U5RvryLO
	fBDrl9SDTCk6keGVFJY654/48cN28Kg=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC v2 03/21] mm: thp: handle split failure in copy_huge_pmd()
Date: Thu, 26 Feb 2026 03:23:32 -0800
Message-ID: <20260226113233.3987674-4-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

copy_huge_pmd() splits the source PMD when a folio is pinned and can't
be COW-shared at PMD granularity.  It then returns -EAGAIN so
copy_pmd_range() falls through to copy_pte_range().

If the split fails, the PMD is still huge.  Returning -EAGAIN would cause
copy_pmd_range() to call copy_pte_range(), which would dereference the
huge PMD entry as if it were a pointer to a PTE page table.
Return -ENOMEM on split failure instead (which is already done in
copy_huge_pmd() if pte_alloc_one() fails), which causes copy_page_range()
to abort the fork with -ENOMEM, similar to how copy_pmd_range() would
be aborted if pmd_alloc() and copy_pte_range() fail.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a979aa5bd2995..d9fb5875fa59e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1929,7 +1929,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-		__split_huge_pmd(src_vma, src_pmd, addr, false);
+		/*
+		 * If split fails, the PMD is still huge so copy_pte_range
+		 * (via -EAGAIN) would misinterpret it as a page table
+		 * pointer.  Return -ENOMEM directly to copy_pmd_range.
+		 */
+		if (__split_huge_pmd(src_vma, src_pmd, addr, false))
+			return -ENOMEM;
 		return -EAGAIN;
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-- 
2.47.3

