From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 08/10] vfio: ccw: Handling reset and shutdown with
 states
Date: Tue, 5 Jun 2018 14:18:27 +0200
Message-ID: <20180605141827.6911fc74.cohuck@redhat.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1527243678-3140-9-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527243678-3140-9-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 May 2018 12:21:16 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Two new events, VFIO_CCW_EVENT_ONLINE and VFIO_CCW_EVENT_OFFLINE
> allow to handle the enabling and disabling of a Sub Channel and
> the init, shutdown, quiesce and reset operations are changed
> accordingly.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 44 ++++------------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 75 +++++++++++++++++++++++++++++++++----
>  drivers/s390/cio/vfio_ccw_ops.c     | 15 ++------
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  4 files changed, 82 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 6fc7668..3e7b514 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -30,41 +30,13 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
>  {
>  	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>  	DECLARE_COMPLETION_ONSTACK(completion);
> -	int iretry, ret = 0;
> -
> -	spin_lock_irq(sch->lock);
> -	if (!sch->schib.pmcw.ena)
> -		goto out_unlock;
> -	ret = cio_disable_subchannel(sch);
> -	if (ret != -EBUSY)
> -		goto out_unlock;
> -
> -	do {
> -		iretry = 255;
> -
> -		ret = cio_cancel_halt_clear(sch, &iretry);
> -		while (ret == -EBUSY) {
> -			/*
> -			 * Flush all I/O and wait for
> -			 * cancel/halt/clear completion.
> -			 */
> -			private->completion = &completion;
> -			spin_unlock_irq(sch->lock);
> -
> -			wait_for_completion_timeout(&completion, 3*HZ);
> -
> -			spin_lock_irq(sch->lock);
> -			private->completion = NULL;
> -			flush_workqueue(vfio_ccw_work_q);
> -			ret = cio_cancel_halt_clear(sch, &iretry);
> -		};
> -
> -		ret = cio_disable_subchannel(sch);
> -	} while (ret == -EBUSY);
> -out_unlock:
> -	private->state = VFIO_CCW_STATE_NOT_OPER;
> -	spin_unlock_irq(sch->lock);
> -	return ret;
> +
> +	private->completion = &completion;
> +	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_OFFLINE);
> +	wait_for_completion_interruptible_timeout(&completion, jiffies + 3*HZ);
> +	if (private->state != VFIO_CCW_STATE_STANDBY)
> +		return -EFAULT;

-EFAULT really looks like the wrong error here. -EIO?

(I'm not sold on the whole concept here, though. See below.)

> +	return 0;
>  }
>  
>  static void vfio_ccw_sch_io_todo(struct work_struct *work)
> @@ -95,8 +67,6 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
>  	memcpy(&private->irb, irb, sizeof(*irb));
>  
>  	queue_work(vfio_ccw_work_q, &private->io_work);
> -	if (private->completion)
> -		complete(private->completion);
>  }
>  
>  static int vfio_ccw_sch_probe(struct subchannel *sch)
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 20b909c..0acab2f 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -73,6 +73,53 @@ static int fsm_notoper(struct vfio_ccw_private *private)
>  	return VFIO_CCW_STATE_NOT_OPER;
>  }
>  
> +static int fsm_online(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch = private->sch;
> +	int ret = VFIO_CCW_STATE_IDLE;
> +
> +	spin_lock_irq(sch->lock);
> +	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
> +		ret = VFIO_CCW_STATE_NOT_OPER;
> +	spin_unlock_irq(sch->lock);
> +
> +	return ret;
> +}
> +static int fsm_offline(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch = private->sch;
> +	int ret = VFIO_CCW_STATE_STANDBY;
> +
> +	spin_lock_irq(sch->lock);
> +	if (cio_disable_subchannel(sch))
> +		ret = VFIO_CCW_STATE_NOT_OPER;

So, what about a subchannel that is busy? Why should it go to the not
oper state?

(And you should try to flush pending I/O and then try again in that
case. Otherwise, you may have a still-enabled subchannel which may
throw an interrupt.)

> +	spin_unlock_irq(sch->lock);
> +	if (private->completion)
> +		complete(private->completion);
> +
> +	return ret;
> +}
> +static int fsm_quiescing(struct vfio_ccw_private *private)
> +{
> +	struct subchannel *sch = private->sch;
> +	int ret = VFIO_CCW_STATE_STANDBY;
> +	int iretry = 255;
> +
> +	spin_lock_irq(sch->lock);
> +	ret = cio_cancel_halt_clear(sch, &iretry);
> +	if (ret == -EBUSY)
> +		ret = VFIO_CCW_STATE_QUIESCING;
> +	else if (private->completion)
> +		complete(private->completion);
> +	spin_unlock_irq(sch->lock);
> +	return ret;

If I read this correctly, you're calling cio_cancel_halt_clear() only
once. What happened to the retry loop?

> +}
> +static int fsm_quiescing_done(struct vfio_ccw_private *private)
> +{
> +	if (private->completion)
> +		complete(private->completion);
> +	return VFIO_CCW_STATE_STANDBY;
> +}
>  /*
>   * No operation action.
>   */
> @@ -178,15 +225,10 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
>  static int fsm_init(struct vfio_ccw_private *private)
>  {
>  	struct subchannel *sch = private->sch;
> -	int ret = VFIO_CCW_STATE_STANDBY;
>  
> -	spin_lock_irq(sch->lock);
>  	sch->isc = VFIO_CCW_ISC;
> -	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
> -		ret = VFIO_CCW_STATE_NOT_OPER;
> -	spin_unlock_irq(sch->lock);
>  
> -	return ret;
> +	return VFIO_CCW_STATE_STANDBY;

Doesn't that change the semantic of the standby state?

>  }
>  
>  
> @@ -196,6 +238,8 @@ static int fsm_init(struct vfio_ccw_private *private)
>  fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	[VFIO_CCW_STATE_NOT_OPER] = {
>  		[VFIO_CCW_EVENT_INIT]		= fsm_init,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_nop,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_nop,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_nop,
> @@ -203,13 +247,17 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	},
>  	[VFIO_CCW_STATE_STANDBY] = {
>  		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_online,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_offline,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
> -		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> +		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>  		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
>  	},
>  	[VFIO_CCW_STATE_IDLE] = {
>  		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_offline,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> @@ -217,6 +265,8 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	},
>  	[VFIO_CCW_STATE_BOXED] = {
>  		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> @@ -224,9 +274,20 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	},
>  	[VFIO_CCW_STATE_BUSY] = {
>  		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
>  	},
> +	[VFIO_CCW_STATE_QUIESCING] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
> +		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
> +		[VFIO_CCW_EVENT_OFFLINE]	= fsm_nop,
> +		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> +		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
> +		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_quiescing_done,
> +		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
> +	},

Your idea here seems to be to go to either disabling the subchannel
directly or flushing out I/O first, depending on the state you're in.
The problem is that you may need retries in any case (the subchannel
may be status pending if it is enabled; not necessarily by any I/O that
had been started, but also from an unsolicited notification.)

>  };
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index ea8fd64..b202e73 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -21,21 +21,14 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
>  
>  	private = dev_get_drvdata(mdev_parent_dev(mdev));
>  	sch = private->sch;
> -	/*
> -	 * TODO:
> -	 * In the cureent stage, some things like "no I/O running" and "no
> -	 * interrupt pending" are clear, but we are not sure what other state
> -	 * we need to care about.
> -	 * There are still a lot more instructions need to be handled. We
> -	 * should come back here later.
> -	 */

This is still true, no? I'm thinking about things like channel monitors
and the like (even if we don't support them yet).

> +
>  	ret = vfio_ccw_sch_quiesce(sch);
>  	if (ret)
>  		return ret;
> +	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ONLINE);
>  
> -	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> -	if (!ret)
> -		private->state = VFIO_CCW_STATE_IDLE;
> +	if (!(private->state == VFIO_CCW_STATE_IDLE))
> +		ret = -EFAULT;

The -EFAULT looks wrong here as well.

I'm also not sure whether we should conflate enabling/disabling a
device and doing a reset.

>  
>  	return ret;
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index c5455a9..ad59091 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -68,6 +68,7 @@ enum vfio_ccw_state {
>  	VFIO_CCW_STATE_IDLE,
>  	VFIO_CCW_STATE_BOXED,
>  	VFIO_CCW_STATE_BUSY,
> +	VFIO_CCW_STATE_QUIESCING,
>  	/* last element! */
>  	NR_VFIO_CCW_STATES
>  };
> @@ -81,6 +82,8 @@ enum vfio_ccw_event {
>  	VFIO_CCW_EVENT_SSCH_REQ,
>  	VFIO_CCW_EVENT_INTERRUPT,
>  	VFIO_CCW_EVENT_SCHIB_CHANGED,
> +	VFIO_CCW_EVENT_ONLINE,
> +	VFIO_CCW_EVENT_OFFLINE,
>  	/* last element! */
>  	NR_VFIO_CCW_EVENTS
>  };
