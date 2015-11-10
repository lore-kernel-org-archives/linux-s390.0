From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Mon, 9 Nov 2015 16:46:20 -0800
Message-ID: <CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447109937.31884.42.camel@kernel.crashing.org>
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
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 9, 2015 at 2:58 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> So ...
>
> I've finally tried to sort that out for powerpc and I can't find a way
> to make that work that isn't a complete pile of stinking shit.
>
> I'm very tempted to go back to my original idea: virtio itself should
> indicate it's "bypassing ability" via the virtio config space or some
> other bit (like the ProgIf of the PCI header etc...).
>
> I don't see how I can make it work otherwise.
>
> The problem with the statement "it's a platform matter" is that:
>
>   - It's not entirely correct. It's actually a feature of a specific
> virtio implementation (qemu's) that it bypasses all the platform IOMMU
> facilities.
>
>   - The platforms (on powerpc there's at least 3 or 4 that have qemu
> emulation and support some form of PCI) don't have an existing way to
> convey the information that a device bypasses the IOMMU (if any).
>
>   - Even if we add such a mechanism (new property in the device-tree),
> we end up with a big turd: Because we need to be compatible with older
> qemus, we essentially need a quirk that will make all virtio devices
> assume that property is present. That will of course break whenever we
> try to use another implementation of virtio on powerpc which doesn't
> bypass the iommu.
>
> We don't have a way to differenciate a virtio device that does the
> bypass from one that doesn't and the backward compatibility requirement
> forces us to treat all existing virtio devices as doing bypass.

The problem here is that in some of the problematic cases the virtio
driver may not even be loaded.  If someone runs an L1 guest with an
IOMMU-bypassing virtio device and assigns it to L2 using vfio, then
*boom* L1 crashes.  (Same if, say, DPDK gets used, I think.)

>
> The only way out of this while keeping the "platform" stuff would be to
> also bump some kind of version in the virtio config (or PCI header). I
> have no other way to differenciate between "this is an old qemu that
> doesn't do the 'bypass property' yet" from "this is a virtio device
> that doesn't bypass".
>
> Any better idea ?

I'd suggest that, in the absence of the new DT binding, we assume that
any PCI device with the virtio vendor ID is passthrough on powerpc.  I
can do this in the virtio driver, but if it's in the platform code
then vfio gets it right too (i.e. fails to load).

--Andy
