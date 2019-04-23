From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RESEND PATCH v3 08/11] powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
Date: Tue, 23 Apr 2019 12:49:56 +0900
Message-ID: <20190423034959.13525-9-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following modpost warnings are
reported:

WARNING: vmlinux.o(.text.unlikely+0x20): Section mismatch in reference from the function .prom_getprop() to the function .init.text:.call_prom()
The function .prom_getprop() references
the function __init .call_prom().
This is often because .prom_getprop lacks a __init
annotation or the annotation of .call_prom is wrong.

WARNING: vmlinux.o(.text.unlikely+0x3c): Section mismatch in reference from the function .prom_getproplen() to the function .init.text:.call_prom()
The function .prom_getproplen() references
the function __init .call_prom().
This is often because .prom_getproplen lacks a __init
annotation or the annotation of .call_prom is wrong.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/powerpc/kernel/prom_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff4163a51..241fe6b7a8cc 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -501,14 +501,14 @@ static int __init prom_next_node(phandle *nodep)
 	}
 }
 
-static inline int prom_getprop(phandle node, const char *pname,
-			       void *value, size_t valuelen)
+static inline int __init prom_getprop(phandle node, const char *pname,
+				      void *value, size_t valuelen)
 {
 	return call_prom("getprop", 4, 1, node, ADDR(pname),
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
-static inline int prom_getproplen(phandle node, const char *pname)
+static inline int __init prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
-- 
2.17.1
