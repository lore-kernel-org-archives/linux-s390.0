Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfG2IjB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jul 2019 04:39:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T8YCZu033897
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2019 04:39:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u1t790as9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2019 04:39:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 29 Jul 2019 09:38:58 +0100
Date: Mon, 29 Jul 2019 10:38:52 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] vfio-ccw: make vfio_ccw_async_region_ops static
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>

Since vfio_ccw_async_region_ops is not exported and has no reason to be
globally visible make it static to avoid the following sparse warning:
drivers/s390/cio/vfio_ccw_async.c:73:30: warning: symbol 'vfio_ccw_async_region_ops' was not declared. Should it be static?

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 8c1d2357ef5b..7a838e3d7c0f 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -70,7 +70,7 @@ static void vfio_ccw_async_region_release(struct vfio_ccw_private *private,
 
 }
 
-const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
+static const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
 	.read = vfio_ccw_async_region_read,
 	.write = vfio_ccw_async_region_write,
 	.release = vfio_ccw_async_region_release,
-- 
2.21.0
