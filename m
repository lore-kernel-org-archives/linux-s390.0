Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CA3AFB18;
	Tue, 18 Aug 2026 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025650; cv=none; b=Fib8xTYK3kGT1yqSalNS96kXUfDw1tP65gmiqhYdg4xRE7Eg9Pd7TO2+Rx0YwAWezpKLwu5Ian+lI460/j6tehk+xJZvFLV4+twn31DrEnL6uFqCTp/e8xxX76QSlFR6Iq+pSG2scj8Be0JIKcczaihftow72Z0irUbY4fQWcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025650; c=relaxed/simple;
	bh=LRR2JW96qzLG8uXgU1+MfoOsPimHhtCsmfw/iXX8kB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7BrJZ0DGKPsvdoknoe78OSNsuI3shVTMV/bj1XDXzkMOXRFLjVver7CwxlosaOQMTZwyni6M3DBER51LBhgQx/L20fhYN4joNAtdmPwPPCZfpYaXE1k321+U633VlHrOwlb6tIodRA/N3idWpR/Qw/kV3V+hF+gI298NbMEd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NtFRXij4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NtFRXij4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46004153B;
	Mon, 17 Aug 2026 21:00:41 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5453F66F;
	Mon, 17 Aug 2026 21:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025645; bh=LRR2JW96qzLG8uXgU1+MfoOsPimHhtCsmfw/iXX8kB4=;
	h=From:To:Cc:Subject:Date:From;
	b=NtFRXij4Uhwnlv72AF85fJYzj/aymvsPMmb1FV54uYlLFKg3t/C+cIPPz6W0jsHV1
	 9J4gARXAWELXnskJwPs+BnDvgT6ZNx/a8ZwzPVKYIGTlZF5fGPZRP4qKo2lnT7Fr1w
	 ur0UrDi2dMsXj4xyEnxA47CkAD4o6o2g2lJDsONI=
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
Subject: [RFC V3 0/8] mm: Drop pxd_ERROR()
Date: Tue, 18 Aug 2026 09:30:33 +0530
Message-ID: <20260818040041.1891769-1-anshuman.khandual@arm.com>
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

This series is based on v7.2 after the following patch and has also been
built tested on multiple platforms.

https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/

Changes in RFC V3:

- Moved ptrval_to_str() as header in a separate patch
- Stopped using pxd_ERROR() in generic MM in a separate patch
- Dropped pxd_ERRO() macros from all platforms in a separate patch
- Dropped print_bad_pte() and also cleaned up set_pte_phys()
- Added some pr_error() messages in __get_pte_phys()
- Cleaned up error messages and used ptrval_to_str() in platforms

Changes in RFC V2:

https://lore.kernel.org/all/20260811042119.3652929-1-anshuman.khandual@arm.com/

- Added clean up patches for platforms with existing pxd_ERROR() usage
- Dropped __FILE__ and __LINE__ from all print sections per David

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

Anshuman Khandual (8):
  mm: Make ptrval_to_str() generally available
  mm: Stop using pxd_ERROR()
  loongarch/mm: Stop using pte_ERROR()
  parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
  sh/mm: Stop using pte_ERROR()
  sh/mm: Stop using [p4d|pud|pmd]_ERROR()
  sh/mm: Stop using pgd_ERROR()
  mm: Drop pxd_ERROR()

 arch/alpha/include/asm/pgtable.h              |  7 -------
 arch/arc/include/asm/pgtable-levels.h         | 11 ----------
 arch/arm/include/asm/pgtable.h                |  7 -------
 arch/arm/kernel/traps.c                       | 17 ---------------
 arch/arm64/include/asm/pgtable.h              | 15 -------------
 arch/csky/include/asm/pgtable.h               |  4 ----
 arch/hexagon/include/asm/pgtable.h            |  3 ---
 arch/loongarch/include/asm/pgtable.h          | 13 ------------
 arch/loongarch/mm/init.c                      |  4 +++-
 arch/m68k/include/asm/mcf_pgtable.h           |  6 ------
 arch/m68k/include/asm/motorola_pgtable.h      |  8 -------
 arch/m68k/include/asm/sun3_pgtable.h          |  7 -------
 arch/microblaze/include/asm/pgtable.h         |  7 -------
 arch/mips/include/asm/pgtable-32.h            | 10 ---------
 arch/mips/include/asm/pgtable-64.h            | 13 ------------
 arch/nios2/include/asm/pgtable.h              |  7 -------
 arch/openrisc/include/asm/pgtable.h           |  7 -------
 arch/parisc/include/asm/pgtable.h             |  9 --------
 arch/parisc/kernel/pci-dma.c                  |  6 ++----
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 --
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 -------
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 --
 .../include/asm/nohash/64/pgtable-4k.h        |  3 ---
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 -----
 arch/riscv/include/asm/pgtable-64.h           |  9 --------
 arch/riscv/include/asm/pgtable.h              |  4 ----
 arch/s390/include/asm/pgtable.h               | 11 ----------
 arch/sh/include/asm/pgtable-3level.h          |  3 ---
 arch/sh/include/asm/pgtable_32.h              | 13 ------------
 arch/sh/mm/init.c                             | 16 +++++++-------
 arch/sparc/include/asm/pgtable_32.h           |  3 ---
 arch/sparc/include/asm/pgtable_64.h           | 10 ---------
 arch/um/include/asm/pgtable-2level.h          |  7 -------
 arch/um/include/asm/pgtable-4level.h          | 13 ------------
 arch/x86/include/asm/pgtable-2level.h         |  5 -----
 arch/x86/include/asm/pgtable-3level.h         | 11 ----------
 arch/x86/include/asm/pgtable_64.h             | 18 ----------------
 arch/xtensa/include/asm/pgtable.h             |  4 ----
 include/asm-generic/pgtable-nop4d.h           |  1 -
 include/asm-generic/pgtable-nopmd.h           |  1 -
 include/asm-generic/pgtable-nopud.h           |  1 -
 include/linux/mm_types.h                      | 15 +++++++++++++
 mm/memory.c                                   | 16 ++------------
 mm/pgtable-generic.c                          | 21 +++++++++++++++----
 44 files changed, 48 insertions(+), 314 deletions(-)

-- 
2.43.0

