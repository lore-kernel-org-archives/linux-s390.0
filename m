Return-Path: <linux-kernel-owner+w=401wt.eu-S934078AbXKPOfI@vger.kernel.org>
Message-Id: <20071116143321.965171725@de.ibm.com>
References: <20071116142942.978412023@de.ibm.com>
Date: Fri, 16 Nov 2007 15:29:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/6] sclp: convert channel path configure code to use sync interface.
Content-Disposition: inline; filename=104-sclp-chpid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/Makefile   |    2 
 drivers/s390/char/sclp_chp.c |  200 -------------------------------------------
 drivers/s390/char/sclp_cmd.c |  123 ++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 202 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2007-11-16 14:27:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Makefile	2007-11-16 14:27:49.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_cmd.o sclp_config.o sclp_chp.o sclp_cpi_sys.o
+	 sclp_cmd.o sclp_config.o sclp_cpi_sys.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
diff -urpN linux-2.6/drivers/s390/char/sclp_chp.c linux-2.6-patched/drivers/s390/char/sclp_chp.c
--- linux-2.6/drivers/s390/char/sclp_chp.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_chp.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,200 +0,0 @@
-/*
- *  drivers/s390/char/sclp_chp.c
- *
- *    Copyright IBM Corp. 2007
- *    Author(s): Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
- */
-
-#include <linux/types.h>
-#include <linux/gfp.h>
-#include <linux/errno.h>
-#include <linux/completion.h>
-#include <asm/sclp.h>
-#include <asm/chpid.h>
-
-#include "sclp.h"
-
-#define TAG	"sclp_chp: "
-
-#define SCLP_CMDW_CONFIGURE_CHANNEL_PATH	0x000f0001
-#define SCLP_CMDW_DECONFIGURE_CHANNEL_PATH	0x000e0001
-#define SCLP_CMDW_READ_CHANNEL_PATH_INFORMATION	0x00030001
-
-static inline sclp_cmdw_t get_configure_cmdw(struct chp_id chpid)
-{
-	return SCLP_CMDW_CONFIGURE_CHANNEL_PATH | chpid.id << 8;
-}
-
-static inline sclp_cmdw_t get_deconfigure_cmdw(struct chp_id chpid)
-{
-	return SCLP_CMDW_DECONFIGURE_CHANNEL_PATH | chpid.id << 8;
-}
-
-static void chp_callback(struct sclp_req *req, void *data)
-{
-	struct completion *completion = data;
-
-	complete(completion);
-}
-
-struct chp_cfg_sccb {
-	struct sccb_header header;
-	u8 ccm;
-	u8 reserved[6];
-	u8 cssid;
-} __attribute__((packed));
-
-struct chp_cfg_data {
-	struct chp_cfg_sccb sccb;
-	struct sclp_req req;
-	struct completion completion;
-} __attribute__((packed));
-
-static int do_configure(sclp_cmdw_t cmd)
-{
-	struct chp_cfg_data *data;
-	int rc;
-
-	if (!SCLP_HAS_CHP_RECONFIG)
-		return -EOPNOTSUPP;
-	/* Prepare sccb. */
-	data = (struct chp_cfg_data *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!data)
-		return -ENOMEM;
-	data->sccb.header.length = sizeof(struct chp_cfg_sccb);
-	data->req.command = cmd;
-	data->req.sccb = &(data->sccb);
-	data->req.status = SCLP_REQ_FILLED;
-	data->req.callback = chp_callback;
-	data->req.callback_data = &(data->completion);
-	init_completion(&data->completion);
-
-	/* Perform sclp request. */
-	rc = sclp_add_request(&(data->req));
-	if (rc)
-		goto out;
-	wait_for_completion(&data->completion);
-
-	/* Check response .*/
-	if (data->req.status != SCLP_REQ_DONE) {
-		printk(KERN_WARNING TAG "configure channel-path request failed "
-		       "(status=0x%02x)\n", data->req.status);
-		rc = -EIO;
-		goto out;
-	}
-	switch (data->sccb.header.response_code) {
-	case 0x0020:
-	case 0x0120:
-	case 0x0440:
-	case 0x0450:
-		break;
-	default:
-		printk(KERN_WARNING TAG "configure channel-path failed "
-		       "(cmd=0x%08x, response=0x%04x)\n", cmd,
-		       data->sccb.header.response_code);
-		rc = -EIO;
-		break;
-	}
-out:
-	free_page((unsigned long) data);
-
-	return rc;
-}
-
-/**
- * sclp_chp_configure - perform configure channel-path sclp command
- * @chpid: channel-path ID
- *
- * Perform configure channel-path command sclp command for specified chpid.
- * Return 0 after command successfully finished, non-zero otherwise.
- */
-int sclp_chp_configure(struct chp_id chpid)
-{
-	return do_configure(get_configure_cmdw(chpid));
-}
-
-/**
- * sclp_chp_deconfigure - perform deconfigure channel-path sclp command
- * @chpid: channel-path ID
- *
- * Perform deconfigure channel-path command sclp command for specified chpid
- * and wait for completion. On success return 0. Return non-zero otherwise.
- */
-int sclp_chp_deconfigure(struct chp_id chpid)
-{
-	return do_configure(get_deconfigure_cmdw(chpid));
-}
-
-struct chp_info_sccb {
-	struct sccb_header header;
-	u8 recognized[SCLP_CHP_INFO_MASK_SIZE];
-	u8 standby[SCLP_CHP_INFO_MASK_SIZE];
-	u8 configured[SCLP_CHP_INFO_MASK_SIZE];
-	u8 ccm;
-	u8 reserved[6];
-	u8 cssid;
-} __attribute__((packed));
-
-struct chp_info_data {
-	struct chp_info_sccb sccb;
-	struct sclp_req req;
-	struct completion completion;
-} __attribute__((packed));
-
-/**
- * sclp_chp_read_info - perform read channel-path information sclp command
- * @info: resulting channel-path information data
- *
- * Perform read channel-path information sclp command and wait for completion.
- * On success, store channel-path information in @info and return 0. Return
- * non-zero otherwise.
- */
-int sclp_chp_read_info(struct sclp_chp_info *info)
-{
-	struct chp_info_data *data;
-	int rc;
-
-	if (!SCLP_HAS_CHP_INFO)
-		return -EOPNOTSUPP;
-	/* Prepare sccb. */
-	data = (struct chp_info_data *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!data)
-		return -ENOMEM;
-	data->sccb.header.length = sizeof(struct chp_info_sccb);
-	data->req.command = SCLP_CMDW_READ_CHANNEL_PATH_INFORMATION;
-	data->req.sccb = &(data->sccb);
-	data->req.status = SCLP_REQ_FILLED;
-	data->req.callback = chp_callback;
-	data->req.callback_data = &(data->completion);
-	init_completion(&data->completion);
-
-	/* Perform sclp request. */
-	rc = sclp_add_request(&(data->req));
-	if (rc)
-		goto out;
-	wait_for_completion(&data->completion);
-
-	/* Check response .*/
-	if (data->req.status != SCLP_REQ_DONE) {
-		printk(KERN_WARNING TAG "read channel-path info request failed "
-		       "(status=0x%02x)\n", data->req.status);
-		rc = -EIO;
-		goto out;
-	}
-	if (data->sccb.header.response_code != 0x0010) {
-		printk(KERN_WARNING TAG "read channel-path info failed "
-		       "(response=0x%04x)\n", data->sccb.header.response_code);
-		rc = -EIO;
-		goto out;
-	}
-	memcpy(info->recognized, data->sccb.recognized,
-	       SCLP_CHP_INFO_MASK_SIZE);
-	memcpy(info->standby, data->sccb.standby,
-	       SCLP_CHP_INFO_MASK_SIZE);
-	memcpy(info->configured, data->sccb.configured,
-	       SCLP_CHP_INFO_MASK_SIZE);
-out:
-	free_page((unsigned long) data);
-
-	return rc;
-}
diff -urpN linux-2.6/drivers/s390/char/sclp_cmd.c linux-2.6-patched/drivers/s390/char/sclp_cmd.c
--- linux-2.6/drivers/s390/char/sclp_cmd.c	2007-11-16 14:27:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cmd.c	2007-11-16 14:27:49.000000000 +0100
@@ -2,7 +2,8 @@
  *  drivers/s390/char/sclp_cmd.c
  *
  *    Copyright IBM Corp. 2007
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
 #include <linux/completion.h>
@@ -10,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <asm/chpid.h>
 #include <asm/sclp.h>
 #include "sclp.h"
 
@@ -317,3 +319,122 @@ int sclp_cpu_deconfigure(u8 cpu)
 {
 	return do_cpu_configure(SCLP_CMDW_DECONFIGURE_CPU | cpu << 8);
 }
+
+/*
+ * Channel path configuration related functions.
+ */
+
+#define SCLP_CMDW_CONFIGURE_CHPATH		0x000f0001
+#define SCLP_CMDW_DECONFIGURE_CHPATH		0x000e0001
+#define SCLP_CMDW_READ_CHPATH_INFORMATION	0x00030001
+
+struct chp_cfg_sccb {
+	struct sccb_header header;
+	u8 ccm;
+	u8 reserved[6];
+	u8 cssid;
+} __attribute__((packed));
+
+static int do_chp_configure(sclp_cmdw_t cmd)
+{
+	struct chp_cfg_sccb *sccb;
+	int rc;
+
+	if (!SCLP_HAS_CHP_RECONFIG)
+		return -EOPNOTSUPP;
+	/* Prepare sccb. */
+	sccb = (struct chp_cfg_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sccb)
+		return -ENOMEM;
+	sccb->header.length = sizeof(*sccb);
+	rc = do_sync_request(cmd, sccb);
+	if (rc)
+		goto out;
+	switch (sccb->header.response_code) {
+	case 0x0020:
+	case 0x0120:
+	case 0x0440:
+	case 0x0450:
+		break;
+	default:
+		printk(KERN_WARNING TAG "configure channel-path failed "
+		       "(cmd=0x%08x, response=0x%04x)\n", cmd,
+		       sccb->header.response_code);
+		rc = -EIO;
+		break;
+	}
+out:
+	free_page((unsigned long) sccb);
+	return rc;
+}
+
+/**
+ * sclp_chp_configure - perform configure channel-path sclp command
+ * @chpid: channel-path ID
+ *
+ * Perform configure channel-path command sclp command for specified chpid.
+ * Return 0 after command successfully finished, non-zero otherwise.
+ */
+int sclp_chp_configure(struct chp_id chpid)
+{
+	return do_chp_configure(SCLP_CMDW_CONFIGURE_CHPATH | chpid.id << 8);
+}
+
+/**
+ * sclp_chp_deconfigure - perform deconfigure channel-path sclp command
+ * @chpid: channel-path ID
+ *
+ * Perform deconfigure channel-path command sclp command for specified chpid
+ * and wait for completion. On success return 0. Return non-zero otherwise.
+ */
+int sclp_chp_deconfigure(struct chp_id chpid)
+{
+	return do_chp_configure(SCLP_CMDW_DECONFIGURE_CHPATH | chpid.id << 8);
+}
+
+struct chp_info_sccb {
+	struct sccb_header header;
+	u8 recognized[SCLP_CHP_INFO_MASK_SIZE];
+	u8 standby[SCLP_CHP_INFO_MASK_SIZE];
+	u8 configured[SCLP_CHP_INFO_MASK_SIZE];
+	u8 ccm;
+	u8 reserved[6];
+	u8 cssid;
+} __attribute__((packed));
+
+/**
+ * sclp_chp_read_info - perform read channel-path information sclp command
+ * @info: resulting channel-path information data
+ *
+ * Perform read channel-path information sclp command and wait for completion.
+ * On success, store channel-path information in @info and return 0. Return
+ * non-zero otherwise.
+ */
+int sclp_chp_read_info(struct sclp_chp_info *info)
+{
+	struct chp_info_sccb *sccb;
+	int rc;
+
+	if (!SCLP_HAS_CHP_INFO)
+		return -EOPNOTSUPP;
+	/* Prepare sccb. */
+	sccb = (struct chp_info_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sccb)
+		return -ENOMEM;
+	sccb->header.length = sizeof(*sccb);
+	rc = do_sync_request(SCLP_CMDW_READ_CHPATH_INFORMATION, sccb);
+	if (rc)
+		goto out;
+	if (sccb->header.response_code != 0x0010) {
+		printk(KERN_WARNING TAG "read channel-path info failed "
+		       "(response=0x%04x)\n", sccb->header.response_code);
+		rc = -EIO;
+		goto out;
+	}
+	memcpy(info->recognized, sccb->recognized, SCLP_CHP_INFO_MASK_SIZE);
+	memcpy(info->standby, sccb->standby, SCLP_CHP_INFO_MASK_SIZE);
+	memcpy(info->configured, sccb->configured, SCLP_CHP_INFO_MASK_SIZE);
+out:
+	free_page((unsigned long) sccb);
+	return rc;
+}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
