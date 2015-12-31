From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 21/32] mips: define __smp_xxx
Date: Thu, 31 Dec 2015 21:08:30 +0200
Message-ID: <1451572003-2440-22-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemlof>
List-ID: <linux-s390.vger.kernel.org>

This defines __smp_xxx barriers for mips,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: the only exception is smp_mb__before_llsc which is mips-specific.
We define both the __smp_mb__before_llsc variant (for use in
asm/barriers.h) and smp_mb__before_llsc (for use elsewhere on this
architecture).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/barrier.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 3eac4b9..d296633 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -85,20 +85,20 @@
 #define wmb()		fast_wmb()
 #define rmb()		fast_rmb()
 
-#if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
+#if defined(CONFIG_WEAK_ORDERING)
 # ifdef CONFIG_CPU_CAVIUM_OCTEON
-#  define smp_mb()	__sync()
-#  define smp_rmb()	barrier()
-#  define smp_wmb()	__syncw()
+#  define __smp_mb()	__sync()
+#  define __smp_rmb()	barrier()
+#  define __smp_wmb()	__syncw()
 # else
-#  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_mb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
 # endif
 #else
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
+#define __smp_mb()	barrier()
+#define __smp_rmb()	barrier()
+#define __smp_wmb()	barrier()
 #endif
 
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
@@ -111,6 +111,7 @@
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
+#define __smp_mb__before_llsc() __smp_wmb()
 /* Cause previous writes to become visible on all CPUs as soon as possible */
 #define nudge_writes() __asm__ __volatile__(".set push\n\t"		\
 					    ".set arch=octeon\n\t"	\
@@ -118,11 +119,12 @@
 					    ".set pop" : : : "memory")
 #else
 #define smp_mb__before_llsc() smp_llsc_mb()
+#define __smp_mb__before_llsc() smp_llsc_mb()
 #define nudge_writes() mb()
 #endif
 
-#define smp_mb__before_atomic()	smp_mb__before_llsc()
-#define smp_mb__after_atomic()	smp_llsc_mb()
+#define __smp_mb__before_atomic()	__smp_mb__before_llsc()
+#define __smp_mb__after_atomic()	smp_llsc_mb()
 
 #include <asm-generic/barrier.h>
 
-- 
MST
