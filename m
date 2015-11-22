From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 22 Nov 2015 23:52:29 +0200
Message-ID: <20151122231622-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
 <20151119153821-mutt-send-email-mst@redhat.com>
 <CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
 <1447976286.145626.122.camel@infradead.org>
 <20151120085658-mutt-send-email-mst@redhat.com>
 <1448207908.89124.54.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448207908.89124.54.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.a@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Nov 22, 2015 at 03:58:28PM +0000, David Woodhouse wrote:
> On Fri, 2015-11-20 at 10:21 +0200, Michael S. Tsirkin wrote:
> >=20
> > David, there are two things a hypervisor needs to tell the guest.
> > 1. The actual device is behind an IOMMU. This is what you
> > =A0=A0 are suggesting we use DMAR for.
> > 2. Using IOMMU from kernel (as opposed to from userspace with VFIO)
> > =A0=A0 actually adds security. For exising virtio devices on KVM,
> > =A0=A0 the answer is no. And DMAR has no way to reflect that.
>=20
> Using the IOMMU from the kernel *always* adds security. It protects
> against device driver (and device) bugs which can be made exploitable
> by allowing DMA to anywhere in the system.

No - speaking about QEMU/KVM here - you are not "allowing" DMA - by
programming the virtual IOMMU you are asking the hypervisor nicely to d=
o
that. If it's buggy, it can ignore you and there's nothing you can do.

As with any random change in the system, some bugs might get masked and
become non-exploitable, but then some other bugs might surface and
become exploitable.

I gather that e.g. Xen is different.


> Sure, there are classes of that which are far more interesting, for
> example where you give the whole device to a guest and let it load th=
e
> firmware. But "we trust the hypervisor" and "we trust the hardware" a=
re
> not *so* far apart conceptually.

Depends on the hypervisor I guess. At least for QEMU/KVM, one conceptua=
l
difference is that we actually could have the hypervisor tell us whethe=
r
a specific device has to be trusted, or can be protected against, and
user can actually read the code and verify that QEMU is doing the right
thing.

Hardware is closed source so harder to trust.

> Hell, with ATS you *still* have to trust the hardware to a large
> extent.
>
> I really think that something like the proposed DMA_ATTR_IOMMU_BYPASS
> should suffice

I'm not sure how that is supposed to be used - does
the driver request DMA_ATTR_IOMMU_BYPASS at setup time?

If yes then I think that will work for virtio -
we can just set that in the driver.

> for the "who cares about security; we want performance"
> case.
>=20
> --=A0
> dwmw2
>=20

There's that, and there's an "I care about security, but
do not want to burn up cycles on fake protections that
do not work" case.


--=20
MST
