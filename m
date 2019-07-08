Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfGHIXG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 04:23:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x688MplM107076
        for <linux-s390@vger.kernel.org>; Mon, 8 Jul 2019 04:23:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tkysjwamv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 04:23:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 8 Jul 2019 09:23:03 +0100
Date: Mon, 8 Jul 2019 10:22:57 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] s390: ap: constify parameter of match_apqn
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
Message-Id: <patch.git-14fdf13eac05.your-ad-here.call-01562573328-ext-8139@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
class_find_device()") changed the prototype of driver_find_device to
use a const void pointer.

Change match_apqn accordingly.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2c9fb1423a39..7e85ba7c6ef0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -26,7 +26,7 @@
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
 
-static int match_apqn(struct device *dev, void *data)
+static int match_apqn(struct device *dev, const void *data)
 {
 	struct vfio_ap_queue *q = dev_get_drvdata(dev);
 
-- 
2.21.0
