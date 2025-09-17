Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3062F546D;
	Wed, 17 Sep 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076222; cv=none; b=IX7MiagHAJ9PmXCRvgRhbxxa33sxzkOp4D/H2ojfEMpfhWtTx8gSt/qV/N7RD5Z5QWG45cv0msDy2t7SNU+orxS+m8hV9SjDa58MQlvAQBhqAgTNTF04qvbkCVms5DR0WltFJi6w+NqUsRBb+2zSjn2F2xAyZDBXb4gSzWWGbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076222; c=relaxed/simple;
	bh=9X7QADcxt2zCen4jv6C9mftiuf17xh85fpQtuE7OSM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJUaFu9m55mYJg0hVFuI+S+PnYq68DekKodX9Y+6R4TYbv0IkmDtUroSVf6aTncGckzGgW89MVDInyAqGdhCqgnJkHZBCd8iS/ryPnSXyy9D+3UJe5FfqlOUvefIKSxFCK58uEh8WslE6sM3D5RA2paWi/KUbenHohjkoKGRLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2IjJp7i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2IjJp7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8F3C4CEFE;
	Wed, 17 Sep 2025 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758076221;
	bh=9X7QADcxt2zCen4jv6C9mftiuf17xh85fpQtuE7OSM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2IjJp7i0geiRr9f92HGSScUadmZ6+qWXyDpkJSiwVyNs91904DNhtSDuJbhhaj0J
	 DJKcETxEWzNzBxsyhW7usZxODZD+xgUjmFC614GNYEbZbQwsw0dpeLBxPsCcNBGAAm
	 /22ayxgBAuSTcnlHABRPG0MUY0z4e8po0p2SiK2dFhh7nhDHJz7GwWhBHU1yJcuQLJ
	 exW4ZkNB5uaXDutsFJDYqObop2XHXw0CvvnXp7EzwCxcF77trENSy7QplSvBv3vKS4
	 jDuk3O3FlOraGmLgFKmXx7v+Qqg8oWrsCQSC/M4tSYke5eVMO4wboVh9+IgNJL4b2X
	 uYcs479yd3FIA==
Date: Tue, 16 Sep 2025 19:30:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] compiler_types: Add __assume macro
Message-ID: <20250917023016.GA3935228@ax162>
References: <20250916134803.874580-1-hca@linux.ibm.com>
 <20250916134803.874580-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916134803.874580-3-hca@linux.ibm.com>

On Tue, Sep 16, 2025 at 03:48:01PM +0200, Heiko Carstens wrote:
> Make the statement attribute "assume" with a new __assume macro available.
> 
> The assume attribute is used to indicate that a certain condition is
> assumed to be true. Compilers may or may not use this indication to
> generate optimized code. If this condition is violated at runtime, the
> behavior is undefined.
> 
> Note that the clang documentation states that optimizers may react
> differently to this attribute, and this may even have a negative
> performance impact. Therefore this attribute should be used with care.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

LGTM.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler_types.h | 23 +++++++++++++++++++++++
>  init/Kconfig                   | 10 ++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index a910f9fa5341..41c16fb8eb40 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -329,6 +329,29 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>  
> +/*
> + * The assume attribute is used to indicate that a certain condition is
> + * assumed to be true. If this condition is violated at runtime, the behavior
> + * is undefined. Compilers may or may not use this indication to generate
> + * optimized code.
> + *
> + * Note that the clang documentation states that optimizers may react
> + * differently to this attribute, and this may even have a negative
> + * performance impact. Therefore this attribute should be used with care.
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
> index 59ae2b967195..935eff59af97 100644
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
> 
