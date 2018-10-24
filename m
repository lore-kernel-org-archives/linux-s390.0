Return-Path: <linux-arch-owner@vger.kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
Date: Wed, 24 Oct 2018 12:32:54 -0700
Message-ID: <20181024193256.23734-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20181024193254.NC5HZwptypecf7bZLUjVErU4Jek3N-_4SJpBUgnlqGg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:C6X ARCHITECTURE" <linux-c6x-dev@linux-c6x.org>, "moderated list:H8/300
        ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>, "open list:IA64 Itanium PLATFORM" <linux-ia64@vger.kernel.org>, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@linux-mips.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, "open list:OPENRISC ARCHITECTURE" <openrisc@lists.librecores.org>, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, "open list:LINUX FOR POWERPC 32-BIT AND
        64-BIT" <linuxppc-dev@lists.ozlabs.org>, "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, "open list:S390" <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:SPARC + UltraSPARC
        sparc/sparc64" <sparclinux@vger.kernel.org>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, "open list:TENSILICA XTENSA PORT xtensa" <linux-xtensa@linux-xtensa.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE" <devicetree@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi all,

While investigating why ARM64 required a ton of objects to be rebuilt
when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
because we define __early_init_dt_declare_initrd() differently and we do
that in arch/arm64/include/asm/memory.h which gets included by a fair
amount of other header files, and translation units as well.

Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
systems that generate two kernels: one with the initramfs and one
without. buildroot is one of these build systems, OpenWrt is also
another one that does this.

This patch series proposes adding an empty initrd.h to satisfy the need
for drivers/of/fdt.c to unconditionally include that file, and moves the
custom __early_init_dt_declare_initrd() definition away from
asm/memory.h

This cuts the number of objects rebuilds from 1920 down to 26, so a
factor 73 approximately.

Apologies for the long CC list, please let me know how you would go
about merging that and if another approach would be preferable, e.g:
introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
something like that.

Changes in v2:

- put an /* empty */ comment in the asm-generic/initrd.h file
- trim down the CC list to maximize the chances of people receiving this

Florian Fainelli (2):
  arch: Add asm-generic/initrd.h and make use of it for most
    architectures
  arm64: Create asm/initrd.h

 arch/alpha/include/asm/Kbuild      |  1 +
 arch/arc/include/asm/Kbuild        |  1 +
 arch/arm/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/initrd.h    | 13 +++++++++++++
 arch/arm64/include/asm/memory.h    |  8 --------
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/Kbuild       |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 drivers/of/fdt.c                   |  1 +
 include/asm-generic/initrd.h       |  1 +
 27 files changed, 38 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h
 create mode 100644 include/asm-generic/initrd.h

-- 
2.17.1
