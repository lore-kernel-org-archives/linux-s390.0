Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA42374739
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105608; cv=none; b=SWvrhtThgt88UEU+P2DyhxcoVixYnWEfMMCRoX+Mo1HJKif8BZt+h3B0UmVDeHdFrjF3p59cOVucxMhHwNU/jkrII5ONwra6SbCx/yEuIkdWpFTd1McdOeCeD5G8yMg5HB2Oq2kSwMJs/tfHGlq71B3qKGr6pK6Tl12LAroKvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105608; c=relaxed/simple;
	bh=XyNsyJWDLdtMWfeztXZkJusewWEMu4gny4UKw8prAfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eby5wL4ZLsJTtje4KuhNainTIPnXoVBoGKEwdq4yq89s6i9xwGz0gKtG3pNGWJJfHRDLcXLjOdtgehRMDC3Y2m/uBwGeyKHK6hcx5YIryjTH6yMzGiLR04IWyf/Vowpg4y9GpX1H4LrLzSVlJbjMn+y7UMdNeHIyEoOb43t/rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHP1wfJE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHP1wfJE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38HBryh3cdm+ftgRS5GbtNG5HBrHnG2TSvjgBx98jPU=;
	b=WHP1wfJEjiIuo805/CDPw1ZEpoyAmOLPJew54t/Qv6FjvLJsRZl6KQ9zw/ResskmnYgraa
	1InmrX9KSZwqmCAV2swDPkNm4ZtR9ljeMBHNos7fGqBRB8m2acYEuuIZAd9e5c3HR9DorB
	QqjH5/b9k2rgaJpkswdULdkEDYIRqsQ=
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
Subject: [RFC v2 04/21] mm: thp: handle split failure in do_huge_pmd_wp_page()
Date: Thu, 26 Feb 2026 03:23:33 -0800
Message-ID: <20260226113233.3987674-5-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

do_huge_pmd_wp_page() splits the PMD when a COW of the entire huge page
fails (e.g., can't allocate a new folio or the folio is pinned).  It then
returns VM_FAULT_FALLBACK so the fault can be retried at PTE granularity.

If the split fails, the PMD is still huge.  Returning VM_FAULT_FALLBACK
would re-enter the PTE fault path, which expects a PTE page table at the
PMD entry — not a huge PMD.

Return VM_FAULT_OOM on split failure, which signals the fault handler to
invoke the OOM killer or return -ENOMEM to userspace.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d9fb5875fa59e..e82b8435a0b7f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2153,7 +2153,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	folio_unlock(folio);
 	spin_unlock(vmf->ptl);
 fallback:
-	__split_huge_pmd(vma, vmf->pmd, vmf->address, false);
+	/*
+	 * Split failure means the PMD is still huge; returning
+	 * VM_FAULT_FALLBACK would re-enter the PTE path with a
+	 * huge PMD, causing incorrect behavior.
+	 */
+	if (__split_huge_pmd(vma, vmf->pmd, vmf->address, false))
+		return VM_FAULT_OOM;
 	return VM_FAULT_FALLBACK;
 }
 
-- 
2.47.3

