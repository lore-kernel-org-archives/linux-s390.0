From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/5] Define AT_VECTOR_SIZE_ARCH correctly
Date: Mon, 25 Jul 2016 16:59:49 +0100
Message-ID: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>, Nathan Lynch <nathan_lynch@mentor.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

Several architectures define ARCH_DLINFO to [sometimes] contain
NEW_AUX_ENT entries, but don't define AT_VECTOR_SIZE_ARCH with the
corresponding maximum number of NEW_AUX_ENT entries.

In practice this doesn't cause any problems as AT_VECTOR_SIZE_BASE
includes space for AT_BASE_PLATFORM which none of these arches use, but
nevertheless lets define it now and add the comment above ARCH_DLINFO as
found in several other architectures to remind future modifiers of
ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to date.

Arch maintainers, please take via your own trees if you're happy to do
so.

- I haven't included an update for x86/um as it doesn't follow the same
  pattern as other architectures so it is unclear to me whether it has
  the same issue.

- Build tested on MIPS, ARM & tile.

- Tested on MIPS.

James Hogan (5):
  MIPS: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  ARM: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  s390: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  tile: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO

 arch/arm/include/asm/elf.h           | 1 +
 arch/arm/include/uapi/asm/auxvec.h   | 2 ++
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 2 ++
 arch/mips/include/asm/elf.h          | 1 +
 arch/mips/include/uapi/asm/auxvec.h  | 2 ++
 arch/s390/include/asm/elf.h          | 1 +
 arch/s390/include/uapi/asm/auxvec.h  | 2 ++
 arch/tile/include/asm/elf.h          | 1 +
 arch/tile/include/uapi/asm/auxvec.h  | 2 ++
 10 files changed, 15 insertions(+)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
-- 
2.4.10
