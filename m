From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 06/10] vfio: ccw: Make FSM functions atomic
Date: Tue, 5 Jun 2018 15:35:39 +0200
Message-ID: <20180605153539.1eee99f9.cohuck@redhat.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1527243678-3140-7-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180605133850.3509a3d3.cohuck@redhat.com>
        <46613ac7-3156-7a78-7d49-acbc3f615b76@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46613ac7-3156-7a78-7d49-acbc3f615b76@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Jun 2018 15:10:11 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 05/06/2018 13:38, Cornelia Huck wrote:
> > On Fri, 25 May 2018 12:21:14 +0200
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >  
> >> We use mutex around the FSM function call to make the FSM
> >> event handling and state change atomic.  
> > I'm still not really clear as to what this mutex is supposed to
> > serialize:
> >
> > - Modification of the state?
> > - Any calls in the state machine?
> > - A combination? (That would imply that we only deal with the state in
> >    the state machine.)  
> 
> yes to all

But wouldn't that imply that you need to either take the mutex if you
do something dependent on the state, or fire an event in that case?

> 
> >  
> >> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_drv.c     | 3 +--
> >>   drivers/s390/cio/vfio_ccw_private.h | 3 +++
> >>   2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> >> index 6b7112e..98951d5 100644
> >> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >> @@ -73,8 +73,6 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
> >>   
> >>   	private = container_of(work, struct vfio_ccw_private, io_work);
> >>   	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
> >> -	if (private->mdev)
> >> -		private->state = VFIO_CCW_STATE_IDLE;  
> > Looks like an unrelated change? If you want to do all state changes
> > under the mutex, that should rather be moved than deleted, shouldn't it?  
> 
> It is moved to fsm_irq() which is called under mutex.
> fsm_irq() returns VFIO_CCW_STATE_IDLE.

So, should that go into another patch?

> 
> >  
> >>   }
> >>   
> >>   static void vfio_ccw_sch_event_todo(struct work_struct *work)  
> 
> 
