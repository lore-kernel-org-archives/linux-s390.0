Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0B27D79E;
	Fri, 11 Apr 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354418; cv=none; b=CZoHcM/3rOFuk4mZVrJUnF1KPYhEAywpSMmvi4640I+6u9VNcZ6Ak2F20y/EqXVPu/rtH/Al0ODZu/VZzwb8gDm+Z99MjBYJP+mdLeGQhI+59bUzdeb7tuACV7l6FunItg6tZtUmmP4Dad3sDiiE36jcvowJ3hLbq8pBzCODqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354418; c=relaxed/simple;
	bh=LsVrtsWTdgZtWEyKw4K0oMuOxvSqk85g6kxJNX2LRG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=V1BmLEjhPrRaQQI1NcLSHsFHrWpjjQ5eeQZaNvZRiSubbisEpi5ek9U46qZJ1nGTZyyzPYAob9J3+LIu7fCXC8lcbrH+4NPBKiVPCdY78+Kk/38Pp8zjTy6/fWL0yTa0CQne1+e7hgrRuyyUgxxu7y3EsrqUEUg5O0lNqB5vZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGlv+QXx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGlv+QXx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2260c91576aso13868635ad.3;
        Thu, 10 Apr 2025 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744354416; x=1744959216; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0GUgempXeR1Ai6jdCUdrwnFpwuRrrfXxvPcXnoqanQ=;
        b=HGlv+QXxDqa/8B2DXS3DzaCslr3uilInE2Dq0y3tG+3ysk1KHfQ+p43iOnkp+83Mbm
         r/w4GfvkccRuAJdnvpRAx881cmaqNiZ3Te6kP65XJyVvL9i3oD6EdmlXXt5eEJmsJsUY
         9U0dc1FuQvVNP6Wijpy5r51rcjw7SAxqr+vTmfOE2Ir8j/U6x2SzkbkJO0lAc7s7Qve7
         QDcK+TxHB3df1MZqVvkGMf7zP/3mUFtJt+7o/hK8KLE1LQHa5WBNPgsRaAAdiLNq5pKw
         8YobRQDOPxCzPWz3QK6UOHbK9M8s5lU1KEcsEtXbzk9AF/11LctOpi2oxZ8EuCVZf+VH
         Rf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354416; x=1744959216;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0GUgempXeR1Ai6jdCUdrwnFpwuRrrfXxvPcXnoqanQ=;
        b=pG6yLB6/JQHRSbF3fZmjeP/W5xBzLeW836peYcwTxwZrZaIrkpjByiL8XIdrZ54A2Z
         0tWa18l9r1drv4J0ikWBEgbOZ/u9cN5rh6K2Q1cZDs0+yTIuirUUm/Rh+XDDgWYf+u6x
         yNgrw2go+82Tj4rCVaCwL6UQkczrweYVlRaBC5wjsaEwh2e3Eb44IT5brTXbJzjWseLo
         ucigJ3A77pak9IfD8EasuogvOqadbQqkTu/4VZM2yIDifXRYysj4H12vSTAXAJlfXXJF
         JduKJ7AmOryUrlyV17tkVBmElT3uqUZfEFaAgwt3Zmx/+LxIIpnhAQ5yQ2JdxOACBSJ2
         PyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVExbdBrTu5BOcHjE8Z3VRu1PDQDaJ9Fmw98BFXE2gnAjttKQQ7SQucNqvpaCVMVxUP36YFRwlTrQH6fg==@vger.kernel.org, AJvYcCVU1vAi9zOpOAq8LiZoUER19MOwYL8VAeOYsh70MPzr9ZijmBUQnupPNpAhw6PAahoHwMhtjh9ktlGBYg==@vger.kernel.org, AJvYcCWBxi+3JsYvqcZV3m60cIMoV2ETgi97xjRw+nuwmfg5GW4mA1uuqb7yfbjWngdmozzU+g2hST1vbqvEXMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWK+Pwh0JTGY/Op2BGBSkMGy/4K2DW2PkJYBW2zK637tMgk1S
	Ee1xtIT0125ENz4lNriomgCCG8svLjgnQVCnkAgToP+gByAYGVur
X-Gm-Gg: ASbGncvItZDuL+aq5dWNX/MFKh1RK7yGuaVLHwfXtsgpORIeWtjp12RILh5QbJSKJ4K
	wfA3DuVFtc61iUT39FLSh6PK7hG7ApokE2YbdUuoP4L70Pe06aEbp2c0ITidrfqZG/INPt5E5OW
	efonMms9m4ZqPXKC7xgCelUvPDm9EwC17dp5xfeLGJCdUnAFjC+WS6XXdoLQqNBZ0876ki+lUJv
	UjBOMn3hx/I00/VWt5K2veJ0vicvu4vZ+RXBLm/wjiHHPkkUPRPSCgwvKwxh1nJ2U8U7dVYwMS2
	VAthNr9cdqU0rVKTxNZE1u748Yf0mbix9Q==
X-Google-Smtp-Source: AGHT+IGl0nL5wKmwFlWsQ9ssGXCB2kOLf/x4PGlQUnJhSihZMIEaJP/+c7G4d96OdeU+R8O+pnzM/Q==
X-Received: by 2002:a17:902:cec4:b0:224:e33:889b with SMTP id d9443c01a7336-22bea4ade03mr24590165ad.12.1744354416369;
        Thu, 10 Apr 2025 23:53:36 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2333841sm728200b3a.160.2025.04.10.23.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 16:53:29 +1000
Message-Id: <D93M14UCYU7Y.39ZQIH7VON6DG@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
Cc: "Hugh Dickins" <hughd@google.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Juergen Gross" <jgross@suse.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <kasan-dev@googlegroups.com>, <sparclinux@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] mm: Protect kernel pgtables in
 apply_to_pte_range()
X-Mailer: aerc 0.19.0
References: <cover.1744037648.git.agordeev@linux.ibm.com>
 <11dbe3ac88130dbd2b8554f9369cd93fe138c655.1744037648.git.agordeev@linux.ibm.com>
In-Reply-To: <11dbe3ac88130dbd2b8554f9369cd93fe138c655.1744037648.git.agordeev@linux.ibm.com>

On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> The lazy MMU mode can only be entered and left under the protection
> of the page table locks for all page tables which may be modified.
> Yet, when it comes to kernel mappings apply_to_pte_range() does not
> take any locks. That does not conform arch_enter|leave_lazy_mmu_mode()
> semantics and could potentially lead to re-schedulling a process while
> in lazy MMU mode or racing on a kernel page table updates.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/kasan/shadow.c | 7 ++-----
>  mm/memory.c       | 5 ++++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index edfa77959474..6531a7aa8562 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -308,14 +308,14 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, =
unsigned long addr,
>  	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
>  	pte =3D pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
> =20
> -	spin_lock(&init_mm.page_table_lock);
>  	if (likely(pte_none(ptep_get(ptep)))) {
>  		set_pte_at(&init_mm, addr, ptep, pte);
>  		page =3D 0;
>  	}
> -	spin_unlock(&init_mm.page_table_lock);
> +
>  	if (page)
>  		free_page(page);
> +
>  	return 0;
>  }
> =20

kasan_populate_vmalloc_pte() is really the only thing that
takes the ptl in the apply_to_page_range fn()... Looks like
you may be right. I wonder why they do and nobody else? Just
luck?

Seems okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> @@ -401,13 +401,10 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep=
, unsigned long addr,
> =20
>  	page =3D (unsigned long)__va(pte_pfn(ptep_get(ptep)) << PAGE_SHIFT);
> =20
> -	spin_lock(&init_mm.page_table_lock);
> -
>  	if (likely(!pte_none(ptep_get(ptep)))) {
>  		pte_clear(&init_mm, addr, ptep);
>  		free_page(page);
>  	}
> -	spin_unlock(&init_mm.page_table_lock);
> =20
>  	return 0;
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index f0201c8ec1ce..1f3727104e99 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2926,6 +2926,7 @@ static int apply_to_pte_range(struct mm_struct *mm,=
 pmd_t *pmd,
>  			pte =3D pte_offset_kernel(pmd, addr);
>  		if (!pte)
>  			return err;
> +		spin_lock(&init_mm.page_table_lock);
>  	} else {
>  		if (create)
>  			pte =3D pte_alloc_map_lock(mm, pmd, addr, &ptl);
> @@ -2951,7 +2952,9 @@ static int apply_to_pte_range(struct mm_struct *mm,=
 pmd_t *pmd,
> =20
>  	arch_leave_lazy_mmu_mode();
> =20
> -	if (mm !=3D &init_mm)
> +	if (mm =3D=3D &init_mm)
> +		spin_unlock(&init_mm.page_table_lock);
> +	else
>  		pte_unmap_unlock(mapped_pte, ptl);
> =20
>  	*mask |=3D PGTBL_PTE_MODIFIED;

