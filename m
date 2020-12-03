Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6896 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLCI75 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 03:59:57 -0500
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 3/5] block: remove the request_queue argument to the
 block_split tracepoint
Date: Thu, 3 Dec 2020 08:59:11 +0000
Message-ID: <CH2PR04MB6522398D22B2B461B4037CDDE7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-4-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 2020/12/01 3:09, Christoph Hellwig wrote:=0A=
> The request_queue can trivially be derived from the bio.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-merge.c            |  2 +-=0A=
>  drivers/md/dm.c              |  2 +-=0A=
>  include/trace/events/block.h | 14 ++++++--------=0A=
>  kernel/trace/blktrace.c      |  5 ++---=0A=
>  4 files changed, 10 insertions(+), 13 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index 1a46d5bbd399e3..4071daa88a5eaf 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -338,7 +338,7 @@ void __blk_queue_split(struct bio **bio, unsigned int=
 *nr_segs)=0A=
>  		split->bi_opf |=3D REQ_NOMERGE;=0A=
>  =0A=
>  		bio_chain(split, *bio);=0A=
> -		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);=0A=
> +		trace_block_split(split, (*bio)->bi_iter.bi_sector);=0A=
>  		submit_bio_noacct(*bio);=0A=
>  		*bio =3D split;=0A=
>  	}=0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index ed7e836efbcdbc..9a5bd90779c7c4 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -1612,7 +1612,7 @@ static blk_qc_t __split_and_process_bio(struct mapp=
ed_device *md,=0A=
>  				part_stat_unlock();=0A=
>  =0A=
>  				bio_chain(b, bio);=0A=
> -				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);=0A=
> +				trace_block_split(b, bio->bi_iter.bi_sector);=0A=
>  				ret =3D submit_bio_noacct(bio);=0A=
>  				break;=0A=
>  			}=0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 506c29dc7c76fd..b415e4cba84304 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -411,21 +411,19 @@ DEFINE_EVENT(block_unplug, block_unplug,=0A=
>  =0A=
>  /**=0A=
>   * block_split - split a single bio struct into two bio structs=0A=
> - * @q: queue containing the bio=0A=
>   * @bio: block operation being split=0A=
>   * @new_sector: The starting sector for the new bio=0A=
>   *=0A=
> - * The bio request @bio in request queue @q needs to be split into two=
=0A=
> - * bio requests. The newly created @bio request starts at=0A=
> - * @new_sector. This split may be required due to hardware limitation=0A=
> - * such as operation crossing device boundaries in a RAID system.=0A=
> + * The bio request @bio needs to be split into two bio requests.  The ne=
wly=0A=
> + * created @bio request starts at @new_sector. This split may be require=
d due to=0A=
> + * hardware limitations such as operation crossing device boundaries in =
a RAID=0A=
> + * system.=0A=
>   */=0A=
>  TRACE_EVENT(block_split,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio,=0A=
> -		 unsigned int new_sector),=0A=
> +	TP_PROTO(struct bio *bio, unsigned int new_sector),=0A=
>  =0A=
> -	TP_ARGS(q, bio, new_sector),=0A=
> +	TP_ARGS(bio, new_sector),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field( dev_t,		dev				)=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 7ab88e00c15765..3ca6d62114f461 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -970,10 +970,9 @@ static void blk_add_trace_unplug(void *ignore, struc=
t request_queue *q,=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_split(void *ignore,=0A=
> -				struct request_queue *q, struct bio *bio,=0A=
> -				unsigned int pdu)=0A=
> +static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned =
int pdu)=0A=
>  {=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
>  	struct blk_trace *bt;=0A=
>  =0A=
>  	rcu_read_lock();=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
