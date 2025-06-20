Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62178F39;
	Fri, 20 Jun 2025 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397086; cv=none; b=GvgKtMQAqa4uDM46E+huQGrnlW30etHhZzSfa9y+EUeUPmBKKmwCSlk3Pl4wXELSp8R6C81PRPWAV8G6bZRxqKPuA9QcdAHGJSnuTPjISIq7O4UPA0R6Fg5kCAA0pw92e4JLdnV2GGnRIYLjGRB8V3t9A0SSSgN0N1b7V9n211M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397086; c=relaxed/simple;
	bh=a+uVNoGq9fRm+96SWC94r9MWgC1I8tZ9OPaJZzfREv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hB32OTDz258g6IoRT7FEDD6nWIdfb7dfE0+/RF5sCK7MD0iEWNfPHVReZVy7/bDjrv3vrWtm1GZQipWoY46HYLvKa7DFfF2cuzcifV1LdJpo5BPmtXAB5Dtx8g0BHXR4nlBlAblFGA1dN+eJ4WrdFRdhGu+L8wW/J55bxJwNycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A973176A;
	Thu, 19 Jun 2025 22:24:23 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E98523F673;
	Thu, 19 Jun 2025 22:24:37 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: dev.jain@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2] mm/ptdump: Take the memory hotplug lock inside ptdump_walk_pgd()
Date: Fri, 20 Jun 2025 10:54:27 +0530
Message-Id: <20250620052427.2092093-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hot remove unmaps and tears down various kernel page table regions
as required. The ptdump code can race with concurrent modifications of the
kernel page tables. When leaf entries are modified concurrently, the dump
code may log stale or inconsistent information for a VA range, but this is
otherwise not harmful.

But when intermediate levels of kernel page table are freed, the dump code
will continue to use memory that has been freed and potentially reallocated
for another purpose. In such cases, the ptdump code may dereference bogus
addresses, leading to a number of potential problems.

To avoid the above mentioned race condition, platforms such as arm64, riscv
and s390 take memory hotplug lock, while dumping kernel page table via the
sysfs interface /sys/kernel/debug/kernel_page_tables.

Similar race condition exists while checking for pages that might have been
marked W+X via /sys/kernel/debug/kernel_page_tables/check_wx_pages which in
turn calls ptdump_check_wx(). Instead of solving this race condition again,
let's just move the memory hotplug lock inside generic ptdump_check_wx()
which will benefit both the scenarios.

Drop get_online_mems() and put_online_mems() combination from all existing
platform ptdump code paths.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
CC: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.16-rc2 and has been tested on arm64. Besides it
builds on riscv, s390, x86 and powerpc as well. But should the following
fixes tag from V1 also needs to be around as well ?

Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")

Changes in V2:

- Moved [get|put]_online_mems() inside generic ptdump_walk_pgd()

Changes in V1:

https://lore.kernel.org/all/20250609041214.285664-1-anshuman.khandual@arm.com/

 arch/arm64/mm/ptdump_debugfs.c | 3 ---
 arch/riscv/mm/ptdump.c         | 3 ---
 arch/s390/mm/dump_pagetables.c | 2 --
 mm/ptdump.c                    | 2 ++
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 68bf1a125502d..1e308328c0796 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
-#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptdump.h>
@@ -9,9 +8,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
 
-	get_online_mems();
 	ptdump_walk(m, info);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 32922550a50a3..3b51690cc8760 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,7 +6,6 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
-#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -413,9 +412,7 @@ bool ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
-	get_online_mems();
 	ptdump_walk(m, m->private);
-	put_online_mems();
 
 	return 0;
 }
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index ac604b1766609..9af2aae0a5152 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -247,11 +247,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = markers,
 	};
 
-	get_online_mems();
 	mutex_lock(&cpa_mutex);
 	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 	mutex_unlock(&cpa_mutex);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 9374f29cdc6f8..0a6965e2e7fa6 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -175,6 +175,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 {
 	const struct ptdump_range *range = st->range;
 
+	get_online_mems();
 	mmap_write_lock(mm);
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
@@ -182,6 +183,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 		range++;
 	}
 	mmap_write_unlock(mm);
+	put_online_mems();
 
 	/* Flush out the last page */
 	st->note_page_flush(st);
-- 
2.30.2

