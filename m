Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2018 16:07:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: fence off transport mode
Message-ID: <20180301160714.22c8113d.cohuck@redhat.com>
In-Reply-To: <95c1554e-ada3-f6db-62aa-f04e42a0ae09@linux.vnet.ibm.com>
References: <20180222153959.31272-1-cohuck@redhat.com>
        <20180222153959.31272-2-cohuck@redhat.com>
        <95c1554e-ada3-f6db-62aa-f04e42a0ae09@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 1 Mar 2018 15:51:05 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 02/22/2018 04:39 PM, Cornelia Huck wrote:
> > vfio-ccw only supports command mode for channel programs, not transport
> > mode. User space is supposed to already take care of that and pass us
> > command-mode ORBs only, but better make sure and return an error to
> > the caller instead of trying to process tcws as ccws.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Thanks!

> 
> > ---
> >  drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > index c30420c517b1..ff6963ad6e39 100644
> > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> > @@ -124,6 +124,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >  		orb = (union orb *)io_region->orb_area;
> > 
> > +		/* Don't try to build a cp if transport mode is specified. */
> > +		if (orb->tm.b) {
> > +			io_region->ret_code = -EOPNOTSUPP;  
> 
> I guess now we communicate this as appropriately as possible.

Yes. We certainly only want to return an error to user space; it is
their responsibility to correctly reflect that to the guest (and even
more their responsibility to not present us with a transport orb in the
first place...)

> 
> > +			goto err_out;
> > +		}
> >  		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
> >  					      orb);
> >  		if (io_region->ret_code)
> >   
> 
