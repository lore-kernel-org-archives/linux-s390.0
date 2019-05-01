From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/3] arm: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:15 +0300
Message-ID: <1556740577-4140-2-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The ARCH_SELECT_MEMORY_MODEL in arch/arm/Kconfig is enabled only when
ARCH_SPARSEMEM_ENABLE=y. But in this case, ARCH_SPARSEMEM_DEFAULT is also
enabled and this in turn enables SPARSEMEM_MANUAL.

Since there is no definition of ARCH_FLATMEM_ENABLE in arch/arm/Kconfig,
SPARSEMEM_MANUAL is the only enabled memory model, hence the final
selection will evaluate to SPARSEMEM=y.

Since ARCH_SPARSEMEM_ENABLE is set to 'y' only by several sub-arch
configurations, the default for must sub-arches would be the falback to
FLATMEM regardless of ARCH_SELECT_MEMORY_MODEL.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aed25a..25a69a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1592,9 +1592,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.7.4
