Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50064 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgLCIr6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 03:47:58 -0500
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [dm-devel] [PATCH 1/5] block: remove the unused block_sleeprq
 tracepoint
Date: Thu, 3 Dec 2020 08:46:51 +0000
Message-ID: <CH2PR04MB652225D9AF153543AE4DF758E7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 2020/12/01 3:03, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Even if it is just repeating the patch title, a commit message would be nic=
e.=0A=
You could also mention when the last use of this tracepoint was removed.=0A=
=0A=
> ---=0A=
>  include/trace/events/block.h | 18 ------------------=0A=
>  kernel/trace/blktrace.c      | 22 ----------------------=0A=
>  2 files changed, 40 deletions(-)=0A=
> =0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 34d64ca306b1c7..76459cf750e14d 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -441,24 +441,6 @@ DEFINE_EVENT(block_get_rq, block_getrq,=0A=
>  	TP_ARGS(q, bio, rw)=0A=
>  );=0A=
>  =0A=
> -/**=0A=
> - * block_sleeprq - waiting to get a free request entry in queue for bloc=
k IO operation=0A=
> - * @q: queue for operation=0A=
> - * @bio: pending block IO operation (can be %NULL)=0A=
> - * @rw: low bit indicates a read (%0) or a write (%1)=0A=
> - *=0A=
> - * In the case where a request struct cannot be provided for queue @q=0A=
> - * the process needs to wait for an request struct to become=0A=
> - * available.  This tracepoint event is generated each time the=0A=
> - * process goes to sleep waiting for request struct become available.=0A=
> - */=0A=
> -DEFINE_EVENT(block_get_rq, block_sleeprq,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio, int rw),=0A=
> -=0A=
> -	TP_ARGS(q, bio, rw)=0A=
> -);=0A=
> -=0A=
>  /**=0A=
>   * block_plug - keep operations requests in request queue=0A=
>   * @q: request queue to plug=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index a482a37848bff7..ced589df304b57 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -959,25 +959,6 @@ static void blk_add_trace_getrq(void *ignore,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> -=0A=
> -static void blk_add_trace_sleeprq(void *ignore,=0A=
> -				  struct request_queue *q,=0A=
> -				  struct bio *bio, int rw)=0A=
> -{=0A=
> -	if (bio)=0A=
> -		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);=0A=
> -	else {=0A=
> -		struct blk_trace *bt;=0A=
> -=0A=
> -		rcu_read_lock();=0A=
> -		bt =3D rcu_dereference(q->blk_trace);=0A=
> -		if (bt)=0A=
> -			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,=0A=
> -					0, 0, NULL, 0);=0A=
> -		rcu_read_unlock();=0A=
> -	}=0A=
> -}=0A=
> -=0A=
>  static void blk_add_trace_plug(void *ignore, struct request_queue *q)=0A=
>  {=0A=
>  	struct blk_trace *bt;=0A=
> @@ -1164,8 +1145,6 @@ static void blk_register_tracepoints(void)=0A=
>  	WARN_ON(ret);=0A=
>  	ret =3D register_trace_block_getrq(blk_add_trace_getrq, NULL);=0A=
>  	WARN_ON(ret);=0A=
> -	ret =3D register_trace_block_sleeprq(blk_add_trace_sleeprq, NULL);=0A=
> -	WARN_ON(ret);=0A=
>  	ret =3D register_trace_block_plug(blk_add_trace_plug, NULL);=0A=
>  	WARN_ON(ret);=0A=
>  	ret =3D register_trace_block_unplug(blk_add_trace_unplug, NULL);=0A=
> @@ -1185,7 +1164,6 @@ static void blk_unregister_tracepoints(void)=0A=
>  	unregister_trace_block_split(blk_add_trace_split, NULL);=0A=
>  	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);=0A=
>  	unregister_trace_block_plug(blk_add_trace_plug, NULL);=0A=
> -	unregister_trace_block_sleeprq(blk_add_trace_sleeprq, NULL);=0A=
>  	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);=0A=
>  	unregister_trace_block_bio_queue(blk_add_trace_bio_queue, NULL);=0A=
>  	unregister_trace_block_bio_frontmerge(blk_add_trace_bio_frontmerge, NUL=
L);=0A=
> =0A=
=0A=
Otherwise, looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
