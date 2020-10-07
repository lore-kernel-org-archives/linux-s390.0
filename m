Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgJGRjN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 13:39:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEAC061755
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 10:39:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c2so3771588qkf.10
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 10:39:13 -0700 (PDT)
Date: Wed, 7 Oct 2020 14:39:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 13/13] vfio/type1: Mark follow_pfn as unsafe
Message-ID: <20201007173911.GX5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Wed, Oct 07, 2020 at 06:44:26PM +0200, Daniel Vetter wrote:
> The code seems to stuff these pfns into iommu pts (or something like
> that, I didn't follow), but there's no mmu_notifier to ensure that
> access is synchronized with pte updates.
> 
> Hence mark these as unsafe. This means that with
> CONFIG_STRICT_FOLLOW_PFN, these will be rejected.
> 
> Real fix is to wire up an mmu_notifier ... somehow. Probably means any
> invalidate is a fatal fault for this vfio device, but then this
> shouldn't ever happen if userspace is reasonable.
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
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5fbf0c1f7433..a4d53f3d0a35 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -421,7 +421,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  {
>  	int ret;
>  
> -	ret = follow_pfn(vma, vaddr, pfn);
> +	ret = unsafe_follow_pfn(vma, vaddr, pfn);
>  	if (ret) {
>  		bool unlocked = false;
>  
> @@ -435,7 +435,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  		if (ret)
>  			return ret;
>  
> -		ret = follow_pfn(vma, vaddr, pfn);
> +		ret = unsafe_follow_pfn(vma, vaddr, pfn);
>  	}

This is actually being commonly used, so it needs fixing.

When I talked to Alex about this last we had worked out a patch series
that adds a test on vm_ops that the vma came from vfio in the first
place. The VMA's created by VFIO are 'safe' as the PTEs are never changed.

Jason
