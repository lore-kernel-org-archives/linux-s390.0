Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00321A454;
	Mon, 17 Mar 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192326; cv=none; b=J3I4SvW22PIZPJkur9k85aHj02rf5cLnsR00qdQoTwGIYuNwJW2B3WXB0XbgVj13OqAQetypzMlp5J0e75Fxv2tMKLKXdopAKUg2GySwNXjB1NVUX3LlWDaKFiB/BLbphifxZeLvxmUFgj3/zYBvsIahhEH4GZgeCUGnGPm5v6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192326; c=relaxed/simple;
	bh=pY8Ytozw6CNLACzJxR2R/10S+fFYQn4ueqSWacLtSzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4BGT/ampel04g9ZMGSDiExwnhx8vZUJVoQZ0bLAlkMIAWJpAOKJyEM9ZWAoBpDP5AQcDdNKWGVMlcn+b5OUtqK/hqgdXeizUN9nu+x+gySsWs172u0zB+xhJmZxQxg1i02oBgPFkLdupVZDQeufHUfzTVQkCovi+Y77FqiaonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FFCB1BF3;
	Sun, 16 Mar 2025 23:18:53 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DC983F673;
	Sun, 16 Mar 2025 23:18:37 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/2] arm64/ptdump: Replace u64 with pteval_t
Date: Mon, 17 Mar 2025 11:48:18 +0530
Message-Id: <20250317061818.16244-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317061818.16244-1-anshuman.khandual@arm.com>
References: <20250317061818.16244-1-anshuman.khandual@arm.com>
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
 arch/arm64/include/asm/ptdump.h | 8 ++++----
 arch/arm64/mm/ptdump.c          | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index e5da9ce8a515..476a870489b9 100644
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
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index fd1610b4fd15..a5651be95868 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -194,7 +194,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
 	struct ptdump_pg_level *pg_level = st->pg_level;
 	static const char units[] = "KMGTPE";
-	u64 prot = 0;
+	pteval_t prot = 0;
 
 	/* check if the current level has been folded dynamically */
 	if (st->mm && ((level == 1 && mm_p4d_folded(st->mm)) ||
-- 
2.25.1

