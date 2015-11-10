From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Wed, 11 Nov 2015 06:36:27 +1100
Message-ID: <1447184187.31884.89.camel@kernel.crashing.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<20151110102733.GJ2255@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151110102733.GJ2255@suse.de>
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
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S.
	Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2015-11-10 at 11:27 +0100, Joerg Roedel wrote:
> 
> You have the same problem when real PCIe devices appear that speak
> virtio. I think the only real (still not very nice) solution is to add a
> quirk to powerpc platform code that sets noop dma-ops for the existing
> virtio vendor/device-ids and add a DT property to opt-out of that quirk.
>
> New vendor/device-ids (as for real devices) would just not be covered by
> the quirk and existing emulated devices continue to work.

Why woud real devices use new vendor/device IDs ? Also there are other
cases such as using virtio between 2 partitions, which we could do
under PowerVM ... that would require proper iommu usage with existing
IDs.

> The absence of the property just means that the quirk is in place and
> the system assumes no translation for virtio devices.

The only way that works forward for me (and possibly sparc & others,
what about ARM ?) is if we *change* something in virtio qemu at the
same time as we add some kind of property. For example the ProgIf field
or revision ID field.

That way I can key on that change.

It's still tricky because I would have to somewhat tell my various firmwares
(SLOF, OpenBIOS, OPAL, ...) so they can create the appropriate property, it's
still hacky, but it would be workable.

Ben.
