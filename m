Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41378 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLCJEI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 04:04:08 -0500
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [dm-devel] [PATCH 4/5] block: remove the request_queue argument
 to the block_bio_remap tracepoint
Date: Thu, 3 Dec 2020 09:02:58 +0000
Message-ID: <CH2PR04MB65229B3EE2DBB2BDD215EEA9E7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-5-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 2020/12/01 3:09, Christoph Hellwig wrote:=0A=
> The request_queue can trivially be derived from the bio.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-core.c              |  2 +-=0A=
>  drivers/md/dm.c               |  3 +--=0A=
>  drivers/md/md-linear.c        |  3 +--=0A=
>  drivers/md/md.c               |  5 ++---=0A=
>  drivers/md/raid0.c            |  4 ++--=0A=
>  drivers/md/raid1.c            |  7 +++----=0A=
>  drivers/md/raid10.c           |  6 ++----=0A=
>  drivers/md/raid5.c            | 15 +++++++--------=0A=
>  drivers/nvme/host/multipath.c |  3 +--=0A=
>  include/trace/events/block.h  |  8 +++-----=0A=
>  kernel/trace/blktrace.c       | 14 +++++---------=0A=
>  11 files changed, 28 insertions(+), 42 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index cb24654983e1e4..96e5fcd7f071b6 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -758,7 +758,7 @@ static inline int blk_partition_remap(struct bio *bio=
)=0A=
>  		if (bio_check_eod(bio, bdev_nr_sectors(p)))=0A=
>  			goto out;=0A=
>  		bio->bi_iter.bi_sector +=3D p->bd_start_sect;=0A=
> -		trace_block_bio_remap(bio->bi_disk->queue, bio, p->bd_dev,=0A=
> +		trace_block_bio_remap(bio, p->bd_dev,=0A=
>  				      bio->bi_iter.bi_sector -=0A=
>  				      p->bd_start_sect);=0A=
>  	}=0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 9a5bd90779c7c4..5181907dc59537 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -1276,8 +1276,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)=
=0A=
>  		break;=0A=
>  	case DM_MAPIO_REMAPPED:=0A=
>  		/* the bio has been remapped so dispatch it */=0A=
> -		trace_block_bio_remap(clone->bi_disk->queue, clone,=0A=
> -				      bio_dev(io->orig_bio), sector);=0A=
> +		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);=0A=
>  		ret =3D submit_bio_noacct(clone);=0A=
>  		break;=0A=
>  	case DM_MAPIO_KILL:=0A=
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c=0A=
> index 98f1b4b2bdcef8..68cac7d1927823 100644=0A=
> --- a/drivers/md/md-linear.c=0A=
> +++ b/drivers/md/md-linear.c=0A=
> @@ -257,8 +257,7 @@ static bool linear_make_request(struct mddev *mddev, =
struct bio *bio)=0A=
>  		bio_endio(bio);=0A=
>  	} else {=0A=
>  		if (mddev->gendisk)=0A=
> -			trace_block_bio_remap(bio->bi_disk->queue,=0A=
> -					      bio, disk_devt(mddev->gendisk),=0A=
> +			trace_block_bio_remap(bio, disk_devt(mddev->gendisk),=0A=
>  					      bio_sector);=0A=
>  		mddev_check_writesame(mddev, bio);=0A=
>  		mddev_check_write_zeroes(mddev, bio);=0A=
> diff --git a/drivers/md/md.c b/drivers/md/md.c=0A=
> index 0065736f05b428..c555be0a8dce78 100644=0A=
> --- a/drivers/md/md.c=0A=
> +++ b/drivers/md/md.c=0A=
> @@ -8591,9 +8591,8 @@ void md_submit_discard_bio(struct mddev *mddev, str=
uct md_rdev *rdev,=0A=
>  	bio_chain(discard_bio, bio);=0A=
>  	bio_clone_blkg_association(discard_bio, bio);=0A=
>  	if (mddev->gendisk)=0A=
> -		trace_block_bio_remap(bdev_get_queue(rdev->bdev),=0A=
> -			discard_bio, disk_devt(mddev->gendisk),=0A=
> -			bio->bi_iter.bi_sector);=0A=
> +		trace_block_bio_remap(discard_bio, disk_devt(mddev->gendisk),=0A=
> +				      bio->bi_iter.bi_sector);=0A=
>  	submit_bio_noacct(discard_bio);=0A=
>  }=0A=
>  EXPORT_SYMBOL(md_submit_discard_bio);=0A=
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c=0A=
> index 6f44177593a552..e5d7411cba9b46 100644=0A=
> --- a/drivers/md/raid0.c=0A=
> +++ b/drivers/md/raid0.c=0A=
> @@ -571,8 +571,8 @@ static bool raid0_make_request(struct mddev *mddev, s=
truct bio *bio)=0A=
>  		tmp_dev->data_offset;=0A=
>  =0A=
>  	if (mddev->gendisk)=0A=
> -		trace_block_bio_remap(bio->bi_disk->queue, bio,=0A=
> -				disk_devt(mddev->gendisk), bio_sector);=0A=
> +		trace_block_bio_remap(bio, disk_devt(mddev->gendisk),=0A=
> +				      bio_sector);=0A=
>  	mddev_check_writesame(mddev, bio);=0A=
>  	mddev_check_write_zeroes(mddev, bio);=0A=
>  	submit_bio_noacct(bio);=0A=
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c=0A=
> index 960d854c07f897..c0347997f6ff73 100644=0A=
> --- a/drivers/md/raid1.c=0A=
> +++ b/drivers/md/raid1.c=0A=
> @@ -1305,8 +1305,8 @@ static void raid1_read_request(struct mddev *mddev,=
 struct bio *bio,=0A=
>  	read_bio->bi_private =3D r1_bio;=0A=
>  =0A=
>  	if (mddev->gendisk)=0A=
> -	        trace_block_bio_remap(read_bio->bi_disk->queue, read_bio,=0A=
> -				disk_devt(mddev->gendisk), r1_bio->sector);=0A=
> +	        trace_block_bio_remap(read_bio, disk_devt(mddev->gendisk),=0A=
> +				      r1_bio->sector);=0A=
>  =0A=
>  	submit_bio_noacct(read_bio);=0A=
>  }=0A=
> @@ -1517,8 +1517,7 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,=0A=
>  		atomic_inc(&r1_bio->remaining);=0A=
>  =0A=
>  		if (mddev->gendisk)=0A=
> -			trace_block_bio_remap(mbio->bi_disk->queue,=0A=
> -					      mbio, disk_devt(mddev->gendisk),=0A=
> +			trace_block_bio_remap(mbio, disk_devt(mddev->gendisk),=0A=
>  					      r1_bio->sector);=0A=
>  		/* flush_pending_writes() needs access to the rdev so...*/=0A=
>  		mbio->bi_disk =3D (void *)conf->mirrors[i].rdev;=0A=
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c=0A=
> index b7bca6703df814..a6f99fa0b32cfc 100644=0A=
> --- a/drivers/md/raid10.c=0A=
> +++ b/drivers/md/raid10.c=0A=
> @@ -1200,8 +1200,7 @@ static void raid10_read_request(struct mddev *mddev=
, struct bio *bio,=0A=
>  	read_bio->bi_private =3D r10_bio;=0A=
>  =0A=
>  	if (mddev->gendisk)=0A=
> -	        trace_block_bio_remap(read_bio->bi_disk->queue,=0A=
> -	                              read_bio, disk_devt(mddev->gendisk),=0A=
> +	        trace_block_bio_remap(read_bio, disk_devt(mddev->gendisk),=0A=
>  	                              r10_bio->sector);=0A=
>  	submit_bio_noacct(read_bio);=0A=
>  	return;=0A=
> @@ -1250,8 +1249,7 @@ static void raid10_write_one_disk(struct mddev *mdd=
ev, struct r10bio *r10_bio,=0A=
>  	mbio->bi_private =3D r10_bio;=0A=
>  =0A=
>  	if (conf->mddev->gendisk)=0A=
> -		trace_block_bio_remap(mbio->bi_disk->queue,=0A=
> -				      mbio, disk_devt(conf->mddev->gendisk),=0A=
> +		trace_block_bio_remap(mbio, disk_devt(conf->mddev->gendisk),=0A=
>  				      r10_bio->sector);=0A=
>  	/* flush_pending_writes() needs access to the rdev so...*/=0A=
>  	mbio->bi_disk =3D (void *)rdev;=0A=
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c=0A=
> index 39343479ac2a94..3a90cc0e43ca8e 100644=0A=
> --- a/drivers/md/raid5.c=0A=
> +++ b/drivers/md/raid5.c=0A=
> @@ -1222,9 +1222,9 @@ static void ops_run_io(struct stripe_head *sh, stru=
ct stripe_head_state *s)=0A=
>  				set_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags);=0A=
>  =0A=
>  			if (conf->mddev->gendisk)=0A=
> -				trace_block_bio_remap(bi->bi_disk->queue,=0A=
> -						      bi, disk_devt(conf->mddev->gendisk),=0A=
> -						      sh->dev[i].sector);=0A=
> +				trace_block_bio_remap(bi,=0A=
> +						disk_devt(conf->mddev->gendisk),=0A=
> +						sh->dev[i].sector);=0A=
>  			if (should_defer && op_is_write(op))=0A=
>  				bio_list_add(&pending_bios, bi);=0A=
>  			else=0A=
> @@ -1272,9 +1272,9 @@ static void ops_run_io(struct stripe_head *sh, stru=
ct stripe_head_state *s)=0A=
>  			if (op =3D=3D REQ_OP_DISCARD)=0A=
>  				rbi->bi_vcnt =3D 0;=0A=
>  			if (conf->mddev->gendisk)=0A=
> -				trace_block_bio_remap(rbi->bi_disk->queue,=0A=
> -						      rbi, disk_devt(conf->mddev->gendisk),=0A=
> -						      sh->dev[i].sector);=0A=
> +				trace_block_bio_remap(rbi,=0A=
> +						disk_devt(conf->mddev->gendisk),=0A=
> +						sh->dev[i].sector);=0A=
>  			if (should_defer && op_is_write(op))=0A=
>  				bio_list_add(&pending_bios, rbi);=0A=
>  			else=0A=
> @@ -5468,8 +5468,7 @@ static int raid5_read_one_chunk(struct mddev *mddev=
, struct bio *raid_bio)=0A=
>  		spin_unlock_irq(&conf->device_lock);=0A=
>  =0A=
>  		if (mddev->gendisk)=0A=
> -			trace_block_bio_remap(align_bi->bi_disk->queue,=0A=
> -					      align_bi, disk_devt(mddev->gendisk),=0A=
> +			trace_block_bio_remap(align_bi, disk_devt(mddev->gendisk),=0A=
>  					      raid_bio->bi_iter.bi_sector);=0A=
>  		submit_bio_noacct(align_bi);=0A=
>  		return 1;=0A=
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c=0A=
> index 74896be40c1769..106cf5c44ee7ab 100644=0A=
> --- a/drivers/nvme/host/multipath.c=0A=
> +++ b/drivers/nvme/host/multipath.c=0A=
> @@ -312,8 +312,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)=0A=
>  	if (likely(ns)) {=0A=
>  		bio->bi_disk =3D ns->disk;=0A=
>  		bio->bi_opf |=3D REQ_NVME_MPATH;=0A=
> -		trace_block_bio_remap(bio->bi_disk->queue, bio,=0A=
> -				      disk_devt(ns->head->disk),=0A=
> +		trace_block_bio_remap(bio, disk_devt(ns->head->disk),=0A=
>  				      bio->bi_iter.bi_sector);=0A=
>  		ret =3D submit_bio_noacct(bio);=0A=
>  	} else if (nvme_available_path(head)) {=0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index b415e4cba84304..8fb89574d8677f 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -450,9 +450,8 @@ TRACE_EVENT(block_split,=0A=
>  =0A=
>  /**=0A=
>   * block_bio_remap - map request for a logical device to the raw device=
=0A=
> - * @q: queue holding the operation=0A=
>   * @bio: revised operation=0A=
> - * @dev: device for the operation=0A=
> + * @dev: original device for the operation=0A=
>   * @from: original sector for the operation=0A=
>   *=0A=
>   * An operation for a logical device has been mapped to the=0A=
> @@ -460,10 +459,9 @@ TRACE_EVENT(block_split,=0A=
>   */=0A=
>  TRACE_EVENT(block_bio_remap,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,=0A=
> -		 sector_t from),=0A=
> +	TP_PROTO(struct bio *bio, dev_t dev, sector_t from),=0A=
>  =0A=
> -	TP_ARGS(q, bio, dev, from),=0A=
> +	TP_ARGS(bio, dev, from),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field( dev_t,		dev		)=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 3ca6d62114f461..405637144a0389 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -993,20 +993,16 @@ static void blk_add_trace_split(void *ignore, struc=
t bio *bio, unsigned int pdu)=0A=
>  /**=0A=
>   * blk_add_trace_bio_remap - Add a trace for a bio-remap operation=0A=
>   * @ignore:	trace callback data parameter (not used)=0A=
> - * @q:		queue the io is for=0A=
>   * @bio:	the source bio=0A=
> - * @dev:	target device=0A=
> + * @dev:	source device=0A=
>   * @from:	source sector=0A=
>   *=0A=
> - * Description:=0A=
> - *     Device mapper or raid target sometimes need to split a bio becaus=
e=0A=
> - *     it spans a stripe (or similar). Add a trace for that action.=0A=
> - *=0A=
> + * Called after a bio is remapped to a different device and/or sector.=
=0A=
>   **/=0A=
> -static void blk_add_trace_bio_remap(void *ignore,=0A=
> -				    struct request_queue *q, struct bio *bio,=0A=
> -				    dev_t dev, sector_t from)=0A=
> +static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t=
 dev,=0A=
> +				    sector_t from)=0A=
>  {=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
>  	struct blk_trace *bt;=0A=
>  	struct blk_io_trace_remap r;=0A=
>  =0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
