Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CD4BAB5
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pPLym1Dn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NG4y6T5mz41ygruMS3SPucdfvQG3VJprEVuTqUHC614=; b=pPLym1DnNyymWjJALWJjq2mHEM
	u4qfQouuoLahhYk4rmRuCH3aBEuXKY2qzRFtdZBV9nqNlbL3w1bznnWqZ2cjz1V7pKPdNXC+KwSrc
	RjG3Kao3b7GmlG8ugDoLZwF4ONppDbbEjAZP9VBAuaXWEyyVsVK6pSA2BfV47VryGC/vDhO4aGQZD
	wgNAQo7kiXKQksSHJHZ40YZzGE56PMXLqBndckgnu3EJAx2GdlENwLHxHllsNpSf8f12YnBVU1mzG
	LGOBQ+NummSIPdHsBYyh/VtX9c2z4DtMxWzEzgIg9j2VDsBrnPRHhl+lyMZofy39Pd38bP+x5JraV
	oN3zt/gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9si-DR; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	david@redhat.com,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 02/10] proc: Use pfn_swap_entry_folio where obvious
Date: Thu, 11 Jan 2024 15:24:21 +0000
Message-Id: <20240111152429.3374566-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111152429.3374566-1-willy@infradead.org>
References: <20240111152429.3374566-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These callers only pass the result to PageAnon(), so we can save the
extra call to compound_head() by using pfn_swap_entry_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 62b16f42d5d2..6e75bfd6c3f8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1807,7 +1807,7 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			swp = pte_to_swp_entry(pte);
 			if (is_pfn_swap_entry(swp) &&
-			    !PageAnon(pfn_swap_entry_to_page(swp)))
+			    !folio_test_anon(pfn_swap_entry_folio(swp)))
 				categories |= PAGE_IS_FILE;
 		}
 		if (pte_swp_soft_dirty(pte))
@@ -1873,7 +1873,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			swp = pmd_to_swp_entry(pmd);
 			if (is_pfn_swap_entry(swp) &&
-			    !PageAnon(pfn_swap_entry_to_page(swp)))
+			    !folio_test_anon(pfn_swap_entry_folio(swp)))
 				categories |= PAGE_IS_FILE;
 		}
 	}
-- 
2.43.0

