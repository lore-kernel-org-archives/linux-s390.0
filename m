Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgJHIKG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 04:10:06 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB55AC0613D2
        for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2020 01:10:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m11so4691828otk.13
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 01:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-11-daniel.vetter@ffwll.ch> <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
 <CAKMK7uFoxiPdjO-yhd-mKqumnTpjcENEReb1sOYhOwRRCL0wpQ@mail.gmail.com>
 <CAPcyv4jGxsB5so8mKqYrsn2CEc7nO2yPvzZZ_mvM_-R=BZfKHg@mail.gmail.com> <CAPcyv4iN1q0LUVTO6igMKPe-8hnR5ULF+mBnWy6bdXfY2M6YmA@mail.gmail.com>
In-Reply-To: <CAPcyv4iN1q0LUVTO6igMKPe-8hnR5ULF+mBnWy6bdXfY2M6YmA@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 8 Oct 2020 10:09:54 +0200
Message-ID: <CAKMK7uEETcQrPBC=4URQZtD73nA9MvQpBx-TOv95bdwzNOOA2g@mail.gmail.com>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>

On Thu, Oct 8, 2020 at 12:29 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Oct 7, 2020 at 3:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 12:49 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > >
> > > On Wed, Oct 7, 2020 at 9:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
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
> > > But then I need to find the right one, plus I also need to find the
> > > right one for the procfs side. That gets messy, and I already have no
> > > idea how to really test this. Shared address_space is the same trick
> > > we're using in drm (where we have multiple things all pointing to the
> > > same underlying resources, through different files), and it gets the
> > > job done. So that's why I figured the shared address_space is the
> > > cleaner solution since then unmap_mapping_range takes care of
> > > iterating over all vma for us. I guess I could reimplement that logic
> > > with our own locking and everything in revoke_devmem, but feels a bit
> > > silly. But it would also solve the problem of having mutliple
> > > different mknod of /dev/kmem with different address_space behind them.
> > > Also because of how remap_pfn_range works, all these vma do use the
> > > same pgoff already anyway.
> >
> > True, remap_pfn_range() makes sure that ->pgoff is an absolute
> > physical address offset for all use cases. So you might be able to
> > just point proc_bus_pci_open() at the shared devmem address space. For
> > sysfs it's messier. I think you would need to somehow get the inode
> > from kernfs_fop_open() to adjust its address space, but only if the
> > bin_file will ultimately be used for PCI memory.

Just read the code  a bit more, and for proc it's impossible. There's
only a single file, and before you mmap it you have to call a few
ioctl to select the right pci resource on that device you want to
mmap. Which includes legacy ioport stuff, and at least for now those
don't get revoked (maybe they should, but I'm looking at iomem here
now). Setting the mapping too early in ->open means that on
architectures which can do ioport as mmaps (not many, but powerpc is
among them) we'd shoot down these mmaps too.

Looking at the code there's the generic implementation, which consults
pci_iobar_pfn. And the only other implementation for sparc looks
similar, they separate iomem vs ioport through different pfn. So I
think this should indeed work.

> To me this seems like a new sysfs_create_bin_file() flavor that
> registers the file with the common devmem address_space.

Hm I think we could just add a i_mapping member to bin_attributes and
let the normal open code set that up for us. That should work.
mmapable binary sysfs file is already a similar special case.
-Daniel




--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
