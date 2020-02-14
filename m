Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNMqE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 07:46:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so4863868pfn.4
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 04:46:02 -0800 (PST)
From: qiwuchen55@gmail.com
Subject: [PATCH] s390/cio: use kobj_to_dev() API
Date: Fri, 14 Feb 2020 20:45:57 +0800
Message-Id: <1581684357-24992-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

From: chenqiwu <chenqiwu@xiaomi.com>

Use kobj_to_dev() API instead of container_of().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/s390/cio/chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 51038ec..dfcbe54 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -135,7 +135,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
 	struct channel_path *chp;
 	struct device *device;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	if (chp->cmg == -1)
 		return 0;
@@ -184,7 +184,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
 	struct device *device;
 	unsigned int size;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	css = to_css(chp->dev.parent);
 
-- 
1.9.1
