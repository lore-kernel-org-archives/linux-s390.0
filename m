Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83F381B9;
	Fri, 15 Dec 2023 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BrDM7Z5Y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFSHwP007891;
	Fri, 15 Dec 2023 15:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=JvQizxwxLmPqgh9+r1B4KcnfYVhTh3MJFyhN9f6hnbc=;
 b=BrDM7Z5YudmWQIoUocpWpEQjdQ93AnFmgdWo7GgOkit+mIz55bO2EK3LADXAlH4V4yBX
 01UVTn8HVDNFZgAH0BfwOYC5mjDm2zBrnw6HYDFxY/NjVwoTNE2lsUNe4RLVyiLaVAQM
 Zh10y6iL5U8e0uFKuDtIsw82+KbopvY05P4olrPcV8jGu6nUx0VAkDj6JTZZFlxAWDgf
 EeP7Ri0Pcpp2ct9ZEwxcfQORAEDVGgOmRT6FoFhYehWP2hhLbUCwaPxDo3VNf6MduIbw
 T0ADNHukAdYoxKLZyiUPKmGrTJa/wtqw58b3nJJomvLOvvDcf+lEuADF6MEUJJ7cUHVD zQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0sf9g03h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF5tV9w014813;
	Fri, 15 Dec 2023 15:28:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kkget-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSALD41222898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9592004D;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3066C20040;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id A1BAAE153A; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 08/10] s390/dasd: Remove PRINTK_HEADER and KMSG_COMPONENT definitions
Date: Fri, 15 Dec 2023 16:28:08 +0100
Message-Id: <20231215152809.882602-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215152809.882602-1-sth@linux.ibm.com>
References: <20231215152809.882602-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 30GBTkW_whYdK8-J-IwRv3GDaKIXUZIN
X-Proofpoint-ORIG-GUID: 30GBTkW_whYdK8-J-IwRv3GDaKIXUZIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150106

From: Jan Höppner <hoeppner@linux.ibm.com>

PRINTK_HEADER was mainly used to prefix log messages with the module
name. Most components don't use this definition anymore. Either because
there are no log messages being generated anymore, or pr_*() were
replaced by dev_*(), which contains device and component information
already.

PRINTK_HEADER is also dropped in the function
dasd_3990_erp_handle_match_erp() in dasd_3990_erp.c from a panic() call
as panic() already provides all relevant information.

KMSG_COMPONENT was mainly used to identify a component in a long gone
kernel message catalog feature.

Remove both definition since they're either not used or alternatives
make the code slightly shorter and more readable.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c          | 3 ---
 drivers/s390/block/dasd_3990_erp.c | 7 +------
 drivers/s390/block/dasd_alias.c    | 8 --------
 drivers/s390/block/dasd_devmap.c   | 4 ----
 drivers/s390/block/dasd_diag.c     | 4 ----
 drivers/s390/block/dasd_eckd.c     | 2 --
 drivers/s390/block/dasd_eer.c      | 7 -------
 drivers/s390/block/dasd_erp.c      | 5 -----
 drivers/s390/block/dasd_genhd.c    | 5 -----
 drivers/s390/block/dasd_ioctl.c    | 6 ------
 drivers/s390/block/dasd_proc.c     | 5 -----
 11 files changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index be5f019d878b..c6a5fddd4389 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -30,9 +30,6 @@
 #include <asm/itcw.h>
 #include <asm/diag.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd:"
-
 #include "dasd_int.h"
 /*
  * SECTION: Constant definitions to be used within this file
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index b39c0798a110..c59a961cfdd2 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -7,13 +7,9 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd-eckd"
-
 #include <linux/timer.h>
 #include <asm/idals.h>
 
-#define PRINTK_HEADER "dasd_erp(3990): "
-
 #include "dasd_int.h"
 #include "dasd_eckd.h"
 
@@ -2700,8 +2696,7 @@ dasd_3990_erp_handle_match_erp(struct dasd_ccw_req *erp_head,
 	while (erp_done != erp) {
 
 		if (erp_done == NULL)	/* end of chain reached */
-			panic(PRINTK_HEADER "Programming error in ERP! The "
-			      "original request was lost\n");
+			panic("Programming error in ERP! The original request was lost\n");
 
 		/* remove the request from the device queue */
 		list_del(&erp_done->blocklist);
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index c9740ae88d1a..e84cd5436556 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -6,20 +6,12 @@
  * Author(s): Stefan Weinhuber <wein@de.ibm.com>
  */
 
-#define KMSG_COMPONENT "dasd-eckd"
-
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <asm/ebcdic.h>
 #include "dasd_int.h"
 #include "dasd_eckd.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(eckd):"
-
-
 /*
  * General concept of alias management:
  * - PAV and DASD alias management is specific to the eckd discipline.
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 8a01afb5e3ce..0316c20823ee 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -13,8 +13,6 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/uaccess.h>
 #include <asm/ipl.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd_devmap:"
 #define DASD_MAX_PARAMS 256
 
 #include "dasd_int.h"
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 2e4e555b37c3..041088c7e909 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -8,8 +8,6 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/kernel_stat.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
@@ -31,8 +29,6 @@
 #include "dasd_int.h"
 #include "dasd_diag.h"
 
-#define PRINTK_HEADER "dasd(diag):"
-
 MODULE_LICENSE("GPL");
 
 /* The maximum number of blocks per request (max_blocks) is dependent on the
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index d9f776789429..8aade17d885c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -10,8 +10,6 @@
  * Author.........: Nigel Hislop <hislop_nigel@emc.com>
  */
 
-#define KMSG_COMPONENT "dasd-eckd"
-
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index c956de711cf7..5064a616e041 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -7,8 +7,6 @@
  *  Author(s): Stefan Weinhuber <wein@de.ibm.com>
  */
 
-#define KMSG_COMPONENT "dasd-eckd"
-
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -28,11 +26,6 @@
 #include "dasd_int.h"
 #include "dasd_eckd.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(eer):"
-
 /*
  * SECTION: the internal buffer
  */
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index c462f01d22e3..4c0d3a704513 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -9,8 +9,6 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/ctype.h>
 #include <linux/init.h>
 
@@ -18,9 +16,6 @@
 #include <asm/ebcdic.h>
 #include <linux/uaccess.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd_erp:"
-
 #include "dasd_int.h"
 
 struct dasd_ccw_req *
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 55e3abe94cde..30e8ee583e98 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -11,8 +11,6 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/interrupt.h>
 #include <linux/major.h>
 #include <linux/fs.h>
@@ -20,9 +18,6 @@
 
 #include <linux/uaccess.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd_gendisk:"
-
 #include "dasd_int.h"
 
 static unsigned int queue_depth = 32;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 61b9675e2a67..6814354a23ef 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -10,8 +10,6 @@
  * i/o controls for the dasd driver.
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/interrupt.h>
 #include <linux/compat.h>
 #include <linux/major.h>
@@ -24,12 +22,8 @@
 #include <linux/uaccess.h>
 #include <linux/dasd_mod.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd_ioctl:"
-
 #include "dasd_int.h"
 
-
 static int
 dasd_ioctl_api_version(void __user *argp)
 {
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 62a859ea67f8..0faaa437d9be 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -11,8 +11,6 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd"
-
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -23,9 +21,6 @@
 #include <asm/debug.h>
 #include <linux/uaccess.h>
 
-/* This is ugly... */
-#define PRINTK_HEADER "dasd_proc:"
-
 #include "dasd_int.h"
 
 static struct proc_dir_entry *dasd_proc_root_entry = NULL;
-- 
2.40.1

