Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJHIfy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 04:35:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361EAC0613D4
        for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2020 01:35:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p13so4966068edi.7
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 01:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-11-daniel.vetter@ffwll.ch> <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
 <20201007232448.GC5177@ziepe.ca> <CAPcyv4jA9fe40r_2SfrCtOaeE85V88TA3NNQZOmQMNj=MdsPyw@mail.gmail.com>
 <CAKMK7uHg48-fTR1L78p7q5vxD=Kgr_fBEj1pDLaYeuvTGSSFig@mail.gmail.com>
In-Reply-To: <CAKMK7uHg48-fTR1L78p7q5vxD=Kgr_fBEj1pDLaYeuvTGSSFig@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 8 Oct 2020 01:35:41 -0700
Message-ID: <CAPcyv4gK82tpNWqwF-CFGPWU99WU-Sd84Y79zuQxMfZh1efoMQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>

On Thu, Oct 8, 2020 at 1:13 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Oct 8, 2020 at 9:50 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 4:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 07, 2020 at 12:33:06PM -0700, Dan Williams wrote:
> > > > On Wed, Oct 7, 2020 at 11:11 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > > >
> > > > > Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> > > > > the region") /dev/kmem zaps ptes when the kernel requests exclusive
> > > > > acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> > > > > the default for all driver uses.
> > > > >
> > > > > Except there's two more ways to access pci bars: sysfs and proc mmap
> > > > > support. Let's plug that hole.
> > > >
> > > > Ooh, yes, lets.
> > > >
> > > > >
> > > > > For revoke_devmem() to work we need to link our vma into the same
> > > > > address_space, with consistent vma->vm_pgoff. ->pgoff is already
> > > > > adjusted, because that's how (io_)remap_pfn_range works, but for the
> > > > > mapping we need to adjust vma->vm_file->f_mapping. Usually that's done
> > > > > at ->open time, but that's a bit tricky here with all the entry points
> > > > > and arch code. So instead create a fake file and adjust vma->vm_file.
> > > >
> > > > I don't think you want to share the devmem inode for this, this should
> > > > be based off the sysfs inode which I believe there is already only one
> > > > instance per resource. In contrast /dev/mem can have multiple inodes
> > > > because anyone can just mknod a new character device file, the same
> > > > problem does not exist for sysfs.
> > >
> > > The inode does not come from the filesystem char/mem.c creates a
> > > singular anon inode in devmem_init_inode()
> >
> > That's not quite right, An inode does come from the filesystem I just
> > arranged for that inode's i_mapping to be set to a common instance.
> >
> > > Seems OK to use this more widely, but it feels a bit weird to live in
> > > char/memory.c.
> >
> > Sure, now that more users have arrived it should move somewhere common.
> >
> > > This is what got me thinking maybe this needs to be a bit bigger
> > > generic infrastructure - eg enter this scheme from fops mmap and
> > > everything else is in mm/user_iomem.c
> >
> > It still requires every file that can map physical memory to have its
> > ->open fop do
> >
> >        inode->i_mapping = devmem_inode->i_mapping;
> >        filp->f_mapping = inode->i_mapping;
> >
> > I don't see how you can centralize that part.
>
> btw, why are you setting inode->i_mapping? The inode is already
> published, changing that looks risky. And I don't think it's needed,
> vma_link() only looks at filp->f_mapping, and in our drm_open() we
> only set that one.

I think you're right it is unnecessary for devmem, but I don't think
it's dangerous to do it from the very first open before anything is
using the address space. It's copy-paste from what all the other
"shared address space" implementers do. For example, block-devices in
bd_acquire(). However, the rationale for block_devices to do it is so
that page cache pages can be associated with the address space in the
absence of an f_mapping. Without filesystem page writeback to
coordinate I don't see any devmem code paths that would operate on the
inode->i_mapping.
