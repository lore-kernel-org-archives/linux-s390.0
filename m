Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] mm/frame-vector: Use FOLL_LONGTERM
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-6-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4685181e-8306-0d96-8be6-592b3c563cbf@nvidia.com>
Date: Fri, 16 Oct 2020 00:54:18 -0700
MIME-Version: 1.0
In-Reply-To: <20201009075934.3509076-6-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>

On 10/9/20 12:59 AM, Daniel Vetter wrote:
...
> @@ -48,40 +47,25 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>   
>   	start = untagged_addr(start);
>   
> -	mmap_read_lock(mm);
> -	locked = 1;
> -	vma = find_vma_intersection(mm, start, start + 1);
> -	if (!vma) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> -
> -	/*
> -	 * While get_vaddr_frames() could be used for transient (kernel
> -	 * controlled lifetime) pinning of memory pages all current
> -	 * users establish long term (userspace controlled lifetime)
> -	 * page pinning. Treat get_vaddr_frames() like
> -	 * get_user_pages_longterm() and disallow it for filesystem-dax
> -	 * mappings.
> -	 */
> -	if (vma_is_fsdax(vma)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> -	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> +	ret = pin_user_pages_fast(start, nr_frames,
> +				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  (struct page **)(vec->ptrs));
> +	if (ret > 0) {

None of the callers that we have today will accept anything less than
ret == nr_frames. And the whole partially pinned region idea turns out
to be just not useful for almost everyone, from what I recall of the gup/pup
call sites. So I wonder if we should just have get_vaddr_frames do the
cleanup here and return -EFAULT, if ret != nr_frames ?

thanks,
-- 
John Hubbard
NVIDIA
