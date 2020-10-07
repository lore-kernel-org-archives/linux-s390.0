Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch> <20201007164426.1812530-11-daniel.vetter@ffwll.ch>
In-Reply-To: <20201007164426.1812530-11-daniel.vetter@ffwll.ch>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Oct 2020 12:33:06 -0700
Message-ID: <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 11:11 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> the region") /dev/kmem zaps ptes when the kernel requests exclusive
> acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> the default for all driver uses.
>
> Except there's two more ways to access pci bars: sysfs and proc mmap
> support. Let's plug that hole.

Ooh, yes, lets.

>
> For revoke_devmem() to work we need to link our vma into the same
> address_space, with consistent vma->vm_pgoff. ->pgoff is already
> adjusted, because that's how (io_)remap_pfn_range works, but for the
> mapping we need to adjust vma->vm_file->f_mapping. Usually that's done
> at ->open time, but that's a bit tricky here with all the entry points
> and arch code. So instead create a fake file and adjust vma->vm_file.

I don't think you want to share the devmem inode for this, this should
be based off the sysfs inode which I believe there is already only one
instance per resource. In contrast /dev/mem can have multiple inodes
because anyone can just mknod a new character device file, the same
problem does not exist for sysfs.
