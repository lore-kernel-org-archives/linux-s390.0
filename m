Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18175246BCD
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577720; cv=none; b=CcCVMH/mOG3rgRa1Q7V9wfnPkVca6Eg5zI7mGd+D81DPZPca1186H6HGPCtMbEGiLO+iuz67MARFG23thhTHtx+3yu+xWN+FtaZkIZ3soq0eZgJbY/MiIYFPAOs/5tCbG9Y7UIORgVC5i5h6UqaPhlzCH1tMYFsfeaH4dSdsVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577720; c=relaxed/simple;
	bh=4VB9QOrr8toNuf8HCW3jsSPSxVkjkM7tAv9dxR4tFDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro6dhnFYgrFmrdsQlIXo/k2EPnoa2eQ7XKsvIH+fEpfbhmrZF37FPlZIGgZiXyyp0cGJ+9B6BWLDJka4jd5zgdqekDV9yttm4SGAwn16IMrAt4DBKCjif+neVcbk9MkNDDt9s1Gy12ACCDxi4f7zsM2SA/ErPTX4xPLmQZnZFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTJcN7VC; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTJcN7VC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OmEvrhLT+taWsJJPLmmWMkCHrhCtqMj0PAwSXwnE8E=;
	b=NTJcN7VCFrbbYw8QV6DmQtslK9s9YNMNuM3BLeJdPk9ev+oaHPxhCblvvx8mF+jryQcQ/A
	wg7YpJu4lEnBQjk0VtVknCzS7c33o5merk9llHuNz4qXtYAm5HOn3BSwWdYd/7vyZ/q4XM
	aKuuq0sNgUbjhFWLQf7XvGWk7bo3EeE=
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
Subject: [v3 10/24] mm: thp: handle split failure in mremap move_page_tables()
Date: Thu, 26 Mar 2026 19:08:52 -0700
Message-ID: <20260327021403.214713-11-usama.arif@linux.dev>
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

move_page_tables() splits a huge PMD when the extent is smaller than
HPAGE_PMD_SIZE and the PMD can't be moved at PMD granularity.

If the split fails, the PMD stays huge and move_ptes() can't operate on
individual PTEs.

Break out of the loop on split failure, which causes mremap() to return
however much was moved so far (partial move).  This is consistent with
other allocation failures in the same loop (e.g., alloc_new_pmd(),
pte_alloc()).

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/mremap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832b..2f70cb48f6061 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -855,7 +855,13 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
+			/*
+			 * If split fails, the PMD stays huge and move_ptes
+			 * can't operate on it.  Break out so the caller
+			 * can handle the partial move.
+			 */
+			if (split_huge_pmd(pmc->old, old_pmd, pmc->old_addr))
+				break;
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
-- 
2.52.0

