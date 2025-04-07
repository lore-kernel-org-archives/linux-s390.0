Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B26224241;
	Mon,  7 Apr 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003903; cv=none; b=tRL0EOB6bdpxzQzSCWbMBZIpfc05g0+hVzM2EXGOBdx9fT4fx7XmF4EwD/WeW5vd/IB4WYnpZPMOOlq+SE8UUKTsLB+f3456+Cq/ZcicNfOzW4N1tN8IrftkZleSeiuaQOMT+Xvac6oj1iUY9zY9eHYSEi5P4N21N/k+KdyeE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003903; c=relaxed/simple;
	bh=Kws5l7VmGmx5n9kHBtqOoPT5ggHs3eL0T6dQICtkcbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAjYMdIjr6pDXdQO68PzntMJew0Q0zyZhvx3qk1Z45OUJUDhPXVp75w3lBK2feXu0eX3eN+VQJHz0MbXE40CHHcQN/TtujC6rWELVn77jKkKmr1wLh+RsxOKZBKyyZNUXd8udTVk9Q5WS0nHLJomeRANMLT+CwaVXpSUzCKttvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73871BB0;
	Sun,  6 Apr 2025 22:31:41 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA4633F6A8;
	Sun,  6 Apr 2025 22:31:33 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: mark.rutland@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V2 2/3] mm/ptdump: Split effective_prot() into level specific callbacks
Date: Mon,  7 Apr 2025 11:01:12 +0530
Message-Id: <20250407053113.746295-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407053113.746295-1-anshuman.khandual@arm.com>
References: <20250407053113.746295-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last argument in effective_prot() is u64 assuming pxd_val() returned value
(all page table levels) is 64 bit. pxd_val() is very platform specific and
its type should not be assumed in generic MM.

Split effective_prot() into individual page table level specific callbacks
which accepts corresponding pxd_t argument instead and then the subscribing
platform (only x86) just derive pxd_val() from the entries as required and
proceed as earlier.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/ptdump.h        |  6 +++++-
 mm/ptdump.c                   | 20 ++++++++++----------
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2e1c2d006ace..a4700ef6eb64 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -266,6 +266,32 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
 	st->prot_levels[level] = effective;
 }
 
+static void effective_prot_pte(struct ptdump_state *st, pte_t pte)
+{
+	effective_prot(st, 4, pte_val(pte));
+}
+
+static void effective_prot_pmd(struct ptdump_state *st, pmd_t pmd)
+{
+	effective_prot(st, 3, pmd_val(pmd));
+}
+
+static void effective_prot_pud(struct ptdump_state *st, pud_t pud)
+{
+	effective_prot(st, 2, pud_val(pud));
+}
+
+static void effective_prot_p4d(struct ptdump_state *st, p4d_t p4d)
+{
+	effective_prot(st, 1, p4d_val(p4d));
+}
+
+static void effective_prot_pgd(struct ptdump_state *st, pgd_t pgd)
+{
+	effective_prot(st, 0, pgd_val(pgd));
+}
+
+
 /*
  * This function gets called on a break in a continuous series
  * of PTE entries; the next one is different so we need to
@@ -416,7 +442,11 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
 			.note_page_p4d = note_page_p4d,
 			.note_page_pgd = note_page_pgd,
 			.note_page_flush = note_page_flush,
-			.effective_prot = effective_prot,
+			.effective_prot_pte = effective_prot_pte,
+			.effective_prot_pmd = effective_prot_pmd,
+			.effective_prot_pud = effective_prot_pud,
+			.effective_prot_p4d = effective_prot_p4d,
+			.effective_prot_pgd = effective_prot_pgd,
 			.range		= ptdump_ranges
 		},
 		.level = -1,
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 1c1eb1fae199..240bd3bff18d 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -17,7 +17,11 @@ struct ptdump_state {
 	void (*note_page_p4d)(struct ptdump_state *st, unsigned long addr, p4d_t p4d);
 	void (*note_page_pgd)(struct ptdump_state *st, unsigned long addr, pgd_t pgd);
 	void (*note_page_flush)(struct ptdump_state *st);
-	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
+	void (*effective_prot_pte)(struct ptdump_state *st, pte_t pte);
+	void (*effective_prot_pmd)(struct ptdump_state *st, pmd_t pmd);
+	void (*effective_prot_pud)(struct ptdump_state *st, pud_t pud);
+	void (*effective_prot_p4d)(struct ptdump_state *st, p4d_t p4d);
+	void (*effective_prot_pgd)(struct ptdump_state *st, pgd_t pgd);
 	const struct ptdump_range *range;
 };
 
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 706cfc19439b..9374f29cdc6f 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -38,8 +38,8 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
-	if (st->effective_prot)
-		st->effective_prot(st, 0, pgd_val(val));
+	if (st->effective_prot_pgd)
+		st->effective_prot_pgd(st, val);
 
 	if (pgd_leaf(val)) {
 		st->note_page_pgd(st, addr, val);
@@ -61,8 +61,8 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
-	if (st->effective_prot)
-		st->effective_prot(st, 1, p4d_val(val));
+	if (st->effective_prot_p4d)
+		st->effective_prot_p4d(st, val);
 
 	if (p4d_leaf(val)) {
 		st->note_page_p4d(st, addr, val);
@@ -84,8 +84,8 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
-	if (st->effective_prot)
-		st->effective_prot(st, 2, pud_val(val));
+	if (st->effective_prot_pud)
+		st->effective_prot_pud(st, val);
 
 	if (pud_leaf(val)) {
 		st->note_page_pud(st, addr, val);
@@ -106,8 +106,8 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
-	if (st->effective_prot)
-		st->effective_prot(st, 3, pmd_val(val));
+	if (st->effective_prot_pmd)
+		st->effective_prot_pmd(st, val);
 	if (pmd_leaf(val)) {
 		st->note_page_pmd(st, addr, val);
 		walk->action = ACTION_CONTINUE;
@@ -122,8 +122,8 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pte_t val = ptep_get_lockless(pte);
 
-	if (st->effective_prot)
-		st->effective_prot(st, 4, pte_val(val));
+	if (st->effective_prot_pte)
+		st->effective_prot_pte(st, val);
 
 	st->note_page_pte(st, addr, val);
 
-- 
2.25.1

