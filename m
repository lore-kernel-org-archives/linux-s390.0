Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580961;
	b=ZCYnrfDNnvpWzZNXpWVNG478UHowiL66Tdw7m4VJAa1ah0+YFpf1TJWL2l+RXe5+V1y1
	 9jln4k9DZZ/3MJylteOjc2zObLEUnCCt8jkupUToa4BX0l0algS5J9d+FOBTTPGU2DkTg
	 js8zdK2PloEXVdVklHbezhes+l0UiVCF5chAzbzzYfBk4R/ajoFehQoKN3TeiUxdTUabz
	 DKLAJag/daRdOGfofVwnN79CGXdHKxtAURCN67tYtLbLFy9K+E4MZD0PhK+MiahgRYln1
	 RwF4po5WjGPziW3j9vs8LY5fZTzV2HLM3ACeIhb9vXit0Y9V2HtRn9osQ6VWR4I1KPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580961;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kQUtkasDQrgS7ygK0FLfsabMrE+zbHSe6IS9pb57gWo=;
	b=FRzwaAZclkglLQKsDKnRcHFX1wHnQPlp14EnUDctPxHFEdjAjfeFgaLeFIBnrtBOMGN4
	 4EBnL1qvlieEg5qDwrGXhlvp9Lc8b9Q5Mn1GIsBww45ZzIis3rq4uDBqCU8DV1oncQwby
	 7Ec9hX1AXS7SJKgb4KT6Eo9/PCP+MJ2Vo215wDwkK4OBKu8eohfGNwDUrvqZKEh206+D1
	 iDHwJIeUi2oskfkyQ1+d64a6DAilFfIlzATVJdnlPqJL15w7774IkH/iXCXHI4xCnIXIb
	 MiHrmtoHtheesbKUre4M8kpBYqIZTS87gQcxi9OJtOXvH1vVFNfI/RSJ+eKgTCkQj+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYMbZ+Uw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EC606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYMbZ+Uw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5111F000C9;
	Wed, 21 Oct 2026 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580960;
	bh=kQUtkasDQrgS7ygK0FLfsabMrE+zbHSe6IS9pb57gWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYMbZ+Uwiv6VBLcDZFEg9dFosng03Eg/mZQwExXlG/q2iC/nrCFoc/5SWzQXLAXE3
	 +pRbAryFg/2xIhfjcX7Ma52ZXwN2/K3TQXJ0V0HSS5ufSXYi1T/AAQPTtolnP4tb+E
	 1UGXY3SlIeremraQqQqA5t20goAAMwVp/Qo9MjvKyVFi1IksH1TQqCusqBSLjzhQV8
	 263GmtzQCoxVY0JSrHAXQfE1FBut+j4ReroA+3KLhgcklLgUVr/crYsM4UNcjLoZOU
	 FOKMz7kThCY1QFbgONo4xcu9lMQymkwo9+LBkx+yEKrtUTBwwJ+DGnqafSYQZIFbK/
	 1xtdwJDWbnJnw==
Message-ID: <sashiko-outbox-180145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/diag204: Replace diag204 users with new
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-2-25645b97bf4e@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
 <20261021-diag204ioctl-v1-2-25645b97bf4e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:09:20 +0000
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
- [Critical] s390/sthyi: missing format and subcode checks in diag204_get_d=
ata()
- [Medium] s390/diag204: broken busy-wait in dbfs_d204_create() on empty ca=
che
--

commit c339eee9c087cee65444e6cc2f4556d0002e4640
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Replace diag204 users with new implementation

This commit converts the hypfs and sthyi callers of diagnose 204 to use
the new centralized diag204 buffer allocation, probing, and caching
interface, and enables building diag204.o in arch/s390/kernel/diag/.

> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index 08777f57bd244..c3eebe4667faf 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c

[ ... ]

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

[Severity: Medium]
Previously, dbfs_d204_create() in arch/s390/hypfs/hypfs_diag.c and
hypfs_diag_create_files() in arch/s390/hypfs/hypfs_diag_fs.c called the
local diag204_store(), which set DIAG204_BIF_BIT (when supported) and
looped with schedule_timeout_interruptible(DIAG204_BUSY_WAIT) while
diag204() returned -EBUSY.

With this change, dbfs_d204_create() calls diag204_store(d204->buf, 1, 1).
When a user reads the s390_hypfs/diag_204 debugfs file while g_cache.buf
is null (such as on the first read after boot, or after diag204_work_fn()
expires and frees the cache), dbfs_d204_create() -> diag204_store() ->
diag204_update_cache() runs:

arch/s390/kernel/diag/diag204.c:diag204_update_cache() {
	...
	subcode =3D g_info.type | g_info.subcode;
	if (g_info.has_bif && allow_busy)
		subcode |=3D DIAG204_BIF_BIT;
	WRITE_ONCE(g_cache.updating, true);
	if (!READ_ONCE(g_cache.buf))
		rc =3D diag204_cache_new(buf, subcode);
	else
		rc =3D diag204_cache_replace(buf, subcode, allow_busy_wait);
	...
}

Because DIAG204_BIF_BIT is already set in subcode before calling
diag204_cache_new(), diag204() returns -EBUSY immediately if the
hypervisor is busy, and diag204_cache_new() returns that error without
performing the allow_busy_wait retry loop:

arch/s390/kernel/diag/diag204.c:diag204_cache_new() {
	...
	rc =3D diag204(subcode, g_info.pages, buf);
	if (rc < 0)
		return rc;
	diag204_set_cache(buf);
	return rc;
}

Additionally, hypfs_diag_create_files() in arch/s390/hypfs/hypfs_diag_fs.c
now calls diag204_store(buffer, 0, 0), which drops DIAG204_BIF_BIT and
blocks uninterruptibly in the diagnose instruction instead of sleeping
interruptibly.

Should diag204_update_cache() avoid setting DIAG204_BIF_BIT when
g_cache.buf is null (or retry on -EBUSY when allow_busy_wait is set), and
should hypfs_diag_create_files() also pass allow_busy =3D 1 and
allow_busy_wait =3D 1?

[ ... ]

> diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
> index 5eae2e25997ae..5d9228039ce77 100644
> --- a/arch/s390/kernel/sthyi.c
> +++ b/arch/s390/kernel/sthyi.c
> @@ -305,29 +305,17 @@ static struct diag204_x_part_block *lpar_cpu_inf(st=
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
>  }

[Severity: Critical]
Prior to this change, diag204_get_data() in arch/s390/kernel/sthyi.c
explicitly requested DIAG204_INFO_EXT and DIAG204_SUBC_STIB7.

In arch/s390/kernel/diag/diag204.c, diag204_probe() falls back to
DIAG204_SUBC_STIB6 or DIAG204_INFO_SIMPLE (DIAG204_SUBC_STIB4 with
pages =3D 1) when DIAG204_SUBC_STIB7 or DIAG204_INFO_EXT is not supported:

arch/s390/kernel/diag/diag204.c:diag204_probe() {
	...
		if (diag204(DIAG204_SUBC_STIB6 | type, pages, buf) >=3D 0) {
			subcode =3D DIAG204_SUBC_STIB6;
			goto out;
		}
	} else {
		/* extended data format is not available, fallback to simple */
		pages =3D 1;
		buf =3D __diag204_allocate_buffer(pages);
		if (!buf) {
			rc =3D -ENOMEM;
			goto fail_alloc;
		}
		type =3D DIAG204_INFO_SIMPLE;
		if (diag204(DIAG204_SUBC_STIB4 | type, pages, buf) >=3D 0) {
			subcode =3D DIAG204_SUBC_STIB4;
			goto out;
		}
	}
	...
}

In those fallback cases g_info.pages is still greater than 0, so
diag204_is_available() returns true. However, when s390_sthyi or
handle_sthyi() calls sthyi_fill() -> sthyi_update_cache() -> fill_dst() ->
fill_diag(), fill_diag() and lpar_cpu_inf() in arch/s390/kernel/sthyi.c
unconditionally cast diag204_buf to the extended format structures
(struct diag204_x_info_blk_hdr, struct diag204_x_part_block, and
struct diag204_x_phys_block):

arch/s390/kernel/sthyi.c:fill_diag() {
	...
	ti_hdr =3D diag204_buf;
	part_block =3D diag204_buf + sizeof(*ti_hdr);

	for (i =3D 0; i < ti_hdr->npar; i++) {
		this_lpar =3D (void *)part_block - diag204_buf =3D=3D ti_hdr->this_part;
		part_block =3D lpar_cpu_inf(&lpar_inf, this_lpar, diag224_buf,
					  part_block);
	}

	phys_block =3D (struct diag204_x_phys_block *)part_block;
	part_block =3D diag204_buf + ti_hdr->this_part;
	...
}

What happens on a system without facility 74 where diag204_probe() fell
back to DIAG204_INFO_SIMPLE or DIAG204_SUBC_STIB6? With
DIAG204_INFO_SIMPLE, diag204_allocate_buffer() allocates a single page
containing simple-format data, so fill_diag() and lpar_cpu_inf() read
fields at extended-format offsets and step part_block past the end of the
1-page diag204_buf allocation. With DIAG204_SUBC_STIB6, secondary CPUs are
omitted instead of failing with -EOPNOTSUPP.

Should diag204_get_data() check that diag204_get_info_type() =3D=3D
DIAG204_INFO_EXT and diag204_get_subcode() =3D=3D DIAG204_SUBC_STIB7?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-diag204ioc=
tl-v1-0-25645b97bf4e@linux.ibm.com?part=3D2
