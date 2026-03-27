Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB36310652
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577714; cv=none; b=jBWQ7gjmUNOEjJx82DytlXAxWYYX3g8kYTpOssPPu4kYd+P1ejKTAYM7r+angH8bA0Zoz6jsSl6kVLS862jTitD4cyGUgZ0lzaG5NJZZD+qQTUPNlwrBxUec/UI7piAhdQ8JgGf18lyRIkhVhBq9XKi6Mnxzr0BeN7/9UxXsoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577714; c=relaxed/simple;
	bh=RQLz9tyjrzBwJZqdbpdeWQwAnJH6wxMRNSREyyRf+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Keme8uMDY2algQ41//nsO4xeeqpT9mu8p6Xq+OkILpT0WotJu9Ubg/m3xE3Q2WEj7x6osWomDEcLsdP2t8IKR3XSy3d86HGRAuBvFCHtMUske/W0WVo84eq4L96ROS967JcIy7eB9qPu3Pb3oT7xF0W6rvphoMbtV5yxHqfISq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUprQn+Y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUprQn+Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNWz2MwM4ZY6bFGmoYrNTnpJRQZnNwj/uOrRkiYL5M=;
	b=qUprQn+YADvN/9XX6sWYfNa/kg5jNuE3cirjiQ/YhUk5tRCUEKizV7YGDnhu+O6mL2/RmH
	oTF5aOueObHp18z9I+INhJ7C79JF930GoJirPSOE8DqOuuEiuDjMjZKFEcq6mi9dt+yWRn
	geRfame3sIEEpbw6/P4+nyJYGxERCHk=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [v3 09/24] mm: handle walk_page_range() failure from THP split
Date: Thu, 26 Mar 2026 19:08:51 -0700
Message-ID: <20260327021403.214713-10-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

walk_pmd_range() splits a huge PMD when a page table walker with
pte_entry or install_pte callbacks needs PTE-level granularity. If
the split fails due to memory allocation failure in pte_alloc_one(),
walk_pte_range() would encounter a huge PMD instead of a PTE page
table.

Break out of the loop on split failure and return -ENOMEM to the
walker's caller. Callers that reach this path (those with pte_entry
or install_pte set) such as mincore, hmm_range_fault and
queue_pages_range already handle negative return values from
walk_page_range(). Similar approach is taken when __pte_alloc()
fails in walk_pmd_range().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/pagewalk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3ae2586ff45b4..c5850de71b8cb 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -165,9 +165,11 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				continue;
 		}
 
-		if (walk->vma)
-			split_huge_pmd(walk->vma, pmd, addr);
-		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+		if (walk->vma) {
+			err = split_huge_pmd(walk->vma, pmd, addr);
+			if (err)
+				break;
+		} else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 			continue; /* Nothing to do. */
 
 		err = walk_pte_range(pmd, addr, next, walk);
-- 
2.52.0

