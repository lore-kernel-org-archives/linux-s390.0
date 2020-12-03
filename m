Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6760 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgLCI5j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 03:57:39 -0500
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [dm-devel] [PATCH 2/5] block: simplify and extended the
 block_bio_merge tracepoint class
Date: Thu, 3 Dec 2020 08:56:29 +0000
Message-ID: <CH2PR04MB652293C0177F0CDFE68F44EDE7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

In the patch title:=0A=
=0A=
s/extended/extend=0A=
=0A=
On 2020/12/01 3:06, Christoph Hellwig wrote:=0A=
> The block_bio_merge tracepoint class can be reused for most bio-based=0A=
> tracepoints.  For that is just needs to lose the superflous and rq=0A=
=0A=
s/is/it=0A=
s/superflous/superfluous=0A=
=0A=
> parameters.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-core.c             |   2 +-=0A=
>  block/blk-merge.c            |   4 +-=0A=
>  block/blk-mq.c               |   2 +-=0A=
>  block/bounce.c               |   2 +-=0A=
>  include/trace/events/block.h | 158 ++++++++---------------------------=
=0A=
>  kernel/trace/blktrace.c      |  41 +++------=0A=
>  6 files changed, 48 insertions(+), 161 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index cee568389b7e11..cb24654983e1e4 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -907,7 +907,7 @@ static noinline_for_stack bool submit_bio_checks(stru=
ct bio *bio)=0A=
>  	blkcg_bio_issue_init(bio);=0A=
>  =0A=
>  	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {=0A=
> -		trace_block_bio_queue(q, bio);=0A=
> +		trace_block_bio_queue(bio);=0A=
>  		/* Now that enqueuing has been traced, we need to trace=0A=
>  		 * completion as well.=0A=
>  		 */=0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index cb351ab9b77dbd..1a46d5bbd399e3 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -922,7 +922,7 @@ static enum bio_merge_status bio_attempt_back_merge(s=
truct request *req,=0A=
>  	if (!ll_back_merge_fn(req, bio, nr_segs))=0A=
>  		return BIO_MERGE_FAILED;=0A=
>  =0A=
> -	trace_block_bio_backmerge(req->q, req, bio);=0A=
> +	trace_block_bio_backmerge(bio);=0A=
>  	rq_qos_merge(req->q, req, bio);=0A=
>  =0A=
>  	if ((req->cmd_flags & REQ_FAILFAST_MASK) !=3D ff)=0A=
> @@ -946,7 +946,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,=0A=
>  	if (!ll_front_merge_fn(req, bio, nr_segs))=0A=
>  		return BIO_MERGE_FAILED;=0A=
>  =0A=
> -	trace_block_bio_frontmerge(req->q, req, bio);=0A=
> +	trace_block_bio_frontmerge(bio);=0A=
>  	rq_qos_merge(req->q, req, bio);=0A=
>  =0A=
>  	if ((req->cmd_flags & REQ_FAILFAST_MASK) !=3D ff)=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index a2593748fa5342..13636458f32f1c 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2183,7 +2183,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)=0A=
>  		goto queue_exit;=0A=
>  	}=0A=
>  =0A=
> -	trace_block_getrq(q, bio, bio->bi_opf);=0A=
> +	trace_block_getrq(bio);=0A=
>  =0A=
>  	rq_qos_track(q, rq, bio);=0A=
>  =0A=
> diff --git a/block/bounce.c b/block/bounce.c=0A=
> index 162a6eee89996a..d3f51acd6e3b51 100644=0A=
> --- a/block/bounce.c=0A=
> +++ b/block/bounce.c=0A=
> @@ -340,7 +340,7 @@ static void __blk_queue_bounce(struct request_queue *=
q, struct bio **bio_orig,=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> -	trace_block_bio_bounce(q, *bio_orig);=0A=
> +	trace_block_bio_bounce(*bio_orig);=0A=
>  =0A=
>  	bio->bi_flags |=3D (1 << BIO_BOUNCED);=0A=
>  =0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 76459cf750e14d..506c29dc7c76fd 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -226,45 +226,6 @@ DEFINE_EVENT(block_rq, block_rq_merge,=0A=
>  	TP_ARGS(q, rq)=0A=
>  );=0A=
>  =0A=
> -/**=0A=
> - * block_bio_bounce - used bounce buffer when processing block operation=
=0A=
> - * @q: queue holding the block operation=0A=
> - * @bio: block operation=0A=
> - *=0A=
> - * A bounce buffer was used to handle the block operation @bio in @q.=0A=
> - * This occurs when hardware limitations prevent a direct transfer of=0A=
> - * data between the @bio data memory area and the IO device.  Use of a=
=0A=
> - * bounce buffer requires extra copying of data and decreases=0A=
> - * performance.=0A=
> - */=0A=
> -TRACE_EVENT(block_bio_bounce,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio),=0A=
> -=0A=
> -	TP_ARGS(q, bio),=0A=
> -=0A=
> -	TP_STRUCT__entry(=0A=
> -		__field( dev_t,		dev			)=0A=
> -		__field( sector_t,	sector			)=0A=
> -		__field( unsigned int,	nr_sector		)=0A=
> -		__array( char,		rwbs,	RWBS_LEN	)=0A=
> -		__array( char,		comm,	TASK_COMM_LEN	)=0A=
> -	),=0A=
> -=0A=
> -	TP_fast_assign(=0A=
> -		__entry->dev		=3D bio_dev(bio);=0A=
> -		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
> -		__entry->nr_sector	=3D bio_sectors(bio);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> -		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
> -	),=0A=
> -=0A=
> -	TP_printk("%d,%d %s %llu + %u [%s]",=0A=
> -		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,=0A=
> -		  (unsigned long long)__entry->sector,=0A=
> -		  __entry->nr_sector, __entry->comm)=0A=
> -);=0A=
> -=0A=
>  /**=0A=
>   * block_bio_complete - completed all work on the block operation=0A=
>   * @q: queue holding the block operation=0A=
> @@ -301,11 +262,11 @@ TRACE_EVENT(block_bio_complete,=0A=
>  		  __entry->nr_sector, __entry->error)=0A=
>  );=0A=
>  =0A=
> -DECLARE_EVENT_CLASS(block_bio_merge,=0A=
> +DECLARE_EVENT_CLASS(block_bio,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq, struct bio *bio),=
=0A=
> +	TP_PROTO(struct bio *bio),=0A=
>  =0A=
> -	TP_ARGS(q, rq, bio),=0A=
> +	TP_ARGS(bio),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field( dev_t,		dev			)=0A=
> @@ -329,116 +290,63 @@ DECLARE_EVENT_CLASS(block_bio_merge,=0A=
>  		  __entry->nr_sector, __entry->comm)=0A=
>  );=0A=
>  =0A=
> +/**=0A=
> + * block_bio_bounce - used bounce buffer when processing block operation=
=0A=
> + * @bio: block operation=0A=
> + *=0A=
> + * A bounce buffer was used to handle the block operation @bio in @q.=0A=
> + * This occurs when hardware limitations prevent a direct transfer of=0A=
> + * data between the @bio data memory area and the IO device.  Use of a=
=0A=
> + * bounce buffer requires extra copying of data and decreases=0A=
> + * performance.=0A=
> + */=0A=
> +DEFINE_EVENT(block_bio, block_bio_bounce,=0A=
> +	TP_PROTO(struct bio *bio),=0A=
> +	TP_ARGS(bio)=0A=
> +);=0A=
> +=0A=
>  /**=0A=
>   * block_bio_backmerge - merging block operation to the end of an existi=
ng operation=0A=
> - * @q: queue holding operation=0A=
> - * @rq: request bio is being merged into=0A=
>   * @bio: new block operation to merge=0A=
>   *=0A=
> - * Merging block request @bio to the end of an existing block request=0A=
> - * in queue @q.=0A=
> + * Merging block request @bio to the end of an existing block request.=
=0A=
>   */=0A=
> -DEFINE_EVENT(block_bio_merge, block_bio_backmerge,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq, struct bio *bio),=
=0A=
> -=0A=
> -	TP_ARGS(q, rq, bio)=0A=
> +DEFINE_EVENT(block_bio, block_bio_backmerge,=0A=
> +	TP_PROTO(struct bio *bio),=0A=
> +	TP_ARGS(bio)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
>   * block_bio_frontmerge - merging block operation to the beginning of an=
 existing operation=0A=
> - * @q: queue holding operation=0A=
> - * @rq: request bio is being merged into=0A=
>   * @bio: new block operation to merge=0A=
>   *=0A=
> - * Merging block IO operation @bio to the beginning of an existing block=
=0A=
> - * operation in queue @q.=0A=
> + * Merging block IO operation @bio to the beginning of an existing block=
 request.=0A=
>   */=0A=
> -DEFINE_EVENT(block_bio_merge, block_bio_frontmerge,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq, struct bio *bio),=
=0A=
> -=0A=
> -	TP_ARGS(q, rq, bio)=0A=
> +DEFINE_EVENT(block_bio, block_bio_frontmerge,=0A=
> +	TP_PROTO(struct bio *bio),=0A=
> +	TP_ARGS(bio)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
>   * block_bio_queue - putting new block IO operation in queue=0A=
> - * @q: queue holding operation=0A=
>   * @bio: new block operation=0A=
>   *=0A=
>   * About to place the block IO operation @bio into queue @q.=0A=
>   */=0A=
> -TRACE_EVENT(block_bio_queue,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio),=0A=
> -=0A=
> -	TP_ARGS(q, bio),=0A=
> -=0A=
> -	TP_STRUCT__entry(=0A=
> -		__field( dev_t,		dev			)=0A=
> -		__field( sector_t,	sector			)=0A=
> -		__field( unsigned int,	nr_sector		)=0A=
> -		__array( char,		rwbs,	RWBS_LEN	)=0A=
> -		__array( char,		comm,	TASK_COMM_LEN	)=0A=
> -	),=0A=
> -=0A=
> -	TP_fast_assign(=0A=
> -		__entry->dev		=3D bio_dev(bio);=0A=
> -		__entry->sector		=3D bio->bi_iter.bi_sector;=0A=
> -		__entry->nr_sector	=3D bio_sectors(bio);=0A=
> -		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);=0A=
> -		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
> -	),=0A=
> -=0A=
> -	TP_printk("%d,%d %s %llu + %u [%s]",=0A=
> -		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,=0A=
> -		  (unsigned long long)__entry->sector,=0A=
> -		  __entry->nr_sector, __entry->comm)=0A=
> -);=0A=
> -=0A=
> -DECLARE_EVENT_CLASS(block_get_rq,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio, int rw),=0A=
> -=0A=
> -	TP_ARGS(q, bio, rw),=0A=
> -=0A=
> -	TP_STRUCT__entry(=0A=
> -		__field( dev_t,		dev			)=0A=
> -		__field( sector_t,	sector			)=0A=
> -		__field( unsigned int,	nr_sector		)=0A=
> -		__array( char,		rwbs,	RWBS_LEN	)=0A=
> -		__array( char,		comm,	TASK_COMM_LEN	)=0A=
> -        ),=0A=
> -=0A=
> -	TP_fast_assign(=0A=
> -		__entry->dev		=3D bio ? bio_dev(bio) : 0;=0A=
> -		__entry->sector		=3D bio ? bio->bi_iter.bi_sector : 0;=0A=
> -		__entry->nr_sector	=3D bio ? bio_sectors(bio) : 0;=0A=
> -		blk_fill_rwbs(__entry->rwbs,=0A=
> -			      bio ? bio->bi_opf : 0, __entry->nr_sector);=0A=
> -		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);=0A=
> -        ),=0A=
> -=0A=
> -	TP_printk("%d,%d %s %llu + %u [%s]",=0A=
> -		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,=0A=
> -		  (unsigned long long)__entry->sector,=0A=
> -		  __entry->nr_sector, __entry->comm)=0A=
> +DEFINE_EVENT(block_bio, block_bio_queue,=0A=
> +	TP_PROTO(struct bio *bio),=0A=
> +	TP_ARGS(bio)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
>   * block_getrq - get a free request entry in queue for block IO operatio=
ns=0A=
> - * @q: queue for operations=0A=
>   * @bio: pending block IO operation (can be %NULL)=0A=
> - * @rw: low bit indicates a read (%0) or a write (%1)=0A=
>   *=0A=
> - * A request struct for queue @q has been allocated to handle the=0A=
> - * block IO operation @bio.=0A=
> + * A request struct has been allocated to handle the block IO operation =
@bio.=0A=
>   */=0A=
> -DEFINE_EVENT(block_get_rq, block_getrq,=0A=
> -=0A=
> -	TP_PROTO(struct request_queue *q, struct bio *bio, int rw),=0A=
> -=0A=
> -	TP_ARGS(q, bio, rw)=0A=
> +DEFINE_EVENT(block_bio, block_getrq,=0A=
> +	TP_PROTO(struct bio *bio),=0A=
> +	TP_ARGS(bio)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index ced589df304b57..7ab88e00c15765 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -906,10 +906,9 @@ static void blk_add_trace_bio(struct request_queue *=
q, struct bio *bio,=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_bio_bounce(void *ignore,=0A=
> -				     struct request_queue *q, struct bio *bio)=0A=
> +static void blk_add_trace_bio_bounce(void *ignore, struct bio *bio)=0A=
>  {=0A=
> -	blk_add_trace_bio(q, bio, BLK_TA_BOUNCE, 0);=0A=
> +	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_BOUNCE, 0);=0A=
>  }=0A=
>  =0A=
>  static void blk_add_trace_bio_complete(void *ignore,=0A=
> @@ -919,44 +918,24 @@ static void blk_add_trace_bio_complete(void *ignore=
,=0A=
>  			  blk_status_to_errno(bio->bi_status));=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_bio_backmerge(void *ignore,=0A=
> -					struct request_queue *q,=0A=
> -					struct request *rq,=0A=
> -					struct bio *bio)=0A=
> +static void blk_add_trace_bio_backmerge(void *ignore, struct bio *bio)=
=0A=
>  {=0A=
> -	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE, 0);=0A=
> +	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_BACKMERGE, 0);=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_bio_frontmerge(void *ignore,=0A=
> -					 struct request_queue *q,=0A=
> -					 struct request *rq,=0A=
> -					 struct bio *bio)=0A=
> +static void blk_add_trace_bio_frontmerge(void *ignore, struct bio *bio)=
=0A=
>  {=0A=
> -	blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE, 0);=0A=
> +	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_FRONTMERGE, 0);=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_bio_queue(void *ignore,=0A=
> -				    struct request_queue *q, struct bio *bio)=0A=
> +static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)=0A=
>  {=0A=
> -	blk_add_trace_bio(q, bio, BLK_TA_QUEUE, 0);=0A=
> +	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_QUEUE, 0);=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_getrq(void *ignore,=0A=
> -				struct request_queue *q,=0A=
> -				struct bio *bio, int rw)=0A=
> +static void blk_add_trace_getrq(void *ignore, struct bio *bio)=0A=
>  {=0A=
> -	if (bio)=0A=
> -		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);=0A=
> -	else {=0A=
> -		struct blk_trace *bt;=0A=
> -=0A=
> -		rcu_read_lock();=0A=
> -		bt =3D rcu_dereference(q->blk_trace);=0A=
> -		if (bt)=0A=
> -			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,=0A=
> -					NULL, 0);=0A=
> -		rcu_read_unlock();=0A=
> -	}=0A=
> +	blk_add_trace_bio(bio->bi_disk->queue, bio, BLK_TA_GETRQ, 0);=0A=
>  }=0A=
>  =0A=
>  static void blk_add_trace_plug(void *ignore, struct request_queue *q)=0A=
> =0A=
=0A=
With the commit message fixed, looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
