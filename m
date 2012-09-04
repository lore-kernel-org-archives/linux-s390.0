From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 5/7] s390: Make some css-related structures
	usable by non-cio code.
Date: Tue,  4 Sep 2012 17:13:28 +0200
Message-ID: <1346771610-52423-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

kvm will need to use some css-related structures (pmcw, schib, orb),
so let's move the definitions from drivers/s390/cio/ to include/asm/.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/orb.h   | 69 +++++++++++++++++++++++++++++++++++++++++++
 arch/s390/include/asm/schib.h | 52 ++++++++++++++++++++++++++++++++
 drivers/s390/cio/cio.h        | 46 +----------------------------
 drivers/s390/cio/io_sch.h     |  2 +-
 drivers/s390/cio/ioasm.h      |  2 +-
 drivers/s390/cio/orb.h        | 67 -----------------------------------------
 6 files changed, 124 insertions(+), 114 deletions(-)
 create mode 100644 arch/s390/include/asm/orb.h
 create mode 100644 arch/s390/include/asm/schib.h
 delete mode 100644 drivers/s390/cio/orb.h

diff --git a/arch/s390/include/asm/orb.h b/arch/s390/include/asm/orb.h
new file mode 100644
index 0000000..ca5d255
--- /dev/null
+++ b/arch/s390/include/asm/orb.h
@@ -0,0 +1,69 @@
+/*
+ * Orb related data structures.
+ *
+ * Copyright IBM Corp. 2007, 2011
+ *
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *	      Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ *	      Sebastian Ott <sebott@linux.vnet.ibm.com>
+ */
+
+#ifndef S390_ORB_H
+#define S390_ORB_H
+
+#include <linux/types.h>
+
+/*
+ * Command-mode operation request block
+ */
+struct cmd_orb {
+	u32 intparm;	/* interruption parameter */
+	u32 key:4;	/* flags, like key, suspend control, etc. */
+	u32 spnd:1;	/* suspend control */
+	u32 res1:1;	/* reserved */
+	u32 mod:1;	/* modification control */
+	u32 sync:1;	/* synchronize control */
+	u32 fmt:1;	/* format control */
+	u32 pfch:1;	/* prefetch control */
+	u32 isic:1;	/* initial-status-interruption control */
+	u32 alcc:1;	/* address-limit-checking control */
+	u32 ssic:1;	/* suppress-suspended-interr. control */
+	u32 res2:1;	/* reserved */
+	u32 c64:1;	/* IDAW/QDIO 64 bit control  */
+	u32 i2k:1;	/* IDAW 2/4kB block size control */
+	u32 lpm:8;	/* logical path mask */
+	u32 ils:1;	/* incorrect length */
+	u32 zero:6;	/* reserved zeros */
+	u32 orbx:1;	/* ORB extension control */
+	u32 cpa;	/* channel program address */
+}  __packed __aligned(4);
+
+/*
+ * Transport-mode operation request block
+ */
+struct tm_orb {
+	u32 intparm;
+	u32 key:4;
+	u32:9;
+	u32 b:1;
+	u32:2;
+	u32 lpm:8;
+	u32:7;
+	u32 x:1;
+	u32 tcw;
+	u32 prio:8;
+	u32:8;
+	u32 rsvpgm:8;
+	u32:8;
+	u32:32;
+	u32:32;
+	u32:32;
+	u32:32;
+}  __packed __aligned(4);
+
+union orb {
+	struct cmd_orb cmd;
+	struct tm_orb tm;
+}  __packed __aligned(4);
+
+#endif /* S390_ORB_H */
diff --git a/arch/s390/include/asm/schib.h b/arch/s390/include/asm/schib.h
new file mode 100644
index 0000000..87d7403
--- /dev/null
+++ b/arch/s390/include/asm/schib.h
@@ -0,0 +1,52 @@
+#ifndef _ASM_S390_SCHIB_H_
+#define _ASM_S390_SCHIB_H_
+
+#include <asm/types.h>
+
+#include <asm/scsw.h>
+/*
+ * path management control word
+ */
+struct pmcw {
+	u32 intparm;		/* interruption parameter */
+	u32 qf:1;		/* qdio facility */
+	u32 w:1;
+	u32 isc:3;		/* interruption sublass */
+	u32 res5:3;		/* reserved zeros */
+	u32 ena:1;		/* enabled */
+	u32 lm:2;		/* limit mode */
+	u32 mme:2;		/* measurement-mode enable */
+	u32 mp:1;		/* multipath mode */
+	u32 tf:1;		/* timing facility */
+	u32 dnv:1;		/* device number valid */
+	u32 dev:16;		/* device number */
+	u8  lpm;		/* logical path mask */
+	u8  pnom;		/* path not operational mask */
+	u8  lpum;		/* last path used mask */
+	u8  pim;		/* path installed mask */
+	u16 mbi;		/* measurement-block index */
+	u8  pom;		/* path operational mask */
+	u8  pam;		/* path available mask */
+	u8  chpid[8];		/* CHPID 0-7 (if available) */
+	u32 unused1:8;		/* reserved zeros */
+	u32 st:3;		/* subchannel type */
+	u32 unused2:18;		/* reserved zeros */
+	u32 mbfc:1;		/* measurement block format control */
+	u32 xmwme:1;		/* extended measurement word mode enable */
+	u32 csense:1;		/* concurrent sense; can be enabled ...*/
+				/*  ... per MSCH, however, if facility */
+				/*  ... is not installed, this results */
+				/*  ... in an operand exception.       */
+} __packed;
+
+/*
+ * subchannel information block
+ */
+struct schib {
+	struct pmcw pmcw;	 /* path management control word */
+	union scsw scsw;	 /* subchannel status word */
+	__u64 mba;               /* measurement block address */
+	__u8 mda[4];		 /* model dependent area */
+} __packed __aligned(4);
+
+#endif /* _ASM_S390_SCHIB_H_ */
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 4a1ff5c..b6daa85 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -7,44 +7,10 @@
 #include <asm/chpid.h>
 #include <asm/cio.h>
 #include <asm/fcx.h>
+#include <asm/schib.h>
 #include <asm/schid.h>
 #include "chsc.h"
 
-/*
- * path management control word
- */
-struct pmcw {
-	u32 intparm;		/* interruption parameter */
-	u32 qf	 : 1;		/* qdio facility */
-	u32 w	 : 1;
-	u32 isc  : 3;		/* interruption sublass */
-	u32 res5 : 3;		/* reserved zeros */
-	u32 ena  : 1;		/* enabled */
-	u32 lm	 : 2;		/* limit mode */
-	u32 mme  : 2;		/* measurement-mode enable */
-	u32 mp	 : 1;		/* multipath mode */
-	u32 tf	 : 1;		/* timing facility */
-	u32 dnv  : 1;		/* device number valid */
-	u32 dev  : 16;		/* device number */
-	u8  lpm;		/* logical path mask */
-	u8  pnom;		/* path not operational mask */
-	u8  lpum;		/* last path used mask */
-	u8  pim;		/* path installed mask */
-	u16 mbi;		/* measurement-block index */
-	u8  pom;		/* path operational mask */
-	u8  pam;		/* path available mask */
-	u8  chpid[8];		/* CHPID 0-7 (if available) */
-	u32 unused1 : 8;	/* reserved zeros */
-	u32 st	    : 3;	/* subchannel type */
-	u32 unused2 : 18;	/* reserved zeros */
-	u32 mbfc    : 1;	/* measurement block format control */
-	u32 xmwme   : 1;	/* extended measurement word mode enable */
-	u32 csense  : 1;	/* concurrent sense; can be enabled ...*/
-				/*  ... per MSCH, however, if facility */
-				/*  ... is not installed, this results */
-				/*  ... in an operand exception.       */
-} __attribute__ ((packed));
-
 /* Target SCHIB configuration. */
 struct schib_config {
 	u64 mba;
@@ -59,16 +25,6 @@ struct schib_config {
 } __attribute__ ((packed));
 
 /*
- * subchannel information block
- */
-struct schib {
-	struct pmcw pmcw;	 /* path management control word */
-	union scsw scsw;	 /* subchannel status word */
-	__u64 mba;               /* measurement block address */
-	__u8 mda[4];		 /* model dependent area */
-} __attribute__ ((packed,aligned(4)));
-
-/*
  * When rescheduled, todo's with higher values will overwrite those
  * with lower values.
  */
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index 76253df..39c4ef1 100644
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
diff --git a/drivers/s390/cio/ioasm.h b/drivers/s390/cio/ioasm.h
index 4d80fc6..e5aac8d 100644
--- a/drivers/s390/cio/ioasm.h
+++ b/drivers/s390/cio/ioasm.h
@@ -2,8 +2,8 @@
 #define S390_CIO_IOASM_H
 
 #include <asm/chpid.h>
+#include <asm/orb.h>
 #include <asm/schid.h>
-#include "orb.h"
 #include "cio.h"
 
 /*
diff --git a/drivers/s390/cio/orb.h b/drivers/s390/cio/orb.h
deleted file mode 100644
index 45a9865..0000000
--- a/drivers/s390/cio/orb.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * Orb related data structures.
- *
- * Copyright IBM Corp. 2007, 2011
- *
- * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
- *	      Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
- *	      Sebastian Ott <sebott@linux.vnet.ibm.com>
- */
-
-#ifndef S390_ORB_H
-#define S390_ORB_H
-
-/*
- * Command-mode operation request block
- */
-struct cmd_orb {
-	u32 intparm;	/* interruption parameter */
-	u32 key:4;	/* flags, like key, suspend control, etc. */
-	u32 spnd:1;	/* suspend control */
-	u32 res1:1;	/* reserved */
-	u32 mod:1;	/* modification control */
-	u32 sync:1;	/* synchronize control */
-	u32 fmt:1;	/* format control */
-	u32 pfch:1;	/* prefetch control */
-	u32 isic:1;	/* initial-status-interruption control */
-	u32 alcc:1;	/* address-limit-checking control */
-	u32 ssic:1;	/* suppress-suspended-interr. control */
-	u32 res2:1;	/* reserved */
-	u32 c64:1;	/* IDAW/QDIO 64 bit control  */
-	u32 i2k:1;	/* IDAW 2/4kB block size control */
-	u32 lpm:8;	/* logical path mask */
-	u32 ils:1;	/* incorrect length */
-	u32 zero:6;	/* reserved zeros */
-	u32 orbx:1;	/* ORB extension control */
-	u32 cpa;	/* channel program address */
-}  __packed __aligned(4);
-
-/*
- * Transport-mode operation request block
- */
-struct tm_orb {
-	u32 intparm;
-	u32 key:4;
-	u32:9;
-	u32 b:1;
-	u32:2;
-	u32 lpm:8;
-	u32:7;
-	u32 x:1;
-	u32 tcw;
-	u32 prio:8;
-	u32:8;
-	u32 rsvpgm:8;
-	u32:8;
-	u32:32;
-	u32:32;
-	u32:32;
-	u32:32;
-}  __packed __aligned(4);
-
-union orb {
-	struct cmd_orb cmd;
-	struct tm_orb tm;
-}  __packed __aligned(4);
-
-#endif /* S390_ORB_H */
-- 
1.7.11.5
