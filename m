Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB24C623
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SumA547o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ylZ6GfCWdkm95QXmE5YeGp/GcqdnO5+70q964u8MBL8=; b=SumA547o68BIVFAVAWeLC0QQW2
	NALZ4tmVt2xXo3/c1xlq57lcAwyPCP2kKPW/A9z0fPfpbFFabXPOxNJI9ueJakDzELd4d2kBSuBt0
	k3jzIdFIv7HisV0LfiHPCeiZDSLaKI4SM46T1j2b5/nLq8I+4172YBORhTGv63LOlLSyP4oPJu2Ok
	TT8j5GYv8GpIFio2Gd1fpHiXxQBDNSkGvDDtVjoQvnklfKYa3RaixQ2eM8+Y00SeLpEd802nEAIIc
	vpMUgCt/xcJ0xJ6E/J43XNGBbNRYaUf5eT4FsNEu4ytz5xGjenITQpi9vLA0X69+aLGSuUrhqtoXj
	fnUBg2zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9ss-Sr; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 07/10] mm: use pfn_swap_entry_folio() in copy_nonpresent_pte()
Date: Thu, 11 Jan 2024 15:24:26 +0000
Message-Id: <20240111152429.3374566-8-willy@infradead.org>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Call pfn_swap_entry_folio() as preparation for converting mm counter
functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..60aa08f2ccdc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -806,9 +806,9 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		}
 		rss[MM_SWAPENTS]++;
 	} else if (is_migration_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+		folio = pfn_swap_entry_folio(entry);
 
-		rss[mm_counter(page)]++;
+		rss[mm_counter(&folio->page)]++;
 
 		if (!is_readable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
-- 
2.43.0

