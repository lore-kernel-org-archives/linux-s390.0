Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-11-daniel.vetter@ffwll.ch> <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 7 Oct 2020 21:47:37 +0200
Message-ID: <CAKMK7uFoxiPdjO-yhd-mKqumnTpjcENEReb1sOYhOwRRCL0wpQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>

On Wed, Oct 7, 2020 at 9:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Oct 7, 2020 at 11:11 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> > the region") /dev/kmem zaps ptes when the kernel requests exclusive
> > acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> > the default for all driver uses.
> >
> > Except there's two more ways to access pci bars: sysfs and proc mmap
> > support. Let's plug that hole.
>
> Ooh, yes, lets.
>
> > For revoke_devmem() to work we need to link our vma into the same
> > address_space, with consistent vma->vm_pgoff. ->pgoff is already
> > adjusted, because that's how (io_)remap_pfn_range works, but for the
> > mapping we need to adjust vma->vm_file->f_mapping. Usually that's done
> > at ->open time, but that's a bit tricky here with all the entry points
> > and arch code. So instead create a fake file and adjust vma->vm_file.
>
> I don't think you want to share the devmem inode for this, this should
> be based off the sysfs inode which I believe there is already only one
> instance per resource. In contrast /dev/mem can have multiple inodes
> because anyone can just mknod a new character device file, the same
> problem does not exist for sysfs.

But then I need to find the right one, plus I also need to find the
right one for the procfs side. That gets messy, and I already have no
idea how to really test this. Shared address_space is the same trick
we're using in drm (where we have multiple things all pointing to the
same underlying resources, through different files), and it gets the
job done. So that's why I figured the shared address_space is the
cleaner solution since then unmap_mapping_range takes care of
iterating over all vma for us. I guess I could reimplement that logic
with our own locking and everything in revoke_devmem, but feels a bit
silly. But it would also solve the problem of having mutliple
different mknod of /dev/kmem with different address_space behind them.
Also because of how remap_pfn_range works, all these vma do use the
same pgoff already anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
