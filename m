From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Fri, 25 Jan 2019 17:04:04 +0100
Message-ID: <20190125170404.28c61eab@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190125152154.05120461.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190125152154.05120461.cohuck@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 Jan 2019 15:21:54 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 25 Jan 2019 15:01:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Fri, 25 Jan 2019 13:58:35 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > > - We currently do not want the user space to submit another channel
> > >   program while the first one is still in flight. As submitting another
> > >   one is a valid request, however, we should allow this in the future
> > >   (once we have the code to handle that in place).  
> > 
> > I don't agree. There is at most one channel program processed by a
> > subchannel at any time. I would prefer an early error code if channel
> > programs are issued on top of each other (our virtual subchannel
> > is channel pending or FC start function bit set or similar).
> 
> You can submit a new request if the subchannel is pending with primary,
> but not with secondary state.
> 
> Regardless of that, I think it is much easier to push as much as
> possible of sorting out of requests to the hardware.
> 

Do we expect userspace/QEMU to fence the bad scenarios as tries to do
today, or is this supposed to change to hardware should sort out
requests whenever possible.

The problem I see with the let the hardware sort it out is that, for that
to work, we need to juggle multiple translations simultaneously (or am I
wrong?). Doing that does not appear particularly simple to me.
Furthermore we would go through all that hassle knowingly that the sole
reason is working around bugs. We still expect our Linux guests
serializing it's ssch() stuff as it does today. Thus I would except this
code not getting the love nor the coverage that would guard against bugs
in that code.

Regards,
Halil
