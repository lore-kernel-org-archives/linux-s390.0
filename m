Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5B1F76B4
	for <linux-s390@vger.kernel.org>; Fri, 27 Dec 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317618; cv=none; b=VLjeivYou00J8uICVNmvI6/y/rYZjs4hnU7AnSY3W87OyPkO3dH/M9qmCFyzP0DLemlz9XphCZainAdD9c2v2a5VKjoVGiEyKOMZXGcebnSzkC5HlsEOTrNKob7KdJ/0KwVWtbYei/HcRoV6DWH3LJqtjQdXZTDINAy+Eu35bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317618; c=relaxed/simple;
	bh=BDBP5cg+rIVLRgMT5uzHFCvod2SD2RGOm2yeQu6lvr4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=IS65ysQBA7yHk29HmfCKiT/4iHArSRmTyfxD/fffaQX263W2g6yccml8cTxndGmmbxd/D0LkHfmhbbYWeFl28YfGTDBrz2uJl7WzW/C3VDkIMaBU6aLUlzCrb4xCWL+dY+/MYk/FIy9uUaFQXE+7cMUMTSOJ/ZpF8tpfwx/h/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=euaublLJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="euaublLJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21683192bf9so93579195ad.3
        for <linux-s390@vger.kernel.org>; Fri, 27 Dec 2024 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1735317614; x=1735922414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4Xw2EJnY1X4WK+jvdY4voHsewcHZzxXdmJCqhZbsvE=;
        b=euaublLJ5Vd1sOtYUO3rxorS6gBUra3bZmwdcf9mF7fP1kFUODP5YYr4iJKhEm8A7O
         7uWFCErJY93AkN5/Biq7XC3vzSiffpocVrzboPC5iL/VArHUNK5LZ3Q81cbROCUIIvxM
         ntIrgJBRqTMRJrldDWdDMfrDCdbepqnVzf4HeSLxrNUk+OsUKRTGFE3XLdgOOfzrWfLg
         szZfJi1Q2YwPcuYnnrxpYiSohMZVeRS715xOgSdVhIgLXbhn/w8Yi4TWqfoabeqRrnlb
         ig5YRruIxF3O6UPU6ozIlNGRBeuzRZLvN9BCJEROA5I/o9wNFUFEC0p21H6M2PnfrawD
         qLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735317614; x=1735922414;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Xw2EJnY1X4WK+jvdY4voHsewcHZzxXdmJCqhZbsvE=;
        b=IT9oS9teOmO9EDHH56j4XngoXf3nRL2v4yzyZaf8ZkTt57vsSfli1bOOjFDWBr21is
         5QXlaQJGmKWNFPSPpuxWEtryZ9OYZuFLSOALxwoJ0xFknWaeX5MDvIpDCcDdKWqNXNAJ
         eEp6rAG+ahkadeulWmsQnmG6Xb6CuR9b5NqeepvTgwTVatbw1PHhyRAY3Z7Xyk2YzV/f
         vSE9NlRXAPbiebYfw1JNd46AkN4Uwj4ZAN4yznH3ibFui7htXk8YNIGDK7fhZFeN+BgH
         8dzXG9u65BD+WR5hca6duM6dstZiY0WrBAni/kcvQCxAcgYdXnHR0Dprr50OtVc1QjnU
         ximw==
X-Forwarded-Encrypted: i=1; AJvYcCW4fdXLHt+YO+SlidRWtJxvYkJwBeeu9UGgh+UhCeNHUNUbNphhrU6EcYIUhI+Wg9cppcmi7XBTS28n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DgZRt/giiKev2EhX2vBDgTfMbOt6m9L+lP9JKEQz0SWMPK2j
	pfVcFUPcWU/bSUGyj29ELFVJ3OPqrAZbPZregl33Mc+vnzKZ03wmGTQtfJVnSXQ=
X-Gm-Gg: ASbGnctmHWze3b8qLR1UqIpJZjd74VeSZQXDHbmn3obCwp8v+Pj2tkM3vyNKKdl+yKZ
	H1oE483S9zvEJrt56L7xJ4rDDbu8K4A5MabFQSeTnKkUagqhx19YlU8ufMV4MK4yR4tPnivuqrY
	9MLUyo/tibeqgqaJBrcQ705KT6aQ7W5N5q15AYRryJ8bbLH284bKLhcfwXMtz5n/TuxN0/Cco4I
	lbEqwlQvBf8bjIkjsqAXsiXPZ2p9GeHlEtFl/EmDjrRGIpwWQ==
X-Google-Smtp-Source: AGHT+IGj5bTxRBL/TPC4rp9UNK8vWD764vaF6GBCxeBJ0bzTi0HACd7gUMrcV8Bcwh/Ub684hrsLqw==
X-Received: by 2002:a17:902:f645:b0:216:5556:8b46 with SMTP id d9443c01a7336-219e70dbcf8mr427204505ad.49.1735317614352;
        Fri, 27 Dec 2024 08:40:14 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-89eaa1c4fdfsm7512714a12.60.2024.12.27.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 08:40:13 -0800 (PST)
Date: Fri, 27 Dec 2024 08:40:13 -0800 (PST)
X-Google-Original-Date: Fri, 27 Dec 2024 08:40:12 PST (-0800)
Subject:     Re: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
In-Reply-To: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
CC: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
  tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
  willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
  akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com, Arnd Bergmann <arnd@arndb.de>,
  Will Deacon <will@kernel.org>, aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
  rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
  linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
  sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
  linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
  linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
  linux-sh@vger.kernel.org, linux-um@lists.infradead.org, zhengqi.arch@bytedance.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhengqi.arch@bytedance.com
Message-ID: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 23 Dec 2024 01:40:48 PST (-0800), zhengqi.arch@bytedance.com wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
>
> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
> table level is folded, as {pmd,pud,p4d}_alloc() already does the
> required check. We can therefore remove the runtime page table level
> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
> the generic version, so we remove it altogether.
>
> This is consistent with the way arm64 and x86 handle this situation
> (runtime check in p4d_free() only).
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index f52264304f772..8ad0bbe838a24 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -12,7 +12,6 @@
>  #include <asm/tlb.h>
>
>  #ifdef CONFIG_MMU
> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>  #define __HAVE_ARCH_PUD_FREE
>  #include <asm-generic/pgalloc.h>
>
> @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
>  	}
>  }
>
> -#define pud_alloc_one pud_alloc_one
> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> -{
> -	if (pgtable_l4_enabled)
> -		return __pud_alloc_one(mm, addr);
> -
> -	return NULL;
> -}
> -
>  #define pud_free pud_free
>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  #define p4d_alloc_one p4d_alloc_one
>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	if (pgtable_l5_enabled) {
> -		gfp_t gfp = GFP_PGTABLE_USER;
> -
> -		if (mm == &init_mm)
> -			gfp = GFP_PGTABLE_KERNEL;
> -		return (p4d_t *)get_zeroed_page(gfp);
> -	}
> +	gfp_t gfp = GFP_PGTABLE_USER;
>
> -	return NULL;
> +	if (mm == &init_mm)
> +		gfp = GFP_PGTABLE_KERNEL;
> +	return (p4d_t *)get_zeroed_page(gfp);
>  }
>
>  static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Are you trying to keep these together, or do you want me to try and pick 
up the RISC-V bits on their own?
