From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/3] sparc: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:17 +0300
Message-ID: <1556740577-4140-4-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The ARCH_SELECT_MEMORY_MODEL option is enabled only for 64-bit. However,
64-bit configuration also enables ARCH_SPARSEMEM_DEFAULT and there is no
ARCH_FLATMEM_ENABLE in arch/sparc/Kconfig.

With such settings, the dependencies in mm/Kconfig are always evaluated to
SPARSEMEM=y for 64-bit and to FLATMEM=y for 32-bit.

The ARCH_SELECT_MEMORY_MODEL option in arch/sparc/Kconfig does not affect
anything and can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 40f8f4f..9137dbe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -305,9 +305,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y if SPARC64
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y if SPARC64
 	select SPARSEMEM_VMEMMAP_ENABLE
-- 
2.7.4
