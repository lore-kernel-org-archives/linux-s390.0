From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] vfio-ccw: add handling for async
 channel instructions
Date: Wed, 30 Jan 2019 18:00:45 +0100
Message-ID: <20190130180045.419b1a23@oc2783563651>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-7-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190130132212.7376-7-cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Jan 2019 14:22:12 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> +static void fsm_async_retry(struct vfio_ccw_private *private,
> +			    enum vfio_ccw_event event)
> +{
> +	private->cmd_region->ret_code = -EAGAIN;
> +}
> +

This is essentially dead code at the moment, isn't it? I mean we hold the
io_mutex whenever we are in state VFIO_CCW_STATE_CP_PROCESSING. And we
call vfio_ccw_fsm_event() under the very same mutex.



> @@ -213,26 +323,31 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	[VFIO_CCW_STATE_NOT_OPER] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>  	},
>  	[VFIO_CCW_STATE_STANDBY] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
>  	[VFIO_CCW_STATE_IDLE] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_request,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
>  	[VFIO_CCW_STATE_CP_PROCESSING] = {
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_retry,
> +		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_retry,

Used here.

Regards,
Halil

>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  	},
