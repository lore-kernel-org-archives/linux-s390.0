Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729968AbfHGOuS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 10:50:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77EmGY0134434
        for <linux-s390@vger.kernel.org>; Wed, 7 Aug 2019 10:50:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u7xyn5hx7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2019 10:50:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 7 Aug 2019 15:50:14 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 1/2] scsi: core: fix missing .cleanup_rq for SCSI hosts without request batching
Date: Wed,  7 Aug 2019 16:49:47 +0200
In-Reply-To: <20190807144948.28265-1-maier@linux.ibm.com>
References: <20190807144948.28265-1-maier@linux.ibm.com>
Message-Id: <20190807144948.28265-2-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-next@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

This was missing from scsi_mq_ops_no_commit of linux-next commit
8930a6c20791 ("scsi: core: add support for request batching")
from Martin's scsi/5.4/scsi-queue or James' scsi/misc.

See also linux-next commit b7e9e1fb7a92 ("scsi: implement .cleanup_rq
callback") from block/for-next.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ae03d3e2600f..90c257622bb0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1834,6 +1834,7 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
 	.init_request	= scsi_mq_init_request,
 	.exit_request	= scsi_mq_exit_request,
 	.initialize_rq_fn = scsi_initialize_rq,
+	.cleanup_rq	= scsi_cleanup_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
 };
-- 
2.17.1
