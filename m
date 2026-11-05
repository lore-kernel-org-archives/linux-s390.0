Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894667;
	b=iGjR57uiAm0iKBozRnFJs10JFKFEmhnU47IJJfHxT4uEhMBsua1m5/4ebsbFyDko9SMW
	 FML+B7tP1tvnrzIjm2IzfoaUn6C8hThAB18/pokMcRQImcRfliMtlFU22BQ7oRb4DDsnk
	 35TEeax/OaGJmyLRkYgyqey3IDN74UAAmFPemoxmtVx+NlrPr7WawKWyY9Tv7+nVJ53Y4
	 b2TQGe7LHmf3pi8eVz9B+UgqE6D17r+fJLbp37/faDTTf0Y1HT3+F6B8nb1+DifZF6zuo
	 jTTN0fMrnbv0z/mmE9v4erWlyHH90DU6YyjJcZQYXlgAA3+bzxttw92Di9sBnFAnCug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p2HVoVKNtJLEmeLikyDu7fJaObAEiEXf1XhGA+/s5Z4=;
	b=MY/32tOUbo6j5FXBr08N0mXxArRM3EQ8QNWvqCRVH8AGKwZveCV1BvmOaQjsiWPNnRmM
	 7jeVNgQ+2xsXZPTNKOW9LIZYtuiOUVV9k0tyKXuOJKn4NE61y2aEfhfQbGZqSkBLtt3uh
	 iBg21eUvDXwz+wLLjHyfA7fQld0HsOlCwGZ5YY1MxigHMWODKLQT7DLTaRkXlyfOcac5l
	 sY6ododLDlAWJO5hEjH1JejJvz2KrQcgnAD7j+nuEB2xGHMrM8zD+I4TOy/vgl0ePTWI8
	 JSb5n2RWcRM+AaoExO2T2osjImajrwyeenAels21IJeEba5peD81W4og3l2gDVR0dbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/khrhvk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485B606A332
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/khrhvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E476E1F000C1;
	Thu,  5 Nov 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894667;
	bh=p2HVoVKNtJLEmeLikyDu7fJaObAEiEXf1XhGA+/s5Z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/khrhvkGCiy9gGVTm51hCKyGOBjCl0y81MvIbPlgcCaRbgRlFCLZFmMbX67ldaFe
	 Ts2T49NvXeO3UmK69d0dGZjDfVa6Ng2EaFxNJtuNwSRLmlykca6O1OhWGMiQay8V0S
	 3IEHuYVXOUhorHMU9d6kQFJjw9VoXhzvTOup0a/h5zARKApXi2FsdiB1A2/2jdruh5
	 y16k26gsBVzIyFezYJrdiSZHphdXy3bMBzMqIlwr+V5BCYHdS+Jkp4s9wv+PQ99UpR
	 SQ2x4M8HMbn/1LfhWICX7HXJ6vuXczis2hGs2BW7g5+bjcdeCA61Kj4VVohhNjZVeb
	 Cz2owZjPGdGFA==
Message-ID: <sashiko-outbox-199402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] s390/diag204: Add common diag204 interface with
 caching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
References: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:04:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] s390/diag204: diag204_allocate_buffer() does not zero buffer as doc=
umented
--

commit 58fe47d5083de8e19767f3f73d70eeda63fea0cc
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Add common diag204 interface with caching

This commit introduces a shared diag204 implementation in
arch/s390/kernel/diag/diag204.c with a one-second data cache and converts
hypfs and sthyi to use it.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> new file mode 100644
> index 0000000000000..dc4b9df8ba925
> --- /dev/null
> +++ b/arch/s390/kernel/diag/diag204.c

[ ... ]

> +static void *__diag204_allocate_buffer(int pages)
> +{
> +	return __vmalloc_node(array_size(pages, PAGE_SIZE),
> +			      PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
> +			      __builtin_return_address(0));
> +}
> +
> +/**
> + * diag204_allocate_buffer() - Allocate a buffer for diag204
> + *
> + * Allocate a zeroed, page aligned vmalloc'ed buffer of diag204_get_buf_=
size()
> + * bytes, as required by diag204. The size is determined at initializati=
on
> + * of diag204. Must only be called if diag204_is_available() returns tru=
e.
> + *
> + * Context: Can sleep (GFP_KERNEL).
> + * Return: Pointer to the buffer on success, NULL on failure.
> + */
> +void *diag204_allocate_buffer(void)
> +{
> +	return __diag204_allocate_buffer(diag204_cache_info.pages);
> +}

[ ... ]

> +/**
> + * diag204_store() - Store diag204 data
> + * @buf:             Diag204 data buffer allocated using
> + *                   diag204_allocate_buffer() or a page aligned, zeroed=
 buffer
> + *                   with a size acquired from diag204_get_buf_size().
> + * @allow_busy:      Allow diag204 to return -EBUSY instead of blocking =
and
> + *                   return early when there is a concurrent updater.
> + *
> + * Diag204 queries CPU utilization data from the hypervisor. Per CPU
> + * utilization information is returned either only for the current guest
> + * or, with authorization for all guests configured.
> + *
> + * Context: diag204_store() can sleep and holds diag204_mutex to seriali=
ze
> + *          diag204 cache access.
> + *
> + * Return:
> + * * 0 on success
> + * * -EOPNOTSUPP diag204 is not supported
> + * * -EINVAL if @buf is NULL
> + * * -ENOMEM if the temporary buffer could not be allocated
> + * * -EBUSY if @allow_busy is set and diag204 or a concurrent cache upda=
te
> + *    is busy
> + * * -EINTR if interrupted by a signal
> + */
> +int diag204_store(void *buf, bool allow_busy)
> +{
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	if (!buf)
> +		return -EINVAL;
> +	rc =3D 0;
> +	if (allow_busy) {
> +		if (!mutex_trylock(&diag204_mutex))
> +			return -EBUSY;
> +	} else {
> +		if (mutex_lock_killable(&diag204_mutex))
> +			return -EINTR;
> +	}
> +	if (diag204_is_cache_valid())
> +		goto copy;
> +	rc =3D diag204_update_cache(allow_busy);
> +	if (rc)
> +		goto out;
> +copy:
> +	memcpy(buf, diag204_cache_info.buf, diag204_get_buf_size());
> +out:
> +	mutex_unlock(&diag204_mutex);
> +	return rc;
> +}

[Severity: Low]
This isn't a bug for current in-tree callers since diag204_update_cache()
zeroes diag204_cache_info.buf with memset() and diag204_store() overwrites
the caller buffer via memcpy(), but does diag204_allocate_buffer() actually
zero the allocated memory as documented?

In arch/s390/kernel/diag/diag204.c, diag204_allocate_buffer() calls
__diag204_allocate_buffer(), which invokes __vmalloc_node() with GFP_KERNEL
and without __GFP_ZERO, returning uninitialized memory despite the
kernel-doc stating that it allocates a zeroed buffer.

Similarly, the kernel-doc for diag204_store() states that buf must be a
page-aligned, zeroed buffer, even though diag204_store() only copies from
diag204_cache_info.buf into buf via memcpy().

Should __diag204_allocate_buffer() pass GFP_KERNEL | __GFP_ZERO, or should
the kernel-doc comments on diag204_allocate_buffer() and diag204_store() be
updated to match the implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-diag204ioc=
tl-v5-1-87a96638d58a@linux.ibm.com?part=3D1
