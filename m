From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 3/3] s390/kvm: Perform early event mask processing during boot.
Date: Mon, 11 Jun 2012 16:06:59 +0200
Message-ID: <1339423619-42299-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

For processing under KVM it is required to detect
the actual SCLP console type in order to set it as
preferred console.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/sclp.h  |    2 ++
 arch/s390/kernel/setup.c      |   12 +++++++++---
 drivers/s390/char/sclp.c      |   10 ----------
 drivers/s390/char/sclp.h      |   10 ++++++++++
 drivers/s390/char/sclp_cmd.c  |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/kvm/kvm_virtio.c |    3 ++-
 6 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index bf238c5..173f07a 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -55,5 +55,7 @@ int sclp_chp_configure(struct chp_id chpid);
 int sclp_chp_deconfigure(struct chp_id chpid);
 int sclp_chp_read_info(struct sclp_chp_info *info);
 void sclp_get_ipl_info(struct sclp_ipl_info *info);
+bool sclp_has_linemode(void);
+bool sclp_has_vt220(void);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 489d1d8..e86bca6 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -63,6 +63,7 @@
 #include <asm/kvm_virtio.h>
 #include <asm/diag.h>
 #include <asm/os_info.h>
+#include <asm/sclp.h>
 #include "entry.h"
 
 long psw_kernel_bits	= PSW_DEFAULT_KEY | PSW_MASK_BASE | PSW_ASC_PRIMARY |
@@ -138,9 +139,14 @@ __setup("condev=", condev_setup);
 
 static void __init set_preferred_console(void)
 {
-	if (MACHINE_IS_KVM)
-		add_preferred_console("hvc", 0, NULL);
-	else if (CONSOLE_IS_3215 || CONSOLE_IS_SCLP)
+	if (MACHINE_IS_KVM) {
+		if (sclp_has_vt220())
+			add_preferred_console("ttyS", 1, NULL);
+		else if (sclp_has_linemode())
+			add_preferred_console("ttyS", 0, NULL);
+		else
+			add_preferred_console("hvc", 0, NULL);
+	} else if (CONSOLE_IS_3215 || CONSOLE_IS_SCLP)
 		add_preferred_console("ttyS", 0, NULL);
 	else if (CONSOLE_IS_3270)
 		add_preferred_console("tty3270", 0, NULL);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 30f29a0..3fcc000 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -654,16 +654,6 @@ sclp_remove_processed(struct sccb_header *sccb)
 
 EXPORT_SYMBOL(sclp_remove_processed);
 
-struct init_sccb {
-	struct sccb_header header;
-	u16 _reserved;
-	u16 mask_length;
-	sccb_mask_t receive_mask;
-	sccb_mask_t send_mask;
-	sccb_mask_t sclp_receive_mask;
-	sccb_mask_t sclp_send_mask;
-} __attribute__((packed));
-
 /* Prepare init mask request. Called while sclp_lock is locked. */
 static inline void
 __sclp_make_init_req(u32 receive_mask, u32 send_mask)
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index 49a1bb5..d7e97ae 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -88,6 +88,16 @@ struct sccb_header {
 	u16	response_code;
 } __attribute__((packed));
 
+struct init_sccb {
+	struct sccb_header header;
+	u16 _reserved;
+	u16 mask_length;
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
+	sccb_mask_t sclp_receive_mask;
+	sccb_mask_t sclp_send_mask;
+} __attribute__((packed));
+
 extern u64 sclp_facilities;
 #define SCLP_HAS_CHP_INFO	(sclp_facilities & 0x8000000000000000ULL)
 #define SCLP_HAS_CHP_RECONFIG	(sclp_facilities & 0x2000000000000000ULL)
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 766cb7b..71ea923c 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -48,6 +48,7 @@ struct read_info_sccb {
 	u8	_reserved5[4096 - 112];	/* 112-4095 */
 } __attribute__((packed, aligned(PAGE_SIZE)));
 
+static struct init_sccb __initdata early_event_mask_sccb __aligned(PAGE_SIZE);
 static struct read_info_sccb __initdata early_read_info_sccb;
 static int __initdata early_read_info_sccb_valid;
 
@@ -104,6 +105,19 @@ static void __init sclp_read_info_early(void)
 	}
 }
 
+static void __init sclp_event_mask_early(void)
+{
+	struct init_sccb *sccb = &early_event_mask_sccb;
+	int rc;
+
+	do {
+		memset(sccb, 0, sizeof(*sccb));
+		sccb->header.length = sizeof(*sccb);
+		sccb->mask_length = sizeof(sccb_mask_t);
+		rc = sclp_cmd_sync_early(SCLP_CMDW_WRITE_EVENT_MASK, sccb);
+	} while (rc == -EBUSY);
+}
+
 void __init sclp_facilities_detect(void)
 {
 	struct read_info_sccb *sccb;
@@ -119,6 +133,30 @@ void __init sclp_facilities_detect(void)
 	rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
 	rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
 	rzm <<= 20;
+
+	sclp_event_mask_early();
+}
+
+bool __init sclp_has_linemode(void)
+{
+	struct init_sccb *sccb = &early_event_mask_sccb;
+
+	if (sccb->header.response_code != 0x20)
+		return 0;
+	if (sccb->sclp_send_mask & (EVTYP_MSG_MASK | EVTYP_PMSGCMD_MASK))
+		return 1;
+	return 0;
+}
+
+bool __init sclp_has_vt220(void)
+{
+	struct init_sccb *sccb = &early_event_mask_sccb;
+
+	if (sccb->header.response_code != 0x20)
+		return 0;
+	if (sccb->sclp_send_mask & EVTYP_VT220MSG_MASK)
+		return 1;
+	return 0;
 }
 
 unsigned long long sclp_get_rnmax(void)
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index d74e9ae..d3bdae4 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -25,6 +25,7 @@
 #include <asm/io.h>
 #include <asm/kvm_para.h>
 #include <asm/kvm_virtio.h>
+#include <asm/sclp.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
 
@@ -468,7 +469,7 @@ static __init int early_put_chars(u32 vtermno, const char *buf, int count)
 
 static int __init s390_virtio_console_init(void)
 {
-	if (!MACHINE_IS_KVM)
+	if (sclp_has_vt220() || sclp_has_linemode())
 		return -ENODEV;
 	return virtio_cons_early_init(early_put_chars);
 }
-- 
1.7.10.4
