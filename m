From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Mon, 9 Nov 2015 21:33:07 -0800
Message-ID: <CALCETrVopuN6s7ZTa4ZRe1E1wPiWy_2gMR_OH2B2rK0+VdeWVg@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org> <20151109133624-mutt-send-email-mst@redhat.com>
 <1447109937.31884.42.camel@kernel.crashing.org> <CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
 <1447121076.31884.61.camel@kernel.crashing.org> <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
 <1447133190.31884.65.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447133190.31884.65.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 9, 2015 at 9:26 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2015-11-09 at 18:18 -0800, Andy Lutomirski wrote:
>>
>> Which leaves the special case of Xen, where even preexisting devices
>> don't bypass the IOMMU.  Can we keep this specific to powerpc and
>> sparc?  On x86, this problem is basically nonexistent, since the IOMMU
>> is properly self-describing.
>>
>> IOW, I think that on x86 we should assume that all virtio devices
>> honor the IOMMU.
>
> You don't like performances ? :-)

This should have basically no effect.  Every non-experimental x86
virtio setup in existence either doesn't work at all (Xen) or has DMA
ops that are no-ops.

--Andy
