Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 13/14] ALSA: hda: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:05 -0800
Message-ID: <1488413706-9739-14-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170302001505.Zk2MaSXfLbgoyf0bTHLqKy4MyEh-8xane3RsPEtF2aU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 16108f0e..e3d8756 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -53,7 +53,7 @@
 #ifdef CONFIG_X86
 /* for snoop control */
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
 #include <sound/core.h>
-- 
2.7.4
