Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB51D90B9;
	Wed, 15 Jan 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970946; cv=none; b=FZJdX0IG4wsNx3fIVtq2KFmBuixGIJfRU3C5Tb4Hz+xK4NsNWDsxxtm+LCrdjPT3kGQvg7u00t2eymcZpR44zW+BQiuhcLM19Oo7r85iJGKnuYCA5GdvQedjrtB/2uEjSG9yQ886zD6kKNZd0dr1M1FIBTcMt1k3FRNEXDT6leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970946; c=relaxed/simple;
	bh=M4jc7KywldEBMSriBSffmUb2Aakwp58Qk8yORJ0Ur5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t12uk5odiREuNVdxNo4S3NWn+6rZAON+y60NS5MGuzYFsNeaiEzFH5eDt7fRcMUGICaSV9UAk1XyQAb/A2Hru+jXFQTyceKslKf4H6GBZ2393UkhpOWeSsoOcdz3jHKrFg9SRyG2jJAycpQk2DKH2b8hamuZEdbD4vHayW7pgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ncWWYY7I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ncWWYY7I"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX5T8022844;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QAPQX+hFfDdUU7n4C
	initYfhGV0oNAyMPeW7d6O50js=; b=ncWWYY7IxGkRybImV3m+iTGxBp9XzZXDK
	GCSnOIp8UQs0oNlxYXqUkXvMWkNmizzmDcURqddZKUl/CDja7RLm0ecDp/L82JgU
	yPwM1X/xCkNrx1KJ/lQkG9rolpG+qe8lJbvReujssm4IhanD2VqE5NlakYzQrP9A
	PxPUcJZButWpiuONBry2dlkwyG29CxuP9NlyGA5UYLe3UA7SWhNpwkT4mlkenPus
	KCDYNKV7ay+vlJmsR4i6buV6dr2gjrDgom1qngYNhRg4934qxQZpxlmE0l/Qc3Xi
	N+N2yMms9iH0/lzY9QQ0eU7Bfa0eETKw4i6TaMXQf2K7BfZGBs5zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJtW5T006726;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FIxDwg016499;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1su9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtRtM30147208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74B52004E;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4F020049;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 45CC4E04DC; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [RFC net-next 1/7] net/ism: Create net/ism
Date: Wed, 15 Jan 2025 20:55:21 +0100
Message-ID: <20250115195527.2094320-2-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115195527.2094320-1-wintera@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LAXKG9qPW7047XT2VfpIf8Ye_P_1xwEt
X-Proofpoint-GUID: MLiaogtkvTyks_8K8F2iFA24uHGVnj1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=910 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

Create an 'ISM' shim layer that will provide generic functionality and
declarations for ism device drivers and ism clients.

Move the respective pieces from drivers/s390/net/ism_drv.* to net/ism/

When we need to distinguish between generic ism interfaces and
specifically the s390 virtual pci ism device, it will be called 'ISM_vPCI'.

No optimizations are done in this patch, it only moves pieces around.
Following patch will further detangle ism_vpci and smc-d.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS                |   7 ++
 drivers/s390/net/Kconfig   |   9 +--
 drivers/s390/net/Makefile  |   4 +-
 drivers/s390/net/ism_drv.c | 129 ++---------------------------
 include/linux/ism.h        |   8 ++
 include/net/smc.h          |   3 -
 net/Kconfig                |   1 +
 net/Makefile               |   1 +
 net/ism/Kconfig            |  14 ++++
 net/ism/Makefile           |   7 ++
 net/ism/ism_main.c         | 162 +++++++++++++++++++++++++++++++++++++
 11 files changed, 213 insertions(+), 132 deletions(-)
 create mode 100644 net/ism/Kconfig
 create mode 100644 net/ism/Makefile
 create mode 100644 net/ism/ism_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dcb849e6748..780db61f3f16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12239,6 +12239,13 @@ F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
 F:	Documentation/hwmon/isl28022.rst
 F:	drivers/hwmon/isl28022.c
 
+ISM (INTERNAL SHARED MEMORY)
+M:	Alexandra Winter <wintera@linux.ibm.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/linux/ism.h
+F:	net/ism/
+
 ISOFS FILESYSTEM
 M:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index c61e6427384c..2e900d3087d4 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -100,15 +100,14 @@ config CCWGROUP
 	tristate
 	default (LCS || CTCM || QETH || SMC)
 
-config ISM
+config ISM_VPCI
 	tristate "Support for ISM vPCI Adapter"
-	depends on PCI
+	depends on PCI && ISM
 	imply SMC
-	default n
+	default y
 	help
 	  Select this option if you want to use the Internal Shared Memory
 	  vPCI Adapter. The adapter can be used with the SMC network protocol.
 
-	  To compile as a module choose M. The module name is ism.
-	  If unsure, choose N.
+	  To compile as a module choose M. The module name is ism_vpci.
 endmenu
diff --git a/drivers/s390/net/Makefile b/drivers/s390/net/Makefile
index bc55ec316adb..87461019184e 100644
--- a/drivers/s390/net/Makefile
+++ b/drivers/s390/net/Makefile
@@ -16,5 +16,5 @@ obj-$(CONFIG_QETH_L2) += qeth_l2.o
 qeth_l3-y += qeth_l3_main.o qeth_l3_sys.o
 obj-$(CONFIG_QETH_L3) += qeth_l3.o
 
-ism-y := ism_drv.o
-obj-$(CONFIG_ISM) += ism.o
+ism_vpci-y += ism_drv.o
+obj-$(CONFIG_ISM_VPCI) += ism_vpci.o
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..2eeccf5ef48d 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -4,7 +4,7 @@
  *
  * Copyright IBM Corp. 2018
  */
-#define KMSG_COMPONENT "ism"
+#define KMSG_COMPONENT "ism-vpci"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/module.h>
@@ -31,100 +31,7 @@ MODULE_DEVICE_TABLE(pci, ism_device_table);
 
 static debug_info_t *ism_debug_info;
 
-#define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
-static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
-						/* a list for fast mapping  */
-static u8 max_client;
-static DEFINE_MUTEX(clients_lock);
 static bool ism_v2_capable;
-struct ism_dev_list {
-	struct list_head list;
-	struct mutex mutex; /* protects ism device list */
-};
-
-static struct ism_dev_list ism_dev_list = {
-	.list = LIST_HEAD_INIT(ism_dev_list.list),
-	.mutex = __MUTEX_INITIALIZER(ism_dev_list.mutex),
-};
-
-static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ism->lock, flags);
-	ism->subs[client->id] = client;
-	spin_unlock_irqrestore(&ism->lock, flags);
-}
-
-int ism_register_client(struct ism_client *client)
-{
-	struct ism_dev *ism;
-	int i, rc = -ENOSPC;
-
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < MAX_CLIENTS; ++i) {
-		if (!clients[i]) {
-			clients[i] = client;
-			client->id = i;
-			if (i == max_client)
-				max_client++;
-			rc = 0;
-			break;
-		}
-	}
-	mutex_unlock(&clients_lock);
-
-	if (i < MAX_CLIENTS) {
-		/* initialize with all devices that we got so far */
-		list_for_each_entry(ism, &ism_dev_list.list, list) {
-			ism->priv[i] = NULL;
-			client->add(ism);
-			ism_setup_forwarding(client, ism);
-		}
-	}
-	mutex_unlock(&ism_dev_list.mutex);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ism_register_client);
-
-int ism_unregister_client(struct ism_client *client)
-{
-	struct ism_dev *ism;
-	unsigned long flags;
-	int rc = 0;
-
-	mutex_lock(&ism_dev_list.mutex);
-	list_for_each_entry(ism, &ism_dev_list.list, list) {
-		spin_lock_irqsave(&ism->lock, flags);
-		/* Stop forwarding IRQs and events */
-		ism->subs[client->id] = NULL;
-		for (int i = 0; i < ISM_NR_DMBS; ++i) {
-			if (ism->sba_client_arr[i] == client->id) {
-				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
-				     __func__, client->name);
-				rc = -EBUSY;
-				goto err_reg_dmb;
-			}
-		}
-		spin_unlock_irqrestore(&ism->lock, flags);
-	}
-	mutex_unlock(&ism_dev_list.mutex);
-
-	mutex_lock(&clients_lock);
-	clients[client->id] = NULL;
-	if (client->id + 1 == max_client)
-		max_client--;
-	mutex_unlock(&clients_lock);
-	return rc;
-
-err_reg_dmb:
-	spin_unlock_irqrestore(&ism->lock, flags);
-	mutex_unlock(&ism_dev_list.mutex);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ism_unregister_client);
 
 static int ism_cmd(struct ism_dev *ism, void *cmd)
 {
@@ -475,7 +382,7 @@ static void ism_handle_event(struct ism_dev *ism)
 
 		entry = &ism->ieq->entry[ism->ieq_idx];
 		debug_event(ism_debug_info, 2, entry, sizeof(*entry));
-		for (i = 0; i < max_client; ++i) {
+		for (i = 0; i < MAX_CLIENTS; ++i) {
 			clt = ism->subs[i];
 			if (clt)
 				clt->handle_event(ism, entry);
@@ -524,7 +431,7 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
-	int i, ret;
+	int ret;
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
 	if (ret <= 0)
@@ -558,19 +465,7 @@ static int ism_dev_init(struct ism_dev *ism)
 	else
 		ism_v2_capable = false;
 
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < max_client; ++i) {
-		if (clients[i]) {
-			clients[i]->add(ism);
-			ism_setup_forwarding(clients[i], ism);
-		}
-	}
-	mutex_unlock(&clients_lock);
-
-	list_add(&ism->list, &ism_dev_list.list);
-	mutex_unlock(&ism_dev_list.mutex);
-
+	ism_dev_register(ism);
 	query_info(ism);
 	return 0;
 
@@ -649,17 +544,11 @@ static void ism_dev_exit(struct ism_dev *ism)
 	int i;
 
 	spin_lock_irqsave(&ism->lock, flags);
-	for (i = 0; i < max_client; ++i)
+	for (i = 0; i < MAX_CLIENTS; ++i)
 		ism->subs[i] = NULL;
 	spin_unlock_irqrestore(&ism->lock, flags);
 
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < max_client; ++i) {
-		if (clients[i])
-			clients[i]->remove(ism);
-	}
-	mutex_unlock(&clients_lock);
+	ism_dev_unregister(ism);
 
 	if (ism_v2_capable)
 		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
@@ -668,8 +557,6 @@ static void ism_dev_exit(struct ism_dev *ism)
 	free_irq(pci_irq_vector(pdev, 0), ism);
 	kfree(ism->sba_client_arr);
 	pci_free_irq_vectors(pdev);
-	list_del_init(&ism->list);
-	mutex_unlock(&ism_dev_list.mutex);
 }
 
 static void ism_remove(struct pci_dev *pdev)
@@ -700,8 +587,6 @@ static int __init ism_init(void)
 	if (!ism_debug_info)
 		return -ENODEV;
 
-	memset(clients, 0, sizeof(clients));
-	max_client = 0;
 	debug_register_view(ism_debug_info, &debug_hex_ascii_view);
 	ret = pci_register_driver(&ism_driver);
 	if (ret)
@@ -721,7 +606,7 @@ module_exit(ism_exit);
 
 /*************************** SMC-D Implementation *****************************/
 
-#if IS_ENABLED(CONFIG_SMC)
+#if IS_ENABLED(CONFIG_SMC) // needed to avoid unused functions
 static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
 			  u32 vid)
 {
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 5428edd90982..1462296e8ba7 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -9,6 +9,7 @@
 #ifndef _ISM_H
 #define _ISM_H
 
+#include <linux/device.h>
 #include <linux/workqueue.h>
 
 struct ism_dmb {
@@ -24,6 +25,7 @@ struct ism_dmb {
 
 /* Unless we gain unexpected popularity, this limit should hold for a while */
 #define MAX_CLIENTS		8
+#define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
 #define ISM_NR_DMBS		1920
 
 struct ism_dev {
@@ -76,6 +78,9 @@ static inline void *ism_get_priv(struct ism_dev *dev,
 	return dev->priv[client->id];
 }
 
+int ism_dev_register(struct ism_dev *ism);
+void ism_dev_unregister(struct ism_dev *ism);
+
 static inline void ism_set_priv(struct ism_dev *dev, struct ism_client *client,
 				void *priv) {
 	dev->priv[client->id] = priv;
@@ -87,6 +92,9 @@ int  ism_unregister_dmb(struct ism_dev *dev, struct ism_dmb *dmb);
 int  ism_move(struct ism_dev *dev, u64 dmb_tok, unsigned int idx, bool sf,
 	      unsigned int offset, void *data, unsigned int size);
 
+#define ISM_RESERVED_VLANID	0x1FFF
+#define ISM_ERROR	0xFFFF
+
 const struct smcd_ops *ism_get_smcd_ops(void);
 
 #endif	/* _ISM_H */
diff --git a/include/net/smc.h b/include/net/smc.h
index db84e4e35080..ab732b286f91 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -42,9 +42,6 @@ struct smcd_dmb {
 #define ISM_EVENT_GID	1
 #define ISM_EVENT_SWR	2
 
-#define ISM_RESERVED_VLANID	0x1FFF
-
-#define ISM_ERROR	0xFFFF
 
 struct smcd_dev;
 
diff --git a/net/Kconfig b/net/Kconfig
index c3fca69a7c83..2dbe9655f7de 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -83,6 +83,7 @@ source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
 source "net/iucv/Kconfig"
 source "net/smc/Kconfig"
+source "net/ism/Kconfig"
 source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
diff --git a/net/Makefile b/net/Makefile
index 60ed5190eda8..6f06cf00bfbb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_TIPC)		+= tipc/
 obj-$(CONFIG_NETLABEL)		+= netlabel/
 obj-$(CONFIG_IUCV)		+= iucv/
 obj-$(CONFIG_SMC)		+= smc/
+obj-$(CONFIG_ISM)		+= ism/
 obj-$(CONFIG_RFKILL)		+= rfkill/
 obj-$(CONFIG_NET_9P)		+= 9p/
 obj-$(CONFIG_CAIF)		+= caif/
diff --git a/net/ism/Kconfig b/net/ism/Kconfig
new file mode 100644
index 000000000000..4329489cc1e9
--- /dev/null
+++ b/net/ism/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+config ISM
+	tristate "ISM support"
+	default n
+	help
+	  Internal Shared Memory (ISM)
+	  A communication method that uses common physical memory for
+	  synchronous direct access into a remote buffer.
+
+	  Select this option to provide the abstraction layer between
+	  ISM devices and ISM users like the SMC protocol.
+
+	  To compile as a module choose M. The module name is ism.
+	  If unsure, choose N.
diff --git a/net/ism/Makefile b/net/ism/Makefile
new file mode 100644
index 000000000000..b752baf72003
--- /dev/null
+++ b/net/ism/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ISM class module
+#
+
+ism-y += ism_main.o
+obj-$(CONFIG_ISM) += ism.o
diff --git a/net/ism/ism_main.c b/net/ism/ism_main.c
new file mode 100644
index 000000000000..268408dbd691
--- /dev/null
+++ b/net/ism/ism_main.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Internal Shared Memory
+ *
+ *  Implementation of the ISM class module
+ *
+ *  Copyright IBM Corp. 2024
+ */
+#define KMSG_COMPONENT "ism"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/ism.h>
+
+MODULE_DESCRIPTION("Internal Shared Memory class");
+MODULE_LICENSE("GPL");
+
+static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
+						/* a list for fast mapping  */
+static u8 max_client;
+static DEFINE_MUTEX(clients_lock);
+struct ism_dev_list {
+	struct list_head list;
+	struct mutex mutex; /* protects ism device list */
+};
+
+static struct ism_dev_list ism_dev_list = {
+	.list = LIST_HEAD_INIT(ism_dev_list.list),
+	.mutex = __MUTEX_INITIALIZER(ism_dev_list.mutex),
+};
+
+static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ism->lock, flags);
+	ism->subs[client->id] = client;
+	spin_unlock_irqrestore(&ism->lock, flags);
+}
+
+int ism_register_client(struct ism_client *client)
+{
+	struct ism_dev *ism;
+	int i, rc = -ENOSPC;
+
+	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < MAX_CLIENTS; ++i) {
+		if (!clients[i]) {
+			clients[i] = client;
+			client->id = i;
+			if (i == max_client)
+				max_client++;
+			rc = 0;
+			break;
+		}
+	}
+	mutex_unlock(&clients_lock);
+
+	if (i < MAX_CLIENTS) {
+		/* initialize with all devices that we got so far */
+		list_for_each_entry(ism, &ism_dev_list.list, list) {
+			ism->priv[i] = NULL;
+			client->add(ism);
+			ism_setup_forwarding(client, ism);
+		}
+	}
+	mutex_unlock(&ism_dev_list.mutex);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ism_register_client);
+
+int ism_unregister_client(struct ism_client *client)
+{
+	struct ism_dev *ism;
+	unsigned long flags;
+	int rc = 0;
+
+	mutex_lock(&ism_dev_list.mutex);
+	list_for_each_entry(ism, &ism_dev_list.list, list) {
+		spin_lock_irqsave(&ism->lock, flags);
+		/* Stop forwarding IRQs and events */
+		ism->subs[client->id] = NULL;
+		for (int i = 0; i < ISM_NR_DMBS; ++i) {
+			if (ism->sba_client_arr[i] == client->id) {
+				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
+				     __func__, client->name);
+				rc = -EBUSY;
+				goto err_reg_dmb;
+			}
+		}
+		spin_unlock_irqrestore(&ism->lock, flags);
+	}
+	mutex_unlock(&ism_dev_list.mutex);
+
+	mutex_lock(&clients_lock);
+	clients[client->id] = NULL;
+	if (client->id + 1 == max_client)
+		max_client--;
+	mutex_unlock(&clients_lock);
+	return rc;
+
+err_reg_dmb:
+	spin_unlock_irqrestore(&ism->lock, flags);
+	mutex_unlock(&ism_dev_list.mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ism_unregister_client);
+
+int ism_dev_register(struct ism_dev *ism)
+{
+	int i;
+
+	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i]) {
+			clients[i]->add(ism);
+			ism_setup_forwarding(clients[i], ism);
+		}
+	}
+	mutex_unlock(&clients_lock);
+	list_add(&ism->list, &ism_dev_list.list);
+	mutex_unlock(&ism_dev_list.mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ism_dev_register);
+
+void ism_dev_unregister(struct ism_dev *ism)
+{
+	int i;
+
+	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i])
+			clients[i]->remove(ism);
+	}
+	mutex_unlock(&clients_lock);
+	list_del_init(&ism->list);
+	mutex_unlock(&ism_dev_list.mutex);
+}
+EXPORT_SYMBOL_GPL(ism_dev_unregister);
+
+static int __init ism_init(void)
+{
+	memset(clients, 0, sizeof(clients));
+	max_client = 0;
+
+	return 0;
+}
+
+static void __exit ism_exit(void)
+{
+}
+
+module_init(ism_init);
+module_exit(ism_exit);
-- 
2.45.2

