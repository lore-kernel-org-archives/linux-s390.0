Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0D32939C
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577686; cv=none; b=OlSeTXHoET2VAUOpHkjXLeWZNF3QtLnka1ka01QSR+ZJwIBaA7xg9Sok07mxG7gqXPQ6b7aqEm6mY2lqfYfLUjeN+uXWf4wT+mT+nf4/aSJwFm2TR+769ZhzUTH8vAkdNOukGSoLN1AX2IgMZBP0gBXb/Bc6fgQSR2VPp8U12G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577686; c=relaxed/simple;
	bh=zKlP5pVKPnTMhZ3fH6jP6aRAXsG4BYpLMfDDzJG9YKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAjCEJdluw5/tiuoQWu+M9CWlg+xmb6W+kxtwIvIOkkMb8SILum1C0kpMgEoVJiVxciKhb4M0bmmJO/gWpnpX+0P/CZmxf8mOnb7YYnTONH0aA0OJJjYRn8eiEgmzyNv51o48jfcfLjE+TK2WBUZoymYMl+p+UNMSb1f0B5VMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HOqb9c3q; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HOqb9c3q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLE/jttxUNtNWJGXfdbfQ0fLOQxN3ImdDTn6kFnTkPI=;
	b=HOqb9c3qtURSYEfsDks7zbx2QDtDTH9l8hI6RIZbNZVZjMBH564Y3pW5ZPIcsI8NKoiThq
	EoKp0vqkwqrK6t8HL7D5u0ey61UVlkvaX3oR+haZEDWM9M+SC4Ti9llRE18ryT8ip3fCx4
	H6PgMQ7rNNkpgtUJP6NJzF9wyR2yris=
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
Subject: [v3 05/24] mm: thp: handle split failure in zap_pmd_range()
Date: Thu, 26 Mar 2026 19:08:47 -0700
Message-ID: <20260327021403.214713-6-usama.arif@linux.dev>
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

zap_pmd_range() splits a huge PMD when the zap range doesn't cover the
full PMD (partial unmap).  If the split fails, the PMD stays huge.
Falling through to zap_pte_range() would dereference the huge PMD entry
as a PTE page table pointer.

Skip the range covered by the PMD on split failure instead.

The skip is safe across all call paths into zap_pmd_range():

- exit_mmap() and OOM reaper: the zap range covers entire VMAs, so
  every PMD is fully covered (next - addr == HPAGE_PMD_SIZE).  The
  zap_huge_pmd() branch handles these without splitting.  The split
  failure path is unreachable.

- munmap / mmap overlay: vma_adjust_trans_huge() (called from
  __split_vma) splits any PMD straddling the VMA boundary before the
  VMA is split.  If that PMD split fails, __split_vma() returns
  -ENOMEM and the munmap is aborted before reaching zap_pmd_range().
  The split failure path is unreachable.

- MADV_DONTNEED: advisory hint, the kernel is allowed to ignore it.
  The pages remain valid and accessible.  A subsequent access returns
  existing data without faulting.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/memory.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e44469f9cf659..caf97c48cb166 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1985,9 +1985,18 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (pmd_is_huge(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE)
-				__split_huge_pmd(vma, pmd, addr, false);
-			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
+			if (next - addr != HPAGE_PMD_SIZE) {
+				/*
+				 * If split fails, the PMD stays huge.
+				 * Skip the range to avoid falling through
+				 * to zap_pte_range, which would treat the
+				 * huge PMD entry as a page table pointer.
+				 */
+				if (__split_huge_pmd(vma, pmd, addr, false)) {
+					addr = next;
+					continue;
+				}
+			} else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
 				addr = next;
 				continue;
 			}
-- 
2.52.0

