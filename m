From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Thu, 29 Oct 2015 09:04:43 +0900
Message-ID: <5631629B.2050505@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 29.10.2015 um 07:22 schrieb Andy Lutomirski:
> On Tue, Oct 27, 2015 at 3:48 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> This is an RFC to check if I am on the right track.  There
>> are some attempts to unify the dma ops (Christoph) as well
>> as some attempts to make virtio use the dma API (Andy).
>>
>> At todays discussion at the kernel summit, we concluded that
>> we want to use the same code on all platforms, whereever
>> possible, so having a dummy dma_op might be the easiest
>> solution to keep virtio-ccw as similar as possible to
>> virtio-pci. Andy Lutomirski will rework his patchset to
>> unconditionally use the dma ops.  We will also need a
>> compatibility quirk for powerpc to bypass the iommu mappings
>> on older QEMU version (which translates to all versions as
>> of today) and per device, e.g.  via device tree.  Ben
>> Herrenschmidt will look into that.
> 
> The combination of these patches plus my series don't link for me
> unless I enable PCI.  Would s390 need to select HAS_DMA from VIRTIO or
> something similar?

Well, actually this is a potential improvement for series. I could just 
make the noop dma ops default for _all_ devices unless it has a per 
device dma_ops (e.g. s390 pci) and the unconditionally set HAS_DMA.
> 
> Also, is it possible to use QEMU to emulate an s390x?  Even just:
> 
> qemu-system-s390x -M s390-ccw-virtio

Yes, we have no interactive bios and if no boot device is there is bios
will load a disabled wait, which will exit qemu.

Make sure to compile your kernel for z900  (processor type) as qemu does not
handle all things of newer processors.
You can then do 
qemu-system-s390x -nographic -m 256 -kernel vmlinux -initrd <something>
