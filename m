Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEA2D7BF;
	Thu, 12 Jun 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718680; cv=none; b=lGpAHJ6QvJKvt3MzFrJpZSUBiIWcjB1KPQZ3UT4K7VTHiwsIJBHw1iTou//nq/cv9w0uludDtM9aQUduy2IXRwdlP09pEaKHA8mEkl0rwETdPyKaKoUPEbGJO+OOs39omkRBH6GFqEop8qbiVtkcC9u0flQ8Hlo/PLM6S6bBJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718680; c=relaxed/simple;
	bh=BypLNqwBlyb9rBmpUWSRlT4eLHQJ96bKDnE5K9dLUG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0HM78/wx0lTgO1tL1wp0d+nTWtZ4pLJ1qHsxyfHqpm61hSocuS3MoHCSFVzbjfVlDBNFMA5JKP35jhoauVbvEqok4Jv1hpuY4Mo6sGEGLnVFvAG/bIG7xiHWrUn9fZQ15qLFvrqCR/uRC6OxLitJqKvjAmOUR1j0uxry84S7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRWbeulX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRWbeulX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E3CC4CEEA;
	Thu, 12 Jun 2025 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749718680;
	bh=BypLNqwBlyb9rBmpUWSRlT4eLHQJ96bKDnE5K9dLUG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRWbeulXkdN4ok9yIEgSL+AxDcjiHgVrzKUttBjEjCJRA7theN+HcP7h7GIkvq2fx
	 DfUdY9qcFt1YSg/O4JpAYBIZKU9hVfCJpfO/cD3G4UulkhyrynbA0qhMJhcjsHuf/j
	 CKhTvB1YFnCWKjV0TsXKgtQEXY/VVlnx/mSakcuQ1W85arY7TQqHY0cq6ucYAVliyv
	 LBFNDwvzSEeCL4Vy+2AlUwHfKRtrbhAf/KeEwqk8AIPhD6XmBgMG9mJXiSeOwAg1Kb
	 E9x2gnsnW0avJ3AG33q0w6NWtz+YUzS3DoJVFTjY8laOAnFL6SYsm4gkNNj1/sMbiR
	 v+mq4H0ZEdyBg==
Date: Thu, 12 Jun 2025 11:57:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH 5/5] mm/alloc_tag: add the CONFIG_ARCH_NEEDS_WEAK_PER_CPU
 macro when statically defining the percpu variable _shared_alloc_tag
Message-ID: <aEqWjSSLB3TPt9CH@kernel.org>
References: <cover.1749715979.git.gehao@kylinos.cn>
 <adcd63180c9492361d929019c60ffa942255988a.1749715979.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcd63180c9492361d929019c60ffa942255988a.1749715979.git.gehao@kylinos.cn>

On Thu, Jun 12, 2025 at 04:27:30PM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Recently discovered this entry while checking kallsyms on ARM64:
> ffff800083e509c0 D _shared_alloc_tag
> 
> If CONFIG_ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
> s390 and alpha architectures),there's no need to statically define
> the percpu variable _shared_alloc_tag. As the number of CPUs
> increases,the wasted memory will grow correspondingly.
> 
> Enclose the definition of _shared_alloc_tag within the
> CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  lib/alloc_tag.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index c7f602fa7b23..14fd66f26e42 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -24,8 +24,10 @@ static bool mem_profiling_support;
>  
>  static struct codetag_type *alloc_tag_cttype;
>  
> +#ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU

It should be enough to add #ifdef ARCH_NEEDS_WEAK_PER_CPU here instead of
all the churn.

>  DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  EXPORT_SYMBOL(_shared_alloc_tag);
> +#endif
>  
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>  			mem_alloc_profiling_key);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
