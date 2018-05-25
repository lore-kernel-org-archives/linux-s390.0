From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 10/10] vfio: ccw: Let user wait when busy on IO
Date: Fri, 25 May 2018 16:04:18 +0200
Message-ID: <20180525140418.GA17131@osiris>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-11-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527243678-3140-11-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 25, 2018 at 12:21:18PM +0200, Pierre Morel wrote:
> In the current implementation, we do not want to start a new SSCH
> command before the last one ends.
> 
> Currently the user needs to poll on the -EBUSY error to
> wait before sending a new request.
> 
> Let's be friendly with global warming and let the user sleep
> until he may send a new request.
> 
> Let's make the caller wait until the last SSCH ends.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c     | 4 ++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 6 ++++++
>  drivers/s390/cio/vfio_ccw_private.h | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index c37052d..97b74a1 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -200,6 +200,10 @@ static int fsm_irq(struct vfio_ccw_private *private)
>  
>  	if (private->io_trigger)
>  		eventfd_signal(private->io_trigger, 1);
> +
> +	if (private->io_completion)
> +		complete(private->io_completion);
> +
>  	return VFIO_CCW_STATE_IDLE;
>  }
>  
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index b202e73..39beb6e 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -183,6 +183,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  	struct vfio_ccw_private *private;
>  	struct ccw_io_region *region;
>  	union scsw *scsw;
> +	DECLARE_COMPLETION_ONSTACK(completion);
>  
>  	if (*ppos + count > sizeof(*region))
>  		return -EINVAL;
> @@ -196,6 +197,11 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  	scsw = (union scsw *) &region->scsw_area;
>  	switch (scsw->cmd.fctl) {
>  	case SCSW_FCTL_START_FUNC:
> +		if (private->state == VFIO_CCW_STATE_BUSY) {
> +			private->io_completion = &completion;
> +			if (wait_for_completion_interruptible(&completion))
> +				return -EINTR;
> +		}

What prevents a state change between checking the state and before
private->io_completion is set? If that happens you would end with an
endless wait.

Similarly, you would have memory corruption if the task would be
interrupted and if the function would be left, ending up with a stale
private->io_completion completion pointer.
The complete(private->io_completion) call will then write to a memory
location that might already be reused.

Just my 0.02 after having a very very short look ;)
