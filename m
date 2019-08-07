Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbfHGQRR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 12:17:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so1854133wra.6
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2019 09:17:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: core: regression fixes for request batching
References: <20190807144948.28265-1-maier@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <700f3175-561a-c577-0cb7-3f9ae4d82db0@redhat.com>
Date: Wed, 7 Aug 2019 18:17:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190807144948.28265-1-maier@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-next@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

On 07/08/19 16:49, Steffen Maier wrote:
> Hi James, Martin, Paolo, Ming,
> 
> multipathing with linux-next is broken since 20190723 in our CI.
> The patches fix a memleak and a severe dh/multipath functional regression.
> It would be nice if we could get them to 5.4/scsi-queue and also next.
> 
> I would have preferred if such a new feature had used its own
> new copy scsi_mq_ops_batching instead of changing the use case and
> semantics of the existing scsi_mq_ops, because this would likely
> cause less regressions for all the other users not using the new feature.
> 
> Steffen Maier (2):
>   scsi: core: fix missing .cleanup_rq for SCSI hosts without request
>     batching
>   scsi: core: fix dh and multipathing for SCSI hosts without request
>     batching
> 
>  drivers/scsi/scsi_lib.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
