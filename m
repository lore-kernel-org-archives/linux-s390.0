Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45833126C2
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105640; cv=none; b=rTsKNNXrmutLutLbQttbW+fXuR8UlOZsk89Ld5HdQ3+u3BEWcXmUZgQOnWqsUvdsDxo5uRaKrcgdQXLR3HBmwN3EZ9Ai9Cv9pQI1Ron5ks9QDI8wlDBO6bLoro72vflZiOlNk4Vv6XyN/t9lz4l6hxIcIIUXHytyhHC1pxX14Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105640; c=relaxed/simple;
	bh=ZWG3lmzbNO/V87Q3kSOztnc/R3lYgBCciGKRZ2YiCn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFqjmklO21culwejAwnW849WEUJVfKfvUay6vHcBzKDfz2twXlUG+AZX3dyK1yG9dwM4sIv8zWXLwz4Lm9admj1szp5njnJP8FBdfe6DQz4qA6UJZuBefcPHAZHKFEgwTFEkKqn+uyPPxFwb0C+uj4sJ6C+BCn5n47DBpwQWV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GNBY0ei9; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GNBY0ei9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aUMkxnHNH9mcF53dL6rFOoKpYMbGORopHm1QOQnqHs=;
	b=GNBY0ei9szFMPQP/mBgbMCFztPaf5KixVYVsniCIVlDSW7j+DoDleEyGyDQNRUFKeG506m
	zD1Gi7r+Zhgmqi4g2f201lHrFpqSlyBpA3zLxA945W0jK92rfYWz4T6YR0Uiy0ohgdYeQc
	JMgf7lbMY23ljMMajF764JDFPOwe/Bs=
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
Subject: [RFC v2 10/21] mm: thp: handle split failure in mremap move_page_tables()
Date: Thu, 26 Feb 2026 03:23:39 -0800
Message-ID: <20260226113233.3987674-11-usama.arif@linux.dev>
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
index 2be876a70cc0d..d067c9fbf140b 100644
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
2.47.3

