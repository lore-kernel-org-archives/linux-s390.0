From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Thu, 29 Oct 2015 18:17:02 -0700
Message-ID: <CALCETrWP14E9k=BKhhm3CJZmM_W9CYt77W0m29BtzigZucSu5g@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
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
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 6:09 PM, Andy Lutomirski <luto@kernel.org> wrote:
> This switches virtio to use the DMA API unconditionally.  I'm sure
> it breaks things, but it seems to work on x86 using virtio-pci, with
> and without Xen, and using both the modern 1.0 variant and the
> legacy variant.

...

> Andy Lutomirski (5):
>   virtio_ring: Support DMA APIs
>   virtio_pci: Use the DMA API
>   virtio: Add improved queue allocation API
>   virtio_mmio: Use the DMA API
>   virtio_pci: Use the DMA API

Ugh.  The two virtio_pci patches should be squashed together.  I'll do
that for v5, but I'm not going to send it until there's more feedback.

FWIW, I'm collecting this stuff here:

https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=virtio_dma

That branch includes this series (with the squash) and the s390
patches.  I'll keep it up to date, since it seems silly to declare it
stable enough to stop rebasing yet.

--Andy
