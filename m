Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3FC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD5E60ED4
	for <linux-s390@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhJOGxO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Oct 2021 02:53:14 -0400
Received: from mail-eopbgr1310104.outbound.protection.outlook.com ([40.107.131.104]:22816
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235753AbhJOGxL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Oct 2021 02:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ldJwaCP0+XLtQVE23ce5TA5otCVRLtj0r72iPjvzQ4LbAYJbqS+MXg+r0X+qzSCyiR0bUUdbM2Wlj+gE1T/rV0GfT/avHjtVXaklHm/qXIUz8Q/ItvGzGIOjvRFQCd2RCV9vg3mX7P4tKBYjdT0hbu7j5kSXCZ3I6cS4+Pha0kZF9W3Qy+MghETiyqapgRYnhTQ/legf6EMtypKgB5Yzmghc82Zfhe8JjzTtjCuENz3oIx8TakbykAUz1T/kISOX2BKrAHhh7AOujeBVXUCxAjH4b8YNUBIEQWpiJ+rb/vVDE4/2k6Skg67ohy+cCDxU1aKQZHL7v14PWvWIAmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbwOZkuYMmnkR5Fi/VOinzn8uUCeA8kSjSgIxhq+TS0=;
 b=LWk3468N025kxRmOxAam7Wcg+FK4Tgvs6iv1ddI1QbJeEcG85pp9Corzh9mR3MAVXe0IpfMTuxdp2GBfoLfhGKj1Wk6fXRAr/tLphQ/vdQIyW52VshiGe2TkBxPuUMXicQytaiuq0FiOZzZhYQwhcm5ZdqoFuk4sjbUi5b3P4Kq174oNhuA9Jyo5JjROelaDY5xOifdU0hBxC9DHu2QAbxPFXXL0dx4xTVA3g8gjYJ9Rt6b+ec8r5tXJVTaPHwwbfzk9wDAICWxBbVhlMpfkrDhfRa30yN1yqWe9RGuSQbQAJ2lIUsW6g5amPd+PKbTNriAkDTvG15JbkIUXJk8boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbwOZkuYMmnkR5Fi/VOinzn8uUCeA8kSjSgIxhq+TS0=;
 b=i5ICkd+V0MhcgrbXcPcFH9OK05k97VF/W7xoMb+2Zifw7xQdS2pN6YSmc/b8q011xIQZGgasUUY8O407fte6hDHillqZWONqM91Y4xsmUeXrZWZsGXAPiS5FtwIvPEhUjUGwYUseh+U2Is61cb/76mQdMak5Q8qxKZ++jdh9Wmg=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:51:03 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:51:03 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] s390: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:50:54 -0700
Message-Id: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0053.apcprd04.prod.outlook.com
 (2603:1096:202:14::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR04CA0053.apcprd04.prod.outlook.com (2603:1096:202:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:51:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cab2306-c6ee-48ab-f908-08d98fa82784
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3003FC30AE9B514C4BDD92D1BDB99@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTX6710Re/ao2DDeHd3mAXJwiZi3MobYzDza98jIHRsLxaJqFRD7mPhS+S3blZNZMXWyvjvGA5Hso3VjBOV1oArVH7p8yFZQHNB24y2kci/sk4ujDFuA0Z6/1Fg41LV/3SL5yr0miAt+OiM7ZO/PbZLHqcRN9duoZRh/ukuFl5AYPZDjvz0TIbcnQ8RBizFuckty2QA7lpZvalPVQVrnRmFMoJNUnn0d8/JJogXqNqt7xX5pamcPO1XsM1rL0ou7NzXUISgJUxgex5qdgKH2Sc518mLcrXY6WE5bloU6EI2XVwn9W/kY2UMq1NYpvw8XgisnUWY+7eBfk1btcLipdWweDLGRhmGtXPZWOZ4UzDr9o9td2wOi81bDNCXcr5dqGnuQ36ltAkv2Pf0oeGpM7f2/5JhTfmTJ7cxxnIqDnAWMHvSZHzchwK5NiFyKxfwASzWIb1PhjOreqQQdVT7PypkgFQRE489U9RUYmYpCMyAOhMEhNB8CjnmwYCB+16wS/i/MyDiKfLNVfV7+Y88jjk5sY9iUbHhhcXPesk8lNkQj6bZ/uVf38uCNPXaBVSIuUnada3jp3tvVTqxKP+2y/c2OSLb180zFWWmGlB9JyIHv2WH1OA0x7h0Q2S0U7JN+EOYAHOTFfxO6qxQB4LkY0WqSLSH/sxUoC3Y2l4hp0YUbJCYMaWUTIgNZ2qFYtXx6KCnBia8k2R3NmOh68wGwyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(8936002)(66476007)(83380400001)(316002)(2906002)(4326008)(36756003)(110136005)(6666004)(66946007)(86362001)(186003)(956004)(2616005)(107886003)(30864003)(26005)(6512007)(8676002)(508600001)(52116002)(38350700002)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/znYxJN1Vf0OGvgfJ5euNTnREfEp6i3imPwl0kgAXbA/pQkrDev/1VyUapve?=
 =?us-ascii?Q?voVGTKKTjps5ocsSGCyNU95idzNvuwBYGXPvfcIgGbyiDt/GIEuO+UiAZlib?=
 =?us-ascii?Q?QrdBE9HpqOQfVtYe3myp8RSrUAz/IfeH1nC4KzXobpRRA32RimAK0nZOGkB/?=
 =?us-ascii?Q?+koMl8dUhEgVmR5//z/S4+QybCC2zW30S7OrYNQzWFZw39kq+/I0xqh/MmG1?=
 =?us-ascii?Q?y5TRMafO5evVW9+fh8S5UvGRp+of0UW55OMnX20NsVFkHx+y93VwcwMS7CQl?=
 =?us-ascii?Q?KxtxYKqC8C6vKlLrIrNooPZnIIlg3flQKhCngASykHHtLytGCpF00t1qNUic?=
 =?us-ascii?Q?HF8hfEpTSRFzD0qcIyfgcw+PT/yskVWWqZFn+s56BxSzvjHoZMgSL/7CRvoZ?=
 =?us-ascii?Q?+FKpOLmvLnDqQpRJoImrbkoXOu5MFU3czONdjT0h5To89Y1OWAbHijBc5E05?=
 =?us-ascii?Q?fmd7yknJY8EUFAkuuynMh4pYk186jD6bK3KUIZOt1HQW0vm+QxlXi59a0On7?=
 =?us-ascii?Q?9o77omvmtNJMhDoYQLdUyZnQ2MNYghmmwwp8gwlMnjOTBNmMhbGdAsT0ssHf?=
 =?us-ascii?Q?/l4vRNTeoE9tBzU2UwAgijOl1FXzLJEHPQ5r8cJyx42HkbAesZGxK78MHIic?=
 =?us-ascii?Q?r+89HwOEucWFBqdCOGmthuC13d6KZuJavOyrolJPkcjlZxZqDYDZgEcs6tyc?=
 =?us-ascii?Q?+lIc+Gj5r/1G3glzZy0YlTNkjG6G6Sd3L0Qn0X41sq9dfwMXmMYh9cbtz/8s?=
 =?us-ascii?Q?Es+OtphzKHH53iY7ZhFHiaGdojMZDtDVUCAXFYBqkQV9v+0gtSbioKoFJxJ5?=
 =?us-ascii?Q?/dyEOIN81hotq6CyFpUzQ12WD8dlJ/YXtwg08zmrPnlCIFCWfxZPPRwE8bjU?=
 =?us-ascii?Q?scdDHvmxrwuOnjJ4B9nXbn/hLlNWnvTQQQ2gBq2GIKh1ancsWbZuF3yDa/09?=
 =?us-ascii?Q?KOA0K/w1Eap9Dm8Ll1PtdFaIvm/9q75E18ohZIwrM4Er8YcbfI569ert7w8+?=
 =?us-ascii?Q?IxDK+sS6Q7dhgQtTg1iS3eghy1uTL08tpsW7tpSiSnQ24+Q8Ab8Liq0CmgrJ?=
 =?us-ascii?Q?Wg4JpY/g8NMObLVxS7SiX/HpIjiwb7pO5JJ+wZVtZCO99Dx58S1uYo7ofewS?=
 =?us-ascii?Q?Z3HL9cQN5Mfg7Ltbm5n1v/EO3QwL8kG4CWOmFJpPUUp6OjIPv8OWQ3+1g0Qn?=
 =?us-ascii?Q?K+jesL+nvz3CS5enLAFM5+PuUpdnk7RU//JyeQgwlIHMmbwGgF9RGUggApDK?=
 =?us-ascii?Q?H10n3jRFA77N8Z2DT40zZOjqA72eUIqNk0/5HCwv2pO5E4CjT0YMbH7VtW8u?=
 =?us-ascii?Q?B1S8nV/0wsJ8qMJD2G/uFjCP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cab2306-c6ee-48ab-f908-08d98fa82784
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:51:03.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eABLYScRjDFlaAJgAypXzc5dxBfE5YvxtlKyLF3tYQdpklR64qqFUGqPWiL1DA725P+KfGFNFKd2DYd5CKNrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/s390/block/dasd_devmap.c | 74 ++++++++++++++++++++--------------------
 drivers/s390/char/raw3270.c      |  6 ++--
 drivers/s390/cio/chp.c           |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2c40fe1..78eb479 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -731,7 +731,7 @@ static ssize_t dasd_ff_show(struct device *dev, struct device_attribute *attr,
 		ff_flag = (devmap->features & DASD_FEATURE_FAILFAST) != 0;
 	else
 		ff_flag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_FAILFAST) != 0;
-	return snprintf(buf, PAGE_SIZE, ff_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, ff_flag ? "1\n" : "0\n");
 }
 
 static ssize_t dasd_ff_store(struct device *dev, struct device_attribute *attr,
@@ -773,7 +773,7 @@ dasd_ro_show(struct device *dev, struct device_attribute *attr, char *buf)
 	spin_unlock(&dasd_devmap_lock);
 
 out:
-	return snprintf(buf, PAGE_SIZE, ro_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, ro_flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -834,7 +834,7 @@ dasd_erplog_show(struct device *dev, struct device_attribute *attr, char *buf)
 		erplog = (devmap->features & DASD_FEATURE_ERPLOG) != 0;
 	else
 		erplog = (DASD_FEATURE_DEFAULT & DASD_FEATURE_ERPLOG) != 0;
-	return snprintf(buf, PAGE_SIZE, erplog ? "1\n" : "0\n");
+	return sysfs_emit(buf, erplog ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1033,13 +1033,13 @@ dasd_discipline_show(struct device *dev, struct device_attribute *attr,
 		dasd_put_device(device);
 		goto out;
 	} else {
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
+		len = sysfs_emit(buf, "%s\n",
 			       device->discipline->name);
 		dasd_put_device(device);
 		return len;
 	}
 out:
-	len = snprintf(buf, PAGE_SIZE, "none\n");
+	len = sysfs_emit(buf, "none\n");
 	return len;
 }
 
@@ -1056,30 +1056,30 @@ dasd_device_status_show(struct device *dev, struct device_attribute *attr,
 	if (!IS_ERR(device)) {
 		switch (device->state) {
 		case DASD_STATE_NEW:
-			len = snprintf(buf, PAGE_SIZE, "new\n");
+			len = sysfs_emit(buf, "new\n");
 			break;
 		case DASD_STATE_KNOWN:
-			len = snprintf(buf, PAGE_SIZE, "detected\n");
+			len = sysfs_emit(buf, "detected\n");
 			break;
 		case DASD_STATE_BASIC:
-			len = snprintf(buf, PAGE_SIZE, "basic\n");
+			len = sysfs_emit(buf, "basic\n");
 			break;
 		case DASD_STATE_UNFMT:
-			len = snprintf(buf, PAGE_SIZE, "unformatted\n");
+			len = sysfs_emit(buf, "unformatted\n");
 			break;
 		case DASD_STATE_READY:
-			len = snprintf(buf, PAGE_SIZE, "ready\n");
+			len = sysfs_emit(buf, "ready\n");
 			break;
 		case DASD_STATE_ONLINE:
-			len = snprintf(buf, PAGE_SIZE, "online\n");
+			len = sysfs_emit(buf, "online\n");
 			break;
 		default:
-			len = snprintf(buf, PAGE_SIZE, "no stat\n");
+			len = sysfs_emit(buf, "no stat\n");
 			break;
 		}
 		dasd_put_device(device);
 	} else
-		len = snprintf(buf, PAGE_SIZE, "unknown\n");
+		len = sysfs_emit(buf, "unknown\n");
 	return len;
 }
 
@@ -1120,7 +1120,7 @@ static ssize_t dasd_vendor_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	vendor = "";
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
+		return sysfs_emit(buf, "%s\n", vendor);
 
 	if (device->discipline && device->discipline->get_uid &&
 	    !device->discipline->get_uid(device, &uid))
@@ -1128,7 +1128,7 @@ static ssize_t dasd_vendor_show(struct device *dev,
 
 	dasd_put_device(device);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
+	return sysfs_emit(buf, "%s\n", vendor);
 }
 
 static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
@@ -1148,7 +1148,7 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	uid_string[0] = 0;
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
+		return sysfs_emit(buf, "%s\n", uid_string);
 
 	if (device->discipline && device->discipline->get_uid &&
 	    !device->discipline->get_uid(device, &uid)) {
@@ -1183,7 +1183,7 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 	}
 	dasd_put_device(device);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
+	return sysfs_emit(buf, "%s\n", uid_string);
 }
 static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
 
@@ -1201,7 +1201,7 @@ dasd_eer_show(struct device *dev, struct device_attribute *attr, char *buf)
 		eer_flag = dasd_eer_enabled(devmap->device);
 	else
 		eer_flag = 0;
-	return snprintf(buf, PAGE_SIZE, eer_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, eer_flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1243,7 +1243,7 @@ dasd_expires_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->default_expires);
+	len = sysfs_emit(buf, "%lu\n", device->default_expires);
 	dasd_put_device(device);
 	return len;
 }
@@ -1283,7 +1283,7 @@ dasd_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->default_retries);
+	len = sysfs_emit(buf, "%lu\n", device->default_retries);
 	dasd_put_device(device);
 	return len;
 }
@@ -1324,7 +1324,7 @@ dasd_timeout_show(struct device *dev, struct device_attribute *attr,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->blk_timeout);
+	len = sysfs_emit(buf, "%lu\n", device->blk_timeout);
 	dasd_put_device(device);
 	return len;
 }
@@ -1398,11 +1398,11 @@ static ssize_t dasd_hpf_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 	if (!device->discipline || !device->discipline->hpf_enabled) {
 		dasd_put_device(device);
-		return snprintf(buf, PAGE_SIZE, "%d\n", dasd_nofcx);
+		return sysfs_emit(buf, "%d\n", dasd_nofcx);
 	}
 	hpf = device->discipline->hpf_enabled(device);
 	dasd_put_device(device);
-	return snprintf(buf, PAGE_SIZE, "%d\n", hpf);
+	return sysfs_emit(buf, "%d\n", hpf);
 }
 
 static DEVICE_ATTR(hpf, 0444, dasd_hpf_show, NULL);
@@ -1416,13 +1416,13 @@ static ssize_t dasd_reservation_policy_show(struct device *dev,
 
 	devmap = dasd_find_busid(dev_name(dev));
 	if (IS_ERR(devmap)) {
-		rc = snprintf(buf, PAGE_SIZE, "ignore\n");
+		rc = sysfs_emit(buf, "ignore\n");
 	} else {
 		spin_lock(&dasd_devmap_lock);
 		if (devmap->features & DASD_FEATURE_FAILONSLCK)
-			rc = snprintf(buf, PAGE_SIZE, "fail\n");
+			rc = sysfs_emit(buf, "fail\n");
 		else
-			rc = snprintf(buf, PAGE_SIZE, "ignore\n");
+			rc = sysfs_emit(buf, "ignore\n");
 		spin_unlock(&dasd_devmap_lock);
 	}
 	return rc;
@@ -1457,14 +1457,14 @@ static ssize_t dasd_reservation_state_show(struct device *dev,
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "none\n");
+		return sysfs_emit(buf, "none\n");
 
 	if (test_bit(DASD_FLAG_IS_RESERVED, &device->flags))
-		rc = snprintf(buf, PAGE_SIZE, "reserved\n");
+		rc = sysfs_emit(buf, "reserved\n");
 	else if (test_bit(DASD_FLAG_LOCK_STOLEN, &device->flags))
-		rc = snprintf(buf, PAGE_SIZE, "lost\n");
+		rc = sysfs_emit(buf, "lost\n");
 	else
-		rc = snprintf(buf, PAGE_SIZE, "none\n");
+		rc = sysfs_emit(buf, "none\n");
 	dasd_put_device(device);
 	return rc;
 }
@@ -1531,7 +1531,7 @@ dasd_path_threshold_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_thrhld);
+	len = sysfs_emit(buf, "%lu\n", device->path_thrhld);
 	dasd_put_device(device);
 	return len;
 }
@@ -1578,7 +1578,7 @@ dasd_path_autodisable_show(struct device *dev,
 	else
 		flag = (DASD_FEATURE_DEFAULT &
 			DASD_FEATURE_PATH_AUTODISABLE) != 0;
-	return snprintf(buf, PAGE_SIZE, flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1616,7 +1616,7 @@ dasd_path_interval_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_interval);
+	len = sysfs_emit(buf, "%lu\n", device->path_interval);
 	dasd_put_device(device);
 	return len;
 }
@@ -1662,9 +1662,9 @@ dasd_device_fcs_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 	fc_sec = dasd_path_get_fcs_device(device);
 	if (fc_sec == -EINVAL)
-		rc = snprintf(buf, PAGE_SIZE, "Inconsistent\n");
+		rc = sysfs_emit(buf, "Inconsistent\n");
 	else
-		rc = snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+		rc = sysfs_emit(buf, "%s\n", dasd_path_get_fcs_str(fc_sec));
 	dasd_put_device(device);
 
 	return rc;
@@ -1677,7 +1677,7 @@ dasd_path_fcs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 	struct dasd_path *path = to_dasd_path(kobj);
 	unsigned int fc_sec = path->fc_security;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+	return sysfs_emit(buf, "%s\n", dasd_path_get_fcs_str(fc_sec));
 }
 
 static struct kobj_attribute path_fcs_attribute =
@@ -1698,7 +1698,7 @@ static ssize_t dasd_##_name##_show(struct device *dev,			\
 		val = _func(device);					\
 	dasd_put_device(device);					\
 									\
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);			\
+	return sysfs_emit(buf, "%d\n", val);			\
 }									\
 static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);		\
 
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 646ec796..be8529f 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1047,7 +1047,7 @@ raw3270_probe (struct ccw_device *cdev)
 static ssize_t
 raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->model);
 }
 static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
@@ -1055,7 +1055,7 @@ static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->rows);
 }
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
@@ -1063,7 +1063,7 @@ static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->cols);
 }
 static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 1097e76..5440f28 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -285,7 +285,7 @@ static ssize_t chp_configure_show(struct device *dev,
 	if (status < 0)
 		return status;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buf, "%d\n", status);
 }
 
 static int cfg_wait_idle(void);
-- 
2.7.4

