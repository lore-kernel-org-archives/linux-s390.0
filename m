Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF63101B9
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577731; cv=none; b=nm8Us2Y9V/oMs8T1Xmca/0XP1Q8uKuGhfeAdyztgXxa2bFFj9LexqmqX9/RqBZlKvzpeB+MoBNdnLebVSTcNLfx07Cgug+NJViopH7U6qKPjVCMZFl5uWGb9FBARRNbg92s+JqLtlZySfIYKIGVCN/b3L9WJCDYu+wLG70jSsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577731; c=relaxed/simple;
	bh=+F5vSD16AY/+SU23Bcz2sZiOlpNz1cHNMnvnF8SdP0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmzEBLNqjj6SK9YJwDGwIE9BWLaLVps5OU2EtzqfEnCChUsA70H75tJEfsgh2Wimn6rKd7uCIncAZ7kw5EylvuW/SyFlzW/FWtcWHzN+rX+j/x3q8WrkgEteMfo7BUjLMh/4mmF6u++hw0GeH3L/vjDfSUGZDRzxosKUgsWlWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eUmbqBO7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eUmbqBO7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTevK4s9bqcsyF5dGhWo4MENNp9vZlr+uy9xAQG2jfo=;
	b=eUmbqBO72zX2904RPuTC7NJzAIMHlr5gcD4RVYygo1GU1dDyzany1Q2T9JuiXvkcB8DQd9
	aunpkimHYmudKZq6kRshELjRaFFsIkn5wCDv9o4AVpLZf/bmSb/rct1ebqgCoY+qovcSBc
	l6ygYvG/M7DXmErg92nyDDfRdBDaJ3A=
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
Subject: [v3 12/24] mm: thp: handle split failure in device migration
Date: Thu, 26 Mar 2026 19:08:54 -0700
Message-ID: <20260327021403.214713-13-usama.arif@linux.dev>
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

Device memory migration has two call sites that split huge PMDs:

migrate_vma_split_unmapped_folio():
  Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
  destination that doesn't support compound pages.  It splits the PMD
  then splits the folio via folio_split_unmapped().

  If the PMD split fails, folio_split_unmapped() would operate on an
  unsplit folio with inconsistent page table state.  Propagate -ENOMEM
  to skip this page's migration. This is safe as folio_split_unmapped
  failure would be propagated in a similar way.

migrate_vma_insert_page():
  Called from migrate_vma_pages() when inserting a page into a VMA
  during migration back from device memory.  If a huge zero PMD exists
  at the target address, it must be split before PTE insertion.

  If the split fails, the subsequent pte_alloc() and set_pte_at() would
  operate on a PMD slot still occupied by the huge zero entry.  Use
  goto abort, consistent with other allocation failures in this function.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/migrate_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 2912eba575d5e..00003fbe803df 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -919,7 +919,19 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	 * drops a reference at the end.
 	 */
 	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	/*
+	 * If PMD split fails, folio_split_unmapped would operate on an
+	 * unsplit folio with inconsistent page table state.
+	 */
+	ret = split_huge_pmd_address(migrate->vma, addr, true);
+	if (ret) {
+		/*
+		 * folio_get above was not consumed by split_huge_pmd_address.
+		 * put back that reference.
+		 */
+		folio_put(folio);
+		return ret;
+	}
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
@@ -1015,7 +1027,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		if (pmd_trans_huge(*pmdp)) {
 			if (!is_huge_zero_pmd(*pmdp))
 				goto abort;
-			split_huge_pmd(vma, pmdp, addr);
+			/*
+			 * If split fails, the huge zero PMD remains and
+			 * pte_alloc/PTE insertion that follows would be
+			 * incorrect.
+			 */
+			if (split_huge_pmd(vma, pmdp, addr))
+				goto abort;
 		} else if (pmd_leaf(*pmdp))
 			goto abort;
 	}
-- 
2.52.0

