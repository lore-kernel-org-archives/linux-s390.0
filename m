Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E514C3D7
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xdb6YNnx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=grYj7oDXTJx8wAhL05lTDgU26iqsxg0SBN9GKoUT5AE=; b=Xdb6YNnxxBXSES0V1LNS1egGU2
	clY+LLffhJGIXNu16qGhurri+B7H6+ljnMyT/GZA2dsuGUKFK6a7u+6lHWLOMnYPZyk2UyIy91Cel
	Rcl+JxphhKwHqOf2kVErU/0Zh/gLVJ+7V86Lqp3ep8aLvMY0kC2A9E3sKmLO0TBfnDctNSK+rD0kD
	YeApnLsNyt9pGyY9MmiIgxzFd8oTF1NC+XH9y9hHqCnB3cw3RwI2JKM1Wwl6LYY7RQO/zUbSpGRhX
	z2pWVhO4ETI/wG0PUTjbxmCJKKf3vUJggjWbCjrd+XDxHJ0y3uZagXZJavOntEfrQPSzhGroPYlNY
	ukjSqK9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9sm-Ir; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 04/10] s390: use pfn_swap_entry_folio() in ptep_zap_swap_entry()
Date: Thu, 11 Jan 2024 15:24:23 +0000
Message-Id: <20240111152429.3374566-5-willy@infradead.org>
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

Call pfn_swap_entry_folio() in ptep_zap_swap_entry() as preparation for
converting mm counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/mm/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 99422926efe1..7e5dd4b17664 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -721,9 +721,9 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 	if (!non_swap_entry(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
 	else if (is_migration_entry(entry)) {
-		struct page *page = pfn_swap_entry_to_page(entry);
+		struct folio *folio = pfn_swap_entry_folio(entry);
 
-		dec_mm_counter(mm, mm_counter(page));
+		dec_mm_counter(mm, mm_counter(&folio->page));
 	}
 	free_swap_and_cache(entry);
 }
-- 
2.43.0

