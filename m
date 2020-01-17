Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51848 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIDh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jan 2020 03:03:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so6447231wmd.1
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 00:03:35 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 0/2] microblaze: Enable CMA
Date: Fri, 17 Jan 2020 09:03:30 +0100
Message-Id: <cover.1579248206.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com, Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@linux.ibm.com>, Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, Andrew Morton <akpm@linux-foundation.org>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Chris Zankel <chris@zankel.net>, Manish Narani <manish.narani@xilinx.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guo Ren <ren_guo@c-sky.com>

Hi,

the patchset enable CMA on Microblaze. Based on Christoph request I have
created the first patch which makes dma-continugous.h mandatory for all
archs before Microblaze wiring.

Thanks,
Michal

Changes in v2:
- New patch suggested by Christoph
- Align commit message
- Remove adding dma-contigous.h via Kbuild because it is done by previous
  patch

Michal Simek (2):
  asm-generic: Make dma-contiguous.h a mandatory include/asm header
  microblaze: Wire CMA allocator

 arch/arm64/include/asm/Kbuild         | 1 -
 arch/csky/include/asm/Kbuild          | 1 -
 arch/microblaze/Kconfig               | 1 +
 arch/microblaze/configs/mmu_defconfig | 2 ++
 arch/microblaze/mm/init.c             | 4 ++++
 arch/mips/include/asm/Kbuild          | 1 -
 arch/riscv/include/asm/Kbuild         | 1 -
 arch/s390/include/asm/Kbuild          | 1 -
 arch/x86/include/asm/Kbuild           | 1 -
 arch/xtensa/include/asm/Kbuild        | 1 -
 include/asm-generic/Kbuild            | 1 +
 11 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.25.0
