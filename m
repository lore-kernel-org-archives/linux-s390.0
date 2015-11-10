From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Mon, 9 Nov 2015 21:35:02 -0800
Message-ID: <CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org> <20151109133624-mutt-send-email-mst@redhat.com>
 <1447109937.31884.42.camel@kernel.crashing.org> <CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
 <1447121076.31884.61.camel@kernel.crashing.org> <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
 <1447133316.31884.67.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447133316.31884.67.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 9, 2015 at 9:28 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2015-11-09 at 18:18 -0800, Andy Lutomirski wrote:
>>
>> /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF.
>> */
>> static const struct pci_device_id virtio_pci_id_table[] = {
>>         { PCI_DEVICE(0x1af4, PCI_ANY_ID) },
>>         { 0 }
>> };
>>
>> Can we match on that range?
>
> We can, but the problem remains, how do we differenciate an existing
> device that does bypass vs. a newer one that needs the IOMMU and thus
> doesn't have the new "bypass" property in the device-tree.
>

We could do it the other way around: on powerpc, if a PCI device is in
that range and doesn't have the "bypass" property at all, then it's
assumed to bypass the IOMMU.  This means that everything that
currently works continues working.  If someone builds a physical
virtio device or uses another system in PCIe target mode speaking
virtio, then it won't work until they upgrade their firmware to set
bypass=0.  Meanwhile everyone using hypothetical new QEMU also gets
bypass=0 and no ambiguity.

vfio will presumably notice the bypass and correctly refuse to map any
current virtio devices.

Would that work?

--Andy
