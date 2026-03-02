Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8822B8AB;
	Mon,  2 Mar 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463556; cv=none; b=WVg9DkD8nDPQxXoIiwyaoAcUUyQkb+wNt8ZUPNDISCgq72u9RU/zor0u0MOy7F8DQWZ+up88oD+es7c+uoxJd8bV+dOdQm2F3pFguN1QlNXNZgykTrJKIRJ4wkm0U8BdGewWIJFDqSaoaaXiP1PEJftIvC+0Ro8shE0cedokjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463556; c=relaxed/simple;
	bh=yLKCSXO+hQApHc+NF2pMZzlTvrx+yrgTZOCdhXU+l+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PEXN9dm36w6bkyM+1eXiETDCKKR2c8PMrbYQNdPmCgbWf+73mMO8OknWy1o+xJhIY3D66wlns4NnVEWadlepklroOCYmvVBcJup922Oj8ISSnct1My9CkgerKWJsJ4981WdHYgjwbyilbeyJGI1w+/Lu/ZKWHZUpFYI9C6/flTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2NBa7ir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2NBa7ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211BAC19423;
	Mon,  2 Mar 2026 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772463556;
	bh=yLKCSXO+hQApHc+NF2pMZzlTvrx+yrgTZOCdhXU+l+s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=f2NBa7irVPOLjk3WW4SCmf8FWi+7tBJ3LbL5TJX9XKvS1spGkziwe9pGBJY+oqLo7
	 kA0iGOYvp0cjlRZXL+tt2MqQSyn2cirVYdwLABTi85/4lhjcDbtxxtfNHjPvF07WxM
	 VGhJDv969X+0XD8Ltsk+AXrf1C36RCmK274CzxkNnrnNzf+bfkiSYGN9DW2Q5LeFol
	 85vi9xmsuMiRcJ/1EsNPNL1+QYTCSEkkbB/fpWUiTL6w5gSJgyz7KbZ7zgfoOhM5xy
	 GUA1X9y6ljSEOT1J2bnp5Y5mMfrMW692fy/GCNHYl8XYEYdmgabRaVoJG4M+mEOaEn
	 5PRbc9SZdCdXw==
Message-ID: <e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
Date: Mon, 2 Mar 2026 15:59:04 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
To: david.laight.linux@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andre Almeida <andrealmeid@igalia.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
 <20260302132755.1475451-2-david.laight.linux@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260302132755.1475451-2-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/03/2026 à 14:27, david.laight.linux@gmail.com a écrit :
> From: David Laight <david.laight.linux@gmail.com>
> 
> If a 'const struct foo __user *ptr' is used for the address passed
> to scoped_user_read_access() then you get a warning/error
> uaccess.h:691:1: error: initialization discards 'const' qualifier
>      from pointer target type [-Werror=discarded-qualifiers]
> for the
>      void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)
> assignment.
> 
> Fix by using 'auto' for both _tmpptr and the redeclaration of uptr.
> Replace the CLASS() with explicit __cleanup() functions on uptr.
> 
> Fixes: e497310b4ffb "(uaccess: Provide scoped user access regions)"
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Can we get this fix merged in 7.0-rc3 so that we can start building 7.1 
on top of it ?

Thanks
Christophe

> ---
>   include/linux/uaccess.h | 54 +++++++++++++++--------------------------
>   1 file changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1f3804245c06..809e4f7dfdbd 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -647,36 +647,22 @@ static inline void user_access_restore(unsigned long flags) { }
>   /* Define RW variant so the below _mode macro expansion works */
>   #define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
>   #define user_rw_access_begin(u, s)	user_access_begin(u, s)
> -#define user_rw_access_end()		user_access_end()
>   
>   /* Scoped user access */
> -#define USER_ACCESS_GUARD(_mode)				\
> -static __always_inline void __user *				\
> -class_user_##_mode##_begin(void __user *ptr)			\
> -{								\
> -	return ptr;						\
> -}								\
> -								\
> -static __always_inline void					\
> -class_user_##_mode##_end(void __user *ptr)			\
> -{								\
> -	user_##_mode##_access_end();				\
> -}								\
> -								\
> -DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
> -	     class_user_##_mode##_end(_T),			\
> -	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
> -								\
> -static __always_inline class_user_##_mode##_access_t		\
> -class_user_##_mode##_access_ptr(void __user *scope)		\
> -{								\
> -	return scope;						\
> -}
>   
> -USER_ACCESS_GUARD(read)
> -USER_ACCESS_GUARD(write)
> -USER_ACCESS_GUARD(rw)
> -#undef USER_ACCESS_GUARD
> +/* Cleanup wrapper functions */
> +static __always_inline void __scoped_user_read_access_end(const void *p)
> +{
> +	user_read_access_end();
> +};
> +static __always_inline void __scoped_user_write_access_end(const void *p)
> +{
> +	user_write_access_end();
> +};
> +static __always_inline void __scoped_user_rw_access_end(const void *p)
> +{
> +	user_access_end();
> +};
>   
>   /**
>    * __scoped_user_access_begin - Start a scoped user access
> @@ -750,13 +736,13 @@ USER_ACCESS_GUARD(rw)
>    *
>    * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
>    */
> -#define __scoped_user_access(mode, uptr, size, elbl)					\
> -for (bool done = false; !done; done = true)						\
> -	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> -	     !done; done = true)							\
> -		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
> -			/* Force modified pointer usage within the scope */		\
> -			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
> +#define __scoped_user_access(mode, uptr, size, elbl)				\
> +for (bool done = false; !done; done = true)					\
> +	for (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl);	\
> +	     !done; done = true)						\
> +		/* Force modified pointer usage within the scope */		\
> +		for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
> +		     _tmpptr; !done; done = true)
>   
>   /**
>    * scoped_user_read_access_size - Start a scoped user read access with given size

