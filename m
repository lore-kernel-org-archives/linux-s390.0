From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 14:43:09 +0200
Message-ID: <20151110142633-mutt-send-email-mst@redhat.com>
References: <cover.1446162273.git.luto@kernel.org>
 <20151109133624-mutt-send-email-mst@redhat.com>
 <1447109937.31884.42.camel@kernel.crashing.org>
 <CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
 <1447121076.31884.61.camel@kernel.crashing.org>
 <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
 <1447133316.31884.67.camel@kernel.crashing.org>
 <CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
 <1447151874.31884.82.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447151874.31884.82.camel@kernel.crashing.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 10, 2015 at 09:37:54PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-11-09 at 21:35 -0800, Andy Lutomirski wrote:
> >=20
> > We could do it the other way around: on powerpc, if a PCI device is=
 in
> > that range and doesn't have the "bypass" property at all, then it's
> > assumed to bypass the IOMMU.=A0=A0This means that everything that
> > currently works continues working.=A0=A0If someone builds a physica=
l
> > virtio device or uses another system in PCIe target mode speaking
> > virtio, then it won't work until they upgrade their firmware to set
> > bypass=3D0.=A0=A0Meanwhile everyone using hypothetical new QEMU als=
o gets
> > bypass=3D0 and no ambiguity.
> >
> > vfio will presumably notice the bypass and correctly refuse to map =
any
> > current virtio devices.
> >=20
> > Would that work?
>=20
> That would be extremely strange from a platform perspective. Any devi=
ce
> in that vendor/device range would bypass the iommu unless some new
> property "actually-works-like-a-real-pci-device" happens to exist in
> the device-tree, which we would then need to define somewhere and
> handle accross at least 3 different platforms who get their device-tr=
ee=20
> from widly different places.

Then we are back to virtio driver telling DMA core
whether it wants a 1:1 mapping in the iommu?
If that's acceptable to others, I don't think that's too bad.


> Also if tomorrow I create a PCI device that implements virtio-net and
> put it in a machine running IBM proprietary firmware (or Apple's or
> Sun's), it won't have that property...
>=20
> This is not hypothetical. People are using virtio to do point-to-poin=
t
> communication between machines via PCIe today.
>=20
> Cheers,
> Ben.

But not virtio-pci I think - that's broken for that usecase since we us=
e
weaker barriers than required for real IO, as these have measureable
overhead.  We could have a feature "is a real PCI device",
that's completely reasonable.

--=20
MST
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
