From: Marcel Apfelbaum <marcel@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 22 Nov 2015 19:04:32 +0200
Message-ID: <5651F5A0.5060400@redhat.com>
References: <1446039327.3405.216.camel@infradead.org>
 <20151028155105-mutt-send-email-mst@redhat.com>
 <1446041609.3405.228.camel@infradead.org>
 <20151028161424-mutt-send-email-mst@redhat.com>
 <1446042754.3405.237.camel@infradead.org>
 <20151028175136-mutt-send-email-mst@redhat.com>
 <CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
 <20151029104301-mutt-send-email-mst@redhat.com>
 <1446135536.3405.279.camel@infradead.org>
 <20151108120627-mutt-send-email-mst@redhat.com>
 <20151108114946.GG2255@suse.de> <5651BDC0.2040206@gmail.com>
 <1448207661.89124.50.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1448207661.89124.50.camel@infradead.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/22/2015 05:54 PM, David Woodhouse wrote:
> On Sun, 2015-11-22 at 15:06 +0200, Marcel Apfelbaum wrote:
>>
>>
>> I tried to generate a DMAR table that excludes some devices from
>> IOMMU translation, however it does not help.
>>
>> The reason is, as far as I understand, that Linux kernel does
>> not allow any device being outside an IOMMU scope if the
>> iommu kernel option is activated.
>>
>> Does anybody know if it is "by design" or is simply an uncommon
>> configuration?
>> (some devices in an IOMMU scope, while others outside *any* IOMMU
>> scope)
>
> That's a kernel bug in the way it handles per-device DMA operations. =
Or
> more to the point, in the way it doesn't =E2=80=94 the non-translated=
 devices
> end up being pointed to the intel_dma_ops despite the fact they
> shouldn't be. I'm working on that...
>

Hi David,
Thank you for the fast response.

Sadly I am not familiar with the DMA/IOMMU code to contribute
with a sane idea, but I'll gladly test it.
If you lack the time and have an idea to share, I can give it a try tho=
ugh.

Thanks,
Marcel
