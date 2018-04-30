From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ
 event
Date: Mon, 30 Apr 2018 17:30:28 +0200
Message-ID: <20180430173028.0dca976c.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180425104138.1337aff5.cohuck@redhat.com>
        <24f638e4-2f7e-00e1-1efb-ff3fe524bca0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24f638e4-2f7e-00e1-1efb-ff3fe524bca0@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 25 Apr 2018 15:52:19 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 25/04/2018 10:41, Cornelia Huck wrote:
> > On Thu, 19 Apr 2018 16:48:07 +0200
> > Pierre Morel<pmorel@linux.vnet.ibm.com>  wrote:

> >> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> >> index 3284e64..93aab87 100644
> >> --- a/drivers/s390/cio/vfio_ccw_private.h
> >> +++ b/drivers/s390/cio/vfio_ccw_private.h
> >> @@ -76,7 +76,7 @@ enum vfio_ccw_state {
> >>    */
> >>   enum vfio_ccw_event {
> >>   	VFIO_CCW_EVENT_NOT_OPER,
> >> -	VFIO_CCW_EVENT_IO_REQ,
> >> +	VFIO_CCW_EVENT_SSCH_REQ,
> >>   	VFIO_CCW_EVENT_INTERRUPT,
> >>   	VFIO_CCW_EVENT_SCH_EVENT,
> >>   	/* last element! */  
> > I don't think we should separate the ssch handling. The major 
> > difference to halt/clear is that it needs channel program translation. 
> > Everything else (issuing the instruction and processing the interrupt) 
> > are basically the same. If we just throw everything at the hardware 
> > and let the host's channel subsystem figure it out, we already should 
> > be fine with regard to most of the races.  
> 
> We must test at a moment or another the kind of request we do,
> cancel, halt and clear only need the subchannel id in register 1 and as 
> you said are much more direct to implement.
> 
> If we do not separate them here, we need a switch in the "do_io_request" 
> function.
> Is it what you mean?

Yes. Most of the handling should be the same for any function.
