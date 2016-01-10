Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 10 Jan 2016 13:53:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] s390: more efficient smp barriers
Message-ID: <1452426771-27112-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Konovalov <andreyknvl@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

As per: lkml.kernel.org/r/20150921112252.3c2937e1@mschwide
atomics imply a barrier on s390, so s390 should change
smp_mb__before_atomic and smp_mb__after_atomic to barrier() instead of
smp_mb() and hence should not use the generic versions.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This is on top of arch barrier cleanup patchset,
will be included in v3 of that patchset.

 arch/s390/include/asm/barrier.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index 4d26fa4..5c8db3c 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -45,6 +45,9 @@ do {									\
 	___p1;								\
 })
 
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
MST
