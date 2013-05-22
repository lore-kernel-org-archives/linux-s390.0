From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 22 May 2013 12:43:43 +0000
Subject: Re: [PATCH] zfcp: Fix spinlock imbalance in zfcp_qdio_sbal_get
Message-Id: <1369226623.18710.18.camel@br9vgx5g.de.ibm.com>
In-Reply-To: <20130515160356.GE4298@osiris>
References: <20130515160356.GE4298@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


> -------- Original Message --------
> Subject: Re: [PATCH] zfcp: Fix spinlock imbalance in zfcp_qdio_sbal_get
> Date: Wed, 15 May 2013 18:03:56 +0200
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> To: Mikulas Patocka <mpatocka@redhat.com>
> CC: Steffen Maier <maier@linux.vnet.ibm.com>, linux390@de.ibm.com, 
> linux-s390@vger.kernel.org
> 
> On Wed, May 15, 2013 at 10:58:59AM -0400, Mikulas Patocka wrote:
> > zfcp: Fix spinlock imbalance in zfcp_qdio_sbal_get
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >
> > ---
> >  drivers/s390/scsi/zfcp_qdio.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Index: linux-2.6/drivers/s390/scsi/zfcp_qdio.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/s390/scsi/zfcp_qdio.c	2013-05-15 16:53:14.000000000 +0200
> > +++ linux-2.6/drivers/s390/scsi/zfcp_qdio.c	2013-05-15 16:54:23.000000000 +0200
> > @@ -250,8 +250,11 @@ int zfcp_qdio_sbal_get(struct zfcp_qdio
> >  	ret = wait_event_interruptible_timeout(qdio->req_q_wq,
> >  			       zfcp_qdio_sbal_check(qdio), 5 * HZ);
> >
> > -	if (!(atomic_read(&qdio->adapter->status) & ZFCP_STATUS_ADAPTER_QDIOUP))
> > +	if (!(atomic_read(&qdio->adapter->status) & ZFCP_STATUS_ADAPTER_QDIOUP)) {
> > +		if (ret <= 0)
> > +			spin_lock_irq(&qdio->req_q_lock);
> >  		return -EIO;
> > +	}
> 
> Looks good to me. However it's Steffen's call.

Looking at the commit that introduced this race:

commit c2af7545aaff3495d9bf9a7608c52f0af86fb194
Author: Christof Schmitt <christof.schmitt@de.ibm.com>
Date:   Mon Jun 21 10:11:32 2010 +0200

    [SCSI] zfcp: Do not wait for SBALs on stopped queue
    
    Trying to read the FC host statistics on an offline adapter results in
    a 5 seconds wait. Reading the statistics tries to issue an exchange
    port data request which first waits up to 5 seconds for an entry in
    the request queue.
    
    Change the strategy for getting a free SBAL to exit when the queue is
    stopped. Reading the statistics will then fail without the wait.

makes me think that it would be best to revert it.

A much simpler and less error-prone fix for the initial 5 sec delay
usability issue would have been to check the
ZFCP_STATUS_COMMON_UNBLOCKED flag when entering that sysfs code path,
as done in other places (see zfcp_scsi_queuecommand(), for example).

I am reluctant to add more locking statements like the above.
The entire use of req_q_lock sort of works - but the code has become
crappy and should be cleaned up anyway. Just look at the
lock-unlock-lock sequence done prior to entering the critical section.

Martin
