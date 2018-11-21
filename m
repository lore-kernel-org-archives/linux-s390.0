From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 21 Nov 2018 17:20:24 +0000
Subject: Re: [PATCH 5/5] vfio: ccw: Do not change the mediated device state on sch events
Message-Id: <20181121182024.4f1a6df2.cohuck@redhat.com>
In-Reply-To: <1539767923-10539-6-git-send-email-pmorel@linux.ibm.com>
References: <1539767923-10539-6-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Oct 2018 11:18:43 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When we receive a subchannel event the alternative is:
> - to handle the event in the mediated device driver,
> - to let the guest handle it.
> 
> We choose to let the guest handle the changes even we do
> not dynamically signal the event to the guest for now.
> 
> There is no reason to change the state of the mediated device
> here but in error cases.
> Let's suppress the state change.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index b29a96f..e7416dd 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -199,18 +199,11 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>  		rc = 0;
>  		goto out_unlock;
>  	}
> -#if 0
>  	/*
> -	 * We must find a solution to report the change to the guest
> -	 * until there I see no need to change the state of the SCH
> -	 * here.
> +	 * We must find a solution to signal the change to the guest,
> +	 * and let it handle the event.
> +	 * There is no need to update the mediated device state.
>  	 */
> -	private = dev_get_drvdata(&sch->dev);
> -	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
> -		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
> -				 VFIO_CCW_STATE_STANDBY;
> -	}
> -#endif
>  	rc = 0;
>  
>  out_unlock:

Ah, here's more about that issue.

For most of the events we could have here, I would expect that we need
to notify the guest, but do not give it a say in how it should be
handled. I'm thinking of events like device gone or path changed: A
guest would be expected to be able to deal with it, but _how_ it does
that is up to the guest.

Not changing the mediated device state probably makes sense, but do we
want to introduce handling for "device gone" so the device reappearing
can be handled automatically?

This is probably similar to z/VM handling of attached dasd: If that
dasd becomes not operational, it is detached from the guest and the
admin need to manually re-attach it if it becomes available again.
Keeping the device around would make life easier for admins, but I'm
not sure how much of a hassle it would be.
