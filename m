Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7C44064C
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446922; cv=none; b=L50vjzGEY6nzL42xvlGrGko0q0jHlK48wRkm8/LMIktNgtJHtw9+vWvvugfv7KjMwJjgmRoiBNO3b8sFw6f2ndU5raP3sq7PZ2ttVMpfSoKmeIyiDRDL6V27yCM1er1QxnKjwwuuHhApFaeJ9m2x8O9jLWobPGePCnCrYiZv5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446922; c=relaxed/simple;
	bh=D0JbVCjum4XE9aAjuW5mJnGBt6RGUkdPM8iQb0Q8HY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9UQHuEEEJirl5bW6zfyDVNcm7GJ1UTOlKdkCQW+ihtIFsUNBWK50bQET3uaIA5C1BHuAe4NJr7MBbJQQAtjQOeG3IgGdw/asKCjdIRhTiKZ/v0RKKQwMGU/4wEOhBh8fDo5RhY1d7gtpgAYDKiPZmsBTD32JTcwEA4o3qsyyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1xzX5Wg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1xzX5Wg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987Zr7I702901
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3OzOiA
	pEQ7lNqDQt583KZo2bTAvQXwMfsshhaNLMdcs=; b=e1xzX5WgW8PGyBlEM2UHJW
	eZJA1d9tQd9utn1j4+5XU5z/qAcUt3fFNo5hPhphudu+82HoBCjewcTLs7qLk7ha
	wREkFJuLzxaLMqaHB98dNfYLb0CoBeIxhDVlx5Ys6uL6bAoE/TitHIRQKqD1G/6A
	Ns14TnJTQaWSXLV4erwW8Ig9/dEXF7WQ6JY0+RO1hCZkgIm6YGJQOTo9Oq0pqEzC
	pmqUufXFKiOwbWd2nDHHtCbvImGIUAv+inhWoQHm8lEycWM9GsWoCjM9DYolJWCE
	WYOLFrr/DJ92HmDuHASuKblAjTUUKVQzTb7tMD+4NHwPDaJsGfT/4LVjLoQ6vdeA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvaap6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IZJe3149985
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dp6u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69888NIM47579568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:08:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507A22004D;
	Thu,  8 Oct 2026 08:08:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA8F02004B;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:08:04 +0200
Subject: [PATCH 2/4] dibs: introduce dibs peer device bus driver
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-console_server-v1-2-636b11ebf191@linux.ibm.com>
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
X-Proofpoint-GUID: x2kxIOTH-6wgNewom4JvESoAdHh27SYw
X-Proofpoint-ORIG-GUID: x2kxIOTH-6wgNewom4JvESoAdHh27SYw
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac74f7d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=X0JgxACIN1DH1Q6fI_YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX5otI5ADo4B0+
 w2SMnQazYPe8lXWGeGbe68paSwn1uIyQ9P8yQU/7poXwqUgPWCKqA8G3Yuu+bPIa0+42Dem+va1
 Ok5RpmnKuvbBIKDGUP18xvS7iTLt8tEyugyKwijNwFMcveX90y7T0OhL1YKYEm9+Odf3bZcXRwN
 IC0OdIMMsdpntANPkkU5yDsQJPZMFOMjZbUS+wiPwuD2kqct0ByjkI4e72OS1/gO2NFa5Gawyep
 ZmUm7hGZR5jDRUE7m1CaREWnUXQ6Cn4G+4HXE/mUcHtceRmyQwMNmxmL7/QdaYgY83p2dFfQ+T4
 CbMe3WCd8WbHnCVgiHh3o2CsntNOlY+pkQOfWM5ya2fGm+BpUUcvaaU2OvuPB2zYtn6dRohZSmM
 kjf3WnEspzjTaDlWH78hLoJT7Ld6mcLKJLRF4sMTaYP/4l7CvY7LbNiD78abjrLChoTOL+RDVrB
 q0Aqmf0xLpaAOREofSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX19/7iYCtLpbb
 2phtVa2sutEdxvDf/Liyvh2VEITJkS8vej/e74PT+mnL/qKFkEKpoQ04eaVsy0WNtROJ38SOJsc
 d1lmxmvlcGA1OxhDZcgvV/qKe0Ajsz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

Introduce a dibs peer device bus driver that represents remotely
emulated dibs peer devices as kernel devices. The driver handles
discovery and lifecycle management of remote peer devices and provides
the foundation for dibs peer device drivers that operate on top of dibs.

Two such peer device drivers, hvc_dibs and dibsblk, are added in
follow-up patches.

Dibs peer devices are provided by vfio user space tooling (Console
Server) and are discovered by the kernel of a target system.

Discovery works by setting e.g. the kernel parameter
'dibs.dibs_peer_address=gid:64000da3-78e8-3931-0000-000000000000'. The
UUID must be the GID used by the console server of the remote system.

Disovery can also be triggered manually by writing the GID of the remote
system to the discover attribute like e.g. 'echo
gid:04000da5-78e8-3931-0000-000000000000 > /sys/bus/dibs_peer/discover'.

Connections can be terminated by unbinding an dibs peer device from its
driver.

Co-developed-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |    1 +
 arch/s390/configs/defconfig       |    1 +
 drivers/dibs/Kconfig              |   11 +
 drivers/dibs/Makefile             |    3 +-
 drivers/dibs/dibs_main.c          |    7 +
 drivers/dibs/dibs_peer_bus_drv.c  | 1220 +++++++++++++++++++++++++++++++++++++
 include/linux/dibs.h              |   72 ++-
 7 files changed, 1313 insertions(+), 2 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 3dae71474333..23d6c59189cc 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -133,6 +133,7 @@ CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
+CONFIG_DIBS_PEER_BUS_DRV=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 6f5722634b4d..3bffcd016be8 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -124,6 +124,7 @@ CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
+CONFIG_DIBS_PEER_BUS_DRV=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 8f41e5622100..98068bc541e5 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -21,3 +21,14 @@ config DIBS_LO
 	  occurs within the same OS. This helps in convenient testing of
 	  dibs clients, since dibs loopback is independent of architecture or
 	  hardware.
+
+config DIBS_PEER_BUS_DRV
+	bool "dibs peer bus driver support"
+	depends on DIBS
+	default n
+	help
+	  This dibs peer bus driver allows to enumerate and use virtual dibs
+	  peer devices emulated on a dibs remote system. This bus driver is the
+	  foundation for dibs peer device drivers that operate on top of dibs.
+	  It provides device discovery and lifecycle management for peer
+	  devices across the dibs fabric.
diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
index 85805490c77f..b1418f5149c2 100644
--- a/drivers/dibs/Makefile
+++ b/drivers/dibs/Makefile
@@ -5,4 +5,5 @@
 
 dibs-y += dibs_main.o
 obj-$(CONFIG_DIBS) += dibs.o
-dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
\ No newline at end of file
+dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
+dibs-$(CONFIG_DIBS_PEER_BUS_DRV) += dibs_peer_bus_drv.o
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index e3a33bc42fe8..8fa05971912f 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -746,8 +746,14 @@ static int __init dibs_init(void)
 	if (rc)
 		goto err_unregister;
 
+	rc = dibs_pbd_init();
+	if (rc)
+		goto err_loopback_exit;
+
 	return rc;
 
+err_loopback_exit:
+	dibs_loopback_exit();
 err_unregister:
 	class_unregister(&dibs_class);
 err:
@@ -757,6 +763,7 @@ static int __init dibs_init(void)
 
 static void __exit dibs_exit(void)
 {
+	dibs_pbd_exit();
 	dibs_loopback_exit();
 	class_unregister(&dibs_class);
 }
diff --git a/drivers/dibs/dibs_peer_bus_drv.c b/drivers/dibs/dibs_peer_bus_drv.c
new file mode 100644
index 000000000000..99eb0a6f8164
--- /dev/null
+++ b/drivers/dibs/dibs_peer_bus_drv.c
@@ -0,0 +1,1220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dibs peer bus driver
+ *
+ * Copyright IBM Corp.
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/dibs.h>
+#include <linux/gfp_types.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+#include <linux/device/bus.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/utsname.h>
+#include <asm/sysinfo.h>
+#include <asm/ebcdic.h>
+
+static u8 dibs_pbd_boot_event_sent;
+
+static char *dibs_peer_address;
+module_param(dibs_peer_address, charp, 0000);
+MODULE_PARM_DESC(dibs_peer_address,
+		 "specify the address of the remote system that emulates the peer bus");
+
+static unsigned int dibs_pbd_max_timeout = 60;
+module_param(dibs_pbd_max_timeout, uint, 0644);
+MODULE_PARM_DESC(dibs_pbd_max_timeout,
+		 "Maximum timeout for dibs peer bus remote in seconds");
+
+struct dibs_pbd_dmb_state {
+	struct dibs_peer_device *peer_dev;
+	struct dibs_peer_dev_driver *peer_dev_driver;
+	struct dibs_pbd_remote_endpoint *remote_endpoint;
+	/*
+	 * Protects peer_dev_driver and peer_dev pointers in dmb_state array.
+	 * Synchronizes IRQ handler with driver bind/unbind to prevent races
+	 * where driver callbacks are invoked on unbound or freed drivers.
+	 */
+	spinlock_t dmb_state_lock;
+};
+
+struct dibs_pbd_event_work {
+	struct work_struct work;
+	struct dibs_dev *dibs;
+	struct dibs_event event;
+};
+
+struct dibs_pbd_dibs_dev_state {
+	struct list_head list;
+	struct dibs_dev *dibs;
+	/* index is the dmbno of the parent dibs device */
+	struct dibs_pbd_dmb_state dmb_state[];
+};
+
+static LIST_HEAD(dibs_pbd_dibs_dev_state_list);
+/*
+ * List is modified by add_dev/del_dev (called with dibs_dev_list.mutex)
+ * and read by event handlers and sysfs operations.
+ */
+static DEFINE_MUTEX(dibs_pbd_dibs_dev_state_list_mutex);
+
+static LIST_HEAD(dibs_pbd_remote_endpoint_list);
+/*
+ * Endpoints may be added from sysfs and recovery work items and
+ * removed asynchronously from dev_disabled work items. Readers
+ * traversing the list must hold this mutex to prevent races with
+ * concurrent list_add()/list_del() operations.
+ */
+static DEFINE_MUTEX(dibs_pbd_remote_endpoint_list_mutex);
+
+struct access_token {
+	struct list_head list;
+	u128 access_tok;
+};
+
+static LIST_HEAD(dibs_pbd_access_token_list);
+
+static DEFINE_MUTEX(dibs_pbd_access_token_list_mutex);
+
+enum { DIBS_PBD_HDR_V1 = 1 };
+enum {
+	DIBS_PBD_REMOTE_ENDPOINT_ACCESS_TOKEN_MSG = 1,
+	DIBS_PBD_SYSTEM_INFO_MSG = 2,
+	DIBS_PBD_DEV_MSG = 3,
+	DIBS_PBD_PADDING_MSG = 0xff
+};
+
+struct dibs_pbd_remote_endpoint_dev_msg {
+	u64 dmb_tok;
+	u8 peer_dev_type;
+	u8 id;
+	u128 peer_dev_tok;
+} __packed;
+
+struct dibs_pbd_re_sysinfo_msg {
+	u64 dmb_tok;
+	u8 system_name[16];
+	u8 uuid[16];
+	u8 hostname[128];
+} __packed;
+
+struct dibs_pbd_remote_endpoint_access_tok_msg {
+	u128 access_tok;
+} __packed;
+
+struct dibs_pbd_remote_endpoint_msg {
+	struct dibs_msg_hdr hdr;
+	union {
+		struct dibs_pbd_remote_endpoint_access_tok_msg atmsg;
+		struct dibs_pbd_remote_endpoint_dev_msg devmsg;
+		struct dibs_pbd_re_sysinfo_msg simsg;
+	};
+};
+
+#define DIBS_PBD_RING_SIZE (1024 * 1024)
+#define DIBS_PBD_MSG_ALIGNMENT 4
+
+static u32 dibs_pbd_msg_size(struct dibs_msg_hdr *hdr)
+{
+	u32 size;
+
+	if (check_add_overflow(sizeof(*hdr), READ_ONCE(hdr->datalen), &size))
+		return 0;
+	return ALIGN(size, DIBS_PBD_MSG_ALIGNMENT);
+}
+
+/**
+ * dibs_pbd_msg_max_payload() - Calculate maximum payload size for a message
+ * @rb: Ring buffer to check available space
+ *
+ * Calculates the maximum payload size that can be sent in a single message
+ * without having to wrap around.
+ *
+ * Return: Maximum payload size in bytes, or 0 if no space available
+ */
+size_t dibs_pbd_msg_max_payload(struct dibs_ring_buffer *rb)
+{
+	size_t space = dibs_ring_space_to_end(rb);
+
+	if (space == 0)
+		return 0;
+
+	if (space == sizeof(struct dibs_msg_hdr)) {
+		space = dibs_ring_space(rb) - space;
+		if (space == 0)
+			return 0;
+	}
+
+	return ALIGN_DOWN(space - sizeof(struct dibs_msg_hdr),
+			  DIBS_PBD_MSG_ALIGNMENT);
+}
+EXPORT_SYMBOL_GPL(dibs_pbd_msg_max_payload);
+
+static int dibs_pbd_send_padding_msg(struct dibs_ring_buffer *rb)
+{
+	int ret;
+	struct dibs_msg_hdr padding_hdr;
+
+	padding_hdr.version = DIBS_PBD_HDR_V1;
+	padding_hdr.type = DIBS_PBD_PADDING_MSG;
+	padding_hdr.datalen =
+		dibs_ring_space_to_end(rb) - sizeof(struct dibs_msg_hdr);
+
+	ret = dibs_ring_send(rb, &padding_hdr, sizeof(padding_hdr), false);
+	if (ret)
+		return ret;
+
+	return dibs_ring_send_padding(rb, padding_hdr.datalen);
+}
+
+/**
+ * dibs_pbd_msg_send() - Send a message through the ring buffer
+ * @rb: Ring buffer to send message through
+ * @hdr: Message header with payload to send
+ *
+ * Sends a message through the ring buffer, handling alignment and wrapping.
+ * If the message doesn't fit at the end of the ring buffer, a padding message
+ * is sent first to wrap to the beginning.
+ *
+ * Return: 0 on success, -EINVAL if message size overflows, -ENOSPC if
+ *         insufficient space in ring buffer, or error from ring buffer operations
+ */
+int dibs_pbd_msg_send(struct dibs_ring_buffer *rb, struct dibs_msg_hdr *hdr)
+{
+	u32 msg_size = dibs_pbd_msg_size(hdr);
+	int ret;
+
+	if (!msg_size)
+		return -EINVAL;
+
+	if (msg_size > dibs_ring_space(rb))
+		return -ENOSPC;
+
+	if (msg_size > dibs_ring_space_to_end(rb)) {
+		ret = dibs_pbd_send_padding_msg(rb);
+		if (ret)
+			return ret;
+
+		if (msg_size > dibs_ring_space(rb))
+			return -ENOSPC;
+	}
+
+	return dibs_ring_send(rb, hdr, msg_size, true);
+}
+EXPORT_SYMBOL_GPL(dibs_pbd_msg_send);
+
+/**
+ * dibs_pbd_msg_recv() - Receive a message from the ring buffer
+ * @rb: Ring buffer to receive message from
+ *
+ * Receives the next message from the ring buffer, automatically skipping
+ * any padding messages used for alignment.
+ *
+ * Return: Pointer to received message header, or NULL if no message available
+ *         or error occurred
+ */
+struct dibs_msg_hdr *dibs_pbd_msg_recv(struct dibs_ring_buffer *rb)
+{
+	struct dibs_msg_hdr *msg;
+	u32 msg_size;
+
+	while ((msg = dibs_ring_recv(rb))) {
+		msg_size = dibs_pbd_msg_size(msg);
+		if (!msg_size || msg_size > dibs_ring_cnt_to_end(rb)) {
+			pr_warn("%s(%s): discarding message with invalid size\n",
+				__func__, rb->name);
+			rb->msg_size = 0;
+			return NULL;
+		}
+
+		rb->msg_size = msg_size;
+
+		if (READ_ONCE(msg->type) != DIBS_PBD_PADDING_MSG)
+			break;
+		if (dibs_pbd_msg_ack(rb))
+			return NULL;
+	}
+
+	return msg;
+}
+EXPORT_SYMBOL_GPL(dibs_pbd_msg_recv);
+
+/**
+ * dibs_pbd_msg_ack() - Acknowledge a received message
+ * @rb: Ring buffer the message was received from
+ *
+ * Acknowledges the message dibs_pbd_msg_recv() handed out, freeing its space
+ * in the ring buffer for reuse. Must be called after processing each received
+ * message. Uses the size validated by dibs_pbd_msg_recv(), so that the peer
+ * cannot move the tail by rewriting its datalen afterwards.
+ *
+ * Return: 0 on success, -EINVAL if there is no message to acknowledge, or
+ *         error from ring buffer operations
+ */
+int dibs_pbd_msg_ack(struct dibs_ring_buffer *rb)
+{
+	u32 msg_size = rb->msg_size;
+
+	if (!msg_size)
+		return -EINVAL;
+
+	rb->msg_size = 0;
+
+	return dibs_ring_ack(rb, msg_size);
+}
+EXPORT_SYMBOL_GPL(dibs_pbd_msg_ack);
+
+struct dibs_pbd_remote_endpoint {
+	struct dibs_dev *dibs;
+	struct list_head list;
+	uuid_t rgid;
+	bool trusted;
+	struct dibs_ring_buffer rb;
+	struct work_struct handle_irq_work;
+	/*
+	 * Reference count protects this structure from being freed while
+	 * IRQ handler or work items are using it. IRQ handler takes reference
+	 * with kref_get_unless_zero() before scheduling work. Work handler
+	 * drops reference when done. Initial reference is dropped in
+	 * handle_event_work for DIBS_DEV_DISABLED events.
+	 */
+	struct kref kref;
+};
+
+static int dibs_pbd_match(struct device *dev, const struct device_driver *drv)
+{
+	struct dibs_peer_dev_driver *dpdd;
+	struct dibs_peer_device *dpd;
+
+	dpdd = to_dibs_peer_dev_driver(drv);
+	dpd = to_dibs_peer_device(dev);
+	if (dpdd->type && dpdd->type == dpd->type)
+		return 1;
+	return 0;
+};
+
+static int dibs_pbd_probe(struct device *dev)
+{
+	struct dibs_peer_dev_driver *dpdd;
+	struct dibs_peer_device *dpd;
+
+	if (dev->driver) {
+		dpd = to_dibs_peer_device(dev);
+		dpdd = to_dibs_peer_dev_driver(dev->driver);
+		return dpdd->probe(dpd);
+	}
+
+	return 0;
+}
+
+static void dibs_pbd_remove(struct device *dev)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+	struct dibs_peer_dev_driver *dpdd;
+
+	if (dev->driver) {
+		dpdd = to_dibs_peer_dev_driver(dev->driver);
+		dpdd->remove(dpd);
+	}
+}
+
+static int dibs_pbd_uevent(const struct device *dev,
+			   struct kobj_uevent_env *env)
+{
+	struct dibs_peer_device *dpd;
+
+	dpd = to_dibs_peer_device(dev);
+	add_uevent_var(env, "MODALIAS=dibs:peer_dev:%d", dpd->type);
+
+	return 0;
+}
+
+static int dibs_pbd_notifier(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(data);
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		dpd->status = PEER_DEV_CONNECTED;
+		break;
+	case BUS_NOTIFY_UNBIND_DRIVER:
+		dpd->status = PEER_DEV_DISCONNECTED;
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dibs_pbd_nb = { .notifier_call =
+						     dibs_pbd_notifier };
+
+static int dibs_pbd_s390_get_system_info(struct dibs_system_info *sysinfo)
+{
+	struct sysinfo_2_2_2 *info222;
+	struct sysinfo_3_2_2 *info322;
+	void *info;
+	int level;
+
+	info = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memset(sysinfo->system_name, 0, sizeof(sysinfo->system_name));
+
+	level = stsi(NULL, 0, 0, 0);
+	if (level >= 2) {
+		info222 = (struct sysinfo_2_2_2 *)info;
+		if (stsi(info222, 2, 2, 2) == 0) {
+			EBCASC(info222->name, sizeof(info222->name));
+			memcpy(&sysinfo->system_name, info222->name,
+			       sizeof(sysinfo->system_name));
+			memcpy(&sysinfo->uuid, info222->uuid.b, UUID_SIZE);
+		}
+	}
+	if (level >= 3) {
+		info322 = (struct sysinfo_3_2_2 *)info;
+		if (stsi(info322, 3, 2, 2) == 0) {
+			EBCASC(info322->vm[0].name,
+			       sizeof(info322->vm[0].name));
+			memcpy(&sysinfo->system_name, info322->vm[0].name,
+			       sizeof(sysinfo->system_name));
+			memcpy(&sysinfo->uuid, info322->vm[0].uuid.b,
+			       UUID_SIZE);
+		}
+	}
+
+	free_page((unsigned long)info);
+	return 0;
+}
+
+static int dibs_pbd_get_system_info(struct dibs_system_info *sysinfo)
+{
+	int ret = 0;
+
+	strscpy(sysinfo->hostname, utsname()->nodename);
+
+#ifdef CONFIG_S390
+	ret = dibs_pbd_s390_get_system_info(sysinfo);
+#endif
+	return ret;
+}
+
+static void dibs_pbd_re_access_tok_msg(struct dibs_msg_hdr *msg_hdr,
+				       struct dibs_pbd_remote_endpoint *re)
+{
+	struct dibs_pbd_remote_endpoint_access_tok_msg atmsg;
+	struct dibs_pbd_remote_endpoint_msg msg_to_send;
+	struct dibs_pbd_remote_endpoint_msg *msg;
+	struct dibs_system_info sysinfo;
+	struct access_token *at;
+	int ret;
+
+	msg = (struct dibs_pbd_remote_endpoint_msg *)msg_hdr;
+	atmsg = msg->atmsg;
+
+	if (re->trusted) {
+		at = kzalloc_obj(*at);
+		if (!at) {
+			pr_err("%s: failed to allocate access token\n",
+			       __func__);
+			return;
+		}
+		at->access_tok = atmsg.access_tok;
+		mutex_lock(&dibs_pbd_access_token_list_mutex);
+		list_add_tail(&at->list, &dibs_pbd_access_token_list);
+		mutex_unlock(&dibs_pbd_access_token_list_mutex);
+	} else {
+		mutex_lock(&dibs_pbd_access_token_list_mutex);
+		list_for_each_entry(at, &dibs_pbd_access_token_list, list) {
+			if (at->access_tok == atmsg.access_tok)
+				re->trusted = true;
+		}
+		mutex_unlock(&dibs_pbd_access_token_list_mutex);
+	}
+
+	if (re->trusted) {
+		ret = dibs_pbd_get_system_info(&sysinfo);
+		if (!ret) {
+			msg_to_send.hdr.version = DIBS_PBD_HDR_V1;
+			msg_to_send.hdr.type = DIBS_PBD_SYSTEM_INFO_MSG;
+			msg_to_send.hdr.datalen =
+				sizeof(struct dibs_pbd_re_sysinfo_msg);
+			strscpy(msg_to_send.simsg.system_name,
+				sysinfo.system_name);
+			memcpy(msg_to_send.simsg.uuid, sysinfo.uuid,
+			       sizeof(sysinfo.uuid));
+			strscpy(msg_to_send.simsg.hostname, sysinfo.hostname);
+
+			dibs_pbd_msg_send(&re->rb,
+					  (struct dibs_msg_hdr *)&msg_to_send);
+		}
+	}
+}
+
+static int dibs_pbd_peer_dev_match_id(struct device *dev, const void *data)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+	const u8 *id = data;
+
+	if (dpd && dpd->id == *id)
+		return 1;
+	return 0;
+}
+
+static void dibs_pbd_peer_dev_release(struct device *dev)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+
+	kfree(dpd);
+}
+
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+
+	return sysfs_emit(buf, "%u\n", dpd->type);
+}
+static DEVICE_ATTR_RO(type);
+
+static ssize_t id_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+
+	return sysfs_emit(buf, "%u\n", dpd->id);
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t dmb_tok_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+
+	if (!dpd->rb.dmb.dmb_tok)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%pUb,%llx\n", &dpd->parent->gid,
+			  dpd->rb.dmb.dmb_tok);
+}
+static DEVICE_ATTR_RO(dmb_tok);
+
+static ssize_t peer_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+
+	if (uuid_is_null(&dpd->rgid))
+		return -ENODEV;
+	return sysfs_emit(buf, "%pUb\n", &dpd->rgid);
+}
+static DEVICE_ATTR_RO(peer);
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct dibs_peer_device *dpd;
+
+	dpd = to_dibs_peer_device(dev);
+	return sysfs_emit(buf, "%u\n", dpd->status);
+}
+static DEVICE_ATTR_RO(state);
+
+static struct attribute *dibs_peer_dev_attrs[] = {
+	&dev_attr_dmb_tok.attr, &dev_attr_peer.attr, &dev_attr_state.attr,
+	&dev_attr_type.attr,	&dev_attr_id.attr,   NULL,
+};
+ATTRIBUTE_GROUPS(dibs_peer_dev);
+
+static void dibs_pbd_dibs_event_dev_disabled_work(struct work_struct *work)
+{
+	struct dibs_peer_dev_driver *dpdd;
+	struct dibs_peer_device *dpd;
+
+	dpd = container_of(work, struct dibs_peer_device,
+			   event_dev_disabled_work);
+
+	device_lock(&dpd->dev);
+	if (dpd->dev.driver) {
+		dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
+		dpdd->disconnect(dpd);
+	}
+	device_unlock(&dpd->dev);
+
+	schedule_delayed_work(&dpd->timeout_work, dpd->timeout);
+}
+
+static void dibs_pbd_peer_dev_destroy(struct dibs_peer_device *dpd)
+{
+	if (atomic_xchg(&dpd->destroying, 1))
+		return;
+
+	cancel_work_sync(&dpd->event_dev_disabled_work);
+
+	/* Don't cancel if we're running in the timeout_work context */
+	if (current_work() != &dpd->timeout_work.work)
+		cancel_delayed_work_sync(&dpd->timeout_work);
+
+	device_unregister(&dpd->dev);
+}
+
+static void dibs_pbd_dibs_dev_timeout_work(struct work_struct *work)
+{
+	struct dibs_peer_device *dpd;
+
+	dpd = container_of(to_delayed_work(work), struct dibs_peer_device,
+			   timeout_work);
+
+	dibs_pbd_peer_dev_destroy(dpd);
+}
+
+const struct bus_type dibs_pbd_type;
+
+static int dibs_pbd_peer_dev_create(struct dibs_dev *dibs, uuid_t *rgid,
+				    u64 rdmb_tok, u8 server_dev_id, u8 type,
+				    u128 tok)
+{
+	struct dibs_peer_device *dpd;
+	int ret;
+
+	dpd = kzalloc_obj(*dpd, GFP_KERNEL);
+	if (!dpd)
+		return -ENOMEM;
+	atomic_set(&dpd->destroying, 0);
+	dpd->id = server_dev_id;
+	dpd->rgid = *rgid;
+	dpd->type = type;
+	dpd->dev.bus = &dibs_pbd_type;
+	dpd->dev.release = dibs_pbd_peer_dev_release;
+	dpd->parent = dibs;
+	dpd->status = PEER_DEV_DISCONNECTED;
+	dpd->rdmb_tok = rdmb_tok;
+	dpd->dev.groups = dibs_peer_dev_groups;
+	dpd->tok = tok;
+	dev_set_name(&dpd->dev, "%pUb:%u", rgid, dpd->id);
+
+	INIT_WORK(&dpd->event_dev_disabled_work,
+		  dibs_pbd_dibs_event_dev_disabled_work);
+	INIT_DELAYED_WORK(&dpd->timeout_work, dibs_pbd_dibs_dev_timeout_work);
+
+	dpd->timeout = secs_to_jiffies(dibs_pbd_max_timeout);
+
+	ret = device_register(&dpd->dev);
+	if (ret) {
+		put_device(&dpd->dev);
+		return ret;
+	}
+	ret = sysfs_create_link(&dpd->dev.kobj, &dpd->parent->dev.kobj, "dibs");
+	if (ret) {
+		device_unregister(&dpd->dev);
+		return ret;
+	}
+	return 0;
+}
+
+static void dibs_pbd_re_dev_msg(struct dibs_msg_hdr *msg_hdr,
+				struct dibs_pbd_remote_endpoint *re)
+{
+	struct dibs_pbd_remote_endpoint_dev_msg redm;
+	struct dibs_pbd_remote_endpoint_msg *msg;
+	struct dibs_peer_dev_driver *dpdd;
+	struct dibs_peer_device *dpd;
+	struct device *dev;
+	int ret;
+
+	msg = (struct dibs_pbd_remote_endpoint_msg *)msg_hdr;
+	redm = msg->devmsg;
+
+	dev = bus_find_device(&dibs_pbd_type, NULL, &redm.id,
+			      dibs_pbd_peer_dev_match_id);
+	if (dev) {
+		dpd = to_dibs_peer_device(dev);
+		if (dpd->tok != redm.peer_dev_tok) {
+			put_device(dev);
+			return;
+		}
+		if (dpd->rdmb_tok != redm.dmb_tok)
+			dpd->rdmb_tok = redm.dmb_tok;
+
+		device_lock(&dpd->dev);
+		if (dpd->dev.driver) {
+			dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
+			ret = dpdd->reconnect(dpd);
+			if (!ret)
+				dpd->status = PEER_DEV_CONNECTED;
+		}
+		device_unlock(&dpd->dev);
+		put_device(dev);
+	} else {
+		dibs_pbd_peer_dev_create(re->dibs, &re->rgid, redm.dmb_tok,
+					 redm.id, redm.peer_dev_type,
+					 redm.peer_dev_tok);
+	}
+}
+
+static void dibs_pbd_remote_endpoint_release(struct kref *kref)
+{
+	struct dibs_pbd_remote_endpoint *re;
+
+	re = container_of(kref, struct dibs_pbd_remote_endpoint, kref);
+
+	dibs_ring_unregister(&re->rb);
+	kfree(re);
+}
+
+static struct dibs_client dibs_pbd_drv;
+static void dibs_pbd_handle_irq_work(struct work_struct *work)
+{
+	struct dibs_pbd_remote_endpoint *re;
+	struct dibs_ring_buffer *rb;
+	struct dibs_msg_hdr *msg;
+
+	re = container_of(work, struct dibs_pbd_remote_endpoint,
+			  handle_irq_work);
+	rb = &re->rb;
+
+	while ((msg = dibs_pbd_msg_recv(rb))) {
+		switch (msg->type) {
+		case DIBS_PBD_REMOTE_ENDPOINT_ACCESS_TOKEN_MSG:
+			dibs_pbd_re_access_tok_msg(msg, re);
+			break;
+		case DIBS_PBD_DEV_MSG:
+			if (re->trusted)
+				dibs_pbd_re_dev_msg(msg, re);
+			break;
+		default:
+			pr_warn("%s: Received unknown message type: %d\n",
+				__func__, msg->type);
+			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
+			return;
+		}
+		dibs_pbd_msg_ack(rb);
+	}
+
+	kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
+}
+
+static void dibs_pbd_drv_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
+				    u16 dmbemask)
+{
+	struct dibs_pbd_dibs_dev_state *dds;
+	struct dibs_pbd_remote_endpoint *re;
+	struct dibs_peer_dev_driver *dpdd;
+	struct dibs_peer_device *dpd;
+	unsigned long flags;
+
+	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
+
+	spin_lock_irqsave(&dds->dmb_state[dmbno].dmb_state_lock, flags);
+	dpdd = dds->dmb_state[dmbno].peer_dev_driver;
+	dpd = dds->dmb_state[dmbno].peer_dev;
+	if (dpdd && dpd)
+		dpdd->handle_irq(dmbno, dpd, 0);
+	re = dds->dmb_state[dmbno].remote_endpoint;
+	if (re && !kref_get_unless_zero(&re->kref))
+		re = NULL;
+	spin_unlock_irqrestore(&dds->dmb_state[dmbno].dmb_state_lock, flags);
+
+	if (!re)
+		return;
+
+	if (!queue_work(system_dfl_wq, &re->handle_irq_work)) {
+		/* Work already pending, drop the reference */
+		kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
+	}
+	/* If queue_work returned true, work owns the reference */
+}
+
+static int dibs_pbd_peer_dev_event(struct device *dev, void *data)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+	struct dibs_event *event = data;
+
+	switch (event->subtype) {
+	case DIBS_SW_EVENT_REDISCOVER:
+		dpd->rgid = event->gid;
+		cancel_delayed_work(&dpd->timeout_work);
+		break;
+	case DIBS_DEV_DISABLED:
+		if (uuid_equal(&dpd->rgid, &event->gid))
+			schedule_work(&dpd->event_dev_disabled_work);
+		break;
+	}
+
+	return 0;
+}
+
+static int dibs_pbd_remote_endpoint_create(struct dibs_dev *dibs,
+					   const uuid_t *rgid,
+					   const bool trusted)
+{
+	struct dibs_pbd_remote_endpoint *re, *tmp;
+	struct dibs_pbd_dibs_dev_state *dds;
+	bool existing_re_found = false;
+	unsigned long flags;
+	int ret;
+
+	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
+	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list,
+				 list) {
+		if (uuid_equal(&re->rgid, rgid))
+			existing_re_found = true;
+	}
+	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+
+	if (existing_re_found) {
+		pr_warn("%s: remote endpoint already exists for rgid: %pUb\n",
+			__func__, rgid);
+		return 0;
+	}
+
+	re = kzalloc_obj(*re, GFP_KERNEL);
+	if (!re)
+		return -ENOMEM;
+
+	re->dibs = dibs;
+	uuid_copy(&re->rgid, rgid);
+	re->trusted = trusted;
+
+	ret = dibs_ring_register("peer_bus", &re->rb, &dibs_pbd_drv, dibs,
+				 re->rgid, DIBS_PBD_RING_SIZE);
+
+	if (ret) {
+		pr_err("%s: failed to register ring buffer\n", __func__);
+		kfree(re);
+		return ret;
+	}
+
+	INIT_WORK(&re->handle_irq_work, dibs_pbd_handle_irq_work);
+	kref_init(&re->kref);
+
+	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
+	spin_lock_irqsave(&dds->dmb_state[re->rb.dmb.idx].dmb_state_lock,
+			  flags);
+	dds->dmb_state[re->rb.dmb.idx].remote_endpoint = re;
+	dds->dmb_state[re->rb.rd_meta_dmb.idx].remote_endpoint = re;
+	spin_unlock_irqrestore(&dds->dmb_state[re->rb.dmb.idx].dmb_state_lock,
+			       flags);
+
+	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
+	list_add(&re->list, &dibs_pbd_remote_endpoint_list);
+	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+
+	re->dibs->ops->signal_event(re->dibs, &re->rgid, 1,
+				    DIBS_SW_EVENT_DISCOVER,
+				    re->rb.wr_ring_meta.meta_dmb_tok);
+	dibs_pbd_boot_event_sent = 1;
+
+	return 0;
+}
+
+static void dibs_pbd_drv_handle_event_work(struct work_struct *work)
+{
+	struct dibs_pbd_remote_endpoint *re, *tmp;
+	struct dibs_pbd_event_work *ew;
+
+	ew = container_of(work, struct dibs_pbd_event_work, work);
+
+	bus_for_each_dev(&dibs_pbd_type, NULL, &ew->event,
+			 dibs_pbd_peer_dev_event);
+
+	switch (ew->event.subtype) {
+	case DIBS_SW_EVENT_REDISCOVER:
+		if (!ew->dibs->ops->query_remote_gid(ew->dibs, &ew->event.gid,
+						     0, 0))
+			dibs_pbd_remote_endpoint_create(ew->dibs,
+							&ew->event.gid, false);
+		break;
+	case DIBS_DEV_DISABLED:
+		mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
+		list_for_each_entry_safe(re, tmp,
+					 &dibs_pbd_remote_endpoint_list, list) {
+			if (uuid_equal(&re->rgid, &ew->event.gid)) {
+				list_del(&re->list);
+				/* Drop initial reference - free when all other refs are gone */
+				kref_put(&re->kref,
+					 dibs_pbd_remote_endpoint_release);
+			}
+		}
+		mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+		break;
+	}
+
+	kfree(ew);
+}
+
+static void dibs_pbd_drv_handle_event(struct dibs_dev *dev,
+				      const struct dibs_event *event)
+{
+	struct dibs_pbd_event_work *ew;
+
+	ew = kzalloc_obj(*ew, GFP_ATOMIC);
+	if (!ew)
+		return;
+	ew->dibs = dev;
+	ew->event = *event;
+
+	INIT_WORK(&ew->work, dibs_pbd_drv_handle_event_work);
+	schedule_work(&ew->work);
+}
+
+static ssize_t dibs_pbd_discover_store_handle_gid_prefix(const char *buf,
+							 size_t count)
+{
+	struct dibs_pbd_dibs_dev_state *dds;
+	struct dibs_pbd_remote_endpoint *re;
+	bool remote_system_reachable = false;
+	const char *gid_str;
+	uuid_t rgid;
+	int ret;
+
+	gid_str = buf + strlen("gid:");
+	ret = uuid_parse(gid_str, &rgid);
+	if (ret) {
+		pr_err("%s: could not parse rgid\n", __func__);
+		return -EINVAL;
+	}
+	if (uuid_is_null(&rgid)) {
+		pr_err("%s: gid is null\n", __func__);
+		return -EINVAL;
+	}
+	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
+	list_for_each_entry(re, &dibs_pbd_remote_endpoint_list, list) {
+		if (!uuid_equal(&rgid, &re->rgid))
+			continue;
+		re->dibs->ops->signal_event(re->dibs, &re->rgid, 1,
+					    DIBS_SW_EVENT_DISCOVER,
+					    re->rb.wr_ring_meta.meta_dmb_tok);
+		mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+		return count;
+	}
+	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+
+	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
+	list_for_each_entry(dds, &dibs_pbd_dibs_dev_state_list, list) {
+		if (dds->dibs->ops->query_remote_gid(dds->dibs, &rgid, 0, 0))
+			continue;
+		remote_system_reachable = true;
+		ret = dibs_pbd_remote_endpoint_create(dds->dibs, &rgid, true);
+		if (ret) {
+			mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
+			return ret;
+		}
+		break;
+	}
+	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
+	if (!remote_system_reachable) {
+		pr_err("%s: remote system not reachable\n", __func__);
+		return -ENODEV;
+	}
+
+	return count;
+}
+
+static ssize_t discover_store(const struct bus_type *bus, const char *buf,
+			      size_t count)
+{
+	if (str_has_prefix(buf, "gid:"))
+		return dibs_pbd_discover_store_handle_gid_prefix(buf, count);
+
+	pr_err("dibs_pbd: unknown discover identifier type\n");
+	return -EINVAL;
+}
+static BUS_ATTR_WO(discover);
+
+static struct attribute *dibs_pbd_attrs[] = {
+	&bus_attr_discover.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(dibs_pbd);
+
+const struct bus_type dibs_pbd_type = {
+	.name = "dibs_peer",
+	.match = dibs_pbd_match,
+	.bus_groups = dibs_pbd_groups,
+	.uevent = dibs_pbd_uevent,
+	.probe = dibs_pbd_probe,
+	.remove = dibs_pbd_remove,
+};
+
+static void dibs_pbd_drv_add_dibs(struct dibs_dev *dibs)
+{
+	struct dibs_pbd_dibs_dev_state *dds;
+	const char *gid_str;
+	int max_dmbs;
+	uuid_t gid;
+	int ret;
+
+	max_dmbs = dibs->ops->max_dmbs();
+	dds = kzalloc(sizeof(*dds) +
+			      max_dmbs * sizeof(struct dibs_pbd_dmb_state),
+		      GFP_KERNEL);
+	if (!dds) {
+		dev_err(&dibs->dev,
+			"Failed to allocate memory for dibs dev state\n");
+		return;
+	}
+
+	dds->dibs = dibs;
+	for (int i = 0; i < max_dmbs; i++)
+		spin_lock_init(&dds->dmb_state[i].dmb_state_lock);
+	dibs_set_priv(dibs, &dibs_pbd_drv, dds);
+	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
+	list_add(&dds->list, &dibs_pbd_dibs_dev_state_list);
+	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
+
+	/* Send boot event to remote system when module parameter rgid is set.
+	 * Send boot event with the first dibs device that is able to
+	 * communicate with the remote system.
+	 */
+
+	if (dibs_peer_address && str_has_prefix(dibs_peer_address, "gid:") &&
+	    !dibs_pbd_boot_event_sent) {
+		gid_str = dibs_peer_address + strlen("gid:");
+		if (strlen(gid_str) != UUID_STRING_LEN) {
+			pr_err("%s: gid is not valid\n", __func__);
+			return;
+		}
+		ret = uuid_parse(gid_str, &gid);
+		if (ret) {
+			pr_err("%s: Could not parse gid\n", __func__);
+			return;
+		}
+		if (uuid_is_null(&gid)) {
+			pr_err("%s: gid is null\n", __func__);
+			return;
+		}
+		if (!dibs->ops->query_remote_gid(dibs, &gid, 0, 0)) {
+			/* Create a peer device for the dibs base client
+			 * This peer device registers the discovery DMB
+			 */
+			dibs_pbd_remote_endpoint_create(dibs, &gid, true);
+		}
+	}
+}
+
+static int dibs_pbd_destroy_matching_peer_dev(struct device *dev, void *data)
+{
+	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
+	struct dibs_dev *removed = data;
+
+	if (dpd->parent != removed)
+		return 0;
+
+	dibs_pbd_peer_dev_destroy(dpd);
+
+	return 0;
+}
+
+/**
+ * dibs_pbd_driver_register() - Register a peer device driver
+ * @dpdd: Peer device driver to register
+ *
+ * Registers a driver for dibs peer devices on the peer bus.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dibs_pbd_driver_register(struct dibs_peer_dev_driver *dpdd)
+{
+	dpdd->drv.bus = &dibs_pbd_type;
+
+	return driver_register(&dpdd->drv);
+}
+EXPORT_SYMBOL(dibs_pbd_driver_register);
+
+/**
+ * dibs_pbd_driver_unregister() - Unregister a peer device driver
+ * @dpdd: Peer device driver to unregister
+ *
+ * Unregisters a previously registered peer device driver.
+ *
+ * Return: Always returns 0
+ */
+int dibs_pbd_driver_unregister(struct dibs_peer_dev_driver *dpdd)
+{
+	driver_unregister(&dpdd->drv);
+	return 0;
+}
+EXPORT_SYMBOL(dibs_pbd_driver_unregister);
+
+static void peer_bus_drv_remove_dibs(struct dibs_dev *dibs)
+{
+	struct dibs_pbd_remote_endpoint *re, *tmp;
+	struct dibs_pbd_dibs_dev_state *dds;
+
+	bus_for_each_dev(&dibs_pbd_type, NULL, dibs,
+			 dibs_pbd_destroy_matching_peer_dev);
+
+	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
+
+	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
+	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list, list) {
+		if (re->dibs == dibs) {
+			list_del(&re->list);
+			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
+		}
+	}
+	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
+
+	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
+	list_del_init(&dds->list);
+	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
+
+	kfree(dds);
+}
+
+static struct dibs_client_ops dibs_pbd_drv_ops = {
+	.add_dev = dibs_pbd_drv_add_dibs,
+	.del_dev = peer_bus_drv_remove_dibs,
+	.handle_event = dibs_pbd_drv_handle_event,
+	.handle_irq = dibs_pbd_drv_handle_irq,
+};
+
+static struct dibs_client dibs_pbd_drv = {
+	.name = "peer_bus",
+	.ops = &dibs_pbd_drv_ops,
+};
+
+/**
+ * dibs_pbd_register_ring_buffer() - Register a ring buffer for a peer device
+ * @name: Name for the ring buffer
+ * @dpd: Peer device to register ring buffer for
+ * @size: Size of the ring buffer
+ *
+ * Registers a ring buffer for communication with a peer device and associates
+ * it with the peer device's driver. The device must be locked before calling.
+ *
+ * Return: 0 on success, -ENODEV if no driver bound, or error from ring
+ *         buffer registration
+ */
+int dibs_pbd_register_ring_buffer(char *name, struct dibs_peer_device *dpd,
+				  u32 size)
+{
+	struct dibs_pbd_dibs_dev_state *dds;
+	struct dibs_peer_dev_driver *dpdd;
+	unsigned long flags;
+	int ret;
+
+	device_lock_assert(&dpd->dev);
+
+	ret = dibs_ring_register(name, &dpd->rb, &dibs_pbd_drv, dpd->parent,
+				 dpd->rgid, size);
+	if (ret)
+		return ret;
+
+	if (!dpd->dev.driver) {
+		dibs_ring_unregister(&dpd->rb);
+		return -ENODEV;
+	}
+	dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
+	dds = dibs_get_priv(dpd->parent, &dibs_pbd_drv);
+
+	spin_lock_irqsave(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
+			  flags);
+	dds->dmb_state[dpd->rb.dmb.idx].peer_dev_driver = dpdd;
+	dds->dmb_state[dpd->rb.dmb.idx].peer_dev = dpd;
+	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev_driver = dpdd;
+	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev = dpd;
+	spin_unlock_irqrestore(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
+			       flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(dibs_pbd_register_ring_buffer);
+
+/**
+ * dibs_pbd_unregister_ring_buffer() - Unregister a peer device's ring buffer
+ * @dpd: Peer device whose ring buffer to unregister
+ *
+ * Unregisters the ring buffer associated with a peer device and clears
+ * the driver associations.
+ *
+ * Return: 0 on success, or error from ring buffer unregistration
+ */
+int dibs_pbd_unregister_ring_buffer(struct dibs_peer_device *dpd)
+{
+	struct dibs_pbd_dibs_dev_state *dds;
+	unsigned long flags;
+	int ret;
+
+	device_lock_assert(&dpd->dev);
+
+	dds = dibs_get_priv(dpd->parent, &dibs_pbd_drv);
+
+	spin_lock_irqsave(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
+			  flags);
+	dds->dmb_state[dpd->rb.dmb.idx].peer_dev_driver = NULL;
+	dds->dmb_state[dpd->rb.dmb.idx].peer_dev = NULL;
+	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev_driver = NULL;
+	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev = NULL;
+	spin_unlock_irqrestore(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
+			       flags);
+
+	ret = dibs_ring_unregister(&dpd->rb);
+	dpd->rb.dmb.idx = 0;
+	dpd->rb.rd_meta_dmb.idx = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL(dibs_pbd_unregister_ring_buffer);
+
+/**
+ * dibs_pbd_init() - Initialize the dibs peer bus driver
+ *
+ * Initializes the peer bus subsystem by registering the bus type,
+ * notifier, and dibs client. Must be called before any peer devices
+ * can be used.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dibs_pbd_init(void)
+{
+	int ret;
+
+	ret = bus_register(&dibs_pbd_type);
+	if (ret)
+		return ret;
+	ret = bus_register_notifier(&dibs_pbd_type, &dibs_pbd_nb);
+	if (ret)
+		goto bus_reg_not_err;
+	ret = dibs_register_client(&dibs_pbd_drv);
+	if (ret)
+		goto dibs_reg_client_err;
+	return 0;
+
+dibs_reg_client_err:
+	bus_unregister_notifier(&dibs_pbd_type, &dibs_pbd_nb);
+bus_reg_not_err:
+	bus_unregister(&dibs_pbd_type);
+	return ret;
+}
+EXPORT_SYMBOL(dibs_pbd_init);
+
+/**
+ * dibs_pbd_exit() - Clean up the dibs peer bus driver
+ *
+ * Cleans up the peer bus subsystem by unregistering the dibs client,
+ * notifier, and bus type. Should be called during module unload.
+ */
+void dibs_pbd_exit(void)
+{
+	dibs_unregister_client(&dibs_pbd_drv);
+
+	bus_unregister_notifier(&dibs_pbd_type, &dibs_pbd_nb);
+	bus_unregister(&dibs_pbd_type);
+}
+EXPORT_SYMBOL(dibs_pbd_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 30ae03484b58..8c24f7b33e6f 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -164,7 +164,9 @@ enum dibs_event_subtype {
 	DIBS_BUF_UNREGISTERED,
 	DIBS_DEV_DISABLED,
 	DIBS_DEV_ERR_STATE,
-	DIBS_OTHER_SUBTYPE
+	DIBS_OTHER_SUBTYPE,
+	DIBS_SW_EVENT_DISCOVER = 0x9,
+	DIBS_SW_EVENT_REDISCOVER = 0x10,
 };
 
 struct dibs_event {
@@ -269,6 +271,12 @@ int dibs_unregister_client(struct dibs_client *client);
 
 /* dibs clients can call dibs device ops. */
 
+struct dibs_system_info {
+	u8 system_name[16];
+	u8 uuid[16];
+	u8 hostname[128];
+};
+
 /* DIBS devices
  * ------------
  */
@@ -554,10 +562,72 @@ int dibs_dev_add(struct dibs_dev *dibs);
  */
 void dibs_dev_del(struct dibs_dev *dibs);
 
+/*
+ * Dibs Peer Bus
+ */
+#define to_dibs_peer_dev_driver(x) \
+	container_of((x), struct dibs_peer_dev_driver, drv)
+#define to_dibs_peer_device(x) container_of((x), struct dibs_peer_device, dev)
+
+#define PEER_DEV_DISCONNECTED 0
+#define PEER_DEV_CONNECTED 1
+
+struct dibs_peer_device {
+	u8 id;
+	uuid_t rgid;
+	struct dibs_ring_buffer rb;
+	u64 rdmb_tok;
+	u8 status;
+	u8 type;
+	u128 tok;
+	struct delayed_work timeout_work;
+	unsigned long timeout;
+	struct work_struct event_dev_disabled_work;
+	atomic_t destroying;
+	struct dibs_dev *parent;
+	struct device dev;
+	/* priv pointer for driver */
+	void *drv_priv;
+};
+
+struct dibs_peer_dev_driver {
+	u8 type;
+	int (*probe)(struct dibs_peer_device *peer_dev);
+	void (*remove)(struct dibs_peer_device *peer_dev);
+	int (*reconnect)(struct dibs_peer_device *peer_dev);
+	void (*disconnect)(struct dibs_peer_device *peer_dev);
+	void (*handle_irq)(unsigned int dmbno,
+			   struct dibs_peer_device *peer_dev, u16 dmbemask);
+	struct device_driver drv;
+};
+
+#ifdef CONFIG_DIBS_PEER_BUS_DRV
+int dibs_pbd_init(void);
+void dibs_pbd_exit(void);
+#else
+static inline int dibs_pbd_init(void)
+{
+	return 0;
+}
+
+static inline void dibs_pbd_exit(void) {}
+
+#endif
+
 struct dibs_msg_hdr {
 	u8 version;
 	u8 type;
 	u16 datalen;
 } __packed;
 
+int dibs_pbd_register_ring_buffer(char *name, struct dibs_peer_device *dpd,
+				  u32 size);
+int dibs_pbd_unregister_ring_buffer(struct dibs_peer_device *dpd);
+int dibs_pbd_driver_register(struct dibs_peer_dev_driver *driver);
+int dibs_pbd_driver_unregister(struct dibs_peer_dev_driver *ipdd);
+size_t dibs_pbd_msg_max_payload(struct dibs_ring_buffer *rb);
+int dibs_pbd_msg_send(struct dibs_ring_buffer *rb, struct dibs_msg_hdr *hdr);
+struct dibs_msg_hdr *dibs_pbd_msg_recv(struct dibs_ring_buffer *rb);
+int dibs_pbd_msg_ack(struct dibs_ring_buffer *rb);
+
 #endif	/* _DIBS_H */

-- 
2.53.0

