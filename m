From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/3] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 08:11:15 -0700
Message-ID: <CALCETrUWR8p7XSiTALd19LL4mTgkXu_XEewobouz6Jbkb4KjLw@mail.gmail.com>
References: <cover.1409087794.git.luto@amacapital.net>
	<CAJSP0QUcXQ+JV0wys2Mr-+OsFKt=hTGbUxNqfpk-JuyULiQABQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QUcXQ+JV0wys2Mr-+OsFKt=hTGbUxNqfpk-JuyULiQABQ@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Aug 26, 2014 11:46 PM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
>
> On Tue, Aug 26, 2014 at 10:16 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > There are two outstanding issues.  virtio_net warns if DMA debugging
> > is on because it does DMA from the stack.  (The warning is correct.)
> > This also is likely to do something unpleasant to s390.
> > (Maintainers are cc'd -- I don't know what to do about it.)
>
> This changes the semantics of vring and breaks existing guests when
> bus address != physical address.
>
> Can you use a transport feature bit to indicate that bus addresses are
> used?  That way both approaches can be supported.

I can try to support both styles of addressing, but I don't think that
this can be negotiated between the device (i.e. host or physical
virtio-speaking device) and the guest.  In the Xen case that I care
about (Linux on Xen on KVM), the host doesn't know about the
translation at all -- Xen is an intermediate layer that only the guest
is aware of.  In this case, there are effectively two layers of
virtualization, and only the inner one (Xen) knows about the
translation despite the fact that the the outer layer is the one
providing the virtio device.

I could change virtio_ring to use the DMA API only if requested by the
lower driver (virtio_pci, etc) and to have only virtio_pci enable that
feature.  Will that work for all cases?

On s390, this shouldn't work just like the current code.  On x86, I
think that if QEMU ever starts exposing an IOMMU attached to a
virtio-pci device, then QEMU should expect that IOMMU to be used.  If
QEMU expects to see physical addresses, then it shouldn't advertise an
IOMMU.  Since QEMU doesn't currently support guest IOMMUs, this should
be fine for everything that uses QEMU.

At least x86's implementation of the DMA ops for devices that aren't
behind an IOMMU should be very fast.

Are there any other weird cases for which this might be a problem?

>
> Please also update the virtio specification:
> https://tools.oasis-open.org/version-control/browse/wsvn/virtio/
>

I'm not sure it will need an update.  Perhaps a note in the PCI
section indicating that, if the host expects the guest to program an
IOMMU, then it should use the appropriate platform-specific mechanism
to expose that IOMMU.

--Andy
