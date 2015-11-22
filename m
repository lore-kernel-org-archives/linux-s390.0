From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 22 Nov 2015 15:06:08 +0200
Message-ID: <5651BDC0.2040206@gmail.com>
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
	<20151108114946.GG2255@suse.de>
Reply-To: marcel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151108114946.GG2255@suse.de>
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
To: Joerg Roedel <jroedel@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On 11/08/2015 01:49 PM, Joerg Roedel wrote:
> On Sun, Nov 08, 2015 at 12:37:47PM +0200, Michael S. Tsirkin wrote:
>> I have no problem with that. For example, can we teach
>> the DMA API on intel x86 to use PT for virtio by default?
>> That would allow merging Andy's patches with
>> full compatibility with old guests and hosts.
>
> Well, the only incompatibility comes from an experimental qemu feature,
> more explicitly from a bug in that features implementation. So why
> should we work around that in the kernel? I think it is not too hard to
> fix qemu to generate a correct DMAR table which excludes the virtio
> devices from iommu translation.

Hi,

I tried to generate a DMAR table that excludes some devices from
IOMMU translation, however it does not help.

The reason is, as far as I understand, that Linux kernel does
not allow any device being outside an IOMMU scope if the
iommu kernel option is activated.

Does anybody know if it is "by design" or is simply an uncommon configuration?
(some devices in an IOMMU scope, while others outside *any* IOMMU scope)

Thanks,
Marcel

>
>
> 	Joerg
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
