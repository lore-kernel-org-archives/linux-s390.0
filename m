Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231EF4A12;
	Tue,  6 Feb 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182919; cv=none; b=NNsd2MHE5N7p9Ykall8fn8LXUNfeAuBUBlfFVCJxJyslYAzKl8DKUQi8WEq40pY8BolMNMLyUqXtnpvlEkeGSdmGWmlq9z2+o917DG843+sxIsvAym6ULomiJa4KkLrNWMLTOYF0v0sCmccy4MWsoOl1Ot5krgdbPcORaoR+kQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182919; c=relaxed/simple;
	bh=QYynlXCJIaRqirBsQY44in81LETdg2sbfbHwxOyF3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxONZ+QJUAMsfngo1kgZ74fXlXfNRtTF41pxZOgHr5pmHsdftVOZwYm4J+tLVw4UhbjkOjCFnWUlY5WBM3Lm212DBhAmc5fZRQhzCdeAmq4Z+Tr1HF6fhQ9v/sMSrLSdvWu5T0Y/6VnxzW8Cp9RdKLcpupRwuv4hsXjeqtQsPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo+yWVfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo+yWVfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A526C433F1;
	Tue,  6 Feb 2024 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707182918;
	bh=QYynlXCJIaRqirBsQY44in81LETdg2sbfbHwxOyF3eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eo+yWVfuelWwmRzpCVrimfvhnQxEfqkeMD6EGK/xaMY/z8pmZiFRXS01L/0OUE0XU
	 EvKd72oJiF64QGNg9qOJT1JdbcaKJL0AJo/R72zV8xUSoQtVSgCAiMr9S7TO58bG2L
	 02rr2dTK7PNMik1kFC9nj8uCYPwa2qtqYdI5KIOl6RJCtV8PW6dP8BmSEP/BEDkfcY
	 j9x4efhb7kC+N7upswSEpJc9x7viZpM/1adzYgKPQ6eeV0g6EhV5Rz0EcmMePfs7qS
	 Ag6BsCJxvatkC/tXS+OFTkHLH6KcE0lrc9i8Y/jwq3HDnm7ojIKHpMC92SvxkyPPHU
	 ORg0pqti2Frxw==
Date: Mon, 5 Feb 2024 18:28:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __uninitialized macro
Message-ID: <20240206012836.GA2616098@dev-arch.thelio-3990X>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154844.3757121-2-hca@linux.ibm.com>

On Mon, Feb 05, 2024 at 04:48:43PM +0100, Heiko Carstens wrote:
> With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled the kernel will
> be compiled with -ftrivial-auto-var-init=<...> which causes initialization
> of stack variables at function entry time.
> 
> In order to avoid the performance impact that comes with this users can use
> the "uninitialized" attribute to prevent such initialization.
> 
> Therefore provide the __uninitialized macro which can be used for cases
> where INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO is enabled, but only
> selected variables should not be initialized.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler_attributes.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 28566624f008..f5859b8c68b4 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -333,6 +333,18 @@
>   */
>  #define __section(section)              __attribute__((__section__(section)))
>  
> +/*
> + * Optional: only supported since gcc >= 12
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-uninitialized-variable-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#uninitialized
> + */
> +#if __has_attribute(__uninitialized__)
> +# define __uninitialized		__attribute__((__uninitialized__))
> +#else
> +# define __uninitialized
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
> -- 
> 2.40.1
> 
