Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB321505B;
	Mon, 17 Mar 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192314; cv=none; b=Jtwq2cgCaeE4jSbz6iGJE/RS3l3K/MFi7PVFaSG9m9zzIJ8A5lJSBSUTol/HLJpJZHi5lqsdhZjHfHE8PI57K+e5ckil7lkwd5Nkcj8Iccw2HumMNDqc17CPKZCzYmJ8n4g3+mxsiL2rdu+wMfL3CDqUQB+RHyko5y5UDPPvf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192314; c=relaxed/simple;
	bh=K24zDlNib5c1ikzayHI3B8zx/mMqGWPp+2Y0TLG60Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYvbrdukJST9WBdCPA1phV51UQDHjo8aKhncKfSgc3nCC57JDkkJcB0WCzvnC/jce7lEYeGqWBDfBgyrvkTN48T9cXZ54We7h/BXYMNz3AOXn2qBrfp7epliCw3IeUkrxEtyYqdKHWxV4HesS+tqsu1rFf+nZe6a1Bzs2+jE3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2595E13D5;
	Sun, 16 Mar 2025 23:18:39 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A6203F673;
	Sun, 16 Mar 2025 23:18:23 -0700 (PDT)
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
	linux-s390@vger.kernel.org
Subject: [PATCH 0/2] mm/ptdump: Drop assumption that pxd_val() is u64
Date: Mon, 17 Mar 2025 11:48:16 +0530
Message-Id: <20250317061818.16244-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last argument passed down in note_page() is u64 assuming pxd_val() returned
value (all page table levels) is 64 bit - which might not be the case going
ahead when D128 page tables is enabled on arm64 platform. Besides pxd_val()
is very platform specific and its type should not be assumed in generic MM.

This series splits note_page() into individual page table level specific
callbacks which accepts corresponding pxd_t page table entry as an argument
instead and later all subscribing platforms could derive pxd_val() from the
entries as required and proceed as before.

Page table entry's value, mask and protection are represented with pteval_t
not u64 that has been assumed while dumping the page table entries on arm64
platform. Replace such u64 instances with pteval_t instead as expected.

This series has been tested on arm64 platform but it does build on other
relevant platforms (v6.14-rc7).

Changes in V1:

- Added note_page_flush() callback and implemented the same on all
  subscribing platforms
- Moved note_page() argument change from u64 to pteval_t on arm64 platform
  from second patch to the first patch instead

Changes in RFC:

https://lore.kernel.org/all/20250310095902.390664-1-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org

Anshuman Khandual (2):
  mm/ptdump: Split note_page() into level specific callbacks
  arm64/ptdump: Replace u64 with pteval_t

 arch/arm64/include/asm/ptdump.h | 24 ++++++++++++----
 arch/arm64/mm/ptdump.c          | 50 ++++++++++++++++++++++++++++++---
 arch/powerpc/mm/ptdump/ptdump.c | 46 ++++++++++++++++++++++++++++--
 arch/riscv/mm/ptdump.c          | 46 ++++++++++++++++++++++++++++--
 arch/s390/mm/dump_pagetables.c  | 46 ++++++++++++++++++++++++++++--
 arch/x86/mm/dump_pagetables.c   | 39 ++++++++++++++++++++++++-
 include/linux/ptdump.h          |  9 ++++--
 mm/ptdump.c                     | 42 ++++++++++++++++++++-------
 8 files changed, 272 insertions(+), 30 deletions(-)

-- 
2.25.1

