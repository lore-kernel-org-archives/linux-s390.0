From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/8] s390: move orb.h from drivers/s390/ to arch/s390/
Date: Fri, 29 Apr 2016 14:11:49 +0200
Message-ID: <1461931915-22397-3-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Let's make orb-related definitions available outside
of the common I/O layer for future use (e.g. for
passing channel devices to a guest).

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 {drivers/s390/cio => arch/s390/include/asm}/orb.h | 0
 drivers/s390/cio/eadm_sch.c                       | 2 +-
 drivers/s390/cio/eadm_sch.h                       | 2 +-
 drivers/s390/cio/io_sch.h                         | 2 +-
 drivers/s390/cio/ioasm.c                          | 2 +-
 drivers/s390/cio/ioasm.h                          | 2 +-
 drivers/s390/cio/trace.h                          | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename {drivers/s390/cio => arch/s390/include/asm}/orb.h (100%)

diff --git a/drivers/s390/cio/orb.h b/arch/s390/include/asm/orb.h
similarity index 100%
rename from drivers/s390/cio/orb.h
rename to arch/s390/include/asm/orb.h
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index b3f44bc..8082a03 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -21,12 +21,12 @@
 #include <asm/cio.h>
 #include <asm/scsw.h>
 #include <asm/eadm.h>
+#include <asm/orb.h>
 
 #include "eadm_sch.h"
 #include "ioasm.h"
 #include "cio.h"
 #include "css.h"
-#include "orb.h"
 
 MODULE_DESCRIPTION("driver for s390 eadm subchannels");
 MODULE_LICENSE("GPL");
diff --git a/drivers/s390/cio/eadm_sch.h b/drivers/s390/cio/eadm_sch.h
index 9664e46..2184920 100644
--- a/drivers/s390/cio/eadm_sch.h
+++ b/drivers/s390/cio/eadm_sch.h
@@ -5,7 +5,7 @@
 #include <linux/device.h>
 #include <linux/timer.h>
 #include <linux/list.h>
-#include "orb.h"
+#include <asm/orb.h>
 
 struct eadm_private {
 	union orb orb;
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index 8975060..b768523 100644
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -5,8 +5,8 @@
 #include <asm/schid.h>
 #include <asm/ccwdev.h>
 #include <asm/irq.h>
+#include <asm/orb.h>
 #include "css.h"
-#include "orb.h"
 
 struct io_subchannel_private {
 	union orb orb;		/* operation request block */
diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
index 9898481..7fd413d 100644
--- a/drivers/s390/cio/ioasm.c
+++ b/drivers/s390/cio/ioasm.c
@@ -7,9 +7,9 @@
 #include <asm/chpid.h>
 #include <asm/schid.h>
 #include <asm/crw.h>
+#include <asm/orb.h>
 
 #include "ioasm.h"
-#include "orb.h"
 #include "cio.h"
 
 int stsch(struct subchannel_id schid, struct schib *addr)
diff --git a/drivers/s390/cio/ioasm.h b/drivers/s390/cio/ioasm.h
index b31ee6b..b2ca4a3 100644
--- a/drivers/s390/cio/ioasm.h
+++ b/drivers/s390/cio/ioasm.h
@@ -4,7 +4,7 @@
 #include <asm/chpid.h>
 #include <asm/schid.h>
 #include <asm/crw.h>
-#include "orb.h"
+#include <asm/orb.h>
 #include "cio.h"
 #include "trace.h"
 
diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 5b807a0..ba58f7c 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -7,10 +7,10 @@
 
 #include <linux/kernel.h>
 #include <asm/crw.h>
+#include <asm/orb.h>
 #include <uapi/asm/chpid.h>
 #include <uapi/asm/schid.h>
 #include "cio.h"
-#include "orb.h"
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM s390
-- 
2.6.6
