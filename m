Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:32157 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442652AbgJUMva (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Oct 2020 08:51:30 -0400
Date: Wed, 21 Oct 2020 09:51:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/16] follow_pfn and other iomap races
Message-ID: <20201021125124.GA827089@nvidia.com>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org

On Wed, Oct 21, 2020 at 10:56:39AM +0200, Daniel Vetter wrote:
> Hi all,
> 
> Round 3 of my patch series to clamp down a bunch of races and gaps
> around follow_pfn and other access to iomem mmaps. Previous version:
> 
> v1: https://lore.kernel.org/dri-devel/20201007164426.1812530-1-daniel.vetter@ffwll.ch/
> v2: https://lore.kernel.org/dri-devel/20201009075934.3509076-1-daniel.vetter@ffwll.ch
> 
> And the discussion that sparked this journey:
> 
> https://lore.kernel.org/dri-devel/20201007164426.1812530-1-daniel.vetter@ffwll.ch/
> 
> I was waiting for the testing result for habanalabs from Oded, but I guess
> Oded was waiting for my v3.
> 
> Changes in v3:
> - Bunch of polish all over, no functional changes aside from one barrier
>   in the resource code, for consistency.
> - A few more r-b tags.
> 
> Changes in v2:
> - tons of small polish&fixes all over, thanks to all the reviewers who
>   spotted issues
> - I managed to test at least the generic_access_phys and pci mmap revoke
>   stuff with a few gdb sessions using our i915 debug tools (hence now also
>   the drm/i915 patch to properly request all the pci bar regions)
> - reworked approach for the pci mmap revoke: Infrastructure moved into
>   kernel/resource.c, address_space mapping is now set up at open time for
>   everyone (which required some sysfs changes). Does indeed look a lot
>   cleaner and a lot less invasive than I feared at first.
> 
> The big thing I can't test are all the frame_vector changes in habanalbas,
> exynos and media. Gerald has given the s390 patch a spin already.
> 
> Review, testing, feedback all very much welcome.
> 
> Daniel Vetter (16):
>   drm/exynos: Stop using frame_vector helpers
>   drm/exynos: Use FOLL_LONGTERM for g2d cmdlists
>   misc/habana: Stop using frame_vector helpers
>   misc/habana: Use FOLL_LONGTERM for userptr
>   mm/frame-vector: Use FOLL_LONGTERM
>   media: videobuf2: Move frame_vector into media subsystem
>   mm: Close race in generic_access_phys
>   s390/pci: Remove races against pte updates
>   mm: Add unsafe_follow_pfn
>   media/videbuf1|2: Mark follow_pfn usage as unsafe
>   vfio/type1: Mark follow_pfn as unsafe
>   PCI: Obey iomem restrictions for procfs mmap
>   /dev/mem: Only set filp->f_mapping
>   resource: Move devmem revoke code to resource framework
>   sysfs: Support zapping of binary attr mmaps
>   PCI: Revoke mappings like devmem

The whole thing looks like a great improvement!

Thanks,
Jason
