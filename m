Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2314F9E;
	Thu, 11 Jan 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T9hpj0FN4zsVcd;
	Thu, 11 Jan 2024 19:12:45 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id DCDE818006E;
	Thu, 11 Jan 2024 19:13:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 19:13:30 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/8] mm: swap: introduce pfn_swap_entry_to_folio()
Date: Thu, 11 Jan 2024 19:12:32 +0800
Message-ID: <20240111111239.2453282-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
References: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
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

Introduce a new pfn_swap_entry_to_folio(), it is similar to
pfn_swap_entry_to_page(), but return a folio, which allow us
to completely replace the struct page variables with struct
folio variables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/swapops.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index bff1e8d97de0..85cb84e4be95 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -468,6 +468,19 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 	return p;
 }
 
+static inline struct folio *pfn_swap_entry_to_folio(swp_entry_t entry)
+{
+	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
+
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked
+	 */
+	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
+
+	return folio;
+}
+
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
  * in the swap offset. They are used to represent unaddressable device memory
-- 
2.27.0

