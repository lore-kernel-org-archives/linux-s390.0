Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 16/16] treewide: Decouple cacheflush.h and set_memory.h
Date: Tue,  7 Mar 2017 12:55:33 -0800
Message-ID: <1488920133-27229-17-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170307205533.vR_NUpdd1WHbOB0swRbd7oXBfu-OmQ4KqUruZ5oijBU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Laura Abbott <labbott@redhat.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Now that all call sites, completely decouple cacheflush.h and
set_memory.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No changes
---
 arch/arm/include/asm/cacheflush.h   | 1 -
 arch/arm64/include/asm/cacheflush.h | 1 -
 arch/s390/include/asm/Kbuild        | 1 +
 arch/s390/include/asm/cacheflush.h  | 8 --------
 arch/x86/include/asm/cacheflush.h   | 1 -
 5 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 arch/s390/include/asm/cacheflush.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 1cb9d11..d69bebf 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,7 +16,6 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
-#include <asm/set_memory.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 7db6962..5812469 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -20,7 +20,6 @@
 #define __ASM_CACHEFLUSH_H
 
 #include <linux/mm.h>
-#include <asm/set_memory.h>
 
 /*
  * This flag is used to indicate that the page pointed to by a pte is clean
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 8aea32f..c0a7057 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += asm-offsets.h
+generic-y += cacheflush.h
 generic-y += clkdev.h
 generic-y += dma-contiguous.h
 generic-y += export.h
diff --git a/arch/s390/include/asm/cacheflush.h b/arch/s390/include/asm/cacheflush.h
deleted file mode 100644
index afe2965..0000000
--- a/arch/s390/include/asm/cacheflush.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _S390_CACHEFLUSH_H
-#define _S390_CACHEFLUSH_H
-
-/* Caches aren't brain-dead on the s390. */
-#include <asm-generic/cacheflush.h>
-#include <asm/set_memory.h>
-
-#endif /* _S390_CACHEFLUSH_H */
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 3d7db6f..8b4140f 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -4,7 +4,6 @@
 /* Caches aren't brain-dead on the intel. */
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
-#include <asm/set_memory.h>
 
 void clflush_cache_range(void *addr, unsigned int size);
 
-- 
2.7.4
