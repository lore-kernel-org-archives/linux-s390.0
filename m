Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC1332EC5
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105650; cv=none; b=unOZS00fj3P1qmY27a93ArAnzb+fBWv04Go6tG94t0qQMnRnqeu6OKDZH65xT8T4g+sf/gBCkUicfak/w3O+u2BVRlwM9LssqtXhxSj3EoAujugqKuI4+eCGgzYfUmsd7e8uPmF7ZgDjgxBMcfd99RvLHG9AG+tJGGzKDMVvPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105650; c=relaxed/simple;
	bh=R1Tj2DBdPWGs4QfE7rvprsL7l+ZNeXIAbfgGN/wmxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSaHvKVgTdFhnhWuBVfrW2AHtUbmbimljH39OSJmCrR3Zl2t7CwI/gc+Z7ov0Qp2DwHSolRkO2IXf5klcoLg0WxQk7SGmKrenhUIIY43gF87W4//Hs/dkitdSXX96W7b7npQOWCK+f0gQaVQjo5R/DJEwYVdEwcuX4LTEwBLXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IWSKImJr; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IWSKImJr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c14WgMu6/15qhuICdOLPBmddgsK8PG21SZ4l5q+gLlo=;
	b=IWSKImJr/lhTtq+7dWWCDBff/3vlsDJfZ5E4/kWREeiGjoKal7G4aXUV6deMVpg27q/Yop
	OTsn9HimEI/nuXkSIAWQ1bqJnFpUQRDmLiv4z/EhIzmdzFMMJB1Z54wZ7psaJRXtZ10qtQ
	reVy6qgPIMnhvu7EHAlifyWC4llEGMo=
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
Subject: [RFC v2 12/21] mm: thp: handle split failure in device migration
Date: Thu, 26 Feb 2026 03:23:41 -0800
Message-ID: <20260226113233.3987674-13-usama.arif@linux.dev>
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
 mm/migrate_device.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 78c7acf024615..bc53e06fd9735 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	int ret = 0;
 
 	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	/*
+	 * If PMD split fails, folio_split_unmapped would operate on an
+	 * unsplit folio with inconsistent page table state.
+	 */
+	ret = split_huge_pmd_address(migrate->vma, addr, true);
+	if (ret)
+		return ret;
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
@@ -1005,7 +1011,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
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
2.47.3

