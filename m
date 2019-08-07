Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729968AbfHGOuU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 10:50:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77Eks6J061648
        for <linux-s390@vger.kernel.org>; Wed, 7 Aug 2019 10:50:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u7y774vj3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2019 10:50:18 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 7 Aug 2019 15:50:16 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 2/2] scsi: core: fix dh and multipathing for SCSI hosts without request batching
Date: Wed,  7 Aug 2019 16:49:48 +0200
In-Reply-To: <20190807144948.28265-1-maier@linux.ibm.com>
References: <20190807144948.28265-1-maier@linux.ibm.com>
Message-Id: <20190807144948.28265-3-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-next@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

This was missing from scsi_device_from_queue() due to the introduction
of another new scsi_mq_ops_no_commit of linux-next commit
8930a6c20791 ("scsi: core: add support for request batching")
from Martin's scsi/5.4/scsi-queue or James' scsi/misc.

Only devicehandler code seems to call scsi_device_from_queue():
*** drivers/scsi/scsi_dh.c:
scsi_dh_activate[255]          sdev = scsi_device_from_queue(q);
scsi_dh_set_params[302]        sdev = scsi_device_from_queue(q);
scsi_dh_attach[325]            sdev = scsi_device_from_queue(q);
scsi_dh_attached_handler_name[363] sdev = scsi_device_from_queue(q);

Fixes multipath tools follow-on errors:

$ multipath -v6
...
libdevmapper: ioctl/libdm-iface.c(1887): device-mapper: reload ioctl on mpatha  failed: No such device
...
mpatha: failed to load map, error 19
...

showing also as kernel messages:

device-mapper: table: 252:0: multipath: error attaching hardware handler
device-mapper: ioctl: error adding target to table

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/scsi/scsi_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 90c257622bb0..73e7d29fbd66 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1922,7 +1922,8 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 {
 	struct scsi_device *sdev = NULL;
 
-	if (q->mq_ops == &scsi_mq_ops)
+	if (q->mq_ops == &scsi_mq_ops_no_commit ||
+	    q->mq_ops == &scsi_mq_ops)
 		sdev = q->queuedata;
 	if (!sdev || !get_device(&sdev->sdev_gendev))
 		sdev = NULL;
-- 
2.17.1
