Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF2332EC5
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105635; cv=none; b=grP6OWrTAIuVUJ4jKWUvbm5dH0toL75NGuK5WWyxIIi00Lz2mfPjXuYqRf3jLmFhpf8BAhTI/KbQEjEkR3YgEe9WUtxYg27ruX9FrzL3lTo4i3r4NXynvzGFEe3v+pwL42lx3iXiimikKMjpetZKld75K+8wjLPxdeyK8YVUtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105635; c=relaxed/simple;
	bh=pUUXXPmW7bXhtmtKExGJnVno8KAfeEF+vOAxJbtyM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og+9ztqtVxX45cNk/qS3t4bSfv45VHNfWTaIZH572MnJF0VnGSYVZEfagfG7qKbJQL5czQZn9eQino4UWwL+EEFlbniC/jSncLocjTYqVr4AT1kBToEYkUoNgxWors1rAzwhvNvfKnFrQriRcRPwj3BklBRa/wtTGXrh/+KLUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=urU1JU88; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="urU1JU88"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYA2+HQ3PTBt5D8sdrhOr6HCB84Kriw+faUOIzAxMpw=;
	b=urU1JU881GY7kjUvIyBX3z3Lqlmyk50JU6TXPEMfQliw0OxBspGKG47gwOqyYchKYjdhOS
	4MCdiw06/6qjaNTE/dJI2QINH/BZD+AyBh9OYXNlQ7Q+2vDLHhiRiXwTsCMMVh0aAiWh5C
	T/IMdVB4xvM/4LGbijfTnkgoLXbW/+E=
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
Subject: [RFC v2 09/21] mm: handle walk_page_range() failure from THP split
Date: Thu, 26 Feb 2026 03:23:38 -0800
Message-ID: <20260226113233.3987674-10-usama.arif@linux.dev>
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
index a94c401ab2cfe..1ee9df7a4461d 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -147,9 +147,11 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
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
2.47.3

