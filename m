From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 11:27:33 +0100
Message-ID: <20151110102733.GJ2255@suse.de>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1447121076.31884.61.camel@kernel.crashing.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 10, 2015 at 01:04:36PM +1100, Benjamin Herrenschmidt wrote:
> The "in absence of the new DT binding" doesn't make that much sense.
> =

> Those platforms use device-trees defined since the dawn of ages by
> actual open firmware implementations, they either have no iommu
> representation in there (Macs, the platform code hooks it all up) or
> have various properties related to the iommu but no concept of "bypass"
> in there.
> =

> We can *add* a new property under some circumstances that indicates a
> bypass on a per-device basis, however that doesn't completely solve it:
> =

> =A0 - As I said above, what does the absence of that property mean ? An
> old qemu that does bypass on all virtio or a new qemu trying to tell
> you that the virtio device actually does use the iommu (or some other
> environment that isn't qemu) ?

You have the same problem when real PCIe devices appear that speak
virtio. I think the only real (still not very nice) solution is to add a
quirk to powerpc platform code that sets noop dma-ops for the existing
virtio vendor/device-ids and add a DT property to opt-out of that quirk.

New vendor/device-ids (as for real devices) would just not be covered by
the quirk and existing emulated devices continue to work.

The absence of the property just means that the quirk is in place and
the system assumes no translation for virtio devices.


	Joerg
