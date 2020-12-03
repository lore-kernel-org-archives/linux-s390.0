Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28815 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgLCJHT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 04:07:19 -0500
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [dm-devel] [PATCH 5/5] block: remove the request_queue to
 argument request based tracepoints
Date: Thu, 3 Dec 2020 09:06:11 +0000
Message-ID: <CH2PR04MB6522A9E5DC906CB816CA6150E7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-6-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 2020/12/01 3:11, Christoph Hellwig wrote:=0A=
> The request_queue can trivially be derived from the request.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-merge.c            |  2 +-=0A=
>  block/blk-mq-sched.c         |  2 +-=0A=
>  block/blk-mq.c               |  8 +++----=0A=
>  drivers/md/dm-rq.c           |  2 +-=0A=
>  drivers/s390/scsi/zfcp_fsf.c |  3 +--=0A=
>  include/linux/blktrace_api.h |  5 ++--=0A=
>  include/trace/events/block.h | 30 ++++++++++--------------=0A=
>  kernel/trace/blktrace.c      | 44 ++++++++++++++----------------------=
=0A=
>  8 files changed, 39 insertions(+), 57 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index 4071daa88a5eaf..7497d86fff3834 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -799,7 +799,7 @@ static struct request *attempt_merge(struct request_q=
ueue *q,=0A=
>  	 */=0A=
>  	blk_account_io_merge_request(next);=0A=
>  =0A=
> -	trace_block_rq_merge(q, next);=0A=
> +	trace_block_rq_merge(next);=0A=
>  =0A=
>  	/*=0A=
>  	 * ownership of bio passed from next to req, return 'next' for=0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index d1eafe2c045caa..deff4e826e234d 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);=0A=
>  =0A=
>  void blk_mq_sched_request_inserted(struct request *rq)=0A=
>  {=0A=
> -	trace_block_rq_insert(rq->q, rq);=0A=
> +	trace_block_rq_insert(rq);=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);=0A=
>  =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 13636458f32f1c..bb669b415a387e 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -732,7 +732,7 @@ void blk_mq_start_request(struct request *rq)=0A=
>  {=0A=
>  	struct request_queue *q =3D rq->q;=0A=
>  =0A=
> -	trace_block_rq_issue(q, rq);=0A=
> +	trace_block_rq_issue(rq);=0A=
>  =0A=
>  	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {=0A=
>  		rq->io_start_time_ns =3D ktime_get_ns();=0A=
> @@ -759,7 +759,7 @@ static void __blk_mq_requeue_request(struct request *=
rq)=0A=
>  =0A=
>  	blk_mq_put_driver_tag(rq);=0A=
>  =0A=
> -	trace_block_rq_requeue(q, rq);=0A=
> +	trace_block_rq_requeue(rq);=0A=
>  	rq_qos_requeue(q, rq);=0A=
>  =0A=
>  	if (blk_mq_request_started(rq)) {=0A=
> @@ -1820,7 +1820,7 @@ static inline void __blk_mq_insert_req_list(struct =
blk_mq_hw_ctx *hctx,=0A=
>  =0A=
>  	lockdep_assert_held(&ctx->lock);=0A=
>  =0A=
> -	trace_block_rq_insert(hctx->queue, rq);=0A=
> +	trace_block_rq_insert(rq);=0A=
>  =0A=
>  	if (at_head)=0A=
>  		list_add(&rq->queuelist, &ctx->rq_lists[type]);=0A=
> @@ -1877,7 +1877,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *h=
ctx, struct blk_mq_ctx *ctx,=0A=
>  	 */=0A=
>  	list_for_each_entry(rq, list, queuelist) {=0A=
>  		BUG_ON(rq->mq_ctx !=3D ctx);=0A=
> -		trace_block_rq_insert(hctx->queue, rq);=0A=
> +		trace_block_rq_insert(rq);=0A=
>  	}=0A=
>  =0A=
>  	spin_lock(&ctx->lock);=0A=
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c=0A=
> index 729a72ec30ccae..13b4385f4d5a92 100644=0A=
> --- a/drivers/md/dm-rq.c=0A=
> +++ b/drivers/md/dm-rq.c=0A=
> @@ -397,7 +397,7 @@ static int map_request(struct dm_rq_target_io *tio)=
=0A=
>  		}=0A=
>  =0A=
>  		/* The target has remapped the I/O so dispatch it */=0A=
> -		trace_block_rq_remap(clone->q, clone, disk_devt(dm_disk(md)),=0A=
> +		trace_block_rq_remap(clone, disk_devt(dm_disk(md)),=0A=
>  				     blk_rq_pos(rq));=0A=
>  		ret =3D dm_dispatch_clone_request(clone, rq);=0A=
>  		if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE) {=
=0A=
> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c=
=0A=
> index 6cb963a0677714..37d450f4695281 100644=0A=
> --- a/drivers/s390/scsi/zfcp_fsf.c=0A=
> +++ b/drivers/s390/scsi/zfcp_fsf.c=0A=
> @@ -2359,8 +2359,7 @@ static void zfcp_fsf_req_trace(struct zfcp_fsf_req =
*req, struct scsi_cmnd *scsi)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> -	blk_add_driver_data(scsi->request->q, scsi->request, &blktrc,=0A=
> -			    sizeof(blktrc));=0A=
> +	blk_add_driver_data(scsi->request, &blktrc, sizeof(blktrc));=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h=
=0A=
> index 3b6ff5902edce6..05556573b896a2 100644=0A=
> --- a/include/linux/blktrace_api.h=0A=
> +++ b/include/linux/blktrace_api.h=0A=
> @@ -75,8 +75,7 @@ static inline bool blk_trace_note_message_enabled(struc=
t request_queue *q)=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> -extern void blk_add_driver_data(struct request_queue *q, struct request =
*rq,=0A=
> -				void *data, size_t len);=0A=
> +extern void blk_add_driver_data(struct request *rq, void *data, size_t l=
en);=0A=
>  extern int blk_trace_setup(struct request_queue *q, char *name, dev_t de=
v,=0A=
>  			   struct block_device *bdev,=0A=
>  			   char __user *arg);=0A=
> @@ -90,7 +89,7 @@ extern struct attribute_group blk_trace_attr_group;=0A=
>  #else /* !CONFIG_BLK_DEV_IO_TRACE */=0A=
>  # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)=0A=
>  # define blk_trace_shutdown(q)				do { } while (0)=0A=
> -# define blk_add_driver_data(q, rq, data, len)		do {} while (0)=0A=
> +# define blk_add_driver_data(rq, data, len)		do {} while (0)=0A=
>  # define blk_trace_setup(q, name, dev, bdev, arg)	(-ENOTTY)=0A=
>  # define blk_trace_startstop(q, start)			(-ENOTTY)=0A=
>  # define blk_trace_remove(q)				(-ENOTTY)=0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 8fb89574d8677f..0d782663a005dc 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -64,7 +64,6 @@ DEFINE_EVENT(block_buffer, block_dirty_buffer,=0A=
>  =0A=
>  /**=0A=
>   * block_rq_requeue - place block IO request back on a queue=0A=
> - * @q: queue holding operation=0A=
>   * @rq: block IO operation request=0A=
>   *=0A=
>   * The block operation request @rq is being placed back into queue=0A=
> @@ -73,9 +72,9 @@ DEFINE_EVENT(block_buffer, block_dirty_buffer,=0A=
>   */=0A=
>  TRACE_EVENT(block_rq_requeue,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq),=0A=
> +	TP_PROTO(struct request *rq),=0A=
>  =0A=
> -	TP_ARGS(q, rq),=0A=
> +	TP_ARGS(rq),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field(  dev_t,	dev			)=0A=
> @@ -147,9 +146,9 @@ TRACE_EVENT(block_rq_complete,=0A=
>  =0A=
>  DECLARE_EVENT_CLASS(block_rq,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq),=0A=
> +	TP_PROTO(struct request *rq),=0A=
>  =0A=
> -	TP_ARGS(q, rq),=0A=
> +	TP_ARGS(rq),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field(  dev_t,	dev			)=0A=
> @@ -181,7 +180,6 @@ DECLARE_EVENT_CLASS(block_rq,=0A=
>  =0A=
>  /**=0A=
>   * block_rq_insert - insert block operation request into queue=0A=
> - * @q: target queue=0A=
>   * @rq: block IO operation request=0A=
>   *=0A=
>   * Called immediately before block operation request @rq is inserted=0A=
> @@ -191,14 +189,13 @@ DECLARE_EVENT_CLASS(block_rq,=0A=
>   */=0A=
>  DEFINE_EVENT(block_rq, block_rq_insert,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq),=0A=
> +	TP_PROTO(struct request *rq),=0A=
>  =0A=
> -	TP_ARGS(q, rq)=0A=
> +	TP_ARGS(rq)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
>   * block_rq_issue - issue pending block IO request operation to device d=
river=0A=
> - * @q: queue holding operation=0A=
>   * @rq: block IO operation operation request=0A=
>   *=0A=
>   * Called when block operation request @rq from queue @q is sent to a=0A=
> @@ -206,14 +203,13 @@ DEFINE_EVENT(block_rq, block_rq_insert,=0A=
>   */=0A=
>  DEFINE_EVENT(block_rq, block_rq_issue,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq),=0A=
> +	TP_PROTO(struct request *rq),=0A=
>  =0A=
> -	TP_ARGS(q, rq)=0A=
> +	TP_ARGS(rq)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
>   * block_rq_merge - merge request with another one in the elevator=0A=
> - * @q: queue holding operation=0A=
>   * @rq: block IO operation operation request=0A=
>   *=0A=
>   * Called when block operation request @rq from queue @q is merged to an=
other=0A=
> @@ -221,9 +217,9 @@ DEFINE_EVENT(block_rq, block_rq_issue,=0A=
>   */=0A=
>  DEFINE_EVENT(block_rq, block_rq_merge,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq),=0A=
> +	TP_PROTO(struct request *rq),=0A=
>  =0A=
> -	TP_ARGS(q, rq)=0A=
> +	TP_ARGS(rq)=0A=
>  );=0A=
>  =0A=
>  /**=0A=
> @@ -491,7 +487,6 @@ TRACE_EVENT(block_bio_remap,=0A=
>  =0A=
>  /**=0A=
>   * block_rq_remap - map request for a block operation request=0A=
> - * @q: queue holding the operation=0A=
>   * @rq: block IO operation request=0A=
>   * @dev: device for the operation=0A=
>   * @from: original sector for the operation=0A=
> @@ -502,10 +497,9 @@ TRACE_EVENT(block_bio_remap,=0A=
>   */=0A=
>  TRACE_EVENT(block_rq_remap,=0A=
>  =0A=
> -	TP_PROTO(struct request_queue *q, struct request *rq, dev_t dev,=0A=
> -		 sector_t from),=0A=
> +	TP_PROTO(struct request *rq, dev_t dev, sector_t from),=0A=
>  =0A=
> -	TP_ARGS(q, rq, dev, from),=0A=
> +	TP_ARGS(rq, dev, from),=0A=
>  =0A=
>  	TP_STRUCT__entry(=0A=
>  		__field( dev_t,		dev		)=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 405637144a0389..7839a78205c243 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -795,12 +795,12 @@ static u64 blk_trace_bio_get_cgid(struct request_qu=
eue *q, struct bio *bio)=0A=
>  #endif=0A=
>  =0A=
>  static u64=0A=
> -blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)=
=0A=
> +blk_trace_request_get_cgid(struct request *rq)=0A=
>  {=0A=
>  	if (!rq->bio)=0A=
>  		return 0;=0A=
>  	/* Use the first bio */=0A=
> -	return blk_trace_bio_get_cgid(q, rq->bio);=0A=
> +	return blk_trace_bio_get_cgid(rq->q, rq->bio);=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -841,40 +841,35 @@ static void blk_add_trace_rq(struct request *rq, in=
t error,=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_rq_insert(void *ignore,=0A=
> -				    struct request_queue *q, struct request *rq)=0A=
> +static void blk_add_trace_rq_insert(void *ignore, struct request *rq)=0A=
>  {=0A=
>  	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,=0A=
> -			 blk_trace_request_get_cgid(q, rq));=0A=
> +			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_rq_issue(void *ignore,=0A=
> -				   struct request_queue *q, struct request *rq)=0A=
> +static void blk_add_trace_rq_issue(void *ignore, struct request *rq)=0A=
>  {=0A=
>  	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,=0A=
> -			 blk_trace_request_get_cgid(q, rq));=0A=
> +			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_rq_merge(void *ignore,=0A=
> -				   struct request_queue *q, struct request *rq)=0A=
> +static void blk_add_trace_rq_merge(void *ignore, struct request *rq)=0A=
>  {=0A=
>  	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_BACKMERGE,=0A=
> -			 blk_trace_request_get_cgid(q, rq));=0A=
> +			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> -static void blk_add_trace_rq_requeue(void *ignore,=0A=
> -				     struct request_queue *q,=0A=
> -				     struct request *rq)=0A=
> +static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)=
=0A=
>  {=0A=
>  	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,=0A=
> -			 blk_trace_request_get_cgid(q, rq));=0A=
> +			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
>  static void blk_add_trace_rq_complete(void *ignore, struct request *rq,=
=0A=
>  			int error, unsigned int nr_bytes)=0A=
>  {=0A=
>  	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,=0A=
> -			 blk_trace_request_get_cgid(rq->q, rq));=0A=
> +			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> @@ -1037,16 +1032,14 @@ static void blk_add_trace_bio_remap(void *ignore,=
 struct bio *bio, dev_t dev,=0A=
>   *     Add a trace for that action.=0A=
>   *=0A=
>   **/=0A=
> -static void blk_add_trace_rq_remap(void *ignore,=0A=
> -				   struct request_queue *q,=0A=
> -				   struct request *rq, dev_t dev,=0A=
> +static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev=
_t dev,=0A=
>  				   sector_t from)=0A=
>  {=0A=
>  	struct blk_trace *bt;=0A=
>  	struct blk_io_trace_remap r;=0A=
>  =0A=
>  	rcu_read_lock();=0A=
> -	bt =3D rcu_dereference(q->blk_trace);=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
>  	if (likely(!bt)) {=0A=
>  		rcu_read_unlock();=0A=
>  		return;=0A=
> @@ -1058,13 +1051,12 @@ static void blk_add_trace_rq_remap(void *ignore,=
=0A=
>  =0A=
>  	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),=0A=
>  			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,=0A=
> -			sizeof(r), &r, blk_trace_request_get_cgid(q, rq));=0A=
> +			sizeof(r), &r, blk_trace_request_get_cgid(rq));=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
>  /**=0A=
>   * blk_add_driver_data - Add binary message with driver-specific data=0A=
> - * @q:		queue the io is for=0A=
>   * @rq:		io request=0A=
>   * @data:	driver-specific data=0A=
>   * @len:	length of driver-specific data=0A=
> @@ -1073,14 +1065,12 @@ static void blk_add_trace_rq_remap(void *ignore,=
=0A=
>   *     Some drivers might want to write driver-specific data per request=
.=0A=
>   *=0A=
>   **/=0A=
> -void blk_add_driver_data(struct request_queue *q,=0A=
> -			 struct request *rq,=0A=
> -			 void *data, size_t len)=0A=
> +void blk_add_driver_data(struct request *rq, void *data, size_t len)=0A=
>  {=0A=
>  	struct blk_trace *bt;=0A=
>  =0A=
>  	rcu_read_lock();=0A=
> -	bt =3D rcu_dereference(q->blk_trace);=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
>  	if (likely(!bt)) {=0A=
>  		rcu_read_unlock();=0A=
>  		return;=0A=
> @@ -1088,7 +1078,7 @@ void blk_add_driver_data(struct request_queue *q,=
=0A=
>  =0A=
>  	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,=0A=
>  				BLK_TA_DRV_DATA, 0, len, data,=0A=
> -				blk_trace_request_get_cgid(q, rq));=0A=
> +				blk_trace_request_get_cgid(rq));=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blk_add_driver_data);=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
