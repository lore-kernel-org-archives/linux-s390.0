Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Oct 2020 08:56:44 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 08/15] mm: Add unsafe_follow_pfn
Message-ID: <20201029085644.GA25658@infradead.org>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201026105818.2585306-9-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026105818.2585306-9-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, J??r??me Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

> +int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
> +	unsigned long *pfn)

The one tab indent here looks weird, normally tis would be two tabs
or aligned aftetthe opening brace.

> +{
> +#ifdef CONFIG_STRICT_FOLLOW_PFN
> +	pr_info("unsafe follow_pfn usage rejected, see CONFIG_STRICT_FOLLOW_PFN\n");
> +	return -EINVAL;
> +#else
> +	WARN_ONCE(1, "unsafe follow_pfn usage\n");
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +
> +	return follow_pfn(vma, address, pfn);
> +#endif

Woudn't this be a pretty good use case of "if (IS_ENABLED(...)))"?

Also I'd expect the inverse polarity of the config option, that is
a USAFE_FOLLOW_PFN option to enable to unsafe behavior.

> +/**
> + * unsafe_follow_pfn - look up PFN at a user virtual address
> + * @vma: memory mapping
> + * @address: user virtual address
> + * @pfn: location to store found PFN
> + *
> + * Only IO mappings and raw PFN mappings are allowed.
> + *
> + * Returns zero and the pfn at @pfn on success, -ve otherwise.
> + */
> +int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
> +	unsigned long *pfn)
> +{
> +	return follow_pfn(vma, address, pfn);
> +}
> +EXPORT_SYMBOL(unsafe_follow_pfn);

Any reason this doesn't use the warn and disable logic?
