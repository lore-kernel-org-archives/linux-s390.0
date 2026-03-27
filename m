Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDC280324
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577706; cv=none; b=bJtmJqCRJj+iD03I4HlXEspkt/8MQ2xYh2wKQcJ780IQO96DmN67O4RC0040TSZVQeo53OQaWr6K2Cuupoy0ErwkReHj4nCBorNqTP4bSqrI8uGiFraH3bgR6RPKo4cv6+VPkS/HL8hPokAtYiKnC3hSFfHbsBO3oPotTdRCUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577706; c=relaxed/simple;
	bh=s0WP9xhE1CTtNKRy6LtQcqflof/ya4sCmhE4hMDDEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI2YicaxrU25uNAJ6ay5jS4xj9xJS36FN8epKgqDq7CO6rP1C6C2lUYLbvg0HMZfhEWYW5nrv6y5SwIA3S7Q5GCxLapLLy6sBHTd8Xj7s0xWs4Sud87d6AH7UeRyXfY/CM4K09xAVJAZvESWz+TnpFG7OeyWgtovaKto+HSXB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+UwEtgW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+UwEtgW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giSfT9S4Y3Fs6MBCHHOkpgsjb4flU8mTLfNnlsB/wxU=;
	b=c+UwEtgWwyc5ExZqiso+pcfyt+iKbZ1QmoTTRB8NhGDZKpUwyzQzLx5Oi6hXFvtdq5ago3
	ODRA0nas4eR1mjjEDHyY5MY9At3yhrqG1QJr6rpr5PRO3un578DMuu2R03YOspCxOxZ+jD
	EPix5NId6vnIBtCHcU6MJtVrfHvraLA=
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
Subject: [v3 08/24] mm: thp: handle split failure in follow_pmd_mask()
Date: Thu, 26 Mar 2026 19:08:50 -0700
Message-ID: <20260327021403.214713-9-usama.arif@linux.dev>
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
index ad9ded39609cb..07c6b0483c322 100644
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
2.52.0

