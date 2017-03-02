Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 05/14] x86: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:14:57 -0800
Message-ID: <1488413706-9739-6-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170302001457.oma3I9LiMFhCs9QuYmqAxNZO85ea62BSUxA1Fce0CzI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/x86/kernel/amd_gart_64.c      | 2 +-
 arch/x86/kernel/cpu/amd.c          | 2 +-
 arch/x86/kernel/cpu/bugs.c         | 2 +-
 arch/x86/kernel/ftrace.c           | 2 +-
 arch/x86/kernel/machine_kexec_64.c | 1 +
 arch/x86/mm/init.c                 | 2 +-
 arch/x86/mm/init_64.c              | 2 +-
 arch/x86/mm/ioremap.c              | 2 +-
 arch/x86/mm/pageattr.c             | 1 +
 arch/x86/net/bpf_jit_comp.c        | 1 +
 arch/x86/pci/pcbios.c              | 2 +-
 arch/x86/platform/efi/efi.c        | 2 +-
 arch/x86/realmode/init.c           | 2 +-
 13 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 82dfe32..6c81048 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -35,7 +35,7 @@
 #include <asm/proto.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/swiotlb.h>
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4e95b2e..f77f7f4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
-# include <asm/cacheflush.h>
+# include <asm/set_memory.h>
 #endif
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a44ef52..0af86d9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -17,7 +17,7 @@
 #include <asm/paravirt.h>
 #include <asm/alternative.h>
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 void __init check_bugs(void)
 {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8639bb2..da9f2b0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -24,7 +24,7 @@
 
 #include <trace/syscall.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/kprobes.h>
 #include <asm/ftrace.h>
 #include <asm/nops.h>
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 307b1f4..8887311 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -27,6 +27,7 @@
 #include <asm/debugreg.h>
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
+#include <asm/set_memory.h>
 
 #ifdef CONFIG_KEXEC_FILE
 static struct kexec_file_ops *kexec_file_loaders[] = {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 22af912..adbfb09 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -5,7 +5,7 @@
 #include <linux/memblock.h>
 #include <linux/bootmem.h>	/* for max_low_pfn */
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/e820.h>
 #include <asm/init.h>
 #include <asm/page.h>
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 15173d3..7eef172 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -50,7 +50,7 @@
 #include <asm/sections.h>
 #include <asm/kdebug.h>
 #include <asm/numa.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/init.h>
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 7aaa263..8ae010c 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -13,7 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/e820.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 28d4213..bfcdd45 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -24,6 +24,7 @@
 #include <asm/pgalloc.h>
 #include <asm/proto.h>
 #include <asm/pat.h>
+#include <asm/set_memory.h>
 
 /*
  * The current flushing context - we pass it instead of 5 arguments:
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 32322ce..a63e6af 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <linux/bpf.h>
 
 int bpf_jit_enable __read_mostly;
diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 1d97cea..4d510a6 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -9,7 +9,7 @@
 #include <linux/uaccess.h>
 #include <asm/pci_x86.h>
 #include <asm/pci-functions.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 /* BIOS32 signature: "_32_" */
 #define BIOS32_SIGNATURE	(('_' << 0) + ('3' << 8) + ('2' << 16) + ('_' << 24))
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 565dff3..6867d88 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -48,7 +48,7 @@
 #include <asm/setup.h>
 #include <asm/efi.h>
 #include <asm/time.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <asm/x86_init.h>
 #include <asm/uv/uv.h>
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 5db706f1..a163a90 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/pgtable.h>
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
-- 
2.7.4
