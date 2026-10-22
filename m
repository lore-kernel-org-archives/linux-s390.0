Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684885;
	b=jcci9lZPbv/O1HMkMfNOyBmMMkIuMDX9XrL+tXv6e3zHv3i+Tz0I97WY2ieRj6MSXNcy
	 7Dmaf0RZl5REDtiRfR/UmIjGqW5kIaeqwQhMEjI2EwviN2UjorKuJ5yQSuu8BNMuK2saE
	 bAtfPHF0rwA5NS3dUlfbqEKYjZ2iJKj/EtSNngENk5UQMAULRJK9dS4IjlPzfCyUUk3OF
	 9SLtsyMLKZnR9an3z1KEQjY82hW1/4X/IDJgLs8/c6Po4eNkRkBPssSMd9Z8wTsfb2qE5
	 ficA7yK/N8KTmTXOzqV4sURqO1+8MjiJK0QVZW70jUxvhHTrDJkO+4bfhAS6kQl6wlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3+x1+h3Ft+Kw0sYMtOd/LewFYqbovQJ1/5cMVKDp5pg=;
	b=W4yCUlbs4ah4v6YzWB9QclleqawoL3hbJgUP/aXpINsV2v+8RSQdK2cznmquGU3xVEJg
	 HqK5RgmhxW+w9u+wSSAcFkbC+O9f9JPemQ9wiVUHL6SPdQQPtwXTmJZQxxzjjYvh67+QH
	 Bhk473usuLdI8FmOsJL/fEAyGSOCP+Zsu30RgFKf+ydR1IJRKhjGi8oQm/E6ljL6OBXVp
	 TpRjQvP9VGywULg5Ffo0fSczn2uoITkr8ue9WUDU6xn4UZ0lxqHcdW2YcL2aU3wSQMl7f
	 zWlcfHMUSOMvS8qiXKr6Fp31fO4oNsCCZwWV5FPgLAvtm1cUsvbWB69Rj7dyQb/jXQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnvpKbmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E38606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnvpKbmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B71F01828;
	Thu, 22 Oct 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684884;
	bh=3+x1+h3Ft+Kw0sYMtOd/LewFYqbovQJ1/5cMVKDp5pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NnvpKbmkPmlm4taAD5HTorIAbxbZ3DUUSgNFU2nrpKAwKsEo3jwnXaP9uw/ZVkndE
	 jKRrXPUYGB0sjCpbOI0U9NTf2+LBJw/8a8MqAg9x1cp4i5jZMCbOqUHuZP8qMgG6BT
	 Iy6yo0iVx7+0cBFtCMjy1SG3ZKqgTVrFL4ZxCfLRACz5U7Vj2N9MBNRc8sTkSw7l1b
	 L6Hs334CnpZsYjM1/X9dAY4MhorESE9BVDM8myRy6FTImg84V0iUtVXqnGPJoJYZqd
	 gzpztKz+xpboUuiFQ40xdKcTM4xcXJU8IjDlGShZ+dHWqRk5UO0BJSW0FgJ1kowhkO
	 bHYbMH7eXVBzA==
Message-ID: <sashiko-outbox-181749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390/diag204: Replace diag204 users with new
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v3-2-c25e7147736e@linux.ibm.com>
References: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
 <20261022-diag204ioctl-v3-2-c25e7147736e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:01:23 +0000
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
- [High] s390/diag204: diag204_store() calls fail with -EINVAL without BIF =
support
--

commit e6a66aa1f5ad19fef893eed0590d4b6f880aaa42
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Replace diag204 users with new implementation

This commit converts existing kernelspace diagnose 204 users in hypfs and
sthyi to use the new centralized diag204 interface.

> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index 08777f57bd244..c3eebe4667faf 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c
> @@ -22,139 +22,24 @@

[ ... ]

> -int diag204_store(void *buf, int pages)
> -{
> -	unsigned long subcode;
> -	int rc;
> -
> -	subcode =3D diag204_get_info_type();
> -	subcode |=3D diag204_store_sc;
> -	if (diag204_has_bif())
> -		subcode |=3D DIAG204_BIF_BIT;
> -	while (1) {
> -		rc =3D diag204(subcode, pages, buf);
> -		if (rc !=3D -EBUSY)
> -			break;
> -		if (signal_pending(current))
> -			return -ERESTARTSYS;
> -		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
> -	}
> -	return rc < 0 ? rc : 0;
> -}
> -
>  struct dbfs_d204_hdr {
>  	u64	len;		/* Length of d204 buffer without header */
>  	u16	version;	/* Version of header */
> @@ -173,19 +58,20 @@ static int dbfs_d204_create(void **data, void **data=
_free_ptr, size_t *size)
>  	int rc, buf_size;
>  	void *base;
> =20
> -	buf_size =3D PAGE_SIZE * (diag204_buf_pages + 1) + sizeof(d204->hdr);
> +	buf_size =3D diag204_get_buf_size();
> +	buf_size +=3D PAGE_SIZE + sizeof(d204->hdr);
>  	base =3D vzalloc(buf_size);
>  	if (!base)
>  		return -ENOMEM;
>  	d204 =3D PTR_ALIGN(base + sizeof(d204->hdr), PAGE_SIZE) - sizeof(d204->=
hdr);
> -	rc =3D diag204_store(d204->buf, diag204_buf_pages);
> -	if (rc) {
> +	rc =3D diag204_store(d204->buf, 1, 1);
> +	if (rc < 0) {
>  		vfree(base);
>  		return rc;
>  	}

[ ... ]

> diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag=
_fs.c
> index 39621c3260103..2ce9119abe990 100644
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
> +	rc =3D diag204_store(buffer, 1, 1);
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

[Severity: High]
Does this cause diag204_store() calls in hypfs and sthyi to fail with
-EINVAL on systems without the Diagnose 204 Busy Indication Facility
(BIF)?

In arch/s390/kernel/diag/diag204.c, diag204_store() rejects any call
where allow_busy is set if g_info.has_bif is false:

    if (!allow_busy && allow_busy_wait)
        return -EOPNOTSUPP;
    if (allow_busy && !g_info.has_bif)
        return -EINVAL;

Previously, diag204_store() in arch/s390/hypfs/hypfs_diag.c checked
diag204_has_bif() before setting DIAG204_BIF_BIT, and diag204_get_data()
in arch/s390/kernel/sthyi.c checked both diag204_has_bif() and
diag204_allow_busy. When BIF was not supported, both callers issued
diagnose 204 without DIAG204_BIF_BIT.

With this change, dbfs_d204_create() in arch/s390/hypfs/hypfs_diag.c and
hypfs_diag_create_files() in arch/s390/hypfs/hypfs_diag_fs.c both pass
allow_busy =3D 1 and allow_busy_wait =3D 1 unconditionally:

    rc =3D diag204_store(d204->buf, 1, 1);

and:

    rc =3D diag204_store(buffer, 1, 1);

When g_info.has_bif is false, reading the debugfs diag_204 file or
mounting and updating s390_hypfs will immediately return -EINVAL.

Similarly, in arch/s390/kernel/sthyi.c, diag204_get_data() now passes
diag204_allow_busy directly to diag204_store():

    sthyi_fill()
      -> sthyi_update_cache()
        -> fill_dst()
          -> diag204_get_data(is_diag204_cached(sctns))
            -> diag204_store(diag204_buf, diag204_allow_busy, 0)

On systems without hardware STHYI (!test_facility(74)) and without BIF,
the first sthyi_fill() call succeeds because sthyi_cache.info is zeroed
and is_diag204_cached(sctns) is false. Once fill_diag() populates the
validity bits in sthyi_cache.info and the cache expires after
CACHE_VALID_JIFFIES, subsequent calls to sthyi_fill() pass
diag204_allow_busy =3D true and fail with -EINVAL because
sthyi_update_cache() only handles -EBUSY.

Should these callers gate allow_busy and allow_busy_wait on BIF support,
or should diag204_store() fall back to a non-BIF store when
!g_info.has_bif?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v3-0-c25e7147736e@linux.ibm.com?part=3D2
