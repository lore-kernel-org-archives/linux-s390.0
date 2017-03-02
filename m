Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 04/14] s390: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:14:56 -0800
Message-ID: <1488413706-9739-5-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170302001456.LpjIcE8UoZk3_70vFOBXOw-23JkSbM-HGYnT_npFoJs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/s390/kernel/ftrace.c        | 1 +
 arch/s390/kernel/kprobes.c       | 2 +-
 arch/s390/kernel/machine_kexec.c | 1 +
 arch/s390/mm/init.c              | 1 +
 arch/s390/mm/pageattr.c          | 1 +
 arch/s390/mm/vmem.c              | 1 +
 arch/s390/net/bpf_jit_comp.c     | 1 +
 7 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 60a8a4e..27477f3 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -17,6 +17,7 @@
 #include <trace/syscall.h>
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include "entry.h"
 
 /*
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 76f9eda..3d6a997 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -31,7 +31,7 @@
 #include <linux/slab.h>
 #include <linux/hardirq.h>
 #include <linux/ftrace.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <linux/uaccess.h>
 #include <asm/dis.h>
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 3074c1d..ab506ef 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -26,6 +26,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
 #include <asm/os_info.h>
+#include <asm/set_memory.h>
 #include <asm/switch_to.h>
 
 typedef void (*relocate_kernel_t)(kimage_entry_t *, unsigned long);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index ee506671..ee6a1d3 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -39,6 +39,7 @@
 #include <asm/sections.h>
 #include <asm/ctl_reg.h>
 #include <asm/sclp.h>
+#include <asm/set_memory.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index fc5dc33..143cc9a 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -8,6 +8,7 @@
 #include <asm/facility.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/set_memory.h>
 
 static inline unsigned long sske_frame(unsigned long addr, unsigned char skey)
 {
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 60d3899..c33c94b 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -17,6 +17,7 @@
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
+#include <asm/set_memory.h>
 
 static DEFINE_MUTEX(vmem_mutex);
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 4ecf6d6..6e97a2e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -24,6 +24,7 @@
 #include <linux/bpf.h>
 #include <asm/cacheflush.h>
 #include <asm/dis.h>
+#include <asm/set_memory.h>
 #include "bpf_jit.h"
 
 int bpf_jit_enable __read_mostly;
-- 
2.7.4
