Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36802 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfHGXcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 19:32:43 -0400
MIME-Version: 1.0
References: <20190807144948.28265-1-maier@linux.ibm.com> <20190807144948.28265-2-maier@linux.ibm.com>
In-Reply-To: <20190807144948.28265-2-maier@linux.ibm.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 8 Aug 2019 07:32:29 +0800
Message-ID: <CACVXFVM0tFj8CmcHON04_KjxR=QErCbUx0abJgG2W9OBb7akZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: core: fix missing .cleanup_rq for SCSI hosts
 without request batching
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, "open list:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

On Wed, Aug 7, 2019 at 10:55 PM Steffen Maier <maier@linux.ibm.com> wrote:
>
> This was missing from scsi_mq_ops_no_commit of linux-next commit
> 8930a6c20791 ("scsi: core: add support for request batching")
> from Martin's scsi/5.4/scsi-queue or James' scsi/misc.
>
> See also linux-next commit b7e9e1fb7a92 ("scsi: implement .cleanup_rq
> callback") from block/for-next.
>
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/scsi_lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index ae03d3e2600f..90c257622bb0 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1834,6 +1834,7 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
>         .init_request   = scsi_mq_init_request,
>         .exit_request   = scsi_mq_exit_request,
>         .initialize_rq_fn = scsi_initialize_rq,
> +       .cleanup_rq     = scsi_cleanup_rq,
>         .busy           = scsi_mq_lld_busy,
>         .map_queues     = scsi_map_queues,
>  };

This one is a cross-tree thing, either scsi/5.4/scsi-queue needs to
pull for-5.4/block, or
do it after both land linus tree.

Thanks,
Ming Lei
