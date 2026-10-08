Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346C41D4F4
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446914; cv=none; b=Y07c9ArNpYxFBkYxcCI8HM9MXCxgOlNgBAW5p4jnE04T+alrxeiKcfgb5hZq6K4R/PQg7j3YuaxGemdo6vpW++AdRDsaQggAhXaGRDcfzkEhb5cpWUDaDZqBFGpYbi/KOAoJbLaniQjP2NGGZllojqJQQ79rT/ZmOzY1/N04j6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446914; c=relaxed/simple;
	bh=qumSuAqZQ5XIl77QmdE0pKq5IkBDTlECcYqRQjEcBME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZHucqELPZ+dw2zgY+0tuOP+GfvI7/yxIMmBdLl3fbKEnJot4lZJaIa0YQFDqxq20/CqDAFslQLqFF2MRq8hUr+JuMcxV3uPaYLNLN3YJnaB/0gslmKCrUvdgKlaifRYaXrnb36wXyvAa9TFT+Tms2jco7xJVrNQclEElCsiPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UoqclBuD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UoqclBuD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987aIx93122294
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sRxNqP
	hcMCaJXgPivKRZ/M6x+pfgBdayQRpX+lCGDpo=; b=UoqclBuD4KOimIU/doEVRm
	2+K7BKndeB1raeXG4Urs3YAfbzzwbqVFzQsupYdSX/6Zh8fxg+TbBZPNO0e+a2xl
	ZyJsgbzjy+95qsHRcyboi8RMt4sexovYqA3PyDsdmaB83QhufpuUmp+lsujVAGBp
	CZaooNg70C+9oLUBrUEJuqBX7NRMccr2HjLRc+umEoDkWwNAS3TYOzPsc+O+TKZx
	OZWrtDKMT8y22kz6tx+i+ogazlc4TgVdh5495uxj/BBou3HKK8xeuJwqo07kfaxC
	Cj3T9bepsZ2EygfJlEzBbLaBwwIokje1Hss/7uTifE/UbiKTfAtlOefNE3NjdHSw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw2aph-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IW083153182
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh28r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69888N8U47579570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:08:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC5320043;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59EFE20040;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:08:05 +0200
Subject: [PATCH 3/4] dibs: introduce dibs console peer device driver
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-console_server-v1-3-636b11ebf191@linux.ibm.com>
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
X-Proofpoint-GUID: ctf14MCDECJzlo6GmGgJqycYhx8Ypasr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXwC16IeGYaAYZ
 nXWASvabNcl1whdKMJlxD890RrlP/81CPJTpwI5xKY/zHewKprjP7io8C0Gn00/YKhDEd7fSnf/
 rJWlB0QX5jpI0t5EKCnS5XFheT59iReR7t4Hf+2XBfIRnO9kTfgbLc9fOix40TdIGs79O5rKuxj
 mFQcgoXzqJo7R9OVVps0HzoD8luKRaciuA2NEezxufqapCT+iT1Ax4zjSldamC8qtqh3kLy+3nT
 8/dFUYKo+OPAiETbnF36+Bm1lT7/sIE0m2a+4tRc6vd+VgaucvaNmg0euvgGb+GFqS0PEfHLnk3
 hdexDxVbrR9HmDv9VW4K7hUW1bm3fkdKi8jzDHD5uBPxFKbAQq3yjfqzB2lqKvr43tZgG0keYnK
 0t+OB++Ba/Wzds6M8KdK3sANMl4nEqxiyeoPk5TlqhTWefaoUmpO420+Mb79uY4TgNITmLzJcvd
 F7rfjhFnuyXI147JE2w==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac74f7e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=biehI8zqAAAA:8 a=750IxlTKyOIG6DHasmIA:9 a=QEXdDO2ut3YA:10
 a=hI-W2eA9asJdKFXjnL6t:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXx7rZYBC7M1Nk
 m2nWsaAfUX3/Zwdz/cflRDvZ7+yX5k2eFGAoJAca3+C0/VMKEWYhZQKI6ddyqCUrkiLC0TW9Sfn
 xPTRYW5wVwaK8rWGhhPHNG4E08RqFn0=
X-Proofpoint-ORIG-GUID: ctf14MCDECJzlo6GmGgJqycYhx8Ypasr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

Introduce a virtual console device driver that makes use of the newly
added dibs peer device bus.

This allows to make use of tty's that connect two systems by using dibs
devices on the same dibs fabric. This works on LPAR as well as z/VM
without requiring a network setup.

The vfio user space tooling on the remote system announces dibs peer
devices of type tty to this instance. If the discovery mechanism of the
dibs peer bus detects a hvc peer device, this driver will be probed via
uevent.

The number of the used hvc device (/dev/hvcX) can be accessed by reading
'/sys/bus/dibs_peer/devices/<rgid>/hvc'

Once the connection is set up, the tty can be accessed by using
'/dev/hvcX'.

Co-developed-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 drivers/dibs/Kconfig              |  11 ++
 drivers/dibs/Makefile             |   1 +
 drivers/dibs/dibs_console.c       | 388 ++++++++++++++++++++++++++++++++++++++
 include/linux/dibs.h              |   4 +
 6 files changed, 406 insertions(+)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 23d6c59189cc..c4acf13aeaba 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -134,6 +134,7 @@ CONFIG_SMC_DIAG=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_DIBS_PEER_BUS_DRV=y
+CONFIG_DIBS_CONSOLE=m
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 3bffcd016be8..344724c56917 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -125,6 +125,7 @@ CONFIG_SMC_DIAG=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_DIBS_PEER_BUS_DRV=y
+CONFIG_DIBS_CONSOLE=m
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 98068bc541e5..a0ed49977274 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -32,3 +32,14 @@ config DIBS_PEER_BUS_DRV
 	  foundation for dibs peer device drivers that operate on top of dibs.
 	  It provides device discovery and lifecycle management for peer
 	  devices across the dibs fabric.
+
+config DIBS_CONSOLE
+	tristate "dibs device console support"
+	depends on DIBS && DIBS_PEER_BUS_DRV
+	select HVC_DRIVER
+	help
+	  Support for console access over dibs peer devices of type console.
+	  This peer device driver operates on the dibs peer bus and enables
+	  virtual console communication across systems in a dibs fabric. A
+	  device of type /dev/hvcN will be created for each peer device that is
+	  detected.
diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
index b1418f5149c2..a39a67020e05 100644
--- a/drivers/dibs/Makefile
+++ b/drivers/dibs/Makefile
@@ -7,3 +7,4 @@ dibs-y += dibs_main.o
 obj-$(CONFIG_DIBS) += dibs.o
 dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
 dibs-$(CONFIG_DIBS_PEER_BUS_DRV) += dibs_peer_bus_drv.o
+obj-$(CONFIG_DIBS_CONSOLE) += dibs_console.o
diff --git a/drivers/dibs/dibs_console.c b/drivers/dibs/dibs_console.c
new file mode 100644
index 000000000000..df53cbcf2fb5
--- /dev/null
+++ b/drivers/dibs/dibs_console.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dibs hypervisor console (HVC) device driver
+ *
+ * This hvc device driver provides terminal access using
+ * dibs peer devices of type tty.
+ *
+ * Copyright IBM Corp.
+ */
+
+#include "../tty/hvc/hvc_console.h"
+#include <linux/dibs.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
+#include <linux/stringify.h>
+#include <linux/uuid.h>
+#include <linux/workqueue.h>
+
+MODULE_DESCRIPTION("dibs hypervisor console (HVC) device driver");
+MODULE_ALIAS("dibs:peer_dev:" __stringify(PEER_DEV_TYPE_CONSOLE));
+
+static unsigned int dibs_con_max_timeout = 60;
+module_param(dibs_con_max_timeout, uint, 0644);
+MODULE_PARM_DESC(dibs_con_max_timeout,
+		 "Maximum timeout for dibs remote in seconds");
+
+enum { DIBS_CON_MAX_PUT_CHARS = 256 };
+enum { DIBS_CON_MAX_VTERMNOS = 8 };
+
+enum { DIBS_CON_PEER_DEV_HDR_VERSION = 1 };
+enum {
+	DIBS_CON_CONNECT_MSG = 1,
+	DIBS_CON_DATA_MSG = 2,
+	DIBS_CON_RESIZE_MSG = 4
+};
+
+#define DIBS_CON_PEER_DEV_BUFFER_SIZE 2048
+#define DIBS_CON_PEER_DEV_RING_SIZE (64 * 1024)
+#define DIBS_CON_PEER_DEV_MAX_RBE_SIZE 512
+
+#define DIBS_CON_PEER_DEV_DATA_MSG_MAX_DATALEN \
+	(DIBS_CON_PEER_DEV_MAX_RBE_SIZE - sizeof(struct dibs_msg_hdr))
+
+struct dibs_con_tty_data_msg {
+	u8 data[DIBS_CON_PEER_DEV_DATA_MSG_MAX_DATALEN];
+} __packed;
+
+struct dibs_con_resize_msg {
+	struct winsize ws;
+} __packed;
+
+struct dibs_con_connect_msg {
+	u64 dmb_tok;
+} __packed;
+
+struct dibs_con_pd_msg {
+	struct dibs_msg_hdr hdr;
+	union {
+		struct dibs_con_connect_msg cm;
+		struct dibs_con_tty_data_msg tdm;
+		struct dibs_con_resize_msg rm;
+	};
+};
+
+struct dibs_con_peer_dev_rbe {
+	union {
+		struct dibs_con_pd_msg pdm;
+		u8 reserved[DIBS_CON_PEER_DEV_MAX_RBE_SIZE];
+	};
+};
+
+struct dibs_con_peer_dev {
+	u8 vtermno;
+	int connect_msg_enqueued;
+	bool ring_registered;
+	struct dibs_peer_device *dpd;
+	struct hvc_struct *hvc;
+	struct kfifo fifo;
+	spinlock_t mr_spinlock /* protects the message ring */;
+};
+
+struct dibs_con_peer_dev *hvc_peer_devs[DIBS_CON_MAX_VTERMNOS] = { NULL };
+
+static void dibs_con_peer_dev_send_connect_msg(struct dibs_peer_device *dpd)
+{
+	struct dibs_con_peer_dev_rbe dcpdr;
+	struct dibs_con_peer_dev *dcpd;
+	int ret;
+
+	dcpd = dpd->drv_priv;
+
+	/* Write own DMB token to the other side */
+	dcpdr.pdm.hdr.version = DIBS_CON_PEER_DEV_HDR_VERSION;
+	dcpdr.pdm.hdr.type = DIBS_CON_CONNECT_MSG;
+	dcpdr.pdm.hdr.datalen = sizeof(dpd->rb.dmb.dmb_tok);
+	dcpdr.pdm.cm.dmb_tok = dpd->rb.dmb.dmb_tok;
+
+	ret = dibs_pbd_msg_send(&dpd->rb, &dcpdr.pdm.hdr);
+	if (!ret)
+		dcpd->connect_msg_enqueued = 1;
+}
+
+static void dibs_con_peer_dev_handle_irq(unsigned int dmbno,
+					 struct dibs_peer_device *peer_dev,
+					 u16 dmbemask)
+{
+	struct dibs_con_peer_dev *dcpd;
+	struct dibs_con_pd_msg *msg;
+	struct winsize winsize;
+	size_t count;
+	u16 datalen;
+
+	dcpd = peer_dev->drv_priv;
+
+	if (!dcpd->connect_msg_enqueued)
+		dibs_con_peer_dev_send_connect_msg(peer_dev);
+
+	while ((msg = (struct dibs_con_pd_msg *)dibs_pbd_msg_recv(&peer_dev->rb))) {
+		switch (msg->hdr.type) {
+		case DIBS_CON_DATA_MSG:
+			datalen = min_t(u16, READ_ONCE(msg->hdr.datalen),
+					DIBS_CON_PEER_DEV_DATA_MSG_MAX_DATALEN);
+			count = kfifo_in(&dcpd->fifo, &msg->tdm, datalen);
+			if (count < datalen)
+				pr_warn("%s: dropping %zu bytes of data\n",
+					__func__, datalen - count);
+			hvc_kick();
+			break;
+
+		case DIBS_CON_RESIZE_MSG:
+			winsize = msg->rm.ws;
+			hvc_resize(dcpd->hvc, winsize);
+			break;
+
+		default:
+			break;
+		}
+		dibs_pbd_msg_ack(&peer_dev->rb);
+	}
+}
+
+static void dibs_con_peer_dev_disconnect(struct dibs_peer_device *dpd)
+{
+	struct dibs_con_peer_dev *dcpd = dpd->drv_priv;
+
+	if (dcpd->ring_registered) {
+		if (dibs_pbd_unregister_ring_buffer(dcpd->dpd))
+			pr_err("%s: dibs_pbd_unregister_ring_buffer() returned with error\n",
+			       __func__);
+		dcpd->ring_registered = false;
+	}
+}
+
+/*
+ * dibs_con_get_chars()
+ * This function is called by the HVC thread to receive tty data.
+ *
+ * @vtermmno: HVC virtual terminal number
+ * @buf: buffer offered by HVC to store data. By calling hvc_kick()
+ *	this function is called again with a new buffer to transfer more data
+ *	to HVC.
+ */
+static ssize_t dibs_con_get_chars(u32 vtermno, u8 *buf, size_t count)
+{
+	struct dibs_con_peer_dev *dcpd = NULL;
+
+	dcpd = hvc_peer_devs[vtermno];
+	if (!dcpd)
+		return 0;
+
+	spin_lock(&dcpd->mr_spinlock);
+	count = kfifo_out(&dcpd->fifo, buf, count);
+	if (!kfifo_is_empty(&dcpd->fifo))
+		hvc_kick();
+
+	spin_unlock(&dcpd->mr_spinlock);
+	return count;
+}
+
+/*
+ * dibs_con_put_chars()
+ *
+ * This function is called by the HVC framework when new tty
+ * data is available. It enqueues the data in the dibs dmb ring
+ * to transfer it to the other side.
+ */
+static ssize_t dibs_con_put_chars(u32 vtermno, const u8 *buf, size_t count)
+{
+	struct dibs_con_peer_dev *dcpd = NULL;
+	struct dibs_con_peer_dev_rbe dcpdr;
+	size_t max_cnt;
+
+	dcpd = hvc_peer_devs[vtermno];
+	if (!dcpd)
+		return 0;
+	if (!dcpd->connect_msg_enqueued)
+		return 0;
+
+	max_cnt = dibs_pbd_msg_max_payload(&dcpd->dpd->rb);
+	if (!max_cnt)
+		return 0;
+
+	count = min(count, max_cnt);
+	dcpdr.pdm.hdr.version = DIBS_CON_PEER_DEV_HDR_VERSION;
+	dcpdr.pdm.hdr.type = DIBS_CON_DATA_MSG;
+	dcpdr.pdm.hdr.datalen = count;
+	memcpy(&dcpdr.pdm.tdm.data, buf, count);
+	if (!dibs_pbd_msg_send(&dcpd->dpd->rb, &dcpdr.pdm.hdr))
+		return (ssize_t)count;
+	else
+		return 0;
+}
+
+static const struct hv_ops dibs_con_ops = {
+	.get_chars = dibs_con_get_chars,
+	.put_chars = dibs_con_put_chars,
+};
+
+static int dibs_con_alloc_hvc(struct dibs_con_peer_dev *dcpd)
+{
+	int vtermno;
+	int ret;
+
+	for (vtermno = 0; vtermno < DIBS_CON_MAX_VTERMNOS; vtermno++) {
+		ret = hvc_instantiate(vtermno, vtermno, &dibs_con_ops);
+		if (ret)
+			continue;
+		dcpd->hvc = hvc_alloc(vtermno, vtermno, &dibs_con_ops,
+				      DIBS_CON_MAX_PUT_CHARS);
+		if (IS_ERR(dcpd->hvc)) {
+			ret = PTR_ERR(dcpd->hvc);
+			pr_err("%s: Cannot allocate HVC devices\n", __func__);
+			dcpd->hvc = NULL;
+			return ret;
+		}
+
+		hvc_peer_devs[vtermno] = dcpd;
+		dcpd->vtermno = vtermno;
+		dcpd->hvc->irq_requested = 1;
+		return 0;
+	}
+	return -EBUSY;
+}
+
+static ssize_t termid_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dibs_peer_device *dpd;
+	struct dibs_con_peer_dev *dcpd;
+
+	dpd = to_dibs_peer_device(dev);
+	dcpd = dpd->drv_priv;
+	if (dcpd->dpd == dpd)
+		return sysfs_emit(buf, "hvc%d\n", dcpd->hvc->index);
+	return 0;
+}
+static DEVICE_ATTR_RO(termid);
+
+static int dibs_con_peer_dev_probe(struct dibs_peer_device *dpd)
+{
+	struct dibs_con_peer_dev *dcpd;
+	int ret;
+
+	dpd->type = PEER_DEV_TYPE_CONSOLE;
+
+	dcpd = kzalloc_obj(*dcpd, GFP_KERNEL);
+	if (!dcpd)
+		return -ENOMEM;
+
+	dpd->drv_priv = dcpd;
+	dcpd->dpd = dpd;
+
+	ret = kfifo_alloc(&dcpd->fifo, DIBS_CON_PEER_DEV_BUFFER_SIZE,
+			  GFP_KERNEL);
+	if (ret)
+		goto err_alloc_fifo;
+
+	ret = dibs_con_alloc_hvc(dcpd);
+	if (ret)
+		goto err_alloc_hvc;
+	ret = sysfs_create_file(&dpd->dev.kobj, &dev_attr_termid.attr);
+	if (ret)
+		pr_warn("Adding hvc number to sysfs failed.\n");
+
+	ret = dibs_pbd_register_ring_buffer("dibs_con", dpd,
+					    DIBS_CON_PEER_DEV_RING_SIZE);
+	if (ret)
+		goto err_register_rb;
+
+	dcpd->ring_registered = true;
+	dibs_ring_set_rdmb_tok(&dpd->rb, dpd->rdmb_tok);
+
+	return 0;
+
+err_register_rb:
+	sysfs_remove_file(&dpd->dev.kobj, &dev_attr_termid.attr);
+	hvc_peer_devs[dcpd->vtermno] = NULL;
+	hvc_remove(dcpd->hvc);
+err_alloc_hvc:
+	kfifo_free(&dcpd->fifo);
+err_alloc_fifo:
+	dpd->drv_priv = NULL;
+	kfree(dcpd);
+	return ret;
+}
+
+static void dibs_con_peer_dev_remove(struct dibs_peer_device *dpd)
+{
+	struct dibs_con_peer_dev *dcpd = dpd->drv_priv;
+
+	if (dcpd->hvc)
+		hvc_remove(dcpd->hvc);
+	hvc_peer_devs[dcpd->vtermno] = NULL;
+	kfifo_free(&dcpd->fifo);
+
+	if (dcpd->ring_registered) {
+		dibs_pbd_unregister_ring_buffer(dcpd->dpd);
+		dcpd->ring_registered = false;
+	}
+
+	sysfs_remove_file(&dpd->dev.kobj, &dev_attr_termid.attr);
+
+	kfree(dcpd);
+}
+
+static int dibs_con_peer_dev_reconnect(struct dibs_peer_device *dpd)
+{
+	struct dibs_con_peer_dev *dcpd;
+	int ret;
+
+	dcpd = dpd->drv_priv;
+
+	dcpd->connect_msg_enqueued = 0;
+	if (dcpd->ring_registered) {
+		dibs_pbd_unregister_ring_buffer(dcpd->dpd);
+		dcpd->ring_registered = false;
+	}
+
+	ret = dibs_pbd_register_ring_buffer("dibs_con", dcpd->dpd,
+					    DIBS_CON_PEER_DEV_RING_SIZE);
+	if (ret) {
+		pr_err("%s: failed to register ring buffer\n", __func__);
+		return ret;
+	}
+	dcpd->ring_registered = true;
+	dibs_ring_set_rdmb_tok(&dcpd->dpd->rb, dcpd->dpd->rdmb_tok);
+
+	return ret;
+}
+
+static struct dibs_peer_dev_driver dibs_con_pdd = {
+	.drv = {
+		.owner = THIS_MODULE,
+		.name = "dibs_con",
+	},
+	.type = DIBS_CLIENT_TYPE_DIBS_CONSOLE,
+	.probe = dibs_con_peer_dev_probe,
+	.remove = dibs_con_peer_dev_remove,
+	.reconnect = dibs_con_peer_dev_reconnect,
+	.disconnect = dibs_con_peer_dev_disconnect,
+
+	.handle_irq = dibs_con_peer_dev_handle_irq,
+};
+
+static int __init dibs_con_init(void)
+{
+	int ret;
+
+	ret = dibs_pbd_driver_register(&dibs_con_pdd);
+
+	return ret;
+}
+
+static void __exit dibs_con_exit(void)
+{
+	dibs_pbd_driver_unregister(&dibs_con_pdd);
+}
+
+module_init(dibs_con_init);
+module_exit(dibs_con_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 8c24f7b33e6f..64e1f5505de5 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -572,6 +572,10 @@ void dibs_dev_del(struct dibs_dev *dibs);
 #define PEER_DEV_DISCONNECTED 0
 #define PEER_DEV_CONNECTED 1
 
+#define DIBS_CLIENT_TYPE_DIBS_CONSOLE 1
+
+#define PEER_DEV_TYPE_CONSOLE 1
+
 struct dibs_peer_device {
 	u8 id;
 	uuid_t rgid;

-- 
2.53.0

