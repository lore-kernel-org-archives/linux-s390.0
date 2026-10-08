Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B439F9C
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446915; cv=none; b=tXoBXx8qvKgmEmJNXcyU6WMDzEvSNblAuvr+s4KjSCW1mz9PSEFUaypsR49+EodmVbJezEypnd3d6FhbRNpGbX7s+BOc7WsAjoK5Am/ACRIOOvkrzkC/cf/jLX3ExuJk+exXZ6Z1LSM4uyXDTPZjXgaS7d9jyN5nBy2kBNg2RMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446915; c=relaxed/simple;
	bh=h2Lk8RzamEaYPLgfv+DzwfhFq4jSUhT24l8ePhKsGiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8jmvRm30pqeLVshSTvn0vnU40mGkcrH5LebLlMEIlY1lVfYZxA3kRTnWsx6w5XfrYPR/LvS4lS9fE54y7TybyveKHlNtcdyYAMvN3rv41fdknT0WYVWHly73j+aE7ULaI/hrir3QIMCtM4n2EXnxpsndwiYuwI8cUjHFyKNjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DjoiSL8p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DjoiSL8p"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZWbn731215
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DennoK
	rVnRbB560uh+SALVmXScLyiaA8f2mx2SX6490=; b=DjoiSL8prdsZ10anm9NVcs
	ROcRikbhQNkGbctdUubBz/rzuFwsvLhJtgYSAzBRua1/EBVo4YZl9sdIKCfWnVfd
	BTeCG2GXmGBdrrJKWbBVBkpMNg/dPZDqaPZ2khE/39lHVQJGc7CKd6b01/7JSkGO
	EZZZl+RygHEaefLTWCPfzhGKzD6NGOr82+gDOtlKVldiSPgnnjRWTdQAWGO2JVlh
	cE6tqDtXTZmf+4hrmhXAbdugD6Ec1ZKLYFUrZn0ILFUTs8PydEyPcf04wuig3pKF
	ZDV49/UYoJv1oWzTnLD4UuAUGN6LFYriO3hq9HSadeAN5Ec4uOmgUjwfrsXaTvPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvj3t5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IcoL3150006
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dp6u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69888OWt50987476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:08:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D04320043;
	Thu,  8 Oct 2026 08:08:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52552004B;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:08:06 +0200
Subject: [PATCH 4/4] dibs: introduce dibs block device peer device driver
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-console_server-v1-4-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8e841VwRH5sCmBabiDR4lsTFPPyfqcAc
X-Proofpoint-ORIG-GUID: 8e841VwRH5sCmBabiDR4lsTFPPyfqcAc
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac74f7e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=MLy2ypzB-lAym1fYPH4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX+61so8TYudfR
 kgOjbp2xHOXhWHZj0zLNSln6x5naPJzcuQQG1LFu5jHzK4vXjEXFIG2KMxP5nOaFuo0jFO3OqRE
 CfJOMDKX/AHMrskvmaJNN3J0mh0nNgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX1Ivq+FU/l+m9
 FsdKaeQFCXgVoaGRVBpRrn5IpTfDm6enqIq7dfcKUPI1JwoZu6W3cVw/gpnUKhKmheiP3RnT2x/
 u9PkLGJbo4/7leKlPQxWhGUh/zN8WCSfUHlXuBEdldho6S0nm1FAZxI8Y9Lz3Pt84GVz9w14h/C
 eSlUEe1mF9NXvIyS64zScvyItwQodVJw4eamVnlUx6O7dktsujJTq78FqxAMh1P/Yg2OwnjHLr0
 Do6e66Ya/7xh4iPdUc4yTMWlU6W4z75o9LM4RGTpkn3N+F+1MWcE447NfBai5ZOD2mufq5fSBHP
 I0k7eeXyaQyAVD9DSosWtalWDpWPjMVac8IJn3xIv/Ag8zzGtJFjdzvWdjVMu0PzghJ3tQ/I2Dj
 dU5vTA17kkP22tzmcX4sJ8CHlezvFA13m2hoX4H5l0sWSImzPc2ybF6+5nxnvUFsfeutmILgr0I
 zpgGczvCXaCbmONWh9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

Introduce a virtual block device driver that makes use of the newly
added dibs peer device bus.

This allows to access resources like e.g. an ISO file hosted on another
system via dibs.

If a dibs peer device of type block is announced to this instance, this
driver is probed via uevenvt.

If a backing resource is provided by the console server, it can be
accessed via '/dev/dibsblkX'.

Co-developed-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 drivers/dibs/Kconfig              |  10 +
 drivers/dibs/Makefile             |   1 +
 drivers/dibs/dibs_blk.c           | 798 ++++++++++++++++++++++++++++++++++++++
 include/linux/dibs.h              |   2 +
 6 files changed, 813 insertions(+)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index c4acf13aeaba..6d0a84fd8d30 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -135,6 +135,7 @@ CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_DIBS_PEER_BUS_DRV=y
 CONFIG_DIBS_CONSOLE=m
+CONFIG_DIBS_BLOCK=m
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 344724c56917..9eeecb5f59fa 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -126,6 +126,7 @@ CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_DIBS_PEER_BUS_DRV=y
 CONFIG_DIBS_CONSOLE=m
+CONFIG_DIBS_BLOCK=m
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index a0ed49977274..e99bb4ea0a9a 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -43,3 +43,13 @@ config DIBS_CONSOLE
 	  virtual console communication across systems in a dibs fabric. A
 	  device of type /dev/hvcN will be created for each peer device that is
 	  detected.
+
+config DIBS_BLOCK
+	def_tristate m
+	prompt "Support for dibs block peer devices"
+	depends on BLOCK && DIBS && DIBS_PEER_BUS_DRV
+	help
+	  Select this option if you want to enable the dibs block device
+	  support for dibs peer devices. This peer device driver operates
+	  on the dibs peer bus and provides block device access to remote
+	  storage across systems connected via the dibs fabric.
diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
index a39a67020e05..5327e4c24efa 100644
--- a/drivers/dibs/Makefile
+++ b/drivers/dibs/Makefile
@@ -7,4 +7,5 @@ dibs-y += dibs_main.o
 obj-$(CONFIG_DIBS) += dibs.o
 dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
 dibs-$(CONFIG_DIBS_PEER_BUS_DRV) += dibs_peer_bus_drv.o
+obj-$(CONFIG_DIBS_BLOCK) += dibs_blk.o
 obj-$(CONFIG_DIBS_CONSOLE) += dibs_console.o
diff --git a/drivers/dibs/dibs_blk.c b/drivers/dibs/dibs_blk.c
new file mode 100644
index 000000000000..94bbd8d37b8a
--- /dev/null
+++ b/drivers/dibs/dibs_blk.c
@@ -0,0 +1,798 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dibs block device driver.
+ *
+ * This driver provides block device access using
+ * dibs peer devices of type blk.
+ *
+ * Copyright IBM Corp.
+ */
+
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+#include <linux/dibs.h>
+#include <linux/fs.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/stringify.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+
+MODULE_ALIAS("dibs:peer_dev:" __stringify(PEER_DEV_TYPE_BLK));
+
+#define DIBS_BLK_SECTOR_SIZE 512ULL
+
+#define DIBS_BLK_RQ_TIMEOUT (5 * HZ)
+
+static unsigned int dibs_blk_max_timeout = 5;
+module_param(dibs_blk_max_timeout, uint, 0644);
+MODULE_PARM_DESC(dibs_blk_max_timeout,
+		 "Maximum timeout for dibs remote in seconds");
+
+enum { MAX_GPT_PARTITIONS = 128 };
+static DEFINE_MUTEX(blkpd_mutex);
+static int dibs_blk_idx;
+static LIST_HEAD(blkpd_list);
+
+enum { DIBS_BLK_PEER_DEV_HDR_VERSION = 1 };
+enum {
+	DIBS_BLK_CONNECT_MSG = 1,
+	DIBS_BLK_REQ_MSG = 2,
+	DIBS_BLK_DATA_MSG = 3,
+	DIBS_BLK_MEDIA_CHANGE = 4,
+	DIBS_BLK_DISK_DETACH = 5
+};
+
+enum {
+	DIBS_BLK_MEDIA_RECONNECT = 0x1,
+};
+
+/* DMB_SIZE must be at least (RING_SIZE * MAX_RBE_SIZE) + MAX_RBE_SIZE */
+/* and a multiple of 4k */
+#define DIBS_BLK_PEER_DEV_BLK_RING_SIZE (512 * 1024)
+#define DIBS_BLK_PEER_DEV_DMB_RING_SIZE 32
+#define DIBS_BLK_PEER_DEV_MAX_RBE_SIZE (28 * 1024)
+
+/* default sector size: 512 byte */
+#define DIBS_BLK_MAX_HW_SECTORS 54
+#define DIBS_BLK_MAX_HW_SECTORS_BYTES (DIBS_BLK_MAX_HW_SECTORS * 512) /* 8k */
+
+static struct queue_limits dibs_blk_lim = {
+	/* 512 byte sector size to be compatible with ISO 9660. */
+	.logical_block_size = 1 << 9,
+	.max_hw_sectors = DIBS_BLK_MAX_HW_SECTORS,
+};
+
+struct dibs_blk_blk_req_msg {
+	u64 offset;
+	u64 len;
+} __packed;
+
+struct dibs_blk_data_msg {
+	u64 total_bytes_of_req;
+	u16 datalen;
+	u8 data[];
+} __packed;
+
+struct dibs_blk_connect_msg {
+	u64 dmb_tok;
+} __packed;
+
+struct dibs_blk_media_change_msg {
+	u64 size;
+	u64 hash;
+	u8 flags;
+	u8 data[];
+} __packed;
+
+struct dibs_blk_peer_dev_msg {
+	struct dibs_msg_hdr hdr;
+	union {
+		struct dibs_blk_connect_msg cm;
+		struct dibs_blk_blk_req_msg blkrm;
+		struct dibs_blk_data_msg blkdm;
+		struct dibs_blk_media_change_msg blkmcm;
+	};
+};
+
+struct dibs_blk_peer_dev_rbe {
+	union {
+		struct dibs_blk_peer_dev_msg pdm;
+		u8 reserved[DIBS_BLK_PEER_DEV_MAX_RBE_SIZE];
+	};
+};
+
+struct dibs_blk_blkdev {
+	struct blk_mq_tag_set tag_set;
+	struct gendisk *gd;
+	bool quiesced;
+	int major;
+};
+
+struct dibs_blk_peer_dev_data_state {
+	u64 already_copied_bytes;
+	u8 data[DIBS_BLK_MAX_HW_SECTORS_BYTES];
+};
+
+struct dibs_blk_peer_dev {
+	struct dibs_blk_peer_dev_rbe rbe_to_send;
+	struct dibs_blk_peer_dev_data_state ds;
+	struct work_struct media_change_work;
+	struct work_struct media_gone_work;
+	struct work_struct proc_recv_msg_work;
+	unsigned long first_timeout;
+	unsigned long last_completion;
+	unsigned long max_wait;
+	struct dibs_peer_device *dpd;
+	int connect_msg_enqueued;
+	bool ring_registered;
+	bool tag_set_allocated;
+	bool blkdev_registered;
+	bool list_added;
+	struct dibs_blk_blkdev blk;
+	struct list_head list;
+	u8 device_add_disk;
+	u64 media_size;
+	/*
+	 * protects current_request, ds.already_copied_bytes, first_timeout,
+	 * media_size, media_hash and rbe_to_send
+	 */
+	spinlock_t req_lock;
+	struct request *current_request;
+	u64 media_hash;
+	int device_index;
+};
+
+static blk_status_t dibs_blk_queue_rq(struct blk_mq_hw_ctx *hctx,
+				      const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct dibs_blk_peer_dev *blkpd;
+	unsigned long flags;
+	u64 offset;
+	int rc;
+
+	offset = blk_rq_pos(req) * DIBS_BLK_SECTOR_SIZE;
+
+	blkpd = bd->rq->q->disk->private_data;
+
+	if (!blkpd->device_add_disk || !blkpd->ring_registered)
+		return BLK_STS_IOERR;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+
+	if (!blkpd->media_size) {
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		return BLK_STS_IOERR;
+	}
+
+	if (offset + blk_rq_bytes(req) > blkpd->media_size) {
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		pr_err("%s: out of bounds request\n", __func__);
+		return BLK_STS_IOERR;
+	}
+
+	/* Send request to remote side */
+	blkpd->rbe_to_send.pdm.hdr.version = DIBS_BLK_PEER_DEV_HDR_VERSION;
+	blkpd->rbe_to_send.pdm.hdr.type = DIBS_BLK_REQ_MSG;
+	blkpd->rbe_to_send.pdm.hdr.datalen =
+		sizeof(struct dibs_blk_blk_req_msg);
+	blkpd->rbe_to_send.pdm.blkrm.offset = offset;
+	blkpd->rbe_to_send.pdm.blkrm.len = blk_rq_bytes(req);
+
+	blkpd->current_request = req;
+	blk_mq_start_request(req);
+
+	rc = dibs_pbd_msg_send(&blkpd->dpd->rb,
+			       (struct dibs_msg_hdr *)&blkpd->rbe_to_send);
+	if (rc)
+		blkpd->current_request = NULL;
+
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	if (!rc)
+		return BLK_STS_OK;
+
+	if (rc == -ENOSPC || rc == -EAGAIN)
+		return BLK_STS_RESOURCE;
+
+	return BLK_STS_IOERR;
+}
+
+static struct request *dibs_blk_claim_request(struct dibs_blk_peer_dev *blkpd)
+{
+	unsigned long flags;
+	struct request *req;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	req = blkpd->current_request;
+	blkpd->current_request = NULL;
+	blkpd->ds.already_copied_bytes = 0;
+	blkpd->first_timeout = 0;
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	return req;
+}
+
+static void dibs_blk_requeue_inflight(struct dibs_blk_peer_dev *blkpd)
+{
+	struct request *req = dibs_blk_claim_request(blkpd);
+
+	if (!req)
+		return;
+
+	blk_mq_requeue_request(req, false);
+}
+
+static void dibs_blk_unquiesce(struct dibs_blk_peer_dev *blkpd)
+{
+	if (!blkpd->blk.quiesced)
+		return;
+
+	blkpd->blk.quiesced = false;
+	if (!blkpd->blk.gd)
+		return;
+
+	blk_mq_unquiesce_queue(blkpd->blk.gd->queue);
+	blk_mq_kick_requeue_list(blkpd->blk.gd->queue);
+}
+
+static void dibs_blk_rescan_partitions(struct dibs_blk_peer_dev *blkpd)
+{
+	struct gendisk *gd = blkpd->blk.gd;
+	int ret;
+
+	mutex_lock(&gd->open_mutex);
+	ret = bdev_disk_changed(gd, false);
+	mutex_unlock(&gd->open_mutex);
+
+	if (ret == -EBUSY)
+		set_bit(GD_NEED_PART_SCAN, &gd->state);
+	else if (ret)
+		pr_warn("%s: partition scan of %s failed: %d\n", __func__,
+			gd->disk_name, ret);
+}
+
+static void dibs_blk_update_capacity(struct dibs_blk_peer_dev *blkpd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	set_capacity(blkpd->blk.gd, blkpd->media_size / DIBS_BLK_SECTOR_SIZE);
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+}
+
+static void dibs_blk_media_gone_work(struct work_struct *work)
+{
+	struct dibs_blk_peer_dev *blkpd =
+		container_of(work, struct dibs_blk_peer_dev, media_gone_work);
+
+	if (!blkpd->device_add_disk)
+		return;
+
+	dibs_blk_update_capacity(blkpd);
+
+	dibs_blk_unquiesce(blkpd);
+	disk_force_media_change(blkpd->blk.gd);
+}
+
+static enum blk_eh_timer_return dibs_blk_timeout(struct request *req)
+{
+	struct dibs_blk_peer_dev *blkpd = req->q->disk->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+
+	if (blkpd->current_request != req) {
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		return BLK_EH_DONE;
+	}
+
+	if (!blkpd->first_timeout) {
+		blkpd->first_timeout = jiffies;
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		return BLK_EH_RESET_TIMER;
+	}
+
+	if (!time_after(jiffies, blkpd->first_timeout + blkpd->max_wait)) {
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		return BLK_EH_RESET_TIMER;
+	}
+
+	blkpd->current_request = NULL;
+	blkpd->ds.already_copied_bytes = 0;
+	blkpd->first_timeout = 0;
+
+	blkpd->media_size = 0;
+	blkpd->media_hash = 0;
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	blk_mq_end_request(req, BLK_STS_IOERR);
+	schedule_work(&blkpd->media_gone_work);
+
+	return BLK_EH_DONE;
+}
+
+static bool dibs_blk_cancel_request(struct request *req, void *data)
+{
+	struct dibs_blk_peer_dev *blkpd = data;
+	unsigned long flags;
+	bool claimed;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	claimed = blkpd->current_request == req;
+	if (claimed) {
+		blkpd->current_request = NULL;
+		blkpd->ds.already_copied_bytes = 0;
+		blkpd->first_timeout = 0;
+	}
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	if (claimed)
+		blk_mq_end_request(req, BLK_STS_IOERR);
+
+	return true;
+}
+
+static struct blk_mq_ops dibs_blk_mq_ops = {
+	.queue_rq = dibs_blk_queue_rq,
+	.timeout = dibs_blk_timeout,
+};
+
+static const struct block_device_operations dibs_blk_ops = {
+	.owner = THIS_MODULE,
+};
+
+static void dibs_blk_peer_dev_disconnect(struct dibs_peer_device *dpd)
+{
+	struct dibs_blk_peer_dev *blkpd = dpd->drv_priv;
+
+	if (blkpd->blk.gd && !blkpd->blk.quiesced) {
+		blk_mq_quiesce_queue(blkpd->blk.gd->queue);
+		blkpd->blk.quiesced = true;
+	}
+
+	if (blkpd->ring_registered) {
+		if (dibs_pbd_unregister_ring_buffer(blkpd->dpd))
+			pr_err("%s: dibs_pbd_unregister_ring_buffer() returned with error\n",
+			       __func__);
+		blkpd->ring_registered = false;
+	}
+
+	cancel_work_sync(&blkpd->proc_recv_msg_work);
+	cancel_work_sync(&blkpd->media_gone_work);
+	/* Peer will not respond after disconnect, requeue inflight request. */
+	dibs_blk_requeue_inflight(blkpd);
+}
+
+static int dibs_blk_peer_dev_reconnect(struct dibs_peer_device *dpd)
+{
+	struct dibs_blk_peer_dev *blkpd;
+	int ret;
+
+	blkpd = dpd->drv_priv;
+	blkpd->connect_msg_enqueued = 0;
+
+	if (blkpd->ring_registered) {
+		dibs_pbd_unregister_ring_buffer(blkpd->dpd);
+		blkpd->ring_registered = false;
+	}
+	cancel_work_sync(&blkpd->proc_recv_msg_work);
+	cancel_work_sync(&blkpd->media_gone_work);
+	dibs_blk_requeue_inflight(blkpd);
+	ret = dibs_pbd_register_ring_buffer("dibs_blk", blkpd->dpd,
+					    DIBS_BLK_PEER_DEV_BLK_RING_SIZE);
+	if (ret) {
+		pr_err("%s: failed to register ring buffer\n", __func__);
+		return ret;
+	}
+
+	blkpd->ring_registered = true;
+	dibs_ring_set_rdmb_tok(&blkpd->dpd->rb, blkpd->dpd->rdmb_tok);
+	dibs_blk_unquiesce(blkpd);
+	schedule_work(&blkpd->proc_recv_msg_work);
+
+	return 0;
+}
+
+static void dibs_blk_peer_dev_send_connect_msg(struct dibs_peer_device *dpd)
+{
+	struct dibs_blk_peer_dev *blkpd;
+	unsigned long flags;
+	int ret;
+
+	blkpd = dpd->drv_priv;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	blkpd->rbe_to_send.pdm.hdr.version = DIBS_BLK_PEER_DEV_HDR_VERSION;
+	blkpd->rbe_to_send.pdm.hdr.type = DIBS_BLK_CONNECT_MSG;
+	blkpd->rbe_to_send.pdm.hdr.datalen = sizeof(dpd->rb.dmb.dmb_tok);
+	blkpd->rbe_to_send.pdm.cm.dmb_tok = dpd->rb.dmb.dmb_tok;
+	ret = dibs_pbd_msg_send(&dpd->rb,
+				(struct dibs_msg_hdr *)&blkpd->rbe_to_send);
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	if (!ret)
+		blkpd->connect_msg_enqueued = 1;
+}
+
+static void dibs_blk_handle_data_msg(struct dibs_blk_peer_dev *blkpd,
+				     void *current_data, u64 data_len,
+				     u64 total_bytes_of_request)
+{
+	struct req_iterator iter;
+	size_t len, copied = 0;
+	struct bio_vec bvec;
+	unsigned long flags;
+	struct request *req;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+
+	req = blkpd->current_request;
+	if (!req) {
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		pr_warn("Received response for unknown request\n");
+		return;
+	}
+
+	blkpd->last_completion = jiffies;
+	blkpd->first_timeout = 0;
+
+	if (total_bytes_of_request != blk_rq_bytes(req)) {
+		pr_err("%s: total_bytes mismatch: got %llu, expected %u\n",
+		       __func__, total_bytes_of_request, blk_rq_bytes(req));
+		goto err;
+	}
+
+	if (data_len > DIBS_BLK_MAX_HW_SECTORS_BYTES)
+		goto err;
+
+	if (blkpd->ds.already_copied_bytes + data_len >
+	    total_bytes_of_request) {
+		pr_err("%s: data overflow: already %llu + new %llu > total %llu\n",
+		       __func__, blkpd->ds.already_copied_bytes, data_len,
+		       total_bytes_of_request);
+		goto err;
+	}
+
+	memcpy(blkpd->ds.data + blkpd->ds.already_copied_bytes, current_data,
+	       data_len);
+	blkpd->ds.already_copied_bytes += data_len;
+
+	if (blkpd->ds.already_copied_bytes < total_bytes_of_request) {
+		/* partial request */
+		spin_unlock_irqrestore(&blkpd->req_lock, flags);
+		return;
+	}
+
+	blkpd->ds.already_copied_bytes = 0;
+	blkpd->current_request = NULL;
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	rq_for_each_segment(bvec, req, iter) {
+		void *buffer = kmap_local_page(bvec.bv_page) + bvec.bv_offset;
+
+		len = min((size_t)bvec.bv_len, total_bytes_of_request - copied);
+		memcpy(buffer, blkpd->ds.data + copied, len);
+		kunmap_local(buffer);
+		copied += len;
+		if (copied >= total_bytes_of_request)
+			break;
+	}
+	blk_mq_end_request(req, BLK_STS_OK);
+	return;
+
+err:
+	blkpd->ds.already_copied_bytes = 0;
+	blkpd->current_request = NULL;
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+	blk_mq_end_request(req, BLK_STS_IOERR);
+}
+
+static bool dibs_blk_set_media(struct dibs_blk_peer_dev *blkpd, u64 media_size,
+			       u64 media_hash, u8 media_flags)
+{
+	unsigned long flags;
+	bool changed = true;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	if (blkpd->device_add_disk && media_size == blkpd->media_size &&
+	    media_hash == blkpd->media_hash &&
+	    (media_flags & DIBS_BLK_MEDIA_RECONNECT)) {
+		changed = false;
+	} else {
+		blkpd->media_size = media_size;
+		blkpd->media_hash = media_hash;
+	}
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	return changed;
+}
+
+static void dibs_blk_media_change_work(struct work_struct *work)
+{
+	struct dibs_blk_peer_dev *blkpd;
+	int ret;
+
+	blkpd = container_of(work, struct dibs_blk_peer_dev, media_change_work);
+
+	if (!blkpd->device_add_disk) {
+		blkpd->blk.gd = blk_mq_alloc_disk(&blkpd->blk.tag_set,
+						  &dibs_blk_lim, &blkpd->blk);
+		if (IS_ERR(blkpd->blk.gd)) {
+			pr_err("%s: failed to allocate gendisk: %pe\n",
+			       __func__, blkpd->blk.gd);
+			blkpd->blk.gd = NULL;
+			return;
+		}
+
+		blkpd->blk.gd->private_data = blkpd;
+		blkpd->blk.gd->fops = &dibs_blk_ops;
+		blkpd->blk.gd->major = blkpd->blk.major;
+		blkpd->blk.gd->first_minor =
+			blkpd->device_index * MAX_GPT_PARTITIONS;
+		blkpd->blk.gd->minors = MAX_GPT_PARTITIONS;
+		blkpd->blk.gd->events = DISK_EVENT_MEDIA_CHANGE;
+
+		set_disk_ro(blkpd->blk.gd, 1);
+		snprintf(blkpd->blk.gd->disk_name, 10, "dibs_blk%d",
+			 blkpd->device_index);
+
+		dibs_blk_update_capacity(blkpd);
+		blkpd->device_add_disk = 1;
+
+		ret = device_add_disk(&blkpd->dpd->dev, blkpd->blk.gd, NULL);
+		if (ret) {
+			pr_err("%s: device_add_disk failed: %d\n", __func__,
+			       ret);
+			blkpd->device_add_disk = 0;
+			put_disk(blkpd->blk.gd);
+			blkpd->blk.gd = NULL;
+			return;
+		}
+	}
+
+	dibs_blk_update_capacity(blkpd);
+	disk_force_media_change(blkpd->blk.gd);
+	dibs_blk_rescan_partitions(blkpd);
+}
+
+static void dibs_blk_handle_disk_detach(struct dibs_blk_peer_dev *blkpd)
+{
+	unsigned long flags;
+
+	if (!blkpd->device_add_disk)
+		return;
+
+	spin_lock_irqsave(&blkpd->req_lock, flags);
+	blkpd->media_size = 0;
+	blkpd->media_hash = 0;
+	spin_unlock_irqrestore(&blkpd->req_lock, flags);
+
+	dibs_blk_update_capacity(blkpd);
+
+	dibs_blk_unquiesce(blkpd);
+	blk_mq_tagset_busy_iter(&blkpd->blk.tag_set, dibs_blk_cancel_request,
+				blkpd);
+	disk_force_media_change(blkpd->blk.gd);
+}
+
+static void dibs_blk_proc_recv_msg_work(struct work_struct *work)
+{
+	struct dibs_peer_device *peer_dev;
+	struct dibs_blk_peer_dev_msg *msg;
+	struct dibs_blk_peer_dev *blkpd;
+	u64 total_bytes_of_request;
+	void *current_data;
+	u64 media_size;
+	u64 media_hash;
+	u64 data_len;
+	u8 media_flags;
+
+	blkpd = container_of(work, struct dibs_blk_peer_dev,
+			     proc_recv_msg_work);
+	peer_dev = blkpd->dpd;
+
+	if (!blkpd->connect_msg_enqueued)
+		dibs_blk_peer_dev_send_connect_msg(peer_dev);
+
+	while ((msg = (struct dibs_blk_peer_dev_msg *)dibs_pbd_msg_recv(&peer_dev->rb))) {
+		switch (msg->hdr.type) {
+		case DIBS_BLK_DATA_MSG:
+			current_data = msg->blkdm.data;
+			data_len = READ_ONCE(msg->blkdm.datalen);
+			total_bytes_of_request =
+				READ_ONCE(msg->blkdm.total_bytes_of_req);
+
+			if (sizeof(msg->blkdm) + data_len >
+			    READ_ONCE(msg->hdr.datalen))
+				break;
+			dibs_blk_handle_data_msg(blkpd, current_data, data_len,
+						 total_bytes_of_request);
+			break;
+
+		case DIBS_BLK_MEDIA_CHANGE:
+			media_size = READ_ONCE(msg->blkmcm.size);
+			media_hash = READ_ONCE(msg->blkmcm.hash);
+			media_flags = READ_ONCE(msg->blkmcm.flags);
+
+			if (dibs_blk_set_media(blkpd, media_size, media_hash,
+					       media_flags))
+				schedule_work(&blkpd->media_change_work);
+			break;
+
+		case DIBS_BLK_DISK_DETACH:
+			dibs_blk_handle_disk_detach(blkpd);
+			break;
+
+		default:
+			pr_warn("Received unknown message type: %d\n",
+				msg->hdr.type);
+			break;
+		}
+		dibs_pbd_msg_ack(&peer_dev->rb);
+	}
+}
+
+static int dibs_blk_peer_dev_probe(struct dibs_peer_device *dpd)
+{
+	struct dibs_blk_peer_dev *blkpd;
+	int ret;
+
+	dpd->type = PEER_DEV_TYPE_BLK;
+
+	blkpd = kzalloc_obj(*blkpd, GFP_KERNEL);
+	if (!blkpd)
+		return -ENOMEM;
+
+	blkpd->dpd = dpd;
+	dpd->drv_priv = blkpd;
+
+	spin_lock_init(&blkpd->req_lock);
+	INIT_LIST_HEAD(&blkpd->list);
+	INIT_WORK(&blkpd->media_change_work, dibs_blk_media_change_work);
+	INIT_WORK(&blkpd->media_gone_work, dibs_blk_media_gone_work);
+	INIT_WORK(&blkpd->proc_recv_msg_work, dibs_blk_proc_recv_msg_work);
+
+	ret = dibs_pbd_register_ring_buffer("dibs_blk", dpd,
+					    DIBS_BLK_PEER_DEV_BLK_RING_SIZE);
+	if (ret) {
+		pr_err("%s: failed to register ring buffer\n", __func__);
+		goto err_free;
+	}
+
+	blkpd->ring_registered = true;
+	dibs_ring_set_rdmb_tok(&dpd->rb, dpd->rdmb_tok);
+	blkpd->blk.major = register_blkdev(0, "dibs_blk");
+	if (blkpd->blk.major < 0) {
+		pr_err("%s: failed to register block device\n", __func__);
+		ret = blkpd->blk.major;
+		goto err_unregister_ring;
+	}
+	blkpd->blkdev_registered = true;
+
+	blkpd->blk.tag_set.ops = &dibs_blk_mq_ops;
+	blkpd->blk.tag_set.nr_hw_queues = 1;
+	blkpd->blk.tag_set.queue_depth = 1;
+	blkpd->blk.tag_set.numa_node = NUMA_NO_NODE;
+	blkpd->blk.tag_set.timeout = DIBS_BLK_RQ_TIMEOUT;
+	blkpd->blk.tag_set.cmd_size = 0;
+	blkpd->blk.tag_set.flags = BLK_MQ_F_TAG_QUEUE_SHARED;
+	blkpd->blk.tag_set.driver_data = &blkpd->blk;
+
+	ret = blk_mq_alloc_tag_set(&blkpd->blk.tag_set);
+	if (ret) {
+		pr_err("%s: blk_mq_alloc_tag_set failed: %d\n", __func__, ret);
+		if (blkpd->blkdev_registered)
+			unregister_blkdev(blkpd->blk.major, "dibs_blk");
+		goto err_unregister_ring;
+	}
+	blkpd->tag_set_allocated = true;
+
+	mutex_lock(&blkpd_mutex);
+	blkpd->device_index = dibs_blk_idx++;
+	list_add(&blkpd->list, &blkpd_list);
+	blkpd->list_added = true;
+	mutex_unlock(&blkpd_mutex);
+
+	blkpd->max_wait = secs_to_jiffies(dibs_blk_max_timeout);
+
+	return 0;
+
+err_unregister_ring:
+	if (blkpd->ring_registered)
+		dibs_pbd_unregister_ring_buffer(dpd);
+err_free:
+	dpd->drv_priv = NULL;
+	kfree(blkpd);
+	return ret;
+}
+
+static void dibs_blk_peer_dev_remove(struct dibs_peer_device *dpd)
+{
+	struct dibs_blk_peer_dev *blkpd = dpd->drv_priv;
+
+	if (blkpd->list_added) {
+		mutex_lock(&blkpd_mutex);
+		list_del(&blkpd->list);
+		mutex_unlock(&blkpd_mutex);
+		blkpd->list_added = false;
+	}
+
+	if (blkpd->ring_registered) {
+		dibs_pbd_unregister_ring_buffer(blkpd->dpd);
+		blkpd->ring_registered = false;
+	}
+
+	cancel_work_sync(&blkpd->proc_recv_msg_work);
+	cancel_work_sync(&blkpd->media_change_work);
+	cancel_work_sync(&blkpd->media_gone_work);
+
+	if (blkpd->device_add_disk) {
+		blk_mark_disk_dead(blkpd->blk.gd);
+		dibs_blk_unquiesce(blkpd);
+		blk_mq_tagset_busy_iter(&blkpd->blk.tag_set,
+					dibs_blk_cancel_request, blkpd);
+		del_gendisk(blkpd->blk.gd);
+		put_disk(blkpd->blk.gd);
+		blkpd->blk.gd = NULL;
+		blkpd->device_add_disk = 0;
+	}
+
+	if (blkpd->tag_set_allocated)
+		blk_mq_free_tag_set(&blkpd->blk.tag_set);
+
+	if (blkpd->blkdev_registered)
+		unregister_blkdev(blkpd->blk.major, "dibs_blk");
+
+	kfree(blkpd);
+}
+
+static void dibs_blk_peer_dev_handle_irq(unsigned int dmbno,
+					 struct dibs_peer_device *peer_dev,
+					 u16 dmbemask)
+{
+	struct dibs_blk_peer_dev *blkpd;
+
+	blkpd = peer_dev->drv_priv;
+	schedule_work(&blkpd->proc_recv_msg_work);
+}
+
+static struct dibs_peer_dev_driver dibs_blk_pdd = {
+	.drv = {
+		.owner = THIS_MODULE,
+		.name = "dibs_blk",
+	},
+	.type = DIBS_CLIENT_TYPE_DIBS_BLK,
+	.probe = dibs_blk_peer_dev_probe,
+	.remove = dibs_blk_peer_dev_remove,
+	.reconnect = dibs_blk_peer_dev_reconnect,
+	.disconnect = dibs_blk_peer_dev_disconnect,
+
+	.handle_irq = dibs_blk_peer_dev_handle_irq,
+};
+
+static int __init dibs_blk_init(void)
+{
+	int ret;
+
+	ret = dibs_pbd_driver_register(&dibs_blk_pdd);
+	return ret;
+}
+
+static void __exit dibs_blk_exit(void)
+{
+	dibs_pbd_driver_unregister(&dibs_blk_pdd);
+}
+
+module_init(dibs_blk_init);
+module_exit(dibs_blk_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("dibs peer device driver for block devices");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 64e1f5505de5..2f4ee27c0ea3 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -573,8 +573,10 @@ void dibs_dev_del(struct dibs_dev *dibs);
 #define PEER_DEV_CONNECTED 1
 
 #define DIBS_CLIENT_TYPE_DIBS_CONSOLE 1
+#define DIBS_CLIENT_TYPE_DIBS_BLK 2
 
 #define PEER_DEV_TYPE_CONSOLE 1
+#define PEER_DEV_TYPE_BLK 2
 
 struct dibs_peer_device {
 	u8 id;

-- 
2.53.0

