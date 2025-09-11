Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E012DC765;
	Thu, 11 Sep 2025 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616275; cv=none; b=RSCbki0epuZmDKYTAvktRoNQbk86H+we9JwZY1/ShTo3vN2Q2Suj9doNVLUIbrjHNkZCAJFXkEsljMkqR5el+Gmx6/gbfmTKLt9K4O6JmHSRVYUx0MIAy3dUbSQ5jYJwwRmR1MaitxNLyOGT16nnrRSS+lWdNZrs3JuHvrXyjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616275; c=relaxed/simple;
	bh=w5MXgFugxnmH56tVIOnCqs0AHe/uK/jNlEbRgaWvsQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfEfhZBMATrEUPvsrg0AIYD8iGgIzgkKlzgi8JLKiQGjwHOF0AJ44AORFqwrl0Ol/XtIdfTbv34pS3ibismAPUNgKQ8CfqfrMugyfbhJgBzmFBG9SzWH8tonFVdFeYPheT6/nTJVqVf7SgCyMi2IAzwv6DPIvFKgZ2UKPI4vLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7s2VtNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7s2VtNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD1EC4CEF0;
	Thu, 11 Sep 2025 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757616274;
	bh=w5MXgFugxnmH56tVIOnCqs0AHe/uK/jNlEbRgaWvsQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7s2VtNpCT6pUPhbm+TP2RoBLL+54M9Xj3c0bEYZNFBLR6bBUi4uzERLY33JjNwML
	 SH2GSslTnR1Tz1F+ujxnzjxLlMIkmeu8dK4aWAJKpufB4hVP4JcG3TX36RMKpiAhlp
	 28b9DD9ojSChK+EFmr3a/DL81eTNyrT5pnHFzeEfNb2FWz/A6tS3Tqj/nkX13DxVOn
	 5IJxj+6igewdLy4PM34v+dwZBOvxU0OWfBqZtsOQZQpSOjeu1guDCPgqfOYEpLIaKT
	 eB1MxqSpYj1+9Zc5g4meTfaAMOBIKLrJUK1D2vQo5uPjiCBR5l/yckP5NDDD5plSWO
	 CeUp6o831T6ow==
Date: Thu, 11 Sep 2025 11:44:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
Message-ID: <20250911184429.GA2395987@ax162>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162>
 <20250911145659.8894Dea-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911145659.8894Dea-hca@linux.ibm.com>

On Thu, Sep 11, 2025 at 04:56:59PM +0200, Heiko Carstens wrote:
> On Wed, Sep 10, 2025 at 06:32:43PM -0700, Nathan Chancellor wrote:
> > > + *
> > > + * Optional: only supported since GCC >= 13.1, clang >= 12.0
> > > + *
> > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#assume
> > 
> > Looking at this link sent me down a bit of a rabbit hole :) Prior to
> > Clang 19.1.0 [2], assume was an OpenMP attribute, which has completely
> > different semantics and errors out when used in the way the series does:
> > 
> >   In file included from kernel/bounds.c:13:
> >   In file included from include/linux/log2.h:12:
> >   In file included from include/linux/bitops.h:67:
> >   arch/s390/include/asm/bitops.h:173:12: error: expected string literal as argument of '__assume__' attribute
> >     173 |                 __assume(bit <= 64);
> >         |                          ^
> > 
> > Unfortunately, I think __assume will need to be handled in the compiler
> > specific headers :/
> > 
> > [1]: https://clang.llvm.org/docs/AttributeReference.html#id13
> > [2]: https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3c185354b9f6c17
> 
> Thank you for having look. This is quite surprising. So after looking into the
> various header files it might be acceptable to add this to compiler_types.h,
> since there seem to be a few similar constructs.
> 
> Maybe something like this(?):

Ah, yeah, that would work too. I had not considered compiler_types.h
since most of those tend to involve dynamic checks via cc-option but I
do like keeping the documentation attached to the attribute in a single
location, rather than duplicating it in the individual compiler files.
This will also make it easy to move this into compiler_attributes.h in
the (likely distant) future when both compilers support this
unconditionally (or clang 19.1.0 is the minimum supported version so
__has_attribute can be used).

> From d9d67807e6854666507e55d9ac0c7b4ec659aa99 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Wed, 10 Sep 2025 14:18:07 +0200
> Subject: [PATCH] compiler_types: Add __assume macro
> 
> Make the statement attribute "assume" with a new __assume macro available.
> 
> This allows compilers to generate better code, however code which makes use
> of __assume must be written as if the compiler ignores the hint. Otherwise
> this may lead to subtle bugs if code is compiled with compilers which do
> not support the attribute.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I do not think anyone really owns compiler_types.h so unless Miguel has
any objections from the compiler attributes perspective, I think you can
just take this via the s390 tree with the other two changes.

> ---
>  include/linux/compiler_types.h | 20 ++++++++++++++++++++
>  init/Kconfig                   | 10 ++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 16755431fc11..38a52a792e48 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -329,6 +329,26 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>  
> +/*
> + * Beware: Code which makes use of __assume must be written as if the compiler
> + * ignores the hint. Otherwise this may lead to subtle bugs if code is compiled
> + * with compilers which do not support the attribute.
> + * Using this attribute requires careful analysis, since in some cases it may
> + * generate worse code (see clang documentation).
> + *
> + * Optional: only supported since gcc >= 13
> + * Optional: only supported since clang >= 19
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#id13
> + *
> + */
> +#ifdef CONFIG_CC_HAS_ASSUME
> +# define __assume(expr)			__attribute__((__assume__(expr)))
> +#else
> +# define __assume(expr)
> +#endif
> +
>  /*
>   * Optional: only supported since gcc >= 15
>   * Optional: only supported since clang >= 18
> diff --git a/init/Kconfig b/init/Kconfig
> index e3eb63eadc87..5882c5e74047 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -112,6 +112,16 @@ config TOOLS_SUPPORT_RELR
>  config CC_HAS_ASM_INLINE
>  	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
>  
> +config CC_HAS_ASSUME
> +	bool
> +	# clang needs to be at least 19.1.0 since the meaning of the assume
> +	# attribute changed:
> +	# https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3c185354b9f6c17
> +	default y if CC_IS_CLANG && CLANG_VERSION >= 190100
> +	# supported since gcc 13.1.0
> +	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106654
> +	default y if CC_IS_GCC && GCC_VERSION >= 130100
> +
>  config CC_HAS_NO_PROFILE_FN_ATTR
>  	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
>  
> -- 
> 2.48.1
