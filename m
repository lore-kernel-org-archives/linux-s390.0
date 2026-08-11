Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18532C3251;
	Tue, 11 Aug 2026 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422094; cv=none; b=tTH5CxmyTwIjtpijyUWBEHLqglC8K96f5zbpSeqjwLDI0JRCaod/hefj1NL/gqIfvjHnYf4i0anOze/CCFmEqzeqpwPcGptMJZ5yuL4YUhGuvjNTfPhqQ2ZnXIMkVEFnvba9TCike5RBE5IJSp5XjVs0+uYaij4E9OYOtAd4vTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422094; c=relaxed/simple;
	bh=U4Z1uTiwNPlptM0+2YMoqojdlsHVf+3xXUYXjiCQ8pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pH0xt5lUp9T3AE1p+9CXrRSwvEIuIdLrFVgrvZYwZe3/pNjIpDJrLJVl4kTo9eF7dNjGeLBcN1YcV0de1u8GZ6KyPq0YS8E6tBl73BB8tKKp3NzTSPJ7+ChknIr1g0rsGncUX1eTp36wKwHVTuXTojxJVz3ijrTiJuDLtX5GbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GopI0I0f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GopI0I0f"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39B3114BF;
	Mon, 10 Aug 2026 21:21:21 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E55B3F673;
	Mon, 10 Aug 2026 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422085; bh=U4Z1uTiwNPlptM0+2YMoqojdlsHVf+3xXUYXjiCQ8pk=;
	h=From:To:Cc:Subject:Date:From;
	b=GopI0I0fYfwHaaeo2Y1tRcsF2e/amGL0odHVP/X1kESNXKYqhycXNoTsAuQ3kbLz6
	 6aWj1XpWWD5XHhdxDVLSsmNEIV5BHzcUh5zug5WGO5oBPaTxRMDHz11rcK3BnPzn8e
	 wSjaNCIByq50FgWv0gwZJCSc7yloLZqXMTvqJhr0=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 0/6] mm: Drop pxd_ERROR()
Date: Tue, 11 Aug 2026 09:51:13 +0530
Message-ID: <20260811042119.3652929-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxd_ERROR() macros have been provided by all platforms, which are very much
identical and can be dropped off completely if these pgtable printing could
be moved to callers in generic MM aka all pxd_clear_bad().

But first cleanups and re-organizations are required in some platforms that
are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
macros have been completely dropped from the entire tree.

This series is based on v7.2-rc7 after the following patch. This has also
been built tested on multiple platforms.

https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/

Changes in RFC V2:

- Added clean up patches for platforms with existing pxd_ERROR() usage
- Dropped __FILE__ and __LINE__ from all pgtable entry printing

Changes in RFC V1:

https://lore.kernel.org/all/20260806080639.1916749-1-anshuman.khandual@arm.com/

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  loongarch/mm: Stop using pte_ERROR()
  parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
  sh/mm: Stop using pte_ERROR()
  sh/mm: Stop using [p4d|pud|pmd]_ERROR()
  sh/mm: Stop using pgd_ERROR()
  mm: Drop pxd_ERROR()

 arch/alpha/include/asm/pgtable.h              |  7 ----
 arch/arc/include/asm/pgtable-levels.h         | 11 -----
 arch/arm/include/asm/pgtable.h                |  7 ----
 arch/arm/kernel/traps.c                       | 17 --------
 arch/arm64/include/asm/pgtable.h              | 15 -------
 arch/csky/include/asm/pgtable.h               |  4 --
 arch/hexagon/include/asm/pgtable.h            |  3 --
 arch/loongarch/include/asm/pgtable.h          | 13 ------
 arch/loongarch/mm/init.c                      |  2 +-
 arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
 arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
 arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
 arch/microblaze/include/asm/pgtable.h         |  7 ----
 arch/mips/include/asm/pgtable-32.h            | 10 -----
 arch/mips/include/asm/pgtable-64.h            | 13 ------
 arch/nios2/include/asm/pgtable.h              |  7 ----
 arch/openrisc/include/asm/pgtable.h           |  7 ----
 arch/parisc/include/asm/pgtable.h             |  9 ----
 arch/parisc/kernel/pci-dma.c                  |  6 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 ----
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 -
 .../include/asm/nohash/64/pgtable-4k.h        |  3 --
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ---
 arch/riscv/include/asm/pgtable-64.h           |  9 ----
 arch/riscv/include/asm/pgtable.h              |  4 --
 arch/s390/include/asm/pgtable.h               | 11 -----
 arch/sh/include/asm/pgtable-3level.h          |  3 --
 arch/sh/include/asm/pgtable_32.h              | 13 ------
 arch/sh/mm/init.c                             | 27 ++++++------
 arch/sparc/include/asm/pgtable_32.h           |  3 --
 arch/sparc/include/asm/pgtable_64.h           | 10 -----
 arch/um/include/asm/pgtable-2level.h          |  7 ----
 arch/um/include/asm/pgtable-4level.h          | 13 ------
 arch/x86/include/asm/pgtable-2level.h         |  5 ---
 arch/x86/include/asm/pgtable-3level.h         | 11 -----
 arch/x86/include/asm/pgtable_64.h             | 18 --------
 arch/xtensa/include/asm/pgtable.h             |  4 --
 include/asm-generic/pgtable-nop4d.h           |  1 -
 include/asm-generic/pgtable-nopmd.h           |  1 -
 include/asm-generic/pgtable-nopud.h           |  1 -
 include/linux/mm_types.h                      | 41 +++++++++++++++++++
 mm/memory.c                                   | 41 +------------------
 mm/pgtable-generic.c                          | 21 ++++++++--
 44 files changed, 76 insertions(+), 346 deletions(-)

-- 
2.43.0

