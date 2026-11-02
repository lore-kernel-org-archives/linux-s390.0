Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626196;
	b=xHKR+PIP90jbf8R6n6t7E377rS+4y3shulO6n/4F28xIPsrXqn9TJDTjZk3JjdK7QSLp
	 XKHIvvE8aoWK6/7fitcfaVbx6SsbmQ+6zhFTplpCO7PKNBQoC4xdFNzli4ljtWAsfpMyc
	 5O0Ru12kr03yg/vOFcoFAnkj3b39WoR5tesztLZzTCpioeq0aH+NFf+Zmnp/4gq8eZaRX
	 PEuIjmpFye+pRrN5ynWdkmKqGltAzfJOADdv+pMl4KM0+DkI+aSyUXv09W6Yn4lJkI3rq
	 L+bJqeTKT6SNMkDzdbO/O3XiWH0eJFsnYbKEoWHmeZnyIJFFB+uqhEiQFMW4ZHou9pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626196;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWVE/AqRKRaVNddmv6NG+nhnU89aW+d0SMAU+Uuclug=;
	b=HakqKJToSAjLRAwMDhr24tieqWgw4RkG0xEssoH8kPmVkQiwgBx1vkN51HAorYYJIzqb
	 o9hdlXSfGbMzgVPQajhRBQayX5UQMEQSH9I8cvA9viUGNDViv8XR2RH3Egg3O2dhorj/y
	 vOvY6QvqgWgZ5lG3/p3Ymta/CLuoQQJpWFKU8WG/elMZbKSGdYgm1BlrQA/FLhJ+OoSL4
	 ljTDG+xB11INZ5EeSFlA/vQMAUyhfTpp7X04cN541NBNf7YlGDjlJZN2TcOZylwwqAv4o
	 HuqsO92tzId//AprWY6njX0yYYFD8jM8suj9AYlOCCYtv8g71ltLFJ26MURaxNVu3kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gOKGLvIO;
	arc=none smtp.remote-ip=95.215.58.189
Received: from mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B3606A327
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 13:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33B3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gOKGLvIO
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oTSssby8yHdQ2jW4COWEzOnQpMmBT2IW4EkQbQx53ao=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793626194; v=1; x=1794230994;
 b=gOKGLvIOSmkS2OG+LA2rWuw8FXD4Vyi6jCqX/OUMEy3h1wFH5gMa4b0sp28yMfzkngp56N1p
 4k1YsUvgYns2foURZFG18EpK7xFQK5t5Ndl8wwk3wNCRHGjCMNrTOVfc+oi8WCCxdw8PQAD7d34
 zOYyIyLx4OpILSV7czNcJS9s=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d9179c91a3ca1243;
	Mon, 02 Nov 2026 13:29:53 +0000
X-Mizu-Trace-ID: d9179c91a3ca1243
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	byungchul@sk.com,
	chengming.zhou@linux.dev,
	david@kernel.org,
	dev.jain@arm.com,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	gourry@gourry.net,
	harry@kernel.org,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jannh@google.com,
	jolsa@kernel.org,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	ljs@kernel.org,
	mark.rutland@arm.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	nico.pache@linux.dev,
	oleg@redhat.com,
	peterz@infradead.org,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	svens@linux.ibm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	xialonglong2025@163.com
Subject: [PATCH v2 2/4] mm: make folio_walk_start()'s locking asserts scalable
Date: Mon,  2 Nov 2026 21:29:27 +0800
Message-Id: <20261102132927.301921-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102132416.300084-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Xin <xu.xin@linux.dev>

Add an additional member 'walk_lock' to folio_walk to indicate
locking requirements for the walk. Similar to commit 49b0638502da0
("mm: enable page walking API to lock vmas during the walk").
But no change is made on any existing locking behavior,
all existing folio_walk_start() callers are currently still
under mmap_read_lock() protection.

This change is prepared for the later patch to enable VMA locking
asserts. folio_walk_start now operate under write-locked mmap_lock.
With introduction of vma locks at the next patch, the vmas have to
be locked as well during such walks to prevent concurrent page
faults in these areas.

No functional change intended.

Signed-off-by: Xu Xin <xu.xin@linux.dev>
---
 arch/s390/mm/fault.c     |  4 +++-
 include/linux/pagewalk.h |  1 +
 kernel/events/uprobes.c  |  4 +++-
 mm/huge_memory.c         |  4 +++-
 mm/ksm.c                 |  4 +++-
 mm/migrate.c             |  8 ++++++--
 mm/pagewalk.c            | 10 +++++++++-
 mm/rmap.c                |  4 +++-
 8 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 46d828926009..968f128a5232 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -412,7 +412,9 @@ __context_unsafe(/* folio_walk_end() not instrumented */)
 	unsigned long addr = get_fault_address(regs);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct folio_walk fw;
+	struct folio_walk fw = {
+		.walk_lock  = PGWALK_RDLOCK,
+	};
 	struct folio *folio;
 	int rc;
 
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 1c397be0d092..455428eaf1fc 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -184,6 +184,7 @@ struct folio_walk {
 	};
 	/* private */
 	spinlock_t *ptl;
+	enum page_walk_lock walk_lock;
 };
 
 struct folio *folio_walk_start(struct folio_walk *fw,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..3e3927109ee9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -507,7 +507,9 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	int ret, ref_ctr_updated = 0;
 	unsigned int gup_flags = FOLL_FORCE;
 	struct mmu_notifier_range range;
-	struct folio_walk fw;
+	struct folio_walk fw = {
+		.walk_lock  = PGWALK_RDLOCK,
+	};
 	struct folio *folio;
 	struct page *page;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e8684..62ec81396c9d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4816,7 +4816,9 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 	 */
 	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
-		struct folio_walk fw;
+		struct folio_walk fw = {
+			.walk_lock  = PGWALK_RDLOCK,
+		};
 		struct folio *folio;
 		struct address_space *mapping;
 		unsigned int target_order = new_order;
diff --git a/mm/ksm.c b/mm/ksm.c
index d6f736a1aa2f..d4fc0b0965aa 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -819,8 +819,10 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 	unsigned long addr = rmap_item->address;
 	struct vm_area_struct *vma;
 	struct page *page = NULL;
-	struct folio_walk fw;
 	struct folio *folio;
+	struct folio_walk fw = {
+		.walk_lock  = PGWALK_RDLOCK,
+	};
 
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
diff --git a/mm/migrate.c b/mm/migrate.c
index 875079464930..89662d5bedf4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2301,7 +2301,9 @@ static int add_folio_for_migration(struct mm_struct *mm, const void __user *p,
 		int node, struct list_head *pagelist, bool migrate_all)
 {
 	struct vm_area_struct *vma;
-	struct folio_walk fw;
+	struct folio_walk fw = {
+		.walk_lock  = PGWALK_RDLOCK,
+	};
 	struct folio *folio;
 	unsigned long addr;
 	int err = -EFAULT;
@@ -2463,7 +2465,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	for (i = 0; i < nr_pages; i++) {
 		unsigned long addr = (unsigned long)untagged_addr_remote(mm, *pages);
 		struct vm_area_struct *vma;
-		struct folio_walk fw;
+		struct folio_walk fw = {
+			.walk_lock  = PGWALK_RDLOCK,
+		};
 		struct folio *folio;
 		int err = -EFAULT;
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e6493bbe6919..7d85289fcb87 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -910,7 +910,15 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 	pgd_t *pgdp;
 	p4d_t *p4dp;
 
-	mmap_assert_locked(vma->vm_mm);
+	/*
+	 * Other locking modes except for mmap or vma read locking are not
+	 * expected.
+	 */
+	if (fw->walk_lock != PGWALK_RDLOCK && fw->walk_lock != PGWALK_VMA_RDLOCK_VERIFY)
+		WARN_ONCE(1, "walk_lock is not expected!\n");
+	process_mm_walk_lock(vma->vm_mm, fw->walk_lock);
+	process_vma_walk_lock(vma, fw->walk_lock);
+
 	vma_pgtable_walk_begin(vma);
 
 	if (WARN_ON_ONCE(addr < vma->vm_start || addr >= vma->vm_end))
diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc2..6e3bc2acd1d7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2862,7 +2862,9 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	struct mmu_notifier_range range;
 	struct folio *folio, *fw_folio;
 	struct vm_area_struct *vma;
-	struct folio_walk fw;
+	struct folio_walk fw = {
+		.walk_lock  = PGWALK_RDLOCK,
+	};
 	struct page *page;
 	swp_entry_t entry;
 	pte_t swp_pte;
-- 
2.34.1

