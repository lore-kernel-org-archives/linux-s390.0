Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 31 Dec 2015 21:06:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 08/32] arm: reuse asm-generic/barrier.h
Message-ID: <1451572003-2440-9-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20151231190646.7sIk9jYqpTEy15lz5M-4PqMRntDArp0Nvxa_lcEWnho@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Russell King <linux@arm.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>
List-ID: <linux-s390.vger.kernel.org>

On arm smp_store_mb, read_barrier_depends, smp_read_barrier_depends,
smp_store_release, smp_load_acquire, smp_mb__before_atomic and
smp_mb__after_atomic match the asm-generic variants exactly. Drop the
local definitions and pull in asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/barrier.h | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 3ff5642..31152e8 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -70,28 +70,7 @@ extern void arm_heavy_mb(void);
 #define smp_wmb()	dmb(ishst)
 #endif
 
-#define smp_store_release(p, v)						\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	WRITE_ONCE(*p, v);						\
-} while (0)
-
-#define smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	___p1;								\
-})
-
-#define read_barrier_depends()		do { } while(0)
-#define smp_read_barrier_depends()	do { } while(0)
-
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#include <asm-generic/barrier.h>
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_BARRIER_H */
-- 
MST
