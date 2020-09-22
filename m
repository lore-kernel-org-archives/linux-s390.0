Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbgIVGXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 02:23:10 -0400
Subject: Re: [PATCH] kernel/resource: Fix use of ternary condition in
 release_mem_region_adjustable
References: <20200911103459.10306-2-david@redhat.com>
 <20200922060748.2452056-1-natechancellor@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <330ff427-6971-25ec-2380-d1c8ad2dc7bc@redhat.com>
Date: Tue, 22 Sep 2020 08:22:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200922060748.2452056-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, bhe@redhat.com, dan.j.williams@intel.com, jgg@ziepe.ca, keescook@chromium.org, linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, mhocko@suse.com, pankaj.gupta.linux@gmail.com, richardw.yang@linux.intel.com, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, clang-built-linux@googlegroups.com

On 22.09.20 08:07, Nathan Chancellor wrote:
> Clang warns:
> 
> kernel/resource.c:1281:53: warning: operator '?:' has lower precedence
> than '|'; '|' will be evaluated first
> [-Wbitwise-conditional-parentheses]
>         new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                  ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> kernel/resource.c:1281:53: note: place parentheses around the '|'
> expression to silence this warning
>         new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                  ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> kernel/resource.c:1281:53: note: place parentheses around the '?:'
> expression to evaluate it first
>         new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                                            ^
>                                               (                              )
> 1 warning generated.
> 
> Add the parentheses as it was clearly intended for the ternary condition
> to be evaluated first.
> 
> Fixes: 5fd23bd0d739 ("kernel/resource: make release_mem_region_adjustable() never fail")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1159
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Presumably, this will be squashed but I included a fixes tag
> nonetheless. Apologies if this has already been noticed and fixed
> already, I did not find anything on LKML.

Hasn't been noticed before (I guess most people build with GCC, which
does not warn in this instance, at least for me) thanks!

Commit ids are not stable yet, so Andrew will most probably squash it.

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index ca2a666e4317..3ae2f56cc79d 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1278,7 +1278,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  	 * similarly).
>  	 */
>  retry:
> -	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
> +	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
>  
>  	p = &parent->child;
>  	write_lock(&resource_lock);
> 
> base-commit: 40ee82f47bf297e31d0c47547cd8f24ede52415a
> 


-- 
Thanks,

David / dhildenb
