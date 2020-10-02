Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388367AbgJBTjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:47 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 02/10] s390/cio: Provide Endpoint-Security Mode per CU
Date: Fri,  2 Oct 2020 21:39:32 +0200
Message-Id: <20201002193940.24012-3-sth@linux.ibm.com>
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Vineeth Vijayan <vneethv@linux.ibm.com>

Add an interface in the CIO layer to retrieve the information about the
Endpoint-Security Mode (ESM) of the specified CU. The ESM values are
defined as 0-None, 1-Authenticated or 2, 3-Encrypted.

Reference-ID: IO1812
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
[vneethv@linux.ibm.com: cleaned-up and modified description]
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 arch/s390/include/asm/cio.h |  1 +
 drivers/s390/cio/chsc.c     | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index b5bfb3123cb1..66e06d0efb72 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -373,5 +373,6 @@ struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages);
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
 int chsc_sstpi(void *page, void *result, size_t size);
 int chsc_sgib(u32 origin);
+int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid);
 
 #endif
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index c314e9495c1b..513fc5748d6e 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1403,3 +1403,86 @@ int chsc_sgib(u32 origin)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(chsc_sgib);
+
+#define SCUD_REQ_LEN	0x10 /* SCUD request block length */
+#define SCUD_REQ_CMD	0x4b /* SCUD Command Code */
+
+struct chse_cudb {
+	u16 flags:8;
+	u16 chp_valid:8;
+	u16 cu;
+	u32 esm_valid:8;
+	u32:24;
+	u8 chpid[8];
+	u32:32;
+	u32:32;
+	u8 esm[8];
+	u32 efla[8];
+} __packed;
+
+struct chsc_scud {
+	struct chsc_header request;
+	u16:4;
+	u16 fmt:4;
+	u16 cssid:8;
+	u16 first_cu;
+	u16:16;
+	u16 last_cu;
+	u32:32;
+	struct chsc_header response;
+	u16:4;
+	u16 fmt_resp:4;
+	u32:24;
+	struct chse_cudb cudb[];
+} __packed;
+
+/**
+ * chsc_scud() - Store control-unit description.
+ * @cu:		number of the control-unit
+ * @esm:	8 1-byte endpoint security mode values
+ * @esm_valid:	validity mask for @esm
+ *
+ * Interface to retrieve information about the endpoint security
+ * modes for up to 8 paths of a control unit.
+ *
+ * Returns 0 on success.
+ */
+int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid)
+{
+	struct chsc_scud *scud = chsc_page;
+	int ret;
+
+	spin_lock_irq(&chsc_page_lock);
+	memset(chsc_page, 0, PAGE_SIZE);
+	scud->request.length = SCUD_REQ_LEN;
+	scud->request.code = SCUD_REQ_CMD;
+	scud->fmt = 0;
+	scud->cssid = 0;
+	scud->first_cu = cu;
+	scud->last_cu = cu;
+
+	ret = chsc(scud);
+	if (!ret)
+		ret = chsc_error_from_response(scud->response.code);
+
+	if (!ret && (scud->response.length <= 8 || scud->fmt_resp != 0
+			|| !(scud->cudb[0].flags & 0x80)
+			|| scud->cudb[0].cu != cu)) {
+
+		CIO_MSG_EVENT(2, "chsc: scud failed rc=%04x, L2=%04x "
+			"FMT=%04x, cudb.flags=%02x, cudb.cu=%04x",
+			scud->response.code, scud->response.length,
+			scud->fmt_resp, scud->cudb[0].flags, scud->cudb[0].cu);
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto out;
+
+	memcpy(esm, scud->cudb[0].esm, sizeof(*esm));
+	*esm_valid = scud->cudb[0].esm_valid;
+out:
+	spin_unlock_irq(&chsc_page_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(chsc_scud);
-- 
2.17.1
