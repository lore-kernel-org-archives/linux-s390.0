Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 06/16] agp: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:23 -0800
Message-ID: <1488920133-27229-7-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170307205523.FtZTWde-H9oX5WD3Y9CoAYr_0bWrvu4rdg11mdnZ8eA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Airlie <airlied@linux.ie>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Added some #ifdef CONFIG_X86
---
 drivers/char/agp/amd-k7-agp.c | 1 +
 drivers/char/agp/ati-agp.c    | 1 +
 drivers/char/agp/generic.     | 0
 drivers/char/agp/generic.c    | 4 +++-
 drivers/char/agp/intel-gtt.c  | 1 +
 drivers/char/agp/sworks-agp.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/agp/generic.

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 3661a51..5fbd333 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -9,6 +9,7 @@
 #include <linux/page-flags.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <asm/set_memory.h>
 #include "agp.h"
 
 #define AMD_MMBASE_BAR	1
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index 75a9786..0b5ec7a 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/agp_backend.h>
 #include <asm/agp.h>
+#include <asm/set_memory.h>
 #include "agp.h"
 
 #define ATI_GART_MMBASE_BAR	1
diff --git a/drivers/char/agp/generic. b/drivers/char/agp/generic.
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index f002fa5..6ca092f 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -39,7 +39,9 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <asm/io.h>
-#include <asm/cacheflush.h>
+#ifdef CONFIG_X86
+#include <asm/set_memory.h>
+#endif
 #include <asm/pgtable.h>
 #include "agp.h"
 
diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 9702c78f..9776f28 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -25,6 +25,7 @@
 #include "agp.h"
 #include "intel-agp.h"
 #include <drm/intel-gtt.h>
+#include <asm/set_memory.h>
 
 /*
  * If we have Intel graphics, we're not going to have anything other than
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index 9b163b4..03be4ac 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/agp_backend.h>
+#include <asm/set_memory.h>
 #include "agp.h"
 
 #define SVWRKS_COMMAND		0x04
-- 
2.7.4
