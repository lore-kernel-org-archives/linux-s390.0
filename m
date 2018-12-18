From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 09:26:55 +0000
Subject: [kvm-unit-tests RFC v3 11/13] s390x: Add sclp busy indication locking
Message-Id: <20181218092657.46466-12-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With smp CPUs have to compete for sclp. Let's add some locking, so
they execute sclp calls in an orderly fashion.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index eed51ef..6b147d1 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -15,6 +15,7 @@
 #include <asm/arch_def.h>
 #include <asm/interrupt.h>
 #include <asm/barrier.h>
+#include <asm/spinlock.h>
 #include "sclp.h"
 #include <alloc_phys.h>
 
@@ -26,6 +27,7 @@ static uint64_t ram_size;
 
 char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
 volatile bool sclp_busy;
+static struct spinlock sclp_lock;
 
 static void mem_init(phys_addr_t mem_end)
 {
@@ -48,7 +50,9 @@ static void sclp_setup_int(void)
 void sclp_handle_ext(void)
 {
 	ctl_clear_bit(0, 9);
+	spin_lock(&sclp_lock);
 	sclp_busy = false;
+	spin_unlock(&sclp_lock);
 }
 
 void sclp_wait_busy(void)
@@ -60,7 +64,19 @@ void sclp_wait_busy(void)
 
 void sclp_mark_busy(void)
 {
+	/*
+	 * With multiple CPUs we might need to wait for another CPU's
+	 * request before grabbing the busy indication.
+	 */
+retry_wait:
+	sclp_wait_busy();
+	spin_lock(&sclp_lock);
+	if (sclp_busy) {
+		spin_unlock(&sclp_lock);
+		goto retry_wait;
+	}
 	sclp_busy = true;
+	spin_unlock(&sclp_lock);
 }
 
 static void sclp_read_scp_info(ReadInfo *ri, int length)
-- 
2.14.3
