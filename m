From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Mon, 28 Jan 2019 18:09:48 +0100
Message-ID: <20190128180948.506a9695.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190125150101.3b61f0a1@oc2783563651>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 Jan 2019 15:01:01 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 25 Jan 2019 13:58:35 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:

> > - The code should not be interrupted while we process the channel
> >   program, do the ssch etc. We want the caller to try again later (i.e.
> >   return -EAGAIN)  

(...)

> > - With the async interface, we want user space to be able to submit a
> >   halt/clear while a start request is still in flight, but not while
> >   we're processing a start request with translation etc. We probably
> >   want to do -EAGAIN in that case.  
> 
> This reads very similar to your first point.

Not quite. ssch() means that we have a cp around; for hsch()/csch() we
don't have such a thing. So we want to protect the process of
translating the cp etc., but we don't need such protection for the
halt/clear processing.

> 
> > 
> > My idea would be:
> > 
> > - The BUSY state denotes "I'm busy processing a request right now, try
> >   again". We hold it while processing the cp and doing the ssch and
> >   leave it afterwards (i.e., while the start request is processed by
> >   the hardware). I/O requests and async requests get -EAGAIN in that
> >   state.
> > - A new state (CP_PENDING?) is entered after ssch returned with cc 0
> >   (from the BUSY state). We stay in there as long as no final state for
> >   that request has been received and delivered. (This may be final
> >   interrupt for that request, a deferred cc, or successful halt/clear.)
> >   I/O requests get -EBUSY, async requests are processed. This state can
> >   be removed again once we are able to handle more than one outstanding
> >   cp.
> > 
> > Does that make sense?
> >   
> 
> AFAIU your idea is to split up the busy state into two states: CP_PENDING
> and of busy without CP_PENDING called BUSY. I like the idea of having a
> separate state for CP_PENDING but I don't like the new semantic of BUSY.
> 
> Hm mashing a conceptual state machine and the jumptabe stuff ain't
> making reasoning about this simpler either. I'm taking about the
> conceptual state machine. It would be nice to have a picture of it and
> then think about how to express that in code.

Sorry, I'm having a hard time parsing your comments. Are you looking
for something like the below?

IDLE --- IO_REQ --> BUSY ---> CP_PENDING --- IRQ ---> IDLE (if final
state for I/O)
(normal ssch)

BUSY --- IO_REQ ---> return -EAGAIN, stay in BUSY
(user space is supposed to retry, as we'll eventually progress from
BUSY)

CP_PENDING --- IO_REQ ---> return -EBUSY, stay in CP_PENDING
(user space is supposed to map this to the appropriate cc for the guest)

IDLE --- ASYNC_REQ ---> IDLE
(user space is welcome to do anything else right away)

BUSY --- ASYNC_REQ ---> return -EAGAIN, stay in BUSY
(user space is supposed to retry, as above)

CP_PENDING --- ASYNC_REQ ---> return success, stay in CP_PENDING
(the interrupt will get us out of CP_PENDING eventually)
