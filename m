Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AB18EFD1;
	Thu, 11 Sep 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554368; cv=none; b=NUR+gYAgtq7FmJqrhyg4yA+U9ZIlH9cmc5Hipu5ljhM8CGfgErpdGmfIZSCFdjdgyqpBTRR4oIMLqyfrtdwhruiipFJI1Ag9MOB6c+Rz8QRtcQpsRLPVDS2be5waTe750XpLRsxB8tPnA3dMw+BGR50nzNva6cQ3MK1nat5sJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554368; c=relaxed/simple;
	bh=ymkpTfpELFB6gx7vh446ALqQuBiD7KUtqI1rXRMuCYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyEiaZ4NR5DsXaGPzIqkiJt9BQOFH8qW4WFBXdNWlnD8O2yyupGUCNXDu703RRbej4HiBrOnJCDq439vpShXQ1+lXdSdMSepUX6eL6GoWpPI3Rytf2UnpZWt3zq4VPfdIqe9VaGMtpdllfEatFb16pAy2o/RVtLzF4XlB6j+3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHQu08GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHQu08GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13BC4CEEB;
	Thu, 11 Sep 2025 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757554368;
	bh=ymkpTfpELFB6gx7vh446ALqQuBiD7KUtqI1rXRMuCYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHQu08GOPQgg9jFutP25ukVoKyJJ86xwBJeZAPQKPDqEb/W/doYl+vACH/SQHJ6vn
	 qwrFFxxBmvmmknQfD+LbP9Xe8sU+1sL7yb+tXHKJ5ys8LPOgDA5IaCJowZU1sOEt1m
	 rKq/Ff/V8pSGip+jFM83a5xoRZWhwsaP1RltbI3A8mfeI2sQkhucAT/Y0mDp6U2wvo
	 0G8vmP89hvBpAq/gvPqeP5e9TIDCFSIM/H8vB/eXaIF14p8RxkGoqbLaZ7tDn3lCbo
	 ejQ1ikZy80x+UouFamiZzB5V4gmw6AgRfRYmyD2EDsg3USTLx+v/MSCJCjnqGJ0ban
	 z9MxsG/dvuvuw==
Date: Wed, 10 Sep 2025 18:32:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
Message-ID: <20250911013243.GA292340@ax162>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910151216.646600-2-hca@linux.ibm.com>

Hi Heiko,

On Wed, Sep 10, 2025 at 05:12:14PM +0200, Heiko Carstens wrote:
> Make the statement attribute "assume" with a new __assume macro available.
> 
> This allows compilers to generate better code, however code which makes use
> of __assume must be written as if the compiler ignores the hint. Otherwise
> this may lead to subtle bugs if code is compiled with compilers which do
> not support the attribute.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  include/linux/compiler_attributes.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index c16d4199bf92..16c3d4a865e2 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -54,6 +54,22 @@
>   */
>  #define __always_inline                 inline __attribute__((__always_inline__))
>  
> +/*
> + * Beware: Code which makes use of __assume must be written as if the compiler
> + * ignores the hint. Otherwise this may lead to subtle bugs if code is compiled
> + * with compilers which do not support the attribute.

It may be worth noting that careful analysis should be performed when
adding this attribute since clang's documentation [1] (more on that
below...) notes that it could hurt optimizations just as much as it
could help it.

> + *
> + * Optional: only supported since GCC >= 13.1, clang >= 12.0
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#assume

Looking at this link sent me down a bit of a rabbit hole :) Prior to
Clang 19.1.0 [2], assume was an OpenMP attribute, which has completely
different semantics and errors out when used in the way the series does:

  In file included from kernel/bounds.c:13:
  In file included from include/linux/log2.h:12:
  In file included from include/linux/bitops.h:67:
  arch/s390/include/asm/bitops.h:173:12: error: expected string literal as argument of '__assume__' attribute
    173 |                 __assume(bit <= 64);
        |                          ^

Unfortunately, I think __assume will need to be handled in the compiler
specific headers :/

[1]: https://clang.llvm.org/docs/AttributeReference.html#id13
[2]: https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3c185354b9f6c17

Cheers,
Nathan

> + */
> +#if __has_attribute(assume)
> +# define __assume(expr)                 __attribute__((__assume__(expr)))
> +#else
> +# define __assume(expr)
> +#endif
> +
>  /*
>   * The second argument is optional (default 0), so we use a variadic macro
>   * to make the shorthand.
> -- 
> 2.48.1
> 
