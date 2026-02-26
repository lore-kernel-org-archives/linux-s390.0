Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3553126C2
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105630; cv=none; b=Zig2XijCYx264hTue03bdGJ9vNScHnYIdufyv4+Q2g0yJEvcecrWowYRUK4Ecdl7XdTezyb/IdUdfhZ+37zS6N+JAeKP2kfprb6EXvIjz/OwPvfSZkzYtgEvOmmjYB4oaIqswpd1R+Q/jMQ/+sD5Z4UDa4708qq8LoaYYMPsc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105630; c=relaxed/simple;
	bh=VtS+Z0IGhYeUBDh/qBGA3j2GFtWW6QsYJ4/y5hAAHb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSSUiMkdbptaVdet2imzJqpn0GuAR4tVe2hZq0ZieDIkS/f6f9pKKK66+8/3hl1cNqNdmyWn4/tU+MefRlX6nESfAVE0Lf6sfvZCw4itJgcaFpvKG6SjPruYDHBJtiPzdmONw5O+AGN5DipoWQWCg7KH+2AdQqz0p42t380xfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=udE+houD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="udE+houD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voiqUydpep5c50p71jeWeFdopCgnIpO6zR1blEnFY9U=;
	b=udE+houDLGseN1f6IYvibBzYYzpJnrx63S12MifUCk13f0DjLpLexn7cLE+r93BBzXNqZW
	GMm8b+RjhZzqazJYt7NxsX82x6AVbHVcuPZhuNhuFnkbnvwr1QnAXR2LjKKpKiQSa6Xdhz
	62qhsCiwM2CIlMTRP3nK9ID7G97Ovc0=
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
Subject: [RFC v2 08/21] mm: thp: handle split failure in follow_pmd_mask()
Date: Thu, 26 Feb 2026 03:23:37 -0800
Message-ID: <20260226113233.3987674-9-usama.arif@linux.dev>
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

follow_pmd_mask() splits a huge PMD when FOLL_SPLIT_PMD is set, so GUP
can pin individual pages at PTE granularity.

If the split fails, the PMD is still huge and follow_page_pte() cannot
process it. Return ERR_PTR(-ENOMEM) on split failure, which causes the
GUP caller to get -ENOMEM. -ENOMEM is already returned in follow_pmd_mask
if pte_alloc_one fails (which is the reason why split_huge_pmd could
fail), hence this is a safe change.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/gup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8e7dc2c6ee738..792b2e7319dd0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -928,8 +928,16 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return follow_page_pte(vma, address, pmd, flags);
 	}
 	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
+		int ret;
+
 		spin_unlock(ptl);
-		split_huge_pmd(vma, pmd, address);
+		/*
+		 * If split fails, the PMD is still huge and
+		 * we cannot proceed to follow_page_pte.
+		 */
+		ret = split_huge_pmd(vma, pmd, address);
+		if (ret)
+			return ERR_PTR(ret);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags);
-- 
2.47.3

