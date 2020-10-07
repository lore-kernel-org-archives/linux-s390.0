Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgJGRgt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 13:36:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E83C0613D5
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 10:36:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j22so2631309qtj.8
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 10:36:49 -0700 (PDT)
Date: Wed, 7 Oct 2020 14:36:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 11/13] mm: add unsafe_follow_pfn
Message-ID: <20201007173647.GW5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-12-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007164426.1812530-12-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

On Wed, Oct 07, 2020 at 06:44:24PM +0200, Daniel Vetter wrote:
> Way back it was a reasonable assumptions that iomem mappings never
> change the pfn range they point at. But this has changed:
> 
> - gpu drivers dynamically manage their memory nowadays, invalidating
> ptes with unmap_mapping_range when buffers get moved
> 
> - contiguous dma allocations have moved from dedicated carvetouts to
> cma regions. This means if we miss the unmap the pfn might contain
> pagecache or anon memory (well anything allocated with GFP_MOVEABLE)
> 
> - even /dev/mem now invalidates mappings when the kernel requests that
> iomem region when CONFIG_IO_STRICT_DEVMEM is set, see 3234ac664a87
> ("/dev/mem: Revoke mappings when a driver claims the region")
> 
> Accessing pfns obtained from ptes without holding all the locks is
> therefore no longer a good idea.
> 
> Unfortunately there's some users where this is not fixable (like v4l
> userptr of iomem mappings) or involves a pile of work (vfio type1
> iommu). For now annotate these as unsafe and splat appropriately.
> 
> This patch adds an unsafe_follow_pfn, which later patches will then
> roll out to all appropriate places.
> 
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
> Cc: kvm@vger.kernel.org
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 32 +++++++++++++++++++++++++++++++-
>  mm/nommu.c         | 17 +++++++++++++++++
>  security/Kconfig   | 13 +++++++++++++
>  4 files changed, 63 insertions(+), 1 deletion(-)

Makes sense to me.

I wonder if we could change the original follow_pfn to require the
ptep and then lockdep_assert_held() it against the page table lock?

> +int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
> +	unsigned long *pfn)
> +{
> +#ifdef CONFIG_STRICT_FOLLOW_PFN
> +	pr_info("unsafe follow_pfn usage rejected, see
> CONFIG_STRICT_FOLLOW_PFN\n");

Wonder if we can print something useful here, like the current
PID/process name?

> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..48945402e103 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -230,6 +230,19 @@ config STATIC_USERMODEHELPER_PATH
>  	  If you wish for all usermode helper programs to be disabled,
>  	  specify an empty string here (i.e. "").
>  
> +config STRICT_FOLLOW_PFN
> +	bool "Disable unsafe use of follow_pfn"
> +	depends on MMU

I would probably invert this CONFIG_ALLOW_UNSAFE_FOLLOW_PFN
default n

Jason
