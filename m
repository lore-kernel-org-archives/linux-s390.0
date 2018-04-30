From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 07/10] vfio: ccw: Introduce the INIT event
Date: Mon, 30 Apr 2018 17:39:10 +0200
Message-ID: <20180430173910.31f13a3a.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-8-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-8-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Apr 2018 16:48:10 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> The VFIO_CCW_EVENT_INIT event allows to export the initial state
> into the FSM.

I don't know, that feels a bit unintuitive to me. I would naively
expect initialization to be done _before_ we activate processing via
the state machine.

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 26 +++++++++++---------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 21 +++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 11 -----------
>  drivers/s390/cio/vfio_ccw_private.h |  1 +
>  4 files changed, 33 insertions(+), 26 deletions(-)

>  /*
>   * Device statemachine
>   */
>  fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>  	[VFIO_CCW_STATE_NOT_OPER] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_init,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>  		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_nop,
>  	},
>  	[VFIO_CCW_STATE_STANDBY] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>  	},
>  	[VFIO_CCW_STATE_IDLE] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>  	},
>  	[VFIO_CCW_STATE_BOXED] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>  		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>  	},
>  	[VFIO_CCW_STATE_BUSY] = {
> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>  		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>  		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>  		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,

...especially as you only call it if in the NOT_OPER state. Why should
this event be generated in any case but in the very beginning?
