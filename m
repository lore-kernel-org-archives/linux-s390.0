Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:36892 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfHHCWG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 22:22:06 -0400
Subject: Re: [PATCH 1/2] scsi: core: fix missing .cleanup_rq for SCSI hosts without request batching
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190807144948.28265-1-maier@linux.ibm.com>
        <20190807144948.28265-2-maier@linux.ibm.com>
        <CACVXFVM0tFj8CmcHON04_KjxR=QErCbUx0abJgG2W9OBb7akZA@mail.gmail.com>
Date: Wed, 07 Aug 2019 22:18:59 -0400
In-Reply-To: <CACVXFVM0tFj8CmcHON04_KjxR=QErCbUx0abJgG2W9OBb7akZA@mail.gmail.com>
        (Ming Lei's message of "Thu, 8 Aug 2019 07:32:29 +0800")
Message-ID: <yq136iccsbw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, "open list:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>


Ming,

>> +       .cleanup_rq     = scsi_cleanup_rq,
>>         .busy           = scsi_mq_lld_busy,
>>         .map_queues     = scsi_map_queues,
>>  };
>
> This one is a cross-tree thing, either scsi/5.4/scsi-queue needs to
> pull for-5.4/block, or do it after both land linus tree.

I'll set up an amalgamated for-next branch tomorrow.

-- 
Martin K. Petersen	Oracle Linux Engineering
