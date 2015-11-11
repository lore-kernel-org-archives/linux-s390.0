From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 11 Nov 2015 07:56:03 -0800
Message-ID: <CALCETrWmZaQxS3-r9jsUb3BPhdLRbRrdZWok2geHnYKaWC4YKA@mail.gmail.com>
References: <20151028161424-mutt-send-email-mst@redhat.com>
 <1446042754.3405.237.camel@infradead.org> <20151028175136-mutt-send-email-mst@redhat.com>
 <CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
 <20151029104301-mutt-send-email-mst@redhat.com> <1446135536.3405.279.camel@infradead.org>
 <20151108120627-mutt-send-email-mst@redhat.com> <20151108114946.GG2255@suse.de>
 <20151109224720-mutt-send-email-mst@redhat.com> <CALCETrUKnNajtHMGarpxdVEVzbJvDr6bU88j530DVJXWrGW9bQ@mail.gmail.com>
 <20151111111125-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151111111125-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 11, 2015 at 2:05 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Nov 10, 2015 at 10:54:21AM -0800, Andy Lutomirski wrote:
>> On Nov 10, 2015 7:02 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >
>> > On Sun, Nov 08, 2015 at 12:49:46PM +0100, Joerg Roedel wrote:
>> > > On Sun, Nov 08, 2015 at 12:37:47PM +0200, Michael S. Tsirkin wrote:
>> > > > I have no problem with that. For example, can we teach
>> > > > the DMA API on intel x86 to use PT for virtio by default?
>> > > > That would allow merging Andy's patches with
>> > > > full compatibility with old guests and hosts.
>> > >
>> > > Well, the only incompatibility comes from an experimental qemu feature,
>> > > more explicitly from a bug in that features implementation. So why
>> > > should we work around that in the kernel? I think it is not too hard to
>> > > fix qemu to generate a correct DMAR table which excludes the virtio
>> > > devices from iommu translation.
>> > >
>> > >
>> > >       Joerg
>> >
>> > It's not that easy - you'd have to dedicate some buses
>> > for iommu bypass, and teach management tools to only put
>> > virtio there - but it's possible.
>> >
>> > This will absolutely address guests that don't need to set up IOMMU for
>> > virtio devices, and virtio that bypasses the IOMMU.
>> >
>> > But the problem is that we do want to *allow* guests
>> > to set up IOMMU for virtio devices.
>> > In that case, these are two other usecases:
>> >
>> > A- monolitic virtio within QEMU:
>> >         iommu only needed for VFIO ->
>> >         guest should always use iommu=pt
>> >         iommu=on works but is just useless overhead.
>> >
>> > B- modular out of process virtio outside QEMU:
>> >         iommu needed for VFIO or kernel driver ->
>> >         guest should use iommu=pt or iommu=on
>> >         depending on security/performance requirements
>> >
>> > Note that there could easily be a mix of these in the same system.
>> >
>> > So for these cases we do need QEMU to specify to guest that IOMMU covers
>> > the virtio devices.  Also, once one does this, the default on linux is
>> > iommu=on and not pt, which works but ATM is very slow.
>> >
>> > This poses three problems:
>> >
>> > 1. How do we address the different needs of A and B?
>> >    One way would be for virtio to pass the information to guest
>> >    using some virtio specific way, and have drivers
>> >    specify what kind of DMA access they want.
>> >
>> > 2. (Kind of a subset of 1) once we do allow IOMMU, how do we make sure most guests
>> >    use the more sensible iommu=pt.
>> >
>> > 3. Once we do allow IOMMU, how can we keep existing guests work in this configuration?
>> >    Creating different hypervisor configurations depending on guest is very nasty.
>> >    Again, one way would be some virtio specific interface.
>> >
>> > I'd rather we figured the answers to this before merging Andy's patches
>> > because I'm concerned that instead of 1 broken configuration
>> > (virtio always bypasses IOMMU) we'll get two bad configurations
>> > (in the second one, virtio uses the slow default with no
>> > gain in security).
>> >
>> > Suggestions wellcome.
>>
>> I think there's still no downside of using my patches, even on x86.
>>
>> Old kernels on new QEMU work unless IOMMU is enabled on the host.  I
>> think that's the best we can possibly do.
>> New kernels work at full speed on old QEMU.
>
> Only if IOMMU is disabled, right?
>
>> New kernels with new QEMU and iommu enabled work slower.  Even newer
>> kernels with default passthrough work at full speed, and there's no
>> obvious downside to the existence of kernels with just my patches.
>>
>> --Andy
>>
>
> I tried to explain the possible downside. Let me try again.  Imagine
> that guest kernel notifies hypervisor that it wants IOMMU to actually
> work.  This will make old kernel on new QEMU work even with IOMMU
> enabled on host - better than "the best we can do" that you described
> above.  Specifically, QEMU will assume that if it didn't get
> notification, it's an old kernel so it should ignore the IOMMU.

Can you flesh out this trick?

On x86 IIUC the IOMMU more-or-less defaults to passthrough.  If the
kernel wants, it can switch it to a non-passthrough mode.  My patches
cause the virtio driver to do exactly this, except that the host
implementation doesn't actually exist yet, so the patches will instead
have no particular effect.

On powerpc and sparc, we *already* screwed up.  The host already tells
the guest that there's an IOMMU and that it's *enabled* because those
platforms don't have selective IOMMU coverage the way that x86 does.
So we need to work around it.

I think that, if we want fancy virt-friendly IOMMU stuff like you're
talking about, then the right thing to do is to create a virtio bus
instead of pretending to be PCI.  That bus could have a virtio IOMMU
and its own cross-platform enumeration mechanism for devices on the
bus, and everything would be peachy.

In the mean time, there are existing mechanisms by which every PCI
driver is supposed to notify the host/platform of how it intends to
map DMA memory, and virtio gets it wrong.

>
> But if we apply your patches this trick won't work.
>

I still don't understand what trick.  If we want virtio devices to be
assignable, then they should be translated through the IOMMU, and the
DMA API is the right interface for that.

> Without implementing it all, I think the easiest incremental step would
> be to teach linux to make passthrough the default when running as a
> guest on top of QEMU, put your patches on top. If someone specifies
> non passthrough on command line it'll still be broken,
> but not too bad.

Can powerpc and sparc do exact 1:1 passthrough for a given device?  If
so, that might be a reasonable way forward.  After all, if a new
powerpc kernel asks for exact passthrough (dma addr = phys addr with
no offset at all), then old QEMU will just ignore it and therefore
accidentally get it right.  Ben?

--Andy
