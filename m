Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbfHGOuN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 10:50:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77EknmZ014268
        for <linux-s390@vger.kernel.org>; Wed, 7 Aug 2019 10:50:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7xrvpf5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2019 10:50:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 7 Aug 2019 15:50:08 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 0/2] scsi: core: regression fixes for request batching
Date: Wed,  7 Aug 2019 16:49:46 +0200
Message-Id: <20190807144948.28265-1-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-next@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

Hi James, Martin, Paolo, Ming,

multipathing with linux-next is broken since 20190723 in our CI.
The patches fix a memleak and a severe dh/multipath functional regression.
It would be nice if we could get them to 5.4/scsi-queue and also next.

I would have preferred if such a new feature had used its own
new copy scsi_mq_ops_batching instead of changing the use case and
semantics of the existing scsi_mq_ops, because this would likely
cause less regressions for all the other users not using the new feature.

Steffen Maier (2):
  scsi: core: fix missing .cleanup_rq for SCSI hosts without request
    batching
  scsi: core: fix dh and multipathing for SCSI hosts without request
    batching

 drivers/scsi/scsi_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1
