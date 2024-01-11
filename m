Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C474BAB5
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0nsiLkS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BfP/fGwBklnFZaYvawDWMaMKV/+8upyp4Stw7tV+DLE=; b=R0nsiLkSkD/AHtpue3+mNyRKTe
	E7sf7B2vnUbfKLKR3BihhqaUE29FmRIivR60JM4+O2M7YKN4FE0o9W4to9d0k2VYv1iWe0QV9zOTE
	mIIy6vy5ujGuW8RGVk/WS0lAHnJVwluedehEzchUYhoT7Dbpl/I8fC/9MOaGFI12tGKynmU8Q7dGL
	cRaxSEq7Fpa5LTjmob0aYXGAZmmTKdIX9tSMFwFQqwMFpR3lt6f+0rupEYOiz+s5cU9kEnr/XjlKY
	Fd6ZjDwTBk8CxmhoU6DV89R2O8KvFIF2RN7xz7xb6LWeCrSanosJuVWZed4/BjUJfSwNTuHd1njUU
	OFcwIE0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9sk-G8; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	david@redhat.com,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 03/10] mprotect: Use pfn_swap_entry_folio
Date: Thu, 11 Jan 2024 15:24:22 +0000
Message-Id: <20240111152429.3374566-4-willy@infradead.org>
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

We only want to know whether the folio is anonymous, so use
pfn_swap_entry_folio() and save a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mprotect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 81991102f785..f8a4544b4601 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -198,13 +198,13 @@ static long change_pte_range(struct mmu_gather *tlb,
 			pte_t newpte;
 
 			if (is_writable_migration_entry(entry)) {
-				struct page *page = pfn_swap_entry_to_page(entry);
+				struct folio *folio = pfn_swap_entry_folio(entry);
 
 				/*
 				 * A protection check is difficult so
 				 * just be safe and disable write
 				 */
-				if (PageAnon(page))
+				if (folio_test_anon(folio))
 					entry = make_readable_exclusive_migration_entry(
 							     swp_offset(entry));
 				else
-- 
2.43.0

