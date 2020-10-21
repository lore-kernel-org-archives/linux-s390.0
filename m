Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442624AbgJUMud (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Oct 2020 08:50:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6895C0613D4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 05:50:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s1so965989qvm.13
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 05:50:32 -0700 (PDT)
Date: Wed, 21 Oct 2020 09:50:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
Message-ID: <20201021125030.GK36674@ziepe.ca>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021085655.1192025-13-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.com>

On Wed, Oct 21, 2020 at 10:56:51AM +0200, Daniel Vetter wrote:
> There's three ways to access PCI BARs from userspace: /dev/mem, sysfs
> files, and the old proc interface. Two check against
> iomem_is_exclusive, proc never did. And with CONFIG_IO_STRICT_DEVMEM,
> this starts to matter, since we don't want random userspace having
> access to PCI BARs while a driver is loaded and using it.
> 
> Fix this by adding the same iomem_is_exclusive() check we already have
> on the sysfs side in pci_mmap_resource().
> 
> References: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.com>

Maybe not for fixing in this series, but this access to
IORESOURCE_BUSY doesn't have any locking.

The write side holds the resource_lock at least..

>  	ret = pci_mmap_page_range(dev, i, vma,
>  				  fpriv->mmap_state, write_combine);

At this point the vma isn't linked into the address space, so doesn't
this happen?

     CPU 0                                  CPU1
 mmap_region()
   vma = vm_area_alloc
   proc_bus_pci_mmap
    iomem_is_exclusive
    pci_mmap_page_range
                                            revoke_devmem
                                             unmap_mapping_range()
     // vma is not linked to the address space here,
     // unmap doesn't find it
  vma_link() 
  !!! The VMA gets mapped with the revoked PTEs

I couldn't find anything that prevents it at least, no mmap_sem on the
unmap side, just the i_mmap_lock

Not seeing how address space and pre-populating during mmap work
together? Did I miss locking someplace?

Not something to be fixed for this series, this is clearly an
improvement, but seems like another problem to tackle?

Jason
