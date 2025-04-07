Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E141C6B4;
	Mon,  7 Apr 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003894; cv=none; b=WeapvPa6gtKTYzLKoYz12mhwa6SUrWg/bGAVDXZ6CjDWI8eBT4PNVsZw+1PQTA9wtL/uXHdigJ5pI0Wb0/sCgOngFhA9OUH/bRTqIiC0FrqCyG+ChEQXNF4b4Y6fVSW3yV8mywozI0n3zJKdbOa/qDZzy7whB3ja+R5VV3wAV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003894; c=relaxed/simple;
	bh=vzKn42vmU3YBYe5mDLuqrSyTsvv4kVJ8L+DKlZiid1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gl/+YBJH5uYfqIf3SP0HaJy/Lc19Cq/uk7JkoKUXVWVwrHmM61gsjdlqsW/+tXxzbPjN+3ZFO00wLTJSs0v2uStH2je2U9UCcRq3AeA5+seb999buaHaL4aPqa3JPREnH9sJuOpTxmL9ZgQCT67juftPAKK6E4HqNz01CMkuPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B171F106F;
	Sun,  6 Apr 2025 22:31:26 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 527C93F6A8;
	Sun,  6 Apr 2025 22:31:18 -0700 (PDT)
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
	linux-s390@vger.kernel.org
Subject: [PATCH V2 0/3] mm/ptdump: Drop assumption that pxd_val() is u64
Date: Mon,  7 Apr 2025 11:01:10 +0530
Message-Id: <20250407053113.746295-1-anshuman.khandual@arm.com>
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
A similar problem exists for effective_prot(), although it is restricted to
x86 platform.

This series splits note_page() and effective_prot() into individual page
table level specific callbacks which accepts corresponding pxd_t page table
entry as an argument instead and later on all subscribing platforms could
derive pxd_val() from the table entries as required and proceed as before.

Define ptdesc_t type which describes the basic page table descriptor layout
on arm64 platform. Subsequently all level specific pxxval_t descriptors are
derived from ptdesc_t thus establishing a common original format, which can
also be appropriate for page table entries, masks and protection values etc
which are used at all page table levels.

This series has been tested on arm64 platform but it does build on other
relevant platforms (v6.15-rc1).

Changes in V2:

- Added a patch to split effective_prot() callback per Alexander
- Added a patch to define ptdesc_t data type on arm64 platform per Ryan

Changes in V1:

https://lore.kernel.org/all/20250317061818.16244-1-anshuman.khandual@arm.com/

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
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org

Anshuman Khandual (3):
  mm/ptdump: Split note_page() into level specific callbacks
  mm/ptdump: Split effective_prot() into level specific callbacks
  arm64/mm: Define ptdesc_t

 arch/arm64/include/asm/pgtable-types.h | 20 +++++---
 arch/arm64/include/asm/ptdump.h        | 24 ++++++---
 arch/arm64/kernel/efi.c                |  4 +-
 arch/arm64/kernel/pi/map_kernel.c      |  2 +-
 arch/arm64/kernel/pi/map_range.c       |  4 +-
 arch/arm64/kernel/pi/pi.h              |  2 +-
 arch/arm64/mm/mmap.c                   |  2 +-
 arch/arm64/mm/ptdump.c                 | 50 ++++++++++++++++--
 arch/powerpc/mm/ptdump/ptdump.c        | 46 ++++++++++++++++-
 arch/riscv/mm/ptdump.c                 | 46 ++++++++++++++++-
 arch/s390/mm/dump_pagetables.c         | 46 ++++++++++++++++-
 arch/x86/mm/dump_pagetables.c          | 71 +++++++++++++++++++++++++-
 include/linux/ptdump.h                 | 15 ++++--
 mm/ptdump.c                            | 62 ++++++++++++++--------
 14 files changed, 339 insertions(+), 55 deletions(-)

-- 
2.25.1

