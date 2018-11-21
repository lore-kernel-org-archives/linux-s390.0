From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 21 Nov 2018 17:05:27 +0000
Subject: Re: [PATCH 4/5] vfio: ccw: Refactoring state changes
Message-Id: <20181121180527.3f4c85e0.cohuck@redhat.com>
In-Reply-To: <1539767923-10539-5-git-send-email-pmorel@linux.ibm.com>
References: <1539767923-10539-5-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Oct 2018 11:18:42 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Currently, he state machine is hesitating between following the
> state of the subchannel, the state of the subchannel device,
> and the state of the mediated device.
> 
> The situation leads to unclear state changes
> and we need to clarify the situation.
> 
> Let's let the guest take care of the subchannel
> and let us keep track of the mediated device parent in the
> mediated device driver.
> 
> probe() : -> NOT_OPERATIONAL
> 	We have a transtion to the NOT_OPERATIONAL state
> 	as soon as the device is bound and the private structure
> 	is allocated.
> In NOT_OPERATIONAL:
> 	Nothing is done on the subchannel in this state
> 
> mdev_create() : -> STANDBY
> in STANDBY:
> 	Nothing is done on the subchannel in this state
> 	Interruptions should not happen but are cleared if
> 	they happen.

Is there any reason interrupts could happen here? If the subchannel is
not enabled, I don't see how we can get them from the hardware, and I
would expect transitions to this state disabling the subchannel and
clearing any interrupt state that might be in the way beforehand.

> 
> mdev_open() : -> IDLE
> 	The subchannel is enabled
> In IDLE:
> 	We expect I/O and accept interruptions.
> 
> fsm_io_request() : -> BUSY
> 	mdev_write() eventually calls fsm_io_request() which
> 	starts the IO
> In BUSY:
> 	We refuse I/O and accept interruptions.
> 
> vfio_ccw_sch_io_todo() -> IDLE
> 	If we expected an interruption we process it.
> 	otherwise we clear it and ignore it.

Should we do something for unsolicited interrupts? (Pass them on?)

> 
>       bind() unbind()
>         |       ^
>         v       |
>       -------------
>       | NOT_OPER  |<---- on Error
>       -------------    |
>         |       ^      |
>      create() remove() |
>         v       |      |
>       -------------    |
>       | STANDBY   |<--- release()
>       -------------    |
>         |       ^      |
>       open() release() |
>         v       |      |
>       -------------    |
>       |   IDLE    |<--- reset()
>       -------------    |
>         |       ^      |
>       write()  irq()   |
>         v       |      |
>       -------------    |
>       |   BUSY    |>----
>       -------------

This diagram and the explanations are too useful to hide in a patch
description :) Maybe put at least some of the info into the fsm source
file?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 19 +++++++++++++++----
>  drivers/s390/cio/vfio_ccw_ops.c | 19 +++++++++----------
>  2 files changed, 24 insertions(+), 14 deletions(-)

(...)

> @@ -194,12 +199,18 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>  		rc = 0;
>  		goto out_unlock;
>  	}
> -
> +#if 0
> +	/*
> +	 * We must find a solution to report the change to the guest
> +	 * until there I see no need to change the state of the SCH
> +	 * here.

Hm? I don't think the guest is involved, unless you end up changing the
availability to the guest (operational vs. not operational). My guess
is that this function should do something similar to the callback used
by the normal I/O subchannel driver, only simpler as we don't support a
disconnected state.

> +	 */
>  	private = dev_get_drvdata(&sch->dev);
>  	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
>  		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
>  				 VFIO_CCW_STATE_STANDBY;
>  	}
> +#endif
>  	rc = 0;
>  
>  out_unlock:
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 87a8f8c..765afd7 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -36,6 +36,8 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
>  	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
>  	if (!ret)
>  		private->state = VFIO_CCW_STATE_IDLE;
> +	else
> +		private->state = VFIO_CCW_STATE_NOT_OPER;

private->state = ret ? VFIO_CCW_STATE_NOT_OPER : VFIO_CCW_STATE_IDLE;

?

>  
>  	return ret;
>  }
