From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] treewide: replace config_enabled() with IS_ENABLED() (2nd round)
Date: Wed, 24 Aug 2016 01:45:49 +0900
Message-Id: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, Ingo Molnar <mingo@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Thomas Garnier <thgarnie@google.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Commit 97f2645f358b ("tree-wide: replace config_enabled() with
IS_ENABLED()") mostly killed config_enabled(), but some new users
have appeared for v4.8-rc1.  They are all used for a boolean option,
so can be replaced with IS_ENABLED() safely.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/asm/page.h | 4 ++--
 arch/s390/kernel/setup.c     | 6 ++----
 arch/x86/mm/kaslr.c          | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index ea0cd97..5f98759 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -164,7 +164,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  */
 static inline unsigned long ___pa(unsigned long x)
 {
-	if (config_enabled(CONFIG_64BIT)) {
+	if (IS_ENABLED(CONFIG_64BIT)) {
 		/*
 		 * For MIPS64 the virtual address may either be in one of
 		 * the compatibility segements ckseg0 or ckseg1, or it may
@@ -173,7 +173,7 @@ static inline unsigned long ___pa(unsigned long x)
 		return x < CKSEG0 ? XPHYSADDR(x) : CPHYSADDR(x);
 	}
 
-	if (!config_enabled(CONFIG_EVA)) {
+	if (!IS_ENABLED(CONFIG_EVA)) {
 		/*
 		 * We're using the standard MIPS32 legacy memory map, ie.
 		 * the address x is going to be in kseg0 or kseg1. We can
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ba5f456..7f7ba5f2 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -204,11 +204,9 @@ static void __init conmode_default(void)
 #endif
 		}
 	} else if (MACHINE_IS_KVM) {
-		if (sclp.has_vt220 &&
-		    config_enabled(CONFIG_SCLP_VT220_CONSOLE))
+		if (sclp.has_vt220 && IS_ENABLED(CONFIG_SCLP_VT220_CONSOLE))
 			SET_CONSOLE_VT220;
-		else if (sclp.has_linemode &&
-			 config_enabled(CONFIG_SCLP_CONSOLE))
+		else if (sclp.has_linemode && IS_ENABLED(CONFIG_SCLP_CONSOLE))
 			SET_CONSOLE_SCLP;
 		else
 			SET_CONSOLE_HVC;
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index ec8654f..bda8d5e 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -77,7 +77,7 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
  */
 static inline bool kaslr_memory_enabled(void)
 {
-	return kaslr_enabled() && !config_enabled(CONFIG_KASAN);
+	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
 /* Initialize base and padding for each memory region randomized with KASLR */
-- 
1.9.1
