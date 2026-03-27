Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E1332608
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577747; cv=none; b=bMzDhuOIUGPA71JcvwFMJ1Odf9WOh8oVmKEpkcrsxQzUlNOvyzQ1v2ZXpCDmgp1fC5MNSulgeD53e5/Vql3XEiquAGE9ArywzLZwLHGkHtLhNvLSsTjRJCFXoukUGL1Wq/mYLpIffWxS0RFA+Ws6w5AvbIb2Fgx5k6NQpOQ2QnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577747; c=relaxed/simple;
	bh=MSBXQPCmQM3p81GXRNNhHe5yDRAt26b3JVPgOD91aaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfCge1ZR6E23IRDeWlAtnGXf5yCNTa7miBkmel/vFSMhFekD7cCWfCIIa3MObCOLxPjJ1XuCx/nJ+e31yoIlj+uLnhwNwEU/vgF1aruoMp1WyqorQZkDwU5NJXprAaJ6/5xbHVQMDm3ntFlByUVLTBw3dE9jZTUCAQKkyOuGyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hnot0p5K; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hnot0p5K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tx/Qjve1iVx/sjsNymGDpKKmMZv1TUyDs/EfcYY5GE=;
	b=Hnot0p5K89CAv1AQSFPCVNypjXRfAocNMIZyWJnznY4gpq+GWy2CVy+0V7yyIEu0F+HuLG
	VCDbIV/SqybnVZSHtV9JQkcdTWMzMp9IQ8Hs+qWemVt0yevh5Dk4OIgO/2Wqfo3fp+W2Sb
	aJvabR1V9LfLrBzcx+XgaoHKYXMXuJs=
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
Subject: [v3 15/24] fs/dax: handle split_huge_pmd failure in dax_iomap_pmd_fault
Date: Thu, 26 Mar 2026 19:08:57 -0700
Message-ID: <20260327021403.214713-16-usama.arif@linux.dev>
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

dax_iomap_pmd_fault() splits a huge PMD when the PMD fault falls back
to PTE-level handling. The split is necessary so that the subsequent
PTE fault does not misinterpret the huge PMD entry as a page table
pointer.

In practice this cannot fail today: DAX VMAs are always file-backed,
and __split_huge_pmd() only allocates a PTE page table (the operation
that can return -ENOMEM) for anonymous VMAs. For file-backed VMAs the
split path simply zaps the PMD and returns 0.

Use WARN_ON_ONCE to document this invariant and check the return value
for __must_check compliance introduced in the next patch.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/dax.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index a5237169b4679..ed1859e8a916f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2039,7 +2039,14 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 	dax_unlock_entry(&xas, entry);
 fallback:
 	if (ret == VM_FAULT_FALLBACK) {
-		split_huge_pmd(vmf->vma, vmf->pmd, vmf->address);
+		/*
+		 * split_huge_pmd() cannot fail for file-backed (DAX) VMAs
+		 * since splitting only zaps the PMD without allocating a
+		 * PTE page table.
+		 */
+		if (WARN_ON_ONCE(split_huge_pmd(vmf->vma, vmf->pmd,
+						vmf->address)))
+			ret = VM_FAULT_OOM;
 		count_vm_event(THP_FAULT_FALLBACK);
 	}
 out:
-- 
2.52.0

