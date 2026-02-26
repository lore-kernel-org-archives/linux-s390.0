Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885A376473
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105618; cv=none; b=Mw2boUFldt5Lt9W2jeO/z2+8uLZDl0y3HD7Sf4opbRBUFFDVxIeZnDhxh22n0NVxCgLOeVYfZbfcGRb3evVOGjUJVuhUT6HzKscXBC8ULMRvC7ArkQlWXvDcA+Ty0FM0+le1kfhG1ie0DaIEfCBNUE3VyrrTvgppTCQRffOtEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105618; c=relaxed/simple;
	bh=/9Lx71nKmkYJb1TTSFmE0R6yAn5hKROXn15gQnra39s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skcMCUA4dPOCK1xtreDjbZyuxjcAe7HwpZk52Ch4TEGxX93EHIcF1UvLUGH4dxTIvoWmbjy13aA6Yy27+iGeeeA51U8Qi+Vnr4LP7tGpzLKv19Fo+kyv99sfSQ1+naqD2gv1oKse311qdXn/Ds3dAWtTbrWGxl+Fx2Tw2jTKpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqWTnMAd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqWTnMAd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEWb6ULyOrXRVye+x+KftZvBAQkL33Q0arTZiVRMt8I=;
	b=qqWTnMAdq5dg5CvpyeLbGUPbMz61dA9xpNIaerVTAxRFPXhdC6tgbMB8GUGdaSb1pEj7AQ
	+ksDSA5ARHrYo0OCNpPhXKcjyhuY8ZIczmUrM/O9mt6vELpp8Kp9v5Y2Nt8i4eNS5HVweF
	CbjSJodzFuIWJHz06nT0yacW4sZIjPs=
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
Subject: [RFC v2 06/21] mm: thp: handle split failure in wp_huge_pmd()
Date: Thu, 26 Feb 2026 03:23:35 -0800
Message-ID: <20260226113233.3987674-7-usama.arif@linux.dev>
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

wp_huge_pmd() splits the PMD when COW or write-notify must be handled at
PTE level (e.g., shared/file VMAs, userfaultfd).  It then returns
VM_FAULT_FALLBACK so the fault handler retries at PTE granularity.
If the split fails, the PMD is still huge.  The PTE fault path cannot
handle a huge PMD entry.
Return VM_FAULT_OOM on split failure, which signals the fault handler to
invoke the OOM killer or return -ENOMEM to userspace. This is similar to
what __handle_mm_fault would do if p4d_alloc or pud_alloc fails.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7ba1221c63792..51d2717e3f1b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6161,8 +6161,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 split:
-	/* COW or write-notify handled on pte level: split pmd. */
-	__split_huge_pmd(vma, vmf->pmd, vmf->address, false);
+	/*
+	 * COW or write-notify handled on pte level: split pmd.
+	 * If split fails, the PMD is still huge so falling back
+	 * to PTE handling would be incorrect.
+	 */
+	if (__split_huge_pmd(vma, vmf->pmd, vmf->address, false))
+		return VM_FAULT_OOM;
 
 	return VM_FAULT_FALLBACK;
 }
-- 
2.47.3

