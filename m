From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Fri, 20 Nov 2015 10:34:18 +0200
Message-ID: <20151120102141-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
 <20151119153821-mutt-send-email-mst@redhat.com>
 <CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
 <1447976286.145626.122.camel@infradead.org>
 <1447988199.3016.2.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447988199.3016.2.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 20, 2015 at 01:56:39PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2015-11-19 at 23:38 +0000, David Woodhouse wrote:
> >=20
> > I understand that POWER and other platforms don't currently have a
> > clean way to indicate that certain device don't have translation. A=
nd I
> > understand that we may end up with a *quirk* which ensures that the=
 DMA
> > API does the right thing (i.e. nothing) in certain cases.
> >=20
> > But we should *NOT* be involving the virtio device drivers in that
> > quirk, in any way. And putting a feature bit in the virtio device
> > itself doesn't seem at all sane either.
> >=20
> > Bear in mind that qemu-system-x86_64 currently has the *same* probl=
em
> > with assigned physical devices. It's claiming they're translated, a=
nd
> > they're not.
>=20
> It's not that clear but yeah ... as I mentioned, I can't find a
> way to do that quirk that won't break when we want to actually use
> the iommu...=A0
>=20
> Ben.

Yes, I am not at all sure we need a quirk for assigned devices.
Better teach QEMU to make iommu work for them.


--=20
MST
