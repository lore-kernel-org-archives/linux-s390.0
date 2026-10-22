Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670562;
	b=glCpv4XYTuXTDcsavaOa1lBybCdajYlzDaTVeepsQ6qc/7V2mLRlRhhnvf+LDTLelc5P
	 v65KJ7Z+jtTrnrSKlveXbflm2gN7Dl7aWqoTbZ4zh+QKL8Vqvlgu3/cja18RIrRP4bqjH
	 TFCKmYBckZbtZPz+Jvnf/6GDqAmSMqHWctQknQockN94VXgsvlJ3eqQqaP8uJ89vdrYVO
	 f/J7QTd80Jb3zATJobftanB/Ii/sa/UdbWgtsUBt0rOktvPndrbMDsy020g+yJgv5lXMs
	 EPWtqSCXA3aXgZYhFti+zpDapIJQcuqbWNAkEK8xWO38vTuGhun6IY+ktlSqKVOXozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HLFIyj3o6OA2wNp/GnYEAz8mnQLVU8N0bH4YqrKisBA=;
	b=SIL7/+BhlCuEYMLqliV7ufoY0zUnbCaoL2aYEEKcUiwtN4csvTfhC79fAuoZ5Rr5Kptm
	 WyyLlHgKnJ3KmpiqbHi4Eb08ZBczrY25fvmpLtjqxl3TzKKT+ltBZfQkGcgUVibBkfOXT
	 6cTaqkKYUscpDw+FQYOD6Ze/9oosdvHICkNOxqzUMSluVmGJNwbunuUipBMie3l8KwWoO
	 t/aXtLngqy3I+kmy+iAco0dUvB/RfzXdqWy5wddDMugMrh9z5S0h3GM+peePHRw6h4NfB
	 0c2UhievrnTSLlKyiYcwyzddqkLLm7U8P31thDQ1ufbx3p3rvdbkWgC+ZSere5tFzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyvWHm9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FF606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyvWHm9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2E1F000C1;
	Thu, 22 Oct 2026 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670561;
	bh=HLFIyj3o6OA2wNp/GnYEAz8mnQLVU8N0bH4YqrKisBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyvWHm9fYBY4GwKU/UrdhR9tdszlSQ+uaOtH+Ld7NwCvaJTA9p8zNBzOHPq3HEl1n
	 v0XLYEKasjo4oU2HJQ92rX0HsUgr/gliAF0ec5deSb38Rkdeo7YRcGSv2zOLhBvo2Y
	 yZ4ds9peD2quC1YjkF9QGRKeNtRezVL8jkKQIwUwg74QdmGksTNM6dElTu0wlz78LA
	 Er0nXTd96h08qEjMpoLbThOrCcE6CK0ySvvfOVO+ydm01/LyOuCbQawRQ6VnevAmo2
	 p4SjAqTIAS+/FNd7a+4/T1N3PS+kGsptoCTfzmYEhfTjrvzZZCuZuCzChWz4+t83u3
	 pYx1A+xMo4NDQ==
Message-ID: <sashiko-outbox-181408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] s390/diag204: Replace diag204 users with new
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v2-2-7e5a9d1cd21a@linux.ibm.com>
References: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
 <20261022-diag204ioctl-v2-2-7e5a9d1cd21a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:02:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] s390/diag204: unlocked cache access and unlock imbalance in di=
ag204_store()
- [Medium] s390/diag204: memory leak in diag204_probe() on simple format fa=
llback
--

commit 5ab79951b16e6e4f69656f47d09396782867bf4f
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Replace diag204 users with new implementation

This commit converts the existing kernelspace diag204 users in hypfs and
sthyi to use the new diag204 interface and enables building
arch/s390/kernel/diag/diag204.c.

> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index 08777f57bd244..c3eebe4667faf 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c
> @@ -22,139 +22,24 @@

[ ... ]

> -static int diag204_probe(void)
> -{
> -	void *buf;
> -	int pages, rc;
> -
> -	buf =3D diag204_get_buffer(DIAG204_INFO_EXT, &pages);
> -	if (!IS_ERR(buf)) {
> -		if (diag204((unsigned long)DIAG204_SUBC_STIB7 |
> -			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >=3D 0) {
> -			diag204_store_sc =3D DIAG204_SUBC_STIB7;
> -			diag204_set_info_type(DIAG204_INFO_EXT);
> -			goto out;
> -		}
> -		if (diag204((unsigned long)DIAG204_SUBC_STIB6 |
> -			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >=3D 0) {
> -			diag204_store_sc =3D DIAG204_SUBC_STIB6;
> -			diag204_set_info_type(DIAG204_INFO_EXT);
> -			goto out;
> -		}
> -		diag204_free_buffer();
> -	}

[Severity: Medium]
Does the replacement diag204_probe() in arch/s390/kernel/diag/diag204.c (now
built via arch/s390/kernel/diag/Makefile) leak the extended format vmalloc
buffer buf when falling back to DIAG204_INFO_SIMPLE?

In the removed hypfs implementation above, diag204_free_buffer() freed the
DIAG204_INFO_EXT buffer if both DIAG204_SUBC_STIB7 and DIAG204_SUBC_STIB6
failed.

In arch/s390/kernel/diag/diag204.c:diag204_probe(), if DIAG204_SUBC_RSI
returns pages > 0 and __diag204_allocate_buffer(pages) succeeds, but both
DIAG204_SUBC_STIB7 and DIAG204_SUBC_STIB6 return a negative error code,
execution falls through to the simple format fallback and overwrites buf
without freeing the first allocation:

arch/s390/kernel/diag/diag204.c:diag204_probe() {
	if (pages > 0) {
		buf =3D __diag204_allocate_buffer(pages);
		if (!buf) {
			rc =3D -ENOMEM;
			goto fail_alloc;
		}
		type =3D DIAG204_INFO_EXT;
		if (diag204(DIAG204_SUBC_STIB7 | type, pages, buf) >=3D 0) {
			subcode =3D DIAG204_SUBC_STIB7;
			goto out;
		}
		if (diag204(DIAG204_SUBC_STIB6 | type, pages, buf) >=3D 0) {
			subcode =3D DIAG204_SUBC_STIB6;
			goto out;
		}
	}
	/* extended data format is not available, fallback to simple */
	pages =3D 1;
	buf =3D __diag204_allocate_buffer(pages);
}

Should vfree(buf) (or diag204_free_buffer(buf)) be called before overwriting
buf in the fallback path?

[ ... ]

> diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag=
_fs.c
> index 39621c3260103..13b5a2a4729d1 100644
> --- a/arch/s390/hypfs/hypfs_diag_fs.c
> +++ b/arch/s390/hypfs/hypfs_diag_fs.c
> @@ -303,15 +303,14 @@ int hypfs_diag_create_files(struct dentry *root)
>  	struct dentry *systems_dir, *hyp_dir;
>  	void *time_hdr, *part_hdr;
>  	void *buffer, *ptr;
> -	int i, rc, pages;
> +	int i, rc;
> =20
> -	buffer =3D diag204_get_buffer(diag204_get_info_type(), &pages);
> +	buffer =3D hypfs_diag204_get_buffer();
>  	if (IS_ERR(buffer))
>  		return PTR_ERR(buffer);
> -	rc =3D diag204_store(buffer, pages);
> -	if (rc)
> +	rc =3D diag204_store(buffer, 0, 0);
> +	if (rc < 0)
>  		return rc;
> -
>  	systems_dir =3D hypfs_mkdir(root, "systems");
>  	if (IS_ERR(systems_dir))
>  		return PTR_ERR(systems_dir);

[ ... ]

> diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
> index 5eae2e25997ae..9adb26588d5b5 100644
> --- a/arch/s390/kernel/sthyi.c
> +++ b/arch/s390/kernel/sthyi.c
> @@ -305,29 +305,19 @@ static struct diag204_x_part_block *lpar_cpu_inf(st=
ruct lpar_cpu_inf *part_inf,
> =20
>  static void *diag204_get_data(bool diag204_allow_busy)
>  {
> -	unsigned long subcode;
>  	void *diag204_buf;
> -	int pages, rc;
> -
> -	subcode =3D DIAG204_SUBC_RSI;
> -	subcode |=3D DIAG204_INFO_EXT;
> -	pages =3D diag204(subcode, 0, NULL);
> -	if (pages < 0)
> -		return ERR_PTR(pages);
> -	if (pages =3D=3D 0)
> -		return ERR_PTR(-ENODATA);
> -	diag204_buf =3D __vmalloc_node(array_size(pages, PAGE_SIZE),
> -				     PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
> -				     __builtin_return_address(0));
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (diag204_get_subcode() !=3D DIAG204_SUBC_STIB7)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	diag204_buf =3D diag204_allocate_buffer();
>  	if (!diag204_buf)
>  		return ERR_PTR(-ENOMEM);
> -	subcode =3D DIAG204_SUBC_STIB7;
> -	subcode |=3D DIAG204_INFO_EXT;
> -	if (diag204_has_bif() && diag204_allow_busy)
> -		subcode |=3D DIAG204_BIF_BIT;
> -	rc =3D diag204(subcode, pages, diag204_buf);
> +	rc =3D diag204_store(diag204_buf, diag204_allow_busy, 0);
>  	if (rc < 0) {
> -		vfree(diag204_buf);
> +		diag204_free_buffer(diag204_buf);
>  		return ERR_PTR(rc);
>  	}
>  	return diag204_buf;

[Severity: Critical]
Can calling diag204_store() with allow_busy=3D0 and allow_busy_wait=3D0 from
hypfs_diag_create_files() or fill_dst()->diag204_get_data() (when
is_diag204_cached(sctns) is false) cause unlocked cache access and an
unbalanced mutex_unlock(&diag204_mutex)?

In arch/s390/kernel/diag/diag204.c:diag204_update_cache(), the thread
updating the cache sets g_cache.updating =3D true and unlocks diag204_mutex
while invoking diag204().

If a second thread concurrently calls diag204_store(buf, 0, 0) while
g_cache.updating is true:

arch/s390/kernel/diag/diag204.c:diag204_store() {
	do {
		mutex_lock(&diag204_mutex);
		/* Exit loop with lock taken if there is no concurrent update */
		if (!READ_ONCE(g_cache.updating))
			break;
		mutex_unlock(&diag204_mutex);
		if (allow_busy && !allow_busy_wait)
			return -EBUSY;
		if (signal_pending(current))
			return -ERESTARTSYS;
		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
	} while (allow_busy_wait);
	if (!diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
		rc =3D diag204_update_cache(allow_busy, allow_busy_wait);
	if (rc >=3D 0)
		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
	mutex_unlock(&diag204_mutex);
}

Because allow_busy is 0 and allow_busy_wait is 0, the loop unlocks
diag204_mutex, does not take the -EBUSY return, sleeps once (or returns
-ERESTARTSYS on a pending signal), and then exits at while (allow_busy_wait)
without holding diag204_mutex.

It then calls diag204_is_cache_valid(), diag204_update_cache(), and
memcpy(buf, READ_ONCE(g_cache.buf), ...) without holding diag204_mutex
(risking a NULL dereference or use-after-free on g_cache.buf against
diag204_set_cache()), followed by an unbalanced mutex_unlock(&diag204_mutex=
).

Also, in hypfs_diag_create_files(), the previous diag204_store() set
DIAG204_BIF_BIT when supported and waited interruptibly on -EBUSY. Should
hypfs_diag_create_files() pass allow_busy=3D1, allow_busy_wait=3D1 (matching
dbfs_d204_create()), and how should diag204_store() handle concurrent
updates when allow_busy=3D0 and allow_busy_wait=3D0?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v2-0-7e5a9d1cd21a@linux.ibm.com?part=3D2
