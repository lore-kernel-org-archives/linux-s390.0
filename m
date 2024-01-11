Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1215483;
	Thu, 11 Jan 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T9hph5J6mz1Q7J4;
	Thu, 11 Jan 2024 19:12:44 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EC94140384;
	Thu, 11 Jan 2024 19:13:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 19:13:29 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/8] mm: convert mm counter to take a folio 
Date: Thu, 11 Jan 2024 19:12:31 +0800
Message-ID: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Make all mm_counter() and mm_counter_file() callers to use a folio,
then convert mm counter functions to take a folio, which saves some
of compound_head() calls.

v2:
- rebase on v6.7, since most of mm counter callers already with a folio,
  drop some unneeded changes.

v1:
- rename should_zap_page() to should_zap_folio(), per Matthew Wilcox 
- pass page to page_remove_rmap/page_try_dup_anon_rmap for
  device private page, per Matthew Wilcox

Kefeng Wang (8):
  mm: swap: introduce pfn_swap_entry_to_folio()
  s390: pgtable: use pfn_swap_entry_to_folio() in ptep_zap_swap_entry()
  mm: huge_memory: use pfn_swap_entry_to_folio() in
    __split_huge_pmd_locked()
  mm: huge_memory: use pfn_swap_entry_to_folio() in zap_huge_pmd()
  mm: memory: use pfn_swap_entry_to_folio() in copy_nonpresent_pte()
  mm: memory: convert to should_zap_folio()
  mm: convert mm_counter() to take a folio
  mm: convert mm_counter_file() to take a folio

 arch/s390/mm/pgtable.c  |  4 ++--
 include/linux/mm.h      | 12 +++++-----
 include/linux/swapops.h | 13 +++++++++++
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        | 21 ++++++++++--------
 mm/khugepaged.c         |  4 ++--
 mm/memory.c             | 49 ++++++++++++++++++++++-------------------
 mm/rmap.c               | 10 ++++-----
 mm/userfaultfd.c        |  2 +-
 9 files changed, 68 insertions(+), 49 deletions(-)

-- 
2.27.0

