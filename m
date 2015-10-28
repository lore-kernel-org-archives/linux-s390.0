From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Wed, 28 Oct 2015 15:22:16 -0700
Message-ID: <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 3:48 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> This is an RFC to check if I am on the right track.  There
> are some attempts to unify the dma ops (Christoph) as well
> as some attempts to make virtio use the dma API (Andy).
>
> At todays discussion at the kernel summit, we concluded that
> we want to use the same code on all platforms, whereever
> possible, so having a dummy dma_op might be the easiest
> solution to keep virtio-ccw as similar as possible to
> virtio-pci. Andy Lutomirski will rework his patchset to
> unconditionally use the dma ops.  We will also need a
> compatibility quirk for powerpc to bypass the iommu mappings
> on older QEMU version (which translates to all versions as
> of today) and per device, e.g.  via device tree.  Ben
> Herrenschmidt will look into that.

The combination of these patches plus my series don't link for me
unless I enable PCI.  Would s390 need to select HAS_DMA from VIRTIO or
something similar?

Also, is it possible to use QEMU to emulate an s390x?  Even just:

qemu-system-s390x -M s390-ccw-virtio

exits immediately.  (I build from QEMU git today.)  I don't know what
options to pass to get -M s390 to do anything useful, and AFAICT it's
considered deprecated.

Help?

--Andy
