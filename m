Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6744C60C
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVAy75t8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yGHWwvwa9ptluj2TXfmc505uVrwpyYdKQ6Nqbo89xq8=; b=GVAy75t8wZgBFZolspMGdkhGk1
	Q+OuWbWred73FUR0ZawfK8zULaDHmubx9+2jOwB99Vo9oZH/pMaWhMvJjD2iHbEr7P21gker/gJNQ
	/3R4TY2ZbtVaPhzfDmWIASFIqC2tnfd9OPAylAbZ6D85c34S2GmCBw635V4rQ2ZXwwv/WuWclFIdU
	dVpsIsBS5wDTRW6mQm3ARubZlFcKRUpKVlGvEdHIxaU/vlJXRV+FDuuraMlgV48JoKUAz+kPeAlgd
	aK9zgJACTzU3CGYmoDtqaiNEJ0mnQ8BbH/vOz0hYINWLpRWDtGcvvk/V8NPbgmhL0rEzuRSF6l6Df
	x310vqmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9se-1b; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	david@redhat.com,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 00/10] mm: convert mm counter to take a folio
Date: Thu, 11 Jan 2024 15:24:19 +0000
Message-Id: <20240111152429.3374566-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure all mm_counter() and mm_counter_file() callers have a folio,
then convert mm counter functions to take a folio, which saves some
compound_head() calls.

v3:
 - Rebase on top of my similar patch to add pfn_swap_entry_folio()
 - Various wordsmithing & notes about where we're actually saving
   calls to compound_head().

v2:
- rebase on v6.7, since most of mm counter callers already with a folio,
  drop some unneeded changes.

v1:
- rename should_zap_page() to should_zap_folio(), per Matthew Wilcox
- pass page to page_remove_rmap/page_try_dup_anon_rmap for
  device private page, per Matthew Wilcox

Kefeng Wang (7):
  s390: use pfn_swap_entry_folio() in ptep_zap_swap_entry()
  mm: use pfn_swap_entry_folio() in __split_huge_pmd_locked()
  mm: use pfn_swap_entry_to_folio() in zap_huge_pmd()
  mm: use pfn_swap_entry_folio() in copy_nonpresent_pte()
  mm: Convert to should_zap_page() to should_zap_folio()
  mm: convert mm_counter() to take a folio
  mm: convert mm_counter_file() to take a folio

Matthew Wilcox (Oracle) (3):
  mm: Add pfn_swap_entry_folio()
  proc: Use pfn_swap_entry_folio where obvious
  mprotect: Use pfn_swap_entry_folio

 arch/s390/mm/pgtable.c  |  4 ++--
 fs/proc/task_mmu.c      |  4 ++--
 include/linux/mm.h      | 12 +++++-----
 include/linux/swapops.h | 13 +++++++++++
 kernel/events/uprobes.c |  2 +-
 mm/filemap.c            |  2 +-
 mm/huge_memory.c        | 23 ++++++++++---------
 mm/khugepaged.c         |  4 ++--
 mm/memory.c             | 49 ++++++++++++++++++++++-------------------
 mm/mprotect.c           |  4 ++--
 mm/rmap.c               | 10 ++++-----
 mm/userfaultfd.c        |  2 +-
 12 files changed, 74 insertions(+), 55 deletions(-)

-- 
2.43.0

