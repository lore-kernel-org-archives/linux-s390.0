Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbfFFLvs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 07:51:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56BlqLh072873
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 07:51:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sy1s3sj87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 07:51:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 6 Jun 2019 12:51:44 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v4 5/8] virtio/s390: use cacheline aligned airq bit vectors
Date: Thu,  6 Jun 2019 13:51:24 +0200
In-Reply-To: <20190606115127.55519-1-pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
Message-Id: <20190606115127.55519-6-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

The flag AIRQ_IV_CACHELINE was recently added to airq_iv_create(). Let
us use it! We actually wanted the vector to span a cacheline all along.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index f995798bb025..1da7430f94c8 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -216,7 +216,8 @@ static struct airq_info *new_airq_info(void)
 	if (!info)
 		return NULL;
 	rwlock_init(&info->lock);
-	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR);
+	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR
+				   | AIRQ_IV_CACHELINE);
 	if (!info->aiv) {
 		kfree(info);
 		return NULL;
-- 
2.17.1
