From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Thu, 29 Oct 2015 11:01:41 +0200
Message-ID: <20151029104301-mutt-send-email-mst@redhat.com>
References: <56307BD1.6010806@de.ibm.com>
	<1446019787.3405.203.camel@infradead.org>
	<20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 03:51:58PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 28, 2015 at 9:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Oct 28, 2015 at 11:32:34PM +0900, David Woodhouse wrote:
> >> > I don't have a problem with extending DMA API to address
> >> > more usecases.
> >>
> >> No, this isn't an extension. This is fixing a bug, on certain platforms
> >> where the DMA API has currently done the wrong thing.
> >>
> >> We have historically worked around that bug by introducing *another*
> >> bug, which is not to *use* the DMA API in the virtio driver.
> >>
> >> Sure, we can co-ordinate those two bug-fixes. But let's not talk about
> >> them as anything other than bug-fixes.
> >
> > It was pretty practical not to use it. All virtio devices at the time
> > without exception bypassed the IOMMU, so it was a question of omitting a
> > couple of function calls in virtio versus hacking on DMA implementation
> > on multiple platforms. We have more policy options now, so I agree it's
> > time to revisit this.
> >
> > But for me, the most important thing is that we do coordinate.
> >
> >> > > Drivers use DMA API. No more talky.
> >> >
> >> > Well for virtio they don't ATM. And 1:1 mapping makes perfect sense
> >> > for the wast majority of users, so I can't switch them over
> >> > until the DMA API actually addresses all existing usecases.
> >>
> >> That's still not your business; it's the platform's. And there are
> >> hardware implementations of the virtio protocols on real PCI cards. And
> >> we have the option of doing IOMMU translation for the virtio devices
> >> even in a virtual machine. Just don't get involved.
> >>
> >> --
> >> dwmw2
> >>
> >>
> >
> > I'm involved anyway, it's possible not to put all the code in the virtio
> > subsystem in guest though.  But I suspect we'll need to find a way for
> > non-linux drivers within guest to work correctly too, and they might
> > have trouble poking at things at the system level.  So possibly virtio
> > subsystem will have to tell platform "this device wants to bypass IOMMU"
> > and then DMA API does the right thing.
> >
> 
> After some discussion at KS, no one came up with an example where it's
> necessary, and the patches to convert virtqueue to use the DMA API are
> much nicer when they convert it unconditionally.

It's very surprising no one couldn't.  I did above, I try again below.
Note: below discusses configuration *within guest*.

Example: you have a mix of assigned devices and virtio devices. You
don't trust your assigned device vendor not to corrupt your memory so
you want to limit the damage your assigned device can do to your guest,
so you use an IOMMU for that.  Thus existing iommu=pt within guest is out.

But you trust your hypervisor (you have no choice anyway),
and you don't want the overhead of tweaking IOMMU
on data path for virtio. Thus iommu=on is out too.



> The two interesting cases we thought of were PPC and x86's emulated
> Q35 IOMMU.  PPC will look in to architecting a devicetree-based way to
> indicate passthrough status and will add quirks for the existing
> virtio devices.

Isn't this specified by the hypervisor? I don't think this is a good way
to do this: guest security should be up to guest.

> Everyone seems to agree that x86's emulated Q35 thing
> is just buggy right now and should be taught to use the existing ACPI
> mechanism for enumerating passthrough devices.

I'm not sure what ACPI has to do with it.
It's about a way for guest users to specify whether
they want to bypass an IOMMU for a given device.

> I'll send a new version of the series soon.
> 
> --Andy

By the way, a bunch of code is missing on the QEMU side
to make this useful:
1. virtio ignores the iommu
2. vhost user ignores the iommu
3. dataplane ignores the iommu
4. vhost-net ignores the iommu
5. VFIO ignores the iommu

I think so far I only saw patches for 1 above.

-- 
MST
