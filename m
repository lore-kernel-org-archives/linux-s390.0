Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6961EB19E;
	Fri, 11 Apr 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354027; cv=none; b=OjeUoZ4YiQPAx5MHh7OY5rfHoIiCqaJFuFhy7Y2WV1DNIxBnHSGGDB8vTVGlbnStj4SRvO63hpSRB6C5KN66wNP+jVusyztETCxc998x6dRfQmaXpBOzQGQmfb7pbwzkzDlDJ4jCUqFkIzOaN4YtwTKr/RDMsbXYKotlDZj96ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354027; c=relaxed/simple;
	bh=Z2zMUvb3ZrB/25ixTzFARoTMwKuioIJhsJ24S3PQ+jY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bB6b2V4P0XhSXTUR6p4Y4JX/3zmeVqloTOfOkC8ioqp/5tztcRHaCaqcoSpXFh8+9TX4eGNqdgWHXP0AZnxIQIcc1DlWQFDehyFkXQuh40JKuAmdQIkQ+vefDfDb3ky8cgpPGuM8SuJ2V9BAqQ2X2ag52ZPjDIwzdstkmQ0wVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyiXUwpu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyiXUwpu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso16728975ad.1;
        Thu, 10 Apr 2025 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744354025; x=1744958825; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlT93k3tsOOzLmAYutjlNjX6BFvDuWnFmTQ9IJuMKl4=;
        b=dyiXUwpupfEQc4Iip3IrNNg7EttE60fJkExgb02M4xcJkJ1RcRAHrtF4mdS9XCErTZ
         to7OXxFX8C40t1BgGfahaxgf7K2gsix/MsSZtGPQxOVUXypbcUboD0VcrTS51j5qkJZ/
         r647lDVdreKyUWCViFCMuEbOBR1qurX+79ZYO6OSQPfVsmxBq2yDlotqcBjdgHQE6kNS
         Sm3xhrGeiQD6FZo7blopJOH9Zyfov1PdOctNjDT25przGuwGBlhGqi7OX/S+8Z0MUBbp
         TlxKYjbDG5eGGhJpTJ6to1JRUdC7nLvINkaco8Eo3SXGnJ5NqL+Q0ayl3os5kByeqlQS
         VU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354025; x=1744958825;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlT93k3tsOOzLmAYutjlNjX6BFvDuWnFmTQ9IJuMKl4=;
        b=LS4zbnUsGOswh08aBFzrLVdNf7zoU19xreTsHPlf7khcESgXSICLSMUNU5yJxjNIuV
         Y/HyIoktpKDhNSrvWu7IdkBWyJRczi68Av3lHcS95U8BAJ0hLYo4y4ZE4Cm9yyVeX13v
         1cmTlrrqte4AhTkFtPXSvO3ZQkjWzfkFfYmVkLPozmkY8S/1NQ+gUgfSIr/zKkZvn+q/
         zqrtglv9wBgiifsDN9rsELwl9OAXhQ7+z6DqA0kDhTZTbbzXWWYLQNy8iSNcT1nLFciR
         UoL08bPDPRYvWcrxyWBWpf5xqF3IxKyOxuTPAbqXM6m0vhXHFrPb6D3SFnlwqYqA9tJw
         F7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVSuMtRE6jKhTc2Fh1sddx13FONLwJwanzv2Yt9KWaJRKEJHYaXqIkJuRZY+vJY+qjX1Iw7EkLFay1tcM8=@vger.kernel.org, AJvYcCXEw+JeqdFTQLl5CzYkKKrIkFxdhD+KGDXuX71Qc937+uLkHYbFxA5+8eJBJysk1X4zhD6pOVGGbxH5WQ==@vger.kernel.org, AJvYcCXU1upOOcMAZ7Xuf7Xy5XVkDNYx9Fh5Cfms7bQ11qwcoMCNmmgG+i328XwuNAZJAPENipcB+NuuoI6urw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznM3JlZADFvVoU/CyHRsN4sSj2ENdSsJ46bt+MPak2pULXgBxp
	fa71ynCjF8vh1gXlJ/o4jfSsRi1gEnSETqiJtpYGhoz+MLTgi6gE
X-Gm-Gg: ASbGncvZmI0GOt/lthLb3M6R3rNxBEEBQIZmehzyH6SaIb7YuaVSjdRig+vJmR3zv3B
	zMIjAf1xO1nfez7Gs34Xy7AMpDNQClhHVsHgNcRnnbwc6/Sr3ksjLoueSclkb/Pi/dccN/GqC3R
	eAOLN4IxTctz7uUQfmWypJRLJT0DJnRzrSDnWq0KdA8SUxeLCHrQARTtYQ8DsMkfv/v+STy67bw
	G2ofM3BLlrn7KoLXnV0pkSZZC16zuyEM5qATnptyUGz68PcCyENTfwtuaIBznCMp5gh6JETMCRU
	vjCGCjbJsAw643k/6hv524+NvfBylhfMyw==
X-Google-Smtp-Source: AGHT+IEaCH7pfyseCsY0ABQGUFfCNsdZ0JepyMppPzef2Ij2uLIjrUD7lNR1McifQnqxw6aLmm43tw==
X-Received: by 2002:a17:902:d489:b0:215:58be:3349 with SMTP id d9443c01a7336-22bea05e17fmr25293145ad.14.1744354025413;
        Thu, 10 Apr 2025 23:47:05 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b2c1sm41872295ad.59.2025.04.10.23.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 16:46:58 +1000
Message-Id: <D93LW58FLXOS.2U8X0CO2H9H5S@gmail.com>
Subject: Re: [PATCH v1 2/4] mm: Cleanup apply_to_pte_range() routine
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
Cc: "Hugh Dickins" <hughd@google.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Juergen Gross" <jgross@suse.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <kasan-dev@googlegroups.com>, <sparclinux@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.19.0
References: <cover.1744037648.git.agordeev@linux.ibm.com>
 <93102722541b1daf541fce9fb316a1a2614d8c86.1744037648.git.agordeev@linux.ibm.com>
In-Reply-To: <93102722541b1daf541fce9fb316a1a2614d8c86.1744037648.git.agordeev@linux.ibm.com>

On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> Reverse 'create' vs 'mm =3D=3D &init_mm' conditions and move
> page table mask modification out of the atomic context.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/memory.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 2d8c265fc7d6..f0201c8ec1ce 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2915,24 +2915,28 @@ static int apply_to_pte_range(struct mm_struct *m=
m, pmd_t *pmd,
>  				     pte_fn_t fn, void *data, bool create,
>  				     pgtbl_mod_mask *mask)
>  {
> +	int err =3D create ? -ENOMEM : -EINVAL;

Could you make this a new variable instead of reusing
existing err? 'const int pte_err' or something?

>  	pte_t *pte, *mapped_pte;
> -	int err =3D 0;
>  	spinlock_t *ptl;
> =20
> -	if (create) {
> -		mapped_pte =3D pte =3D (mm =3D=3D &init_mm) ?
> -			pte_alloc_kernel_track(pmd, addr, mask) :
> -			pte_alloc_map_lock(mm, pmd, addr, &ptl);
> +	if (mm =3D=3D &init_mm) {
> +		if (create)
> +			pte =3D pte_alloc_kernel_track(pmd, addr, mask);
> +		else
> +			pte =3D pte_offset_kernel(pmd, addr);
>  		if (!pte)
> -			return -ENOMEM;
> +			return err;
>  	} else {
> -		mapped_pte =3D pte =3D (mm =3D=3D &init_mm) ?
> -			pte_offset_kernel(pmd, addr) :
> -			pte_offset_map_lock(mm, pmd, addr, &ptl);
> +		if (create)
> +			pte =3D pte_alloc_map_lock(mm, pmd, addr, &ptl);
> +		else
> +			pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
>  		if (!pte)
> -			return -EINVAL;
> +			return err;
> +		mapped_pte =3D pte;
>  	}
> =20
> +	err =3D 0;
>  	arch_enter_lazy_mmu_mode();
> =20
>  	if (fn) {
> @@ -2944,12 +2948,14 @@ static int apply_to_pte_range(struct mm_struct *m=
m, pmd_t *pmd,
>  			}
>  		} while (addr +=3D PAGE_SIZE, addr !=3D end);
>  	}
> -	*mask |=3D PGTBL_PTE_MODIFIED;
> =20
>  	arch_leave_lazy_mmu_mode();
> =20
>  	if (mm !=3D &init_mm)
>  		pte_unmap_unlock(mapped_pte, ptl);
> +
> +	*mask |=3D PGTBL_PTE_MODIFIED;

This is done just because we might as well? Less work in critical
section?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
>  	return err;
>  }
> =20

