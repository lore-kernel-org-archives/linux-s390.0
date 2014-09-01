From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] virtio_ring: Remove sg_next indirection
Date: Mon, 1 Sep 2014 10:15:12 -0700
Message-ID: <CALCETrWye0jFCH7CGwLr9ch7cdRXvhvo75wpiO+byB+xa6MPyA@mail.gmail.com>
References: <cover.1409087794.git.luto@amacapital.net>
	<37f797f9f79ae57f88b6b5ca9d0b28ce56f7e701.1409087794.git.luto@amacapital.net>
	<87fvgckvg0.fsf@rustcorp.com.au>
	<CALCETrVd5F50vFzBD5FeH7EynnZ3+EFr3MT_22DmZWKDWfCfiQ@mail.gmail.com>
	<20140901065953.GA20700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140901065953.GA20700@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sep 1, 2014 12:00 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> On Sun, Aug 31, 2014 at 06:42:38PM -0700, Andy Lutomirski wrote:
> > On Sun, Aug 31, 2014 at 5:58 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > Andy Lutomirski <luto@amacapital.net> writes:
> > >> The only unusual thing about virtio's use of scatterlists is that
> > >> two of the APIs accept scatterlists that might not be terminated.
> > >> Using function pointers to handle this case is overkill; for_each_sg
> > >> can do it.
> > >>
> > >> There's a small subtlely here: for_each_sg assumes that the provided
> > >> count is correct, but, because of the way that virtio_ring handles
> > >> multiple scatterlists at once, the count is only an upper bound if
> > >> there is more than one scatterlist.  This is easily solved by
> > >> checking the sg pointer for NULL on each iteration.
> > >
> > > Hi Andy,
> > >
> > >         (Sorry for the delayed response; I was still catching up from
> > > my week at KS.)
> >
> > No problem.  In the grand scheme of maintainer response time, I think
> > you're near the top. :)
> >
> > >
> > > Unfortunately the reason we dance through so many hoops here is that
> > > it has a measurable performance impact :(  Those indirect calls get inlined.
> >
> > gcc inlines that?  That must nearly double the size of the object file. :-/
> >
> > >
> > > There's only one place which actually uses a weirdly-formed sg now,
> > > and that's virtio_net.  It's pretty trivial to fix.
>
> This path in virtio net is also unused on modern hypervisors, so we probably
> don't care how well does it perform: why not apply it anyway?
> It's the virtio_ring changes that we need to worry about.
>
> > > However, vring_bench drops 15% when we do this.  There's a larger
> > > question as to how much difference that makes in Real Life, of course.
> > > I'll measure that today.
> >
> > Weird.  sg_next shouldn't be nearly that slow.  Weird.
>
> I think that's down to the fact that it's out of line,
> so it prevents inlining of the caller.
>
> > >
> > > Here are my two patches, back-to-back (it cam out of of an earlier
> > > concern about reducing stack usage, hence the stack measurements).
> > >
> >
> > I like your version better than mine, except that I suspect that your
> > version will blow up for the same reason that my v2 patches blow up:
> > you probably need the skb_to_sgvec_nomark fix, too.
> >
> > IOW, what happens if you apply patches 1-4 from my v3 series and then
> > apply your patches on top of that?
> >
> > There'll be a hit on some virtio_pci machines due to use of the DMA
> > API.  I would argue that, if this is measurable, the right fix is to
> > prod the DMA API maintainers, whoever they are, to fix it.  The DMA
> > API really out to be very fast on identity-mapped devices, but I don't
> > know whether it is in practice.
> >
> > --Andy
>
> Right but we'd have to fix that before applying the patches
> to avoid performance regressions.

My pathetic attempt to benchmark it came up with no difference.
What's the right benchmark?  I'm having trouble compiling anything in
tools/virtio -- my patch breaks that code, but it seems like it's
already broken.  The next version of my patches will at least not make
the problem worse.

I think that we can eliminate any possibility of a meaningful
performance hit due to the streaming part of the mappings by checking
PCI_DMA_BUS_IS_PHYS.  I'll test and send out a version of the patches
that does that.

For what it's worth, there's another possible performance hit: on some
architectures, coherent memory could be uncached.  This might not
matter for anyone, though.  I think that x86 uses normal memory for
coherent mappings.  ARM is unlikely to make serious use of virtio_pci,
since AFAIK virtio_mmio is strongly preferred on ARM.  s390 should be
unaffected for much the same reason.  Are there other architectures on
which this could be a problem?

It's possible that the weak barrier flag could be used to disable the
use of coherent memory, but it might require some DMA API trickery.
In particular, the only API I see is DMA_BIDIRECTIONAL, and we'll end
up with ugly code in virtio_pci to get it working.

Ultimately, I think that hypervisors need a way to tell their guests
that certain PCI devices are emulated and therefore fully coherent
regardless our normal architectural considerations.

--Andy

>
> --
> MST
