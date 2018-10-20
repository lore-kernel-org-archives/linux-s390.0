From: Cornelia Huck <cohuck@redhat.com>
Date: Sat, 20 Oct 2018 17:07:35 +0000
Subject: Re: [PATCH v1 0/2] vfio: ccw: VFIO CCW cleanup part1
Message-Id: <20181020190735.5c925ac6.cohuck@redhat.com>
In-Reply-To: <03d48cca-8788-75dc-9699-1ccbc166ae6e@ns360863.ovh.net>
References: <03d48cca-8788-75dc-9699-1ccbc166ae6e@ns360863.ovh.net>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 19 Oct 2018 11:36:37 +0200
Pierre Morel <pmorel@ns360863.ovh.net> wrote:

> Le 10/18/18 � 21:48, Eric Farman a �crit�:
> > 
> > 
> > On 10/18/2018 03:51 AM, Pierre Morel wrote:  
> >> The first patch of this serie is essentially cosmetic
> >> to clarify the code.
> >>
> >> The second patch is a bug correction.
> >>
> >>
> >>
> >> Pierre Morel (2):
> >> �� vfio: ccw: Merge BUSY and BOXED states
> >> �� vfio: ccw: Register mediated device once all structures are
> >> ���� initialized
> >>
> >> � drivers/s390/cio/vfio_ccw_drv.c���� | 8 ++++----
> >> � drivers/s390/cio/vfio_ccw_fsm.c���� | 7 +------
> >> � drivers/s390/cio/vfio_ccw_private.h | 1 -
> >> � 3 files changed, 5 insertions(+), 11 deletions(-)
> >>  
> > 
> > You said in the changelog (which gets omitted in reply) that you added 
> > my r-b, but I don't see it.� For the record, I'm still good with these.  
> > :-)
> > 
> >  �- Eric
> > 
> >   
> Oh, indeed, sorry.
> I wont forget next time.
> 
> Pierre

In this case, I can add the R-b if I apply patch 2 (which I think I'll
do).
