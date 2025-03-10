Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C032AE93;
	Mon, 10 Mar 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600768; cv=none; b=Zv4o4nNirxJp+y21AZisArQE4dt/NT9xKeY+IVLy5fByw0mdpQy7tqg+zcseduLSCFNVEHfIMoYb+83bRu0shs22YidAdlsqoL3EQWxEUzbK6/lIHfYkUdpP0tQS6YzBUkcHvcZeFd27BZiGKLslfBDun0MpoG2v+rK90GtYHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600768; c=relaxed/simple;
	bh=nOsFQq3rKL4YonQQCQPrpTwWAHNMeeMHV+wVDjTJLC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCBfnwaycaJhmW+k0TN+x9hA2y7P5IjQx2a9Tais4wlFHm+C9dH3u9RsRvEYXCV0OSrwtqFqrQGNHepqnwf16XWOYZ6yBTeqaBje4uBLHSiGP9mO8OC/63Wlvc/cTh4bs/Etz1Oxro2QEJ1IsK6q1pZZCBzMbfMqhYKXhu4SuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF12826BA;
	Mon, 10 Mar 2025 02:59:37 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.42.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB0C43F673;
	Mon, 10 Mar 2025 02:59:19 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: [RFC 2/2] arm64/ptdump: Replace u64 with pteval_t
Date: Mon, 10 Mar 2025 15:29:02 +0530
Message-Id: <20250310095902.390664-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310095902.390664-1-anshuman.khandual@arm.com>
References: <20250310095902.390664-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page table entry's value, mask and protection are represented with pteval_t
data type format not u64 that has been assumed while dumping the page table
entries. Replace all such u64 instances with pteval_t instead as required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/ptdump.h | 12 ++++++------
 arch/arm64/mm/ptdump.c          |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 8baba0d1aa8f..8ade657547f9 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -24,8 +24,8 @@ struct ptdump_info {
 };
 
 struct ptdump_prot_bits {
-	u64		mask;
-	u64		val;
+	pteval_t	mask;
+	pteval_t	val;
 	const char	*set;
 	const char	*clear;
 };
@@ -34,7 +34,7 @@ struct ptdump_pg_level {
 	const struct ptdump_prot_bits *bits;
 	char name[4];
 	int num;
-	u64 mask;
+	pteval_t mask;
 };
 
 /*
@@ -51,7 +51,7 @@ struct ptdump_pg_state {
 	const struct mm_struct *mm;
 	unsigned long start_address;
 	int level;
-	u64 current_prot;
+	pteval_t current_prot;
 	bool check_wx;
 	unsigned long wx_pages;
 	unsigned long uxn_pages;
@@ -59,7 +59,7 @@ struct ptdump_pg_state {
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-	       u64 val);
+	       pteval_t val);
 void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte);
 void note_page_pmd(struct ptdump_state *st, unsigned long addr, pmd_t pmd);
 void note_page_pud(struct ptdump_state *st, unsigned long addr, pud_t pud);
@@ -74,7 +74,7 @@ static inline void ptdump_debugfs_register(struct ptdump_info *info,
 #endif /* CONFIG_PTDUMP_DEBUGFS */
 #else
 static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
-			     int level, u64 val) { }
+			     int level, pteval_t val) { }
 static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
 static inline void note_page_pmd(struct ptdump_state *st, unsigned long addr, pmd_t pmd) { }
 static inline void note_page_pud(struct ptdump_state *st, unsigned long addr, pud_t pud) { }
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 0c66c8474a48..7950c0e9e89c 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -189,12 +189,12 @@ static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
 }
 
 void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-	       u64 val)
+	       pteval_t val)
 {
 	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
 	struct ptdump_pg_level *pg_level = st->pg_level;
 	static const char units[] = "KMGTPE";
-	u64 prot = 0;
+	pteval_t prot = 0;
 
 	/* check if the current level has been folded dynamically */
 	if (st->mm && ((level == 1 && mm_p4d_folded(st->mm)) ||
-- 
2.25.1

