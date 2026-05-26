Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593823AD51E;
	Tue, 26 May 2026 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824259; cv=none; b=sq0rt4378mkvDmz7B9lcTTyOzoQ84qZ0S7Yz7O1AayLuc4QIaWrkrD1D4wd5ItiPxpdiR4hPzB2NS87v6qPrCrGAC5lOAD0gQEFAQWRB+r4Qu5nSmRgK/CnLScQtbLF3qWbBtcDiCx4ZhNLaPHB4xLC+h5fecAnBNyADcUzYON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824259; c=relaxed/simple;
	bh=eNdBcceAnV2lup2AYg86vhyp2UQb82XTEz4Muy5giV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCnMLDL8h8G4ME9CZKHCHjYevnmvtJMSaH//V6p4O/2bqz5dBkZXb9rw2dg9NU9I7ZzHFiN0lqS0eYlHsdUbsc6O1XJfXd8ALzWqW5wQxAmBvB8xFlgnDwOSe7mIaA6YVi9cYO2RzgutqgJVX4VrUyNHvWKeuCm1MU1oR21qQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4aRlhv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4aRlhv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660881F00A3D;
	Tue, 26 May 2026 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824258;
	bh=PDbVz/BwnHRpIpjuYb7EvGBSPM9x9tSY/uMNXyuwFcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l4aRlhv79Ih0jQA12jftWmnDyxp0kC96VqsvMGsnrgJ7gkIJpjsMZ+PqqccvAelAf
	 3G3SdGTWTVum2hF+eYagcfnbBtRZRiLQJOv3yAmUbEyNhOGZwyCPMtGjZXNd9gYaJo
	 Riov6LSv0UJg3wCZcH9fuqFEOrRLOlCNuC4bkpBaDfXOh4pzeYL+llx8ccWGvlE2Wf
	 AQQZTdJDm0Qur+0+DSrkpban8al4u22Rj7R8UKeD1g9//wKVSEchjE5FN4W1vMjYib
	 zwJvY39sCBHB9Tn8P8yLhcreq/ezwa7qa5V8daaz4wFuhggTM31kYhMI1D3vDjriha
	 Q1V1hTM6cc8QA==
Date: Tue, 26 May 2026 12:37:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org,
	Nicolas Schier <nsc@kernel.org>, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err.h: use __always_inline on all error pointer helpers
Message-ID: <20260526193733.GC2851089@ax162>
References: <20260526101851.2495110-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526101851.2495110-1-arnd@kernel.org>

On Tue, May 26, 2026 at 12:18:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While testing randconfig builds on s390, I came across a
> link failure with CONFIG_DMA_SHARED_BUFFER disabled:
> 
> ERROR: modpost: "dma_buf_put" [drivers/iommu/iommufd/iommufd.ko] undefined!
> 
> The problem here is that IS_ERR() is not inlined and dead code elimination
> fails as a consequence.
> 
> The err.h helpers all turn into a trivial assignment ot a bit mask
> and should never result in a function call, so force them to always be
> inline. This should generally result in better object code aside from
> avoiding the link failure above.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, seems reasonable to me. I agree that this should generally result
in better generated code as opposed to these helpers being generated out
of line.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/err.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/err.h b/include/linux/err.h
> index 8c37be0620ab..d3e38d5b3a98 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -36,7 +36,7 @@
>   *
>   * Return: A pointer with @error encoded within its value.
>   */
> -static inline void * __must_check ERR_PTR(long error)
> +static __always_inline void * __must_check ERR_PTR(long error)
>  {
>  	return (void *) error;
>  }
> @@ -60,7 +60,7 @@ static inline void * __must_check ERR_PTR(long error)
>   * @ptr: An error pointer.
>   * Return: The error code within @ptr.
>   */
> -static inline long __must_check PTR_ERR(__force const void *ptr)
> +static __always_inline long __must_check PTR_ERR(__force const void *ptr)
>  {
>  	return (long) ptr;
>  }
> @@ -73,7 +73,7 @@ static inline long __must_check PTR_ERR(__force const void *ptr)
>   * @ptr: The pointer to check.
>   * Return: true if @ptr is an error pointer, false otherwise.
>   */
> -static inline bool __must_check IS_ERR(__force const void *ptr)
> +static __always_inline bool __must_check IS_ERR(__force const void *ptr)
>  {
>  	return IS_ERR_VALUE((unsigned long)ptr);
>  }
> @@ -87,7 +87,7 @@ static inline bool __must_check IS_ERR(__force const void *ptr)
>   *
>   * Like IS_ERR(), but also returns true for a null pointer.
>   */
> -static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
> +static __always_inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
>  {
>  	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
>  }
> @@ -99,7 +99,7 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
>   * Explicitly cast an error-valued pointer to another pointer type in such a
>   * way as to make it clear that's what's going on.
>   */
> -static inline void * __musggt_check ERR_CAST(__force const void *ptr)
> +static __always_inline void * __must_check ERR_CAST(__force const void *ptr)
>  {
>  	/* cast away the const */
>  	return (void *) ptr;
> @@ -122,7 +122,7 @@ static inline void * __must_check ERR_CAST(__force const void *ptr)
>   *
>   * Return: The error code within @ptr if it is an error pointer; 0 otherwise.
>   */
> -static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
> +static __always_inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
>  {
>  	if (IS_ERR(ptr))
>  		return PTR_ERR(ptr);
> -- 
> 2.39.5
> 

-- 
Cheers,
Nathan
