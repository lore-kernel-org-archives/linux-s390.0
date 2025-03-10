Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87849224240;
	Mon, 10 Mar 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600754; cv=none; b=Tz/H38gVU49oNbHpCyo/g4ILvU2czCipowOqzDnGaf7laGzi1qO062D/lMNRGdFixYVrquJfBmIZz56IUBvpRHpo37TXwIsDLVa/mj7uvaHQWWB+AKg+xA2Az2T3ZovRV4+gLzVgRdg1uH/E404cPN2Y0relTlSiDEBe4JchRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600754; c=relaxed/simple;
	bh=XH1y/JjcV/CKMZwziHUqjxzKZzlcynVjW+vD9avrsjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YhcHenhovLArCOPz6abR+XavLLAp/u5iHwhequn3u9JiDNUFivo1mZr/A1ZF3toHeDLSR2hb6IHlGan5azhIq75SDdesNXsjrgmWZe9Gh/adm2NvPcWgZBjVo4oD6/DMd20HC3kOQm9sEo5Ic4gNHIDsdpquphUx20LQO79jVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD8515A1;
	Mon, 10 Mar 2025 02:59:23 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.42.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59DE33F673;
	Mon, 10 Mar 2025 02:59:04 -0700 (PDT)
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
	linux-s390@vger.kernel.org
Subject: [RFC 0/2] mm/ptdump: Drop assumption that pxd_val() is u64
Date: Mon, 10 Mar 2025 15:29:00 +0530
Message-Id: <20250310095902.390664-1-anshuman.khandual@arm.com>
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

This series has been lightly tested on arm64 platform but it does build on
other relevant platforms (v6.14-rc5).

Some questions:

- Is there a better method to address this problem than splitting current
  note_page() into multiple call backs as proposed here ?

- This replaces note_page(st, 0, -1, 0) with note_page_pte(st, 0, pte_zero)
  Is that problematic ? Does level = -1 has got a special meaning ? Should
  level = -1 case be handled differently possibly via a separate callback ?

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
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

 arch/arm64/include/asm/ptdump.h | 22 ++++++++++++-----
 arch/arm64/mm/ptdump.c          | 41 ++++++++++++++++++++++++++++---
 arch/powerpc/mm/ptdump/ptdump.c | 37 ++++++++++++++++++++++++++--
 arch/riscv/mm/ptdump.c          | 37 ++++++++++++++++++++++++++--
 arch/s390/mm/dump_pagetables.c  | 37 ++++++++++++++++++++++++++--
 arch/x86/mm/dump_pagetables.c   | 31 +++++++++++++++++++++++-
 include/linux/ptdump.h          |  7 ++++--
 mm/ptdump.c                     | 43 +++++++++++++++++++++++++--------
 8 files changed, 226 insertions(+), 29 deletions(-)

-- 
2.25.1

