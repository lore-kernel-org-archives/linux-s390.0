From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 23/34] s390: define __smp_XXX
Date: Wed, 30 Dec 2015 15:25:53 +0200
Message-ID: <1451473761-30019-24-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Davidlohr Bueso <dbueso@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This defines __smp_XXX barriers for s390,
for use by virtualization.

Some smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: smp_mb, smp_rmb and smp_wmb are defined as full barriers
unconditionally on this architecture.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/s390/include/asm/barrier.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index c358c31..fbd25b2 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -26,18 +26,21 @@
 #define wmb()				barrier()
 #define dma_rmb()			mb()
 #define dma_wmb()			mb()
-#define smp_mb()			mb()
-#define smp_rmb()			rmb()
-#define smp_wmb()			wmb()
-
-#define smp_store_release(p, v)						\
+#define __smp_mb()			mb()
+#define __smp_rmb()			rmb()
+#define __smp_wmb()			wmb()
+#define smp_mb()			__smp_mb()
+#define smp_rmb()			__smp_rmb()
+#define smp_wmb()			__smp_wmb()
+
+#define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-- 
MST
