Return-Path: <SRS0=KhOk=TH=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v1 2/2] vfio-ccw: rework sch_event
References: <1557148270-19901-1-git-send-email-pmorel@linux.ibm.com>
 <1557148270-19901-3-git-send-email-pmorel@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 7 May 2019 16:06:58 -0400
MIME-Version: 1.0
In-Reply-To: <1557148270-19901-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3fac544d-897c-03ec-6a3f-709685f280a8@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, cohuck@redhat.com
Cc: pasic@linux.vnet.ibm.com, farman@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/06/2019 09:11 AM, Pierre Morel wrote:
> Set the mediated device as non operational when the
> subchannel went non operational.
> Otherwise keep the current state.
> 
> Since we removed the last use of VFIO_CCW_STATE_STANDBY
> remove this state from the state machine.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c     | 11 +----------
>   drivers/s390/cio/vfio_ccw_fsm.c     |  7 +------
>   drivers/s390/cio/vfio_ccw_ops.c     |  2 +-
>   drivers/s390/cio/vfio_ccw_private.h |  1 -
>   4 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index a95b6c7..2f6140d5 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -210,17 +210,8 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>   	if (work_pending(&sch->todo_work))
>   		goto out_unlock;
>   
> -	if (cio_update_schib(sch)) {
> +	if (cio_update_schib(sch))
>   		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
> -		rc = 0;
> -		goto out_unlock;
> -	}
> -
> -	private = dev_get_drvdata(&sch->dev);
> -	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
> -		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
> -				 VFIO_CCW_STATE_STANDBY;
> -	}
>   	rc = 0;
>   
>   out_unlock:
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 49d9d3d..a6524ca 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -88,6 +88,7 @@ static int fsm_do_halt(struct vfio_ccw_private *private)
>   
>   	/* Issue "Halt Subchannel" */
>   	ccode = hsch(sch->schid);
> +	pr_warn("ccode = hsch(sch->schid);\n");


I am not sure what's the purpose of logging this? Was it for your 
debugging purpose?

>   
>   	switch (ccode) {
>   	case 0:
> @@ -326,12 +327,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>   		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>   	},
> -	[VFIO_CCW_STATE_STANDBY] = {
> -		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
> -		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> -		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
> -		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> -	},
>   	[VFIO_CCW_STATE_IDLE] = {
>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>   		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 497419c..35445ca 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -162,7 +162,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>   	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
>   		goto error;
>   
> -	private->state = VFIO_CCW_STATE_STANDBY;
> +	private->state = VFIO_CCW_STATE_IDLE;
>   	spin_unlock_irq(sch->lock);
>   	return 0;
>   
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index f1092c3..ece6a75 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -105,7 +105,6 @@ extern int vfio_ccw_sch_quiesce(struct subchannel *sch);
>    */
>   enum vfio_ccw_state {
>   	VFIO_CCW_STATE_NOT_OPER,
> -	VFIO_CCW_STATE_STANDBY,
>   	VFIO_CCW_STATE_IDLE,
>   	VFIO_CCW_STATE_CP_PROCESSING,
>   	VFIO_CCW_STATE_CP_PENDING,
> 
