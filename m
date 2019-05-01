Return-Path: <linux-arch-owner@vger.kernel.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:16 +0300
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190501195616.SHD4M59DBxTp2XmQjTFPI2-bdwl6Q2yi2B1ka6z7NWs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
arch/s390/Kconfig is an ancient compile error with allnoconfig which was
fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.

Since then a lot have changed and now allnoconfig builds just fine without
ARCH_SELECT_MEMORY_MODEL, so it can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/s390/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d06..69d3956 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -621,9 +621,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y
-
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y if SPARSEMEM
 
-- 
2.7.4
