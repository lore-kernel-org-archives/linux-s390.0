Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 10 Jan 2016 16:20:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 25/41] tile: define __smp_xxx
Message-ID: <1452426622-4471-26-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160110142000.8s6thDsPaIxQmcA6eINalGa8lwcV87C_2c2gEHknfdQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Chris Metcalf <cmetcalf@ezchip.com>
List-ID: <linux-s390.vger.kernel.org>

This defines __smp_xxx barriers for tile,
for use by virtualization.

Some smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: for 32 bit, keep smp_mb__after_atomic around since it's faster
than the generic implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/tile/include/asm/barrier.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/tile/include/asm/barrier.h b/arch/tile/include/asm/barrier.h
index 96a42ae..d552228 100644
--- a/arch/tile/include/asm/barrier.h
+++ b/arch/tile/include/asm/barrier.h
@@ -79,11 +79,12 @@ mb_incoherent(void)
  * But after the word is updated, the routine issues an "mf" before returning,
  * and since it's a function call, we don't even need a compiler barrier.
  */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	do { } while (0)
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	do { } while (0)
+#define smp_mb__after_atomic()	__smp_mb__after_atomic()
 #else /* 64 bit */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	__smp_mb()
 #endif
 
 #include <asm-generic/barrier.h>
-- 
MST
