Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E71586CB;
	Wed, 13 Nov 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522177; cv=none; b=KIKhD0Y2qEWIRcElfmluSm4QwBqD+cr4aBUYCOP+daVd87S0hOtoikrEDeEJynatJXN1RvoDXvhejy2IAWnTgfEARxE91LanKii7p981LOL+e3mClo6HsF69gZN3XlwWVPV0iQ5HrSrICiKR0PHiFcYL0WKR+TPRhcqEdefnqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522177; c=relaxed/simple;
	bh=4ggIs9ohGlXjwAt8W2C6qExVFEJ+fYmZKLh9vQ9Dm4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUuFW4crZzd14Cd5aoMoT4tGZCAQReIbQkfIQJy8GbvR+oiZIrW6yXUqk0rKrpooAwThXUtjo8QXKz5NTIvDOqrhmSdpOVthO4CVJ9KX/mjHO3aHlxO+OzwMkwBo4NBXnLmTj0aCZJ3466GjkqzwFAyAoOBTOj59e0lc4zwE0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDaFmN/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDaFmN/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E92C4CEC3;
	Wed, 13 Nov 2024 18:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731522176;
	bh=4ggIs9ohGlXjwAt8W2C6qExVFEJ+fYmZKLh9vQ9Dm4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDaFmN/YMyacLyTMXwHc+wGRs8vmylXWZl85oMtNR8UqmRCM0LXFeAHPCbBAX9Xwl
	 C4MLXxka/ccDO4tbM576MDp1FccMUUb0YBhEempgBnhx2K73ygUAVa5kdpwtIpp/uj
	 hMeuAoAFmW0uz5gEvciv9y7S33JEZyfhqtXk1j/Yn1ubUBuWUD5+cGXTV3N/N54vE5
	 esP5Oc3EnEZ/bLueGekJxmbQIjl+jszic2zTnI4gTOX4u6UmXnv0iTLpby/hDLROqw
	 F5fC4J0NCHbG+HIL1qiYwhpl6ssJ4+A99x+aTQAd9b+/Gv7ff5q6ifhZHy0pIyQOE4
	 DBSn3hLzlAqIA==
Date: Wed, 13 Nov 2024 11:22:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/fpu: Remove inline assembly variants for old
 clang versions
Message-ID: <20241113182254.GB3713382@thelio-3990X>
References: <20241113154013.961113-1-hca@linux.ibm.com>
 <20241113154013.961113-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154013.961113-3-hca@linux.ibm.com>

On Wed, Nov 13, 2024 at 04:40:13PM +0100, Heiko Carstens wrote:
> With the minimal clang version raised to 19.1.0 there is no need to keep
> the inline assemblies for old clang versions which do not support the O
> and R inline assembly format flags.
> 
> Support for those flags was added with llvm-project commit 9c75a981554d
> ("[SystemZ] Implement A, O and R inline assembly format flags (#80685)").
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I will trust that it compiles :)

> ---
>  arch/s390/include/asm/fpu-insn.h | 124 -------------------------------
>  1 file changed, 124 deletions(-)
> 
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
> index c1e2e521d9af..e57d80981f13 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -183,22 +183,6 @@ static __always_inline void fpu_vgfmg(u8 v1, u8 v2, u8 v3)
>  		     : "memory");
>  }
>  
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -static __always_inline void fpu_vl(u8 v1, const void *vxr)
> -{
> -	instrument_read(vxr, sizeof(__vector128));
> -	asm volatile("\n"
> -		"	la	1,%[vxr]\n"
> -		"	VL	%[v1],0,,1\n"
> -		:
> -		: [vxr] "R" (*(__vector128 *)vxr),
> -		  [v1] "I" (v1)
> -		: "memory", "1");
> -}
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vl(u8 v1, const void *vxr)
>  {
>  	instrument_read(vxr, sizeof(__vector128));
> @@ -209,8 +193,6 @@ static __always_inline void fpu_vl(u8 v1, const void *vxr)
>  		     : "memory");
>  }
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vleib(u8 v, s16 val, u8 index)
>  {
>  	asm volatile("VLEIB	%[v],%[val],%[index]"
> @@ -238,26 +220,6 @@ static __always_inline u64 fpu_vlgvf(u8 v, u16 index)
>  	return val;
>  }
>  
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
> -{
> -	unsigned int size;
> -
> -	size = min(index + 1, sizeof(__vector128));
> -	instrument_read(vxr, size);
> -	asm volatile("\n"
> -		"	la	1,%[vxr]\n"
> -		"	VLL	%[v1],%[index],0,1\n"
> -		:
> -		: [vxr] "R" (*(u8 *)vxr),
> -		  [index] "d" (index),
> -		  [v1] "I" (v1)
> -		: "memory", "1");
> -}
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
>  {
>  	unsigned int size;
> @@ -272,30 +234,6 @@ static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
>  		     : "memory");
>  }
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -#define fpu_vlm(_v1, _v3, _vxrs)					\
> -({									\
> -	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
> -	struct {							\
> -		__vector128 _v[(_v3) - (_v1) + 1];			\
> -	} *_v = (void *)(_vxrs);					\
> -									\
> -	instrument_read(_v, size);					\
> -	asm volatile("\n"						\
> -		"	la	1,%[vxrs]\n"				\
> -		"	VLM	%[v1],%[v3],0,1\n"			\
> -		:							\
> -		: [vxrs] "R" (*_v),					\
> -		  [v1] "I" (_v1), [v3] "I" (_v3)			\
> -		: "memory", "1");					\
> -	(_v3) - (_v1) + 1;						\
> -})
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  #define fpu_vlm(_v1, _v3, _vxrs)					\
>  ({									\
>  	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
> @@ -312,8 +250,6 @@ static __always_inline void fpu_vll(u8 v1, u32 index, const void *vxr)
>  	(_v3) - (_v1) + 1;						\
>  })
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vlr(u8 v1, u8 v2)
>  {
>  	asm volatile("VLR	%[v1],%[v2]"
> @@ -362,21 +298,6 @@ static __always_inline void fpu_vsrlb(u8 v1, u8 v2, u8 v3)
>  		     : "memory");
>  }
>  
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -static __always_inline void fpu_vst(u8 v1, const void *vxr)
> -{
> -	instrument_write(vxr, sizeof(__vector128));
> -	asm volatile("\n"
> -		"	la	1,%[vxr]\n"
> -		"	VST	%[v1],0,,1\n"
> -		: [vxr] "=R" (*(__vector128 *)vxr)
> -		: [v1] "I" (v1)
> -		: "memory", "1");
> -}
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vst(u8 v1, const void *vxr)
>  {
>  	instrument_write(vxr, sizeof(__vector128));
> @@ -386,26 +307,6 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
>  		     : "memory");
>  }
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
> -{
> -	unsigned int size;
> -
> -	size = min(index + 1, sizeof(__vector128));
> -	instrument_write(vxr, size);
> -	asm volatile("\n"
> -		"	la	1,%[vxr]\n"
> -		"	VSTL	%[v1],%[index],0,1\n"
> -		: [vxr] "=R" (*(u8 *)vxr)
> -		: [index] "d" (index), [v1] "I" (v1)
> -		: "memory", "1");
> -}
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>  {
>  	unsigned int size;
> @@ -418,29 +319,6 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>  		     : "memory");
>  }
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
> -#ifdef CONFIG_CC_IS_CLANG
> -
> -#define fpu_vstm(_v1, _v3, _vxrs)					\
> -({									\
> -	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
> -	struct {							\
> -		__vector128 _v[(_v3) - (_v1) + 1];			\
> -	} *_v = (void *)(_vxrs);					\
> -									\
> -	instrument_write(_v, size);					\
> -	asm volatile("\n"						\
> -		"	la	1,%[vxrs]\n"				\
> -		"	VSTM	%[v1],%[v3],0,1\n"			\
> -		: [vxrs] "=R" (*_v)					\
> -		: [v1] "I" (_v1), [v3] "I" (_v3)			\
> -		: "memory", "1");					\
> -	(_v3) - (_v1) + 1;						\
> -})
> -
> -#else /* CONFIG_CC_IS_CLANG */
> -
>  #define fpu_vstm(_v1, _v3, _vxrs)					\
>  ({									\
>  	unsigned int size = ((_v3) - (_v1) + 1) * sizeof(__vector128);	\
> @@ -456,8 +334,6 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>  	(_v3) - (_v1) + 1;						\
>  })
>  
> -#endif /* CONFIG_CC_IS_CLANG */
> -
>  static __always_inline void fpu_vupllf(u8 v1, u8 v2)
>  {
>  	asm volatile("VUPLLF	%[v1],%[v2]"
> -- 
> 2.45.2
> 
